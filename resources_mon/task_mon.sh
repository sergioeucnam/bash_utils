#!/bin/bash
# Este script muestra el consumo de memoria del proceso que más ocupa
# y lo pinta de diferentes colores según el porcentaje del total de la memoria

# Obtenemos la memoria total en MB
memtotal=$(free -m | grep Mem | awk '{print $2}')

# Obtenemos el proceso que más ocupa y su consumo de memoria en MB
proc=$(ps -eo comm,pmem --sort -pmem | awk -v mt=$memtotal 'NR>1 {a[$1]+=($2/100)*mt} END {for (i in a) print i, a[i]}' | sort -k2nr | head -n 1)

# Formateamos el output con las etiquetas <txt> y <span>
echo $proc | awk -v mt=$memtotal '{
  # Si el consumo de memoria supera el 30% del total
  if ($2/mt > 0.3) {
    # Mostramos el output en rojo y en negrita
    printf "<txt><span weight=\"Bold\" fgcolor=\"Red\">Consumo de %s: %.0f MB</span></txt>\n", $1, $2
  }
  # Si el consumo de memoria está entre el 25% y el 30% del total
  else if ($2/mt > 0.25) {
    # Mostramos el output en naranja y en negrita
    printf "<txt><span weight=\"Bold\" fgcolor=\"Orange\">Consumo de %s: %.0f MB</span></txt>\n", $1, $2
  }
  # Si el consumo de memoria está entre el 20% y el 25% del total
  else if ($2/mt > 0.2) {
    # Mostramos el output en amarillo y en negrita
    printf "<txt><span weight=\"Bold\" fgcolor=\"Yellow\">Consumo de %s: %.0f MB</span></txt>\n", $1, $2
  }
  # Si no
  else {
    # Mostramos el output en verde y en negrita
    printf "<txt><span weight=\"Bold\" fgcolor=\"lightgreen\">Consumo de %s: %.0f MB</span></txt>\n", $1, $2
  }
}'