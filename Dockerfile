# Usa una imagen base con Ruby y Node.js
FROM ruby:3.3.5

# Instala Node.js y Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install -y nodejs yarn && \
    gem install rails

# Instala dependencias de build esenciales
RUN apt-get install -y build-essential libpq-dev

# Establece el directorio de trabajo
WORKDIR /myapp

# Copia el Gemfile y el Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instala las gemas necesarias
RUN bundle install

# Copia el resto del código fuente de la aplicación
COPY . .

# Expose el puerto en el que Rails escucha
EXPOSE 3000

# Comando para iniciar la aplicación Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
