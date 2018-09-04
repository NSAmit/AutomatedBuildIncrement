# Assume that I have MyApp as a repository and my project root folder is also MyApp.

echo "Lets update the build number for featire releases"
echo "Creating temp folder as ~/Documents/TempCadenceIosBuildIncrement/"
mkdir ~/Documents/TempIosBuildIncrement/
cd ~/Documents/TempIosBuildIncrement/
echo "Cloning Repo of master branch....."
git clone https://gitlab.com/MyApp.git 	# clone your master branch here.
echo "Clonned successfully. Updating build number now using PlistBuddy"
cd MyApp/ 								# get into the project directory.
buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" ./MyApp/Info.plist) 
buildNumber=$(($buildNumber + 1)) 		# increment the build number
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" ./MyApp/Info.plist 
echo "Build Number Updated Successfully."
echo "Cruising for commit action...."
# VIMP next step - commit the updates to repo making sure it will skip CI/CD jobs. 
# e.g. "[ci skip]" in case of Gitlab
git commit -m <Appropriate commit message to skip CI/CD jobs> -- MyApp/Info.plist 
git push
echo "Pushed code successfully...."
# Lets delete the temp folder as it is not at all required anymore. 
# Also, will be easy for next time execution of this script.
echo "Deleting the temp folder now..."
cd ..
cd ..
rm -Rf TempIosBuildIncrement/	
echo "Deleted successfully...Done!"