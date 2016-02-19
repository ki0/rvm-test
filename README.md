# rvm-test

Antes de levantar las máquinas virtuales debemos generar los ficheros de nuestra aplicación para sistemas Debiann/Ubuntu:
```
scripts/init.sh
```
Esto instalará todo lo necesarios para usar Ruby on Rails y generará la estructura de directorios de la aplicación en el directorio deployed, los vagrant tienen el directorio completo exportado por NFS a /var/www en la máquina de la aplicación, es decir, que los despliegues serán automáticos.
Para generar nuestro "hello world" primero tenemos que crearnos un controlador:
```
cd deployed/hello/; rails generate controller welcome
```
Editamos el fichero app/controllers/welcome_controller.rb y añadimos esto:
```
def home
    @greeting = "Hello P161!"
end
```
Ahora creamos una vista, editar app/views/welcome/home.html.erb
```
<h1><%= @greeting %></h1>
```
Por último editamos la fichero de rutas, config/routes.rb, y añadimos
```
root to: 'welcome#home'
```
Asegurarse que el directorio app/views/layouts no exitas.
```
rm -rf app/views/layouts
```
Como hemos dicho el despligue será automático porque el directorio esta exportado por NFS.
Finalmente editamos el fichero config/database.yml, que tiene que quedar así:
```
default: &default
  adapter: postgresql
  encoding: unicode
  pool: 5

development:
  <<: *default
  database: hello_development
  username: postgres
  host: db.dev.rvm-test.es
  port: 5432

test:
  <<: *default
  database: hello_test
  username: postgres
  host: db.dev.rvm-test.es
  port: 5432

production:
  <<: *default
  database: hello_production
  username: postgres
  host: db.dev.rvm-test.es
  port: 5432
```

Antes de levantar las máquinas virtuales necesitamos tener dos plugins de vagrant:
```
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-hosts
vagrant up
```



