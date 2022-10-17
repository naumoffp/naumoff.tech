FROM python:3.10.1

LABEL author="Peter Naumoff"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
# ENV PRODUCTION True
ENV PORT 8080

WORKDIR /code
COPY src/ .

# RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ENTRYPOINT [ "python", "./minister.py"]
ENTRYPOINT ["sh", "boot.sh"]
