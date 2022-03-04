package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

const PORT uint = 9002

func main() {
	http.HandleFunc("/ping", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		if err := json.NewEncoder(w).Encode(map[string]string{"message": "pong from user service"}); err != nil {
			log.Fatalf("[ERROR] while pinging user service: %v", err)
		}
	})

	log.Printf("Serving user service on localhost:%v", PORT)
	if err := http.ListenAndServe(fmt.Sprintf(":%v", PORT), nil); err != nil && err != http.ErrServerClosed {
		log.Fatalf("[ERROR] while serving user service: %v", err)
	}
}
