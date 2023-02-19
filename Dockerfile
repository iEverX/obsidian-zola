FROM python:3.11.2

RUN pip3 install python-slugify rtoml && \
    wget -O zola.tar.gz https://github.com/getzola/zola/releases/download/v0.17.0/zola-v0.17.0-x86_64-unknown-linux-gnu.tar.gz && \
    tar zxf zola.tar.gz && mkdir -p /app/bin && cp zola /app/bin/
COPY . /app/obsidian-zola
ENV PATH $PATH:/app/bin
ENV VAULT  /app/vault
WORKDIR /app/obsidian-zola
CMD ["./build.sh"]

