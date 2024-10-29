@echo off
echo The following Maven command installs your Maven-built Java application
echo into the local Maven repository, which will ultimately be stored in
echo Jenkins's local Maven repository (and the "maven-repository" Docker data volume).

mvn jar:jar install:install help:evaluate -Dexpression=project.name

echo The following command extracts the value of the <name/> element within <project/> of your Java/Maven project''s "pom.xml" file.
for /f "tokens=*" %%i in ('mvn -q -DforceStdout help:evaluate -Dexpression=project.name') do set NAME=%%i

echo The following command extracts the value of the <version/> element within <project/> instead.
for /f "tokens=*" %%i in ('mvn -q -DforceStdout help:evaluate -Dexpression=project.version') do set VERSION=%%i

echo The following command runs and outputs the execution of your Java application (which Jenkins built using Maven) to the Jenkins UI.
java -jar target\%NAME%-%VERSION%.jar