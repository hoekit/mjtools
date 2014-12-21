mjtools
=======

Tools for running Mojolicious servers

### mj-run.pl

  Usage: mj-run.pl [start|stop|restart]

This script starts one or more Mojolicious servers as defined in the configuration file <code>config.json</code>.
An example of this file is provided below:

    { 
      "aServer"  : {
          "port"    : "1234", 
          "http"    : "http",
          "logpath" : "log/aServer-test.log",
          "dbfile"  : "db/test_aServer.db"
      }
        "anotherServer"  : {
          "port"    : "5678", 
          "http"    : "https",
          "logpath" : "log/anotherServer-test.log",
          "api_key" : "12345678"
      }
    }

<code>mj-run.pl</code> will start the script named "aServer.pl" at the specified <code>port</code> and <code>http</code> protocol. It will also run <code>tail -f</code> on the log file specified in <code>logpath</code>.


