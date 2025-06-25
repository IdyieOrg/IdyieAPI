# 📘 IdyieAPI – Technical Documentation

## 1. Introduction

### Project name
**IdyieAPI**

### Description
API developed in Ruby on Rails for Idyie. The goal of this API is to communicate between the IdyieWeb, the IdyieLLM and the IdyieFormatter.
<!-- **Target audience**: Developers, DevOps, internal contributors.   -->

### Main technologies
- Ruby on Rails
- MariaDB
- Docker / Docker Compose
<!-- - Continuous Integration (CI)
- Environment Variables -->

## 2. ⚙️ Requirements

### Supported environments
- macOS, Linux recommended (Windows with WSL2 supported)
- Terminal access with `bash`/`zsh`

### Required software
- Docker & Docker Compose
- Git
- (Optional) Ruby / Rails / Node.js if not fully containerized

### Used ports
| Service     | Port |
|-------------|------|
| Rails (web) | 8080 |
| MariaDB     | 3306 |

## 3. 🚀 Installation & Launch

### 3.1 Clone the project
```bash
git clone git@github.com:IdyieOrg/IdyieAPI.git
cd IdyieAPI
```
### 3.2 Configure the environment
```bash
cp .env.example .env
```
### 3.3 Launch the application locally
```bash
docker compose build
docker compose up -d; docker attach idyie-api-application
```

## 4. 🏗 Project Structure
### 4.1 Simplified tree
```
.
├── app
│   ├── channels/
│   ├── controllers/
│   ├── jobs/
│   ├── mailers/
│   ├── models/
│   ├── services/
│   └── views/
├── bin/
├── config/
├── db
│   └── seeds.rb
├── docker/
├── docker-compose.yml
├── .env.example
├── Gemfile
├── Gemfile.lock
├── .github
│   └── workflows
├── .gitignore
├── lib
│   ├── rubocop
│   └── tasks
├── public
│   └── robots.txt
├── README.md
└── test
    ├── channels/
    ├── controllers/
    ├── fixtures/
    ├── integration/
    ├── mailers/
    ├── models/
    └── test_helper.rb
```
### 4.2 Main gems
<!-- devise: Authentication
pundit: Authorization
rspec-rails: Testing
sidekiq: Background jobs (if used)
dotenv-rails: Environment variable management
rubocop: Ruby linter -->
- `httparty`: HTTP client for API requests
- `rack-cors`: Middleware for Cross-Origin Resource Sharing (CORS)
- `rubocop`: Ruby linter

##  5. 🔐 Environment Variables

A ```.env.example``` file is provided to configure the required variables:
```bash
# Application
IDYIE_FORMATTER_URL=
IDYIE_LLM_URL=
PORT=

# Database
MYSQL_ROOT_PASSWORD=
MYSQL_USER=
MYSQL_PASSWORD=
MYSQL_DATABASE=
```
The variables are used to configure the Docker containers and database connection.

## 6. 🔁 API Documentation – IdyieAPI (v1)

### Endpoint `GET /api/v1/prompts`

### Description

This endpoint receives a natural language **prompt**, interprets it using an LLM service to generate an SQL query, executes the query on a MariaDB database, formats the results using a formatter service, and returns the formatted data in JSON format.

### Query Parameters

| Name    | Type   | Required | Description                                  |
|---------|--------|----------|----------------------------------------------|
| prompt  | string | Yes      | A natural language prompt to process         |

### Response

**Success Response (200 OK)**

```json
{
  "message": "Prompt received",
  "data": {
    "data_type": "barChart" | "table",
    "content": { ... } // Formatted data for frontend use
  }
}
```
- `data_type`: Defines the visualization type (barChart, table, etc.).
- `content`: Visualization configuration (e.g., labels, datasets, table rows, etc.).

**Error Response (400 Bad Request)**
```json
{
  "message": "Prompt is required",
  "data": "[]"
}
```
This occurs when the prompt parameter is missing or empty.


### Endpoint `GET /api/v1/database/schema`

### Description:
Returns the schema of the database (tables and columns), usually for use in frontend visual builders or query assistants.

### Response

**Success Response (200 OK)**
```json
{
  "tables": [
    {
      "name": string,  // Table name
      "columns": [string]  // List of column names in the table
    },
    {
      ...
    }
  ]
}
```

### Endpoint `GET /api/v1/database/query`

### Description:
Executes a **raw or generated SQL query** against the database and returns the result set.

### Query Parameters

| Name    | Type   | Required | Description                                  |
|---------|--------|----------|----------------------------------------------|
| sql     | string | Yes      | SQL query to be executed                     |


### Response

**Success Response (200 OK)**
```json
{
  "results": [
    { "column1": "value1", "column2": "value2" }, // Example row
    { "column1": "value3", "column2": "value4" } // Another row
  ]
}
```

## 7. 🧪 Tests & Code Quality
Tool used:
- `rubocop`: Ruby linter

Useful commands:
```bash
docker exec -it idyie-api-application sh
bundle exec rubocop
```

## 8. 🔄 Continuous Integration (CI)
### CI Pipeline

GitHub Actions (or GitLab CI) is used to:
- Check code quality with RuboCop
- Build and push Docker images
<!-- - Run tests -->

### CI Configuration
The CI is run on every push to the `main` branch and on pull requests. The configuration is in the `.github/workflows/ci.yml` file.

## 9. 📚 Appendices
### Glossary
- CI: Continuous Integration

### Useful links
- [GitHub Repository](https://github.com/IdyieOrg/IdyieAPI)
- [Github Organization](https://github.com/IdyieOrg)
- [CI Dashboard](https://github.com/IdyieOrg/IdyieAPI/actions/)
<!-- - Swagger API Documentation (if available) -->

### Conventions
- Ruby style: official guidelines + Rubocop
