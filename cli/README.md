## Using EBF cli tool

1. Install Pre-requisites on your linux machine
  * [curl](https://curl.haxx.se/)
  * [jq](https://stedolan.github.io/jq/)
2. Clone board-farm-rest-api repository
```
git clone https://github.com/TimesysGit/board-farm-rest-api.git
```
3. copy ebf tool to /usr/local/bin
```
sudo cp board-farm-rest-api/ebf-cli/ebf /usr/local/bin/ebf
```
4. Provide executable permission
```
sudo chmod a+x /usr/local/bin/ebf
```
5. Run below help command to see supported options and commands
```
ebf help
```
