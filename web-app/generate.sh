# Delete old json file and resources folder (even if it's got folders within in)
[ -e kiosk-poc.json ] && rm kiosk-poc.json
rm -r ../resources/* 2>/dev/null

cp web-app.json ../kiosk-poc.json
# create a new resources folder
mkdir -p ../resources
mkdir -p ../resources/images/weather-icons/day
mkdir -p ../resources/images/weather-icons/night
cp index.html ../resources/index.html
cp defaultCityList.js ../resources/defaultCityList.js
cp styles.css ../resources/styles.css
cp -vr images/weather-icons/day/* ../resources/images/weather-icons/day
cp -vr images/weather-icons/night/* ../resources/images/weather-icons/night
pushd ..
./package.sh
popd
cp ../kiosk-poc.zip kiosk-poc.zip

# clean up
rm ../kiosk-poc.json
rm ../kiosk-poc.zip
rm -r ../resources