#!/bin/bash

# Define el endpoint que deseas verificar
ENDPOINT="web-alb-testing-1239592585.us-east-1.elb.amazonaws.com"


# Función para realizar la verificación
check_endpoint() {
    # Usa curl para obtener el tiempo total de carga y el código de estado
    RESULT=$(curl -o /dev/null -s -w "%{http_code} %{time_total}\n" "$ENDPOINT")

    # Separa el código de estado y el tiempo de carga
    HTTP_CODE=$(echo $RESULT | cut -f1 -d' ')
    LOAD_TIME=$(echo $RESULT | cut -f2 -d' ')

    echo " $HTTP_CODE - $LOAD_TIME " 


    # Verifica si el código de estado es 200 (OK)
    if [ "$HTTP_CODE" -eq 200 ]; then
        echo ""
    else
        echo "El endpoint no está disponible o hay un problema (Código de Estado: $HTTP_CODE)."
    fi
}

# Bucle infinito, presiona Ctrl+C para detener
while true; do
    check_endpoint
    # Puedes añadir un sleep si quieres espaciar las comprobaciones
    sleep 1
done
