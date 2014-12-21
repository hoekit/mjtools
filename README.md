mjtools
=======

Tools for running Mojolicious servers

### mj-run.pl

    Usage: mj-run.pl [start|stop|restart]

This script *starts* one or more Mojolicious servers as defined in the configuration file <code>config.json</code>.

An example of this file is provided below:

    { 
        "aServer"  : {
            "port"    : "1234", 
            "http"    : "https",
            "logpath" : "log/aServer.log",
            "dbfile"  : "db/test_aServer.db"
      }
        "anotherServer"  : {
            "port"    : "5678", 
            "http"    : "https",
            "logpath" : "log/anotherServer.log",
            "api_key" : "12345678"
      }
    }

<code>mj-run.pl</code> will start the script named "aServer.pl" at the
specified <code>port</code> and <code>http</code> protocol. It will also run
<code>tail -f</code> on the log file specified in <code>logpath</code>.

### configure_env

    Usage: configure_env [TEST|PROD]

This script creates JSON files for different deployment environments from a
master JSON file named <code>tools/config_all.json</code>.

An example of this file as follows:

    { 
        "PROD" : { 
            "aServer"  : {
                "port"    : "1234",
                "http"    : "https",
                "logpath" : "log/aServer-prod.log",
                "dbfile"  : "db/aServer.db"
            }
        },
        "TEST" : { 
            "aServer"  : {
                "port"    : "2234", 
                "http"    : "https",
                "logpath" : "log/aServer-test.log",
                "dbfile"  : "db/test_aServer.db"
            }
        },

        "_output_files" : [ "config.json", "www/js/config.json" ]
    }

The script simply writes the JSON that matches the environment e.g.
<code>PROD</code> and writes it to the list of files specified in
<code>_output_files</code>.

### Using the scripts

The usual practice will be to specify all the configuration info in a
<code>config_all.json</code> file. Then run <code>configure_env</code> to
generate the <code>config.json</code> file required by <code>mj-run.pl</code>.
And finally run mj-run.pl to start the server(s).

