SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export ARCH=x86_64
JVM=zulu17.50.19-ca-fx-jdk17.0.11-linux_x64
set -e
ZIP=$JVM.tar.gz
export JAVA_HOME=$HOME/bin/java17/
if test -d $JAVA_HOME/$JVM/; then
  echo "$JAVA_HOME exists."
else
	rm -rf $JAVA_HOME
	mkdir -p $JAVA_HOME
	wget https://cdn.azul.com/zulu/bin/$ZIP 
	tar -xvzf $ZIP -C $JAVA_HOME
	mv $JAVA_HOME/$JVM/* $JAVA_HOME/
fi
BOWLER=bowler/BowlerStudio.jar
if test -f $BOWLER; then 
	echo "Bowler Jar exists"
else
	mkdir -p bowler/
	wget https://github.com/CommonWealthRobotics/BowlerStudio/releases/latest/download/BowlerStudio.jar -O $BOWLER
fi

./gradlew shadowJar
