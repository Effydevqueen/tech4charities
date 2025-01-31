# Use the official Python image from the Docker Hub
FROM python:3.11

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /code

# Install system dependencies
RUN apt-get update \
    && apt-get install -y \
    libmariadb-dev-compat \
    libmariadb-dev \
    gcc \
    pkg-config \
    && apt-get clean

# Install python dependencies
COPY requirements.txt /code/
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Copy project
COPY . /code/

# Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
