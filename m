From: Tim.Bird@sony.com <Tim.Bird@sony.com>
Date: Fri, 26 Feb 2021 19:20:48 +0000
Subject: [LTP] [Automated-testing] [PATCH v2 0/5] Another attempt at
 hardware discovery
In-Reply-To: <20210224165045.17738-1-chrubis@suse.cz>
References: <20210224165045.17738-1-chrubis@suse.cz>
Message-ID: <BYAPR13MB2503F63EE761C8A8FC98E3DDFD9D9@BYAPR13MB2503.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Here are some questions and feedback on the proposal.

> -----Original Message-----
> From: automated-testing@lists.yoctoproject.org <automated-testing@lists.yoctoproject.org> On Behalf Of Cyril Hrubis
> 
> This is a second attempt on hardware discovery LTP support. The main
> difference between the previous attempts is that this version uses JSON,
> which allows us propagate structured data to the test.

JSON seems like a good choice.  In my experience, if a test is written
in a language where json-handling is not easy (e.g. shell scripts), there
are options for dealing with this.  For example, you could require 'jq'
on the system where the shell script runs.  It's not that bad of a dependency
IMHO.

> 
> This is still an early protototype but I'm sending it out to get more
> feedback before I continue to work on it.
> 
> So how is this supposed to work:
> 
> * Test that needs particular hardware sets the needs_hardware filed in
>   the test test structure. This is a free form string, in the uart
>   example it's called 'UART-loopback'. If we ever add a test for i2c
>   eeprom it would be probably called 'I2C-eeprom', etc.

Sounds good.  It will be good to standardize on these strings
in the long run.  For now, just picking strings and trying to reconcile
them later seems OK.

> 
> * The test library takes this and passes it to the hardware discovery
>   script/binary.

This is probably in the patch set, but how is this invoked?
Does the script have a well-known name or location?

> The example script that is included in this patchset
>   just hardcodes configuration for a usb-to-serial cable. In real world
>   lab this would be either prepared for each board specifically and
>   injected to the filesystem before the test happens, or may be a simple
>   script that calls curl with a request to a lab sever, etc.

Either of these seem like workable approaches.  In the case of
injecting it into the filesystem, do you have any
ideas where you would inject these?  For example,
would they go somewhere under /etc, or in /usr/test/conf?

Is this something that only the hardware discovery program
needs to know?  Or do tests use this data directly?

This seems like a rendezvous point between
the hardware discovery program and the lab management
system, so IMHO it should be well-defined.

> 
> * The output from the script is a JSON object. If there is a need to
>   reconfigure lab hardware before the test, the JSON contains a path to
>   a script/binary that has to be called to do so.

That's interesting.

> Again this may be a
>   script that calls curl with a request to a lab sever which would, for
>   example, interconnect different serial ports with relays.
> 
>   The parameter to that script is an unique ID for the hardware
>   configuration that is listed in each hardware configuration in the
>   hwconfs array of objects that follows.
> 
>   I'm not sure if this actually belongs there, maybe it would be
>   cleaner to have one reconfigure script for the whole LTP and we would
>   pass the needs_hardware content as well as the unique ID, e.g.
> 
>   'hardware-reconfigure.sh UART-loopback ttyUSB0-ttyS0'
> 
>   but that is a minor detail that could be easily sorted out later.
> 
> 
>   The most important part of the JSON is the hwconfs array, which
>   consists of hardware description objects, which, apart form the uid,
>   are not interpreted by the library, but rather passed to the test. The
>   test library loops over the array and forks a testrun for each entry
>   in the array.
> 
>   Each iteration of the test then gets it's parameters as a JSON object.
>   In the case of the UART one of the objects in the array looks like:
> 
>   {
>     "uid": "ttyUSB0-ttyUSB0-01",
>     "rx": "ttyUSB0",
>     "tx": "ttyUSB0",
>     "hwflow": 0,
>     "baud_rates": [
>      9600,
>      19200
>     ]
>   }
> 
>   Which is mostly self-explanatory, the test then parses the structure
>   and executes one test per each baud rate.
> 
>   What is still missing is the ability to pass the JSON hardware
>   description directly to the test, so that we can execute the test
>   manually, but that would be fairly easy to add.

OK - let me describe what I had in mind for a test where the serial
port was not in loopback mode, to see how it relates to the proposed
architecture.  The gpio version of this is implemented in the board
farm REST API, but the serial port testing version of this is still
under consideration:

Here's how the test would work, for a serial port transmission test where
the transmitting side of the serial line was on the DUT and the other side was
managed by the lab hardware:
 - 1) the test discovers the hardware for DUT endpoint of the serial line
    using the hardware discovery program
 - 2) the test discovers the hardware for the lab endpoint (receiving end)
    of the serial line using the hardware discovery program
 - 3) the test discovers the available baud rates from the hardware discovery
    program
 - 4) the test configures the lab endpoint for reception
 - 5) the test configures the DUT endpoint for transmission
 - 6) the test loops over the baud rate values, doing the following (7-13):
    - 7) use a curl interface or local program to set the receive baud rate of the lab endpoint
    - 8) use a curl interface or local program to request serial capture of the lab endpoint
    - 9) configure the baud rate of the DUT endpoint
    - 10) send data through the DUT endpoint
    - 11) use a curl interface or local program to cause the lab endpoint to stop capturing data
    - 12) use a curl interface or local program to request the capture data from the lab endpoint
    - 13) compare data that was received with the data that was intended to be transmitted

These roles could also be reversed (ie, have the lab endpoint be the sender
and the DUT endpoint be the receiver).

The process of configuring the baud rate seems like it corresponds
with the hardware_reconfigure.sh script.  But maybe you were only
thinking of have this actually set up physical connections, and not
manage connection/bus settings.

In any event, maybe the hardware_reconfigure.sh script could know
about 'start data capture', 'stop data capture', and 'get captured data'
operations, or maybe this should be a separate script.

This is structured in a generic way, because I think different tests
(such as audio testing, video testing, power measurement testing,
CAN bus testing, i2C testing, gpio testing, etc. can all be fit into this
model of testing by:
  discovering bus endpoints, configuring bus parameters,
  transmitting or generating data, capturing data
  comparing data

So far, I don't see anything in LTP proposal that precludes this model of testing.
There may be more to add - either extending hardware_reconfigure.sh
or adding a new command that a test would use interactively to
cause data to be exchanged and allow it to be compared.

So - it looks good to me!
 -- Tim

> 
> Cyril Hrubis (5):
>   lib: tst_cmd: Make tst_cmd() usable for global paths
>   lib: Add minimalistic json parser
>   lib: Add hardware discovery code
>   Sample hardware discovery and reconfigure scripts
>   testcases: uart01: Add.
> 
>  hardware-discovery.sh                         |  36 +
>  hardware-reconfigure.sh                       |   3 +
>  include/tst_hwconf.h                          |  13 +
>  include/tst_json.h                            | 177 +++++
>  include/tst_test.h                            |   3 +
>  lib/tst_cmd.c                                 |   2 +-
>  lib/tst_hardware.c                            | 218 ++++++
>  lib/tst_hardware.h                            |  83 +++
>  lib/tst_json.c                                | 679 ++++++++++++++++++
>  lib/tst_test.c                                |  30 +
>  runtest/device_drivers                        |   2 +
>  testcases/kernel/device-drivers/Makefile      |   1 +
>  .../kernel/device-drivers/uart/.gitignore     |   1 +
>  testcases/kernel/device-drivers/uart/Makefile |   3 +
>  testcases/kernel/device-drivers/uart/uart01.c | 620 ++++++++++++++++
>  15 files changed, 1870 insertions(+), 1 deletion(-)
>  create mode 100755 hardware-discovery.sh
>  create mode 100755 hardware-reconfigure.sh
>  create mode 100644 include/tst_hwconf.h
>  create mode 100644 include/tst_json.h
>  create mode 100644 lib/tst_hardware.c
>  create mode 100644 lib/tst_hardware.h
>  create mode 100644 lib/tst_json.c
>  create mode 100644 runtest/device_drivers
>  create mode 100644 testcases/kernel/device-drivers/uart/.gitignore
>  create mode 100644 testcases/kernel/device-drivers/uart/Makefile
>  create mode 100644 testcases/kernel/device-drivers/uart/uart01.c
> 
> --
> 2.26.2

