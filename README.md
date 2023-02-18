# luaScan
This is a fast and lightweight scanner that utilizes Masscan to find open ports on target hosts
and after that it runs nmap on those open ports.

-----------------------------------------------------------------------------------------------
### Usage
```bash
./luaScan.lua [-h] -t <target> [-p <ports>] -r <rate>

./luaScan.lua -t 10.0.0.0/24 -r 25600
```
-p option is to define ports for Masscan to scan

-r option is for packet rate for Masscan
