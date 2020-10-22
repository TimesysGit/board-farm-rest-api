# LAVA Integration

LAVA integration for GPIO is desined as two set of REST APIs
* North-bound REST APIs
  * Generic
  * Public facing
  * Independent of Inherent Lab Infrastructure
  * Deployed on Lava Master
 
* South-bound REST APIs
  * Specific for Lab Infrastucture, undelying GPIO control and communication is hidden beneath it i.e. GPIO Controller
  * Deployed on Lab Controller i.e. Zombie for Timesys's Lab environment


# North-bound REST APIs
LAVA REST APIs based on django-rest-framework(https://www.django-rest-framework.org/).

Below new GPIO API definitions were introduced under lava/lava_rest_app/v02/views.py where all Lava v02 definitions lies.

```
    @detail_route(methods=["get"], suffix="GPIO", url_path="gpio/(?P<command>[^/.]+)/(?P<pins>[0-9]+)")
    def gpio_read(self, request, command=None, pins=None, **kwargs):
        ts_device = self.get_object().timesysdevice
        if request.method == "GET":
            try:
                gpio_pins = int(pins)
                interface = "gpio"
                url = "http://%s/api/gpio" % ts_device.zombie.ip
                info = {
                    "interface": interface,
                    "device_num": ts_device.device_port,
                    "command": command,
                    "gpio_pins": gpio_pins,
                }
                response = requests.post(url, json=info)
                return Response(json.loads(response.content), status=status.HTTP_200_OK)
            except Exception as exc:
                return Response(
                    {"result": "fail",
                     "message": "Problem with submitted data: %s" % exc},
                    status=status.HTTP_400_BAD_REQUEST,
                )
        
    @detail_route(methods=["get"], suffix="GPIO", url_path="gpio/(?P<command>[^/.]+)/(?P<pins>[0-9]+)/(?P<data>[0-9]+)")
    def gpio_write(self, request, command=None, pins=None, data=None, **kwargs):
        ts_device = self.get_object().timesysdevice
        if request.method == "GET":
            try:
                gpio_pins = int(pins)
                gpio_data = int(data)
                interface = "gpio"
                url = "http://%s/api/gpio" % ts_device.zombie.ip
                info = {
                    "interface": interface,
                    "device_num": ts_device.device_port,
                    "command": command,
                    "gpio_pins": gpio_pins,
                    "gpio_data": gpio_data,
                }
                response = requests.post(url, json=info)
                return Response(json.loads(response.content), status=status.HTTP_200_OK)
            except Exception as exc:
                return Response(
                    {"result": "fail",
                     "message": "Problem with submitted data: %s" % exc},
                    status=status.HTTP_400_BAD_REQUEST,
                )
```








