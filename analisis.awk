BEGIN {
total_solicitudes = 0
tamano_respuestas_servidor = 0
numero_errores_ser = 0
}
{
total_solicitudes++

ip = $1
url = $7
estado = $9
bytes = $10

tamano_respuestas_servidor += bytes

#identificar recursos (url)
recurso[url]++

#identificar las ips
ip_unicas[ip]++
for(ip in ip_unicas){
ips[ip]
}

#identificar errores del usuario
if(estado>=400 && estado<500){
error_us[estado]++
}

#identificar errores del servidor
if(estado>=500 && estado<600){
error_ser[estado]++
numero_errores_ser++
}

} 

END{
print "Estadísticas Generales:"
print "Número total de solicitudes:", total_solicitudes
print "Tamaño total de respuestas:", tamano_respuestas_servidor , "bytes"
print "Número total de errores de servidor:" , numero_errores_ser
print "Recursos más solicitados:"
for(url in recurso){
print url, recurso[url], "solicitudes"
}
print "\n"
print "Errores de servidor:"
for(estado in error_ser){
print estado, "-", error_ser[estado], "veces"
}
print "\n"
print "Errores de cliente:"
for(estado in error_us){
print estado, "-", error_us[estado], "veces"
}
}