FROM python:3.6.5

# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1
RUN mkdir /app
WORKDIR /app
COPY requirements.txt /app/
COPY .env /app/
# WORKDIR /app
RUN pip install --upgrade pip

RUN pip install -r requirements.txt

COPY . /app/

EXPOSE 8000

# CMD ["python", "manage.py", "runserver"]

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]