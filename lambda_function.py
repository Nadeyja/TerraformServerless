import json
import math

a = 1.40e-3
b = 2.37e-4
c = 9.90e-8

def lambda_handler(event, context):
    data = json.loads(event['body']) if event.get('body') else event
    sensor_id = data.get('sensor_id')
    R = data.get('value')

    if not 1 <= R <= 20000:
        return {
            'error': "VALUE_OUT_OF_RANGE"
        }

    t = 1 / (a + b * math.log(R) + c * math.pow(math.log(R), 3)) - 273.15

    if -273.15 <= t < 20:
        return{
            'sensor_id': sensor_id,
            'temperature': t,
            'status': "TEMPERATURE_TOO_LOW"
        }
    if 20 <= t < 100:
        return{
            'sensor_id': sensor_id,
            'temperature': t,
            'status': "OK"
        }
    if 100 <= t < 250:
        return{
            'sensor_id': sensor_id,
            'temperature': t,
            'status': "TEMPERATURE_TOO_HIGH"
        }
    if t >= 250:
        return{
            'sensor_id': sensor_id,
            'temperature': t,
            'status': "TEMPERATURE_CRITICAL"
        }
