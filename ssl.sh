#!/bin/bash
export DSA_ROOT="config/ssl"
rails s -b "ssl://127.0.0.1:3000?key=$DSA_ROOT/local.dev-key.pem&cert=$DSA_ROOT/local.dev.pem"
