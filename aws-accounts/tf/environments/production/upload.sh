mkdir -p ./build # create build directory
cp handler.py ./build # copy handler.py code to build directory
cp requirements.txt ./build # copy requirements.txt code to build directory (this is like your package.json)
pip install --target ./build -r requirements.txt # this is like your npm install command (install dependencies into build directory)
'C:/Program Files/7-Zip/7z.exe' a -r build.zip ./build/* # I'm on windows so cannot use `zip` like Linux/Mac but basically .zip the entire build directory
SHA=$(sha256sum build.zip | cut -f1 -d \ | xxd -r -p | base64) # Generate a sha256 base64 encoded string (this is what lambda requires based on TF docs)
echo $SHA # Echo for debugging purposes

# Copy .zip to s3 and append metadata `sha` including our sha256 base64 encoded value so we can use it
# to detect if the .zip differs to what our Lambda function has as it's source_code_hash
aws s3 cp ./build.zip s3://tf-state-production/lambda/build.zip --metadata sha=$SHA