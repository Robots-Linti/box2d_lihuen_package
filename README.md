Cada vez que se genere el paquete desde el SVN puede ser necesario eliminar el parche 02-autoupdate y generarlo nuevamente.

Es necesario compilar con LC_ALL=C ya que se inserta la fecha actual en un archivo .py y si la misma contiene caracteres especiales la importación del módulo falla.

Todo este procedimiento de descargar con el download.sh y modificar los parches solamente hace falta hacerlo una vez. Por ejemplo se puede hacer compilar el paquete para AMD64 y después se puede tomar el paquete fuente que se genera en ese momento para compilar el paquete para i386 sin tener que volver a descargar los fuentes del SVN oficial.

```
rm debian/patches/02-autoupdate
vi debian/patches/series # Sacar el parche autoupdate de ahí
./download.sh
cd python-box2d-23-2.3.1/
LC_ALL=C dpkg-buildpackage
dpkg-source --commit # Hacer una versión nueva del parche autoupdate, parece que hay que hacer esto cada vez que cambia el SVN, nos podemos dar cuenta porque falla al aplicar el parche cuando el mismo queda viejo
LC_ALL=C dpkg-buildpackage
```

Los primeros 2 pasos están sólo como referencia, 02-autoupdate ya fue removido en el repositorio Git para evitar problemas.
