FROM python:3.9

WORKDIR /app

ADD requirements.txt ./
RUN pip install -r requirements.txt
ADD ./ ./
EXPOSE 8000
CMD ["gunicorn", "main.wsgi", "--bind", "0.0.0.0:8000"]