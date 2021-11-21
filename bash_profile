export PATH="$PATH:/Users/blacktulip/Library/Python/2.7/bin"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
alias ipython='python2.7 -m IPython'
alias python='python2.7'
alias e='emacs'

JAVA_HOME=`/usr/libexec/java_home`
echo $JAVA_HOME
export JAVA_HOME
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

export CATALINA_HOME=/opt/apache-tomcat-9.0.55
