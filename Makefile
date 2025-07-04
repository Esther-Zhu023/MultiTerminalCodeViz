# Makefile for MultiTerminal CodeViz Docker operations

# Variables
APP_NAME = multiterminal-app
COMPOSE_FILE = docker-compose.yml
PROD_PORT = 3000
DEV_PORT = 5173

# Default target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  build       - Build the production Docker image"
	@echo "  build-dev   - Build the development Docker image"
	@echo "  up          - Start the production application"
	@echo "  up-dev      - Start the development application"
	@echo "  down        - Stop and remove containers"
	@echo "  restart     - Restart the production application"
	@echo "  logs        - Show application logs"
	@echo "  logs-dev    - Show development logs"
	@echo "  shell       - Open shell in running container"
	@echo "  clean       - Remove all containers and images"
	@echo "  health      - Check application health"

# Build production image
.PHONY: build
build:
	docker-compose build app

# Build development image
.PHONY: build-dev
build-dev:
	docker-compose build app-dev

# Start production application
.PHONY: up
up:
	docker-compose up -d app
	@echo "Application is starting..."
	@echo "Access the app at: http://localhost:$(PROD_PORT)"

# Start development application
.PHONY: up-dev
up-dev:
	docker-compose --profile dev up -d app-dev
	@echo "Development server is starting..."
	@echo "Access the app at: http://localhost:$(DEV_PORT)"

# Stop and remove containers
.PHONY: down
down:
	docker-compose down

# Restart production application
.PHONY: restart
restart:
	docker-compose restart app

# Show application logs
.PHONY: logs
logs:
	docker-compose logs -f app

# Show development logs
.PHONY: logs-dev
logs-dev:
	docker-compose logs -f app-dev

# Open shell in running container
.PHONY: shell
shell:
	docker-compose exec app sh

# Remove all containers and images
.PHONY: clean
clean:
	docker-compose down --rmi all --volumes --remove-orphans
	docker system prune -f

# Check application health
.PHONY: health
health:
	@echo "Checking application health..."
	@curl -f http://localhost:$(PROD_PORT) > /dev/null 2>&1 && echo "✅ Application is healthy" || echo "❌ Application is not responding"

# Quick development setup
.PHONY: dev-setup
dev-setup: build-dev up-dev
	@echo "Development environment is ready!"

# Quick production setup
.PHONY: prod-setup
prod-setup: build up
	@echo "Production environment is ready!"
