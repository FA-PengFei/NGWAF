package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"html/template"
	"log"
	"net/http"
	"os"
)

var templates = template.Must(template.ParseGlob("templates/*"))

const CVE20196340 = "CVE-2019-6340"
const DrupalScan = "Drupal Scanner"
const DrupalScanLogin = "Drupal Scanner - Login Page"
const DrupalScanChangelog = "Drupal Scanner - CHANGELOG.txt"

var (
	Err422 = errors.New("The website encountered an unexpected error. Please try again later.")
)

type Page struct {
	Title    string
	Host     string
	Error    bool
	Username string
}

func NotFoundHandler(app App) func(w http.ResponseWriter, r *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		recordAttack(app, r, DrupalScanChangelog)
		err := templates.ExecuteTemplate(w, "404.html", getHost(r))
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

// IndexHandler provides static pages depending on the request. If
// CHANGELOG.txt is requested, return the appropriate Changelog file and flag
// the IP. Otherwise, return the index page and check whether to record the
// http.Request.
func IndexHandler(app App) func(w http.ResponseWriter, r *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		recordAttack(app, r, DrupalScan)
		host := fmt.Sprintf("http://%s", app.SensorIP)
		p := Page{
			Title: app.Config.Drupal.SiteName,
			Host:  host,
		}
		err := templates.ExecuteTemplate(w, "index.html", p)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

func NodeHandler(app App) func(w http.ResponseWriter, r *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		recordAttack(app, r, CVE20196340)
		http.Error(w, Err422.Error(), http.StatusUnprocessableEntity)
	}
}

func fileServe(w http.ResponseWriter, r *http.Request) {
	path := fmt.Sprintf("public%s", r.URL.Path)
	http.ServeFile(w, r, path)
}

// TODO: Randomize csrf token
func loginHandler(app App) func(w http.ResponseWriter, r *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		host := fmt.Sprintf("http://%s", app.SensorIP)
		p := Page{
			Title: app.Config.Drupal.SiteName,
			Host:  host,
		}
		var err error
		if r.Method == "POST" {
			username := r.PostFormValue("name")
			password := r.PostFormValue("pass")
			recordCredentials(app, r, username, password)

			p.Username = username
			p.Error = true

			err = templates.ExecuteTemplate(w, "login-invalid.html", p)
		} else {
			recordAttack(app, r, DrupalScanLogin)
			err = templates.ExecuteTemplate(w, "login.html", p)
		}
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

// routes sets up the necessary http routing for the webapp.
func routes(app App) *http.ServeMux {
	mux := http.NewServeMux()
	mux.HandleFunc("/", IndexHandler(app))
	mux.HandleFunc("/core/", fileServe)
	mux.HandleFunc("/sites/", fileServe)
	mux.HandleFunc("/logo.svg", fileServe)
	mux.HandleFunc("/CHANGELOG.txt", NotFoundHandler(app))
	mux.HandleFunc("/node/", NodeHandler(app))
	mux.HandleFunc("/user/login", loginHandler(app))
	return mux
}

// recordRequest will parse the http.Request and put it into a normalized format
// and then marshal to JSON. This can then be sent on an hpfeeds channel or
// logged to a file directly.
func recordAttack(app App, r *http.Request, signature string) {
	// Populate data to send
	payload, err := app.Agave.NewHTTPAttack(signature, r)
	if err != nil {
		fmt.Println("error:", err)
		return
	}
	// log.Printf("%s", help)
	// Marshal it to json so we can send it over hpfeeds.
	buf, err := json.Marshal(payload)
	if err != nil {
		fmt.Println("error:", err)
		return
	}

	
	f, err := os.OpenFile("/app/logs/attacker.log",os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Println(err)
		}
	defer f.Close()
	log.SetOutput(f)
	log.Printf("%s", buf)
	if _, err := f.WriteString("\n"); err != nil {
		log.Println(err)
	}
	// Send to hpfeeds broker
	if app.Config.Hpfeeds.Enabled {
		app.Publish <- buf
	}
}

// recordRequest will parse the http.Request and put it into a normalized format
// and then marshal to JSON. This can then be sent on an hpfeeds channel or
// logged to a file directly.
func recordCredentials(app App, r *http.Request, username string, password string) {
	// Populate data to send
	payload, err := app.Agave.NewCredentialAttack(r, username, password)
	if err != nil {
		fmt.Println("error:", err)
		return
	}

	// Marshal it to json so we can send it over hpfeeds.
	buf, err := json.Marshal(payload)
	if err != nil {
		fmt.Println("error:", err)
		return
	}

	log.Printf("Number2:,%s", buf)
	// Send to hpfeeds broker
	if app.Config.Hpfeeds.Enabled {
		app.Publish <- buf
	}
}

// getHost tries its best to return the request host.
func getHost(r *http.Request) string {
	r.URL.Scheme = "http"
	r.URL.Host = r.Host

	return r.URL.String()
}
