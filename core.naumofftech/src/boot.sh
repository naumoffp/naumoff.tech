#!/bin/bash
gunicorn -c config/server.py.ini server:app
