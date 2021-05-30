#! /usr/bin/bash

set -x
set -e

MAX_LINE_LENGTH=120

echo "Check format with black"
poetry run black -l $MAX_LINE_LENGTH --check .

poetry run isort --profile black --check .

echo "Lint with flake8"
poetry run flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics  --extend-exclude=.venv
poetry run flake8 . --count --exit-zero --max-complexity=10 --max-line-length=$MAX_LINE_LENGTH --statistics --extend-exclude=.venv

echo "Run bandit"
poetry run bandit -r src/ --exclude .venv
