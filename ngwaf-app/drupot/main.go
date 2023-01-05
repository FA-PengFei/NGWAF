package main

import (
	"errors"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"net"
	"net/http"
	"sync"
	"time"

	"github.com/Pallinder/go-randomdata"
	"github.com/d1str0/hpfeeds"
	"github.com/google/uuid"
	"github.com/threatstream/agave"
)

const Version = "v0.2.4"
const AgaveApp = "Drupot"

type App struct {
	Publish    chan []byte
	SeenIPLock *sync.RWMutex
	SeenIP     map[string]bool
	SensorIP   string
	Config     *AppConfig
	SensorUUID string
	Agave      *agave.Client
}

func main() {
	fmt.Println("///- Running Drupot")
	fmt.Printf("///- %s\n", Version)

	// All we take is a config file argument.
	var configFilename string
	flag.StringVar(&configFilename, "c", "config.toml", "load given config file")
	flag.Parse()

	fmt.Printf("//- Loading config file: %s\n", configFilename)
	config := loadConfig(configFilename)

	var app App
	app.SeenIPLock = &sync.RWMutex{}
	app.SensorIP = "127.0.0.1" // Default will be overwritten if public IP set to fetch.
	app.Config = config
	app.SeenIP = make(map[string]bool)
	app.Publish = make(chan []byte)

	if app.Config.Drupal.NameRandomizer {
		app.Config.Drupal.SiteName = randomdata.SillyName()
	}

	// TODO: Persist UUID. Maybe a command line flag to refresh or overwrite.
	uuid, err := uuid.NewUUID()
	if err != nil {
		log.Fatalf("Error generating UUID: %s\n", err.Error())
	}
	app.SensorUUID = uuid.String()

	if config.Hpfeeds.Enabled {
		enableHpfeeds(app)
	}

	if config.PublicIP.Enabled {
		ip, err := getPublicIP(config.PublicIP)
		if err != nil {
			log.Fatalf("Error getting public IP: %s\n", err.Error())
		}
		app.SensorIP = ip
	}

	app.Agave = agave.NewClient(AgaveApp, config.Hpfeeds.Channel, app.SensorUUID, app.SensorIP, config.Drupal.Port)

	// Load routes for the server
	mux := routes(app)

	addr := fmt.Sprintf(":%d", config.Drupal.Port)
	s := http.Server{
		Addr:         addr,
		Handler:      mux,
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 10 * time.Second,
		IdleTimeout:  120 * time.Second,
	}
	log.Fatal(s.ListenAndServe())

}

func enableHpfeeds(app App) {
	c := app.Config.Hpfeeds
	fmt.Printf("/- Connecting to hpfeeds server: %s\n", c.Host)
	fmt.Printf("/-\tPort: %d\n", c.Port)
	fmt.Printf("/-\tIdent: %s\n", c.Ident)
	fmt.Printf("/-\tAuth: %s\n", c.Auth)
	fmt.Printf("/-\tChannel: %s\n", c.Channel)

	client := hpfeeds.NewClient(c.Host, c.Port, c.Ident, c.Auth)

	go func() {
		for {
			err := client.Connect()
			if err != nil {
				log.Fatalf("Error connecting to hpfeeds server: %s\n", err.Error())
				time.Sleep(5 * time.Second)
				continue
			}
			client.Publish(c.Channel, app.Publish)
			<-client.Disconnected
			fmt.Printf("Attempting to reconnect...\n")
		}
	}()
}

// getPublicIP goes through a list of URLs to
func getPublicIP(c *PublicIPConfig) (string, error) {
	var ip net.IP

	for _, site := range c.URLs {
		resp, err := http.Get(site)
		if err != nil {
			log.Print(err)
			continue
		}
		defer resp.Body.Close()
		var body []byte
		body, err = ioutil.ReadAll(resp.Body)
		if err != nil {
			return "", err
		}

		// Try and parse response into a valid IP.
		ip = net.ParseIP(string(body))
		// ip will be nil if the parsing fails.
		// if not nil, succesfully got back an IP and parsed it
		if ip != nil {
			return ip.String(), nil
		}
	}

	return "", errors.New("Unable to get public IP")
}
