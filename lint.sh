#! /usr/bin/bash

set -x
set -e

MAX_LINE_LENGTH=120

echo "Check format with black"
poetry run black -l $MAX_LINE_LENGTH --check .

echo "Check imports with isort"
poetry run isort --profile black --check .

echo "Lint with flake8"
poetry run flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics  --extend-exclude=.venv
poetry run flake8 . --count --exit-zero --max-complexity=10 --max-line-length=$MAX_LINE_LENGTH --statistics --extend-exclude=.venv

echo "Lint with pylint"
poetry run pylint --disable=C0114,C0115,C0116 --max-line-length=120 src/

echo "Security analysis with bandit"
poetry run bandit -r src/ --exclude .venv

echo "Type checking with mypy"
poetry run mypy
