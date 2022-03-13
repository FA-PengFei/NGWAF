package main

import (
	"log"
	"github.com/BurntSushi/toml"
)

type AppConfig struct {
	Drupal   *DrupalConfig
	Hpfeeds  *HpfeedsConfig
	PublicIP *PublicIPConfig `toml:"fetch_public_ip"`
}

// DrupalConfig provides configuration for how to host the Drupal web app
// portion of the honeypot.
// [drupal]
type DrupalConfig struct {
	Version               string // Version of Drupal to emulate
	Port                  int
	ChangelogEnabled      bool   `toml:"changelog_enabled"`
	ChangelogFilepath     string `toml:"changelog_filepath"`
	SiteName              string `toml:"site_name"`
	NameRandomizer        bool   `toml:"name_randomizer"`
	HeaderServer          string `toml:"header_server"`
	HeaderContentLanguage string `toml:"header_content_language"`
}

// HpfeedsConfig provides configuration for connecting to an hpfeeds broker
// server and credentials for publishing data.
// [hpfeeds]
type HpfeedsConfig struct {
	Enabled bool
	Host    string
	Port    int
	Ident   string
	Auth    string
	Channel string
	Meta    string
}

// [fetch_public_ip]
type PublicIPConfig struct {
	Enabled bool
	URLs    []string
}

func loadConfig(filename string) *AppConfig {
	var c AppConfig
	_, err := toml.DecodeFile(filename, &c)
	if err != nil {
		log.Fatalf("Unable to parse config file: %s\n", err.Error())
	}
	return &c
}
