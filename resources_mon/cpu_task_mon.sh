# Creamos un bucle infinito
while true; do
  # Obtenemos el proceso que más ocupa y su uso de CPU y tiempo
  proc=$(ps -eo comm,pcpu,time --sort -pcpu | head -n 2 | tail -n 1)

  # Formateamos el output con las etiquetas <txt> y <span>
  echo $proc | awk '{
    # Mostramos el output normalmente
    printf "<txt>Uso de %s: %.0f%% (%s)</txt>\n", $1, $2, $3
  }'
  
  # Esperamos un segundo antes de repetir el bucle
  sleep 1
  
done