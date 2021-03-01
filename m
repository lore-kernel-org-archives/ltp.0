From: Cixi Geng <gengcixi@gmail.com>
Date: Mon, 1 Mar 2021 18:30:19 +0800
Subject: [LTP] [PATCH v2 0/5] Another attempt at hardware discovery
In-Reply-To: <20210224165045.17738-1-chrubis@suse.cz>
References: <20210224165045.17738-1-chrubis@suse.cz>
Message-ID: <CAF12kFtuFvVnykBbcGsgsc_LYuh541SfA9P_RV88KzwFjuTsxg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> ?2021?2?25??? ??12:49???
>
> This is a second attempt on hardware discovery LTP support. The main
> difference between the previous attempts is that this version uses JSON,
> which allows us propagate structured data to the test.
>
> This is still an early protototype but I'm seding it out to get more
> feedback before I continue to work on it.
>
> So how is this supposed to work:
>
> * Test that needs particular hardware sets the needs_hardware filed in
>   the test test structure. This is a free form string, in the uart
>   example it's called 'UART-loopback'. If we ever add a test for i2c
>   eeprom it would be probably called 'I2C-eeprom', etc.
I think this has many advantages over the first edition, In out Internal Test?
we use a similar way to define the test prerequires as JSON structor.[1]
here is My opinion, In the LTP testcase framework, we can set all the
prerequires
in a JSONfile, these prerquires include CONFIGS,  ABIs,
devices-path(sys?proc,dev etc.),
the SETUP stage  to check if the machine satisfy the defined-Json.
at the same time? we also need a scripts to generate a JSON-file from
the current machine to collect all the prerequires list.
In this way, the benefit not just device-driver, but alse common testcase
>
> * The test library takes this and passes it to the hardware discovery
>   script/binary. The example scipt that is included in this patchset
>   just hardcodes configuration for a usb-to-serial cable. In real world
>   lab this would be either prepared for each board specifically and
>   injected to the filesystem before the test happens, or may be a simple
>   script that calls curl with a request to a lab sever, etc.
>
> * The output from the script is a JSON object. If there is a need to
>   reconfigure lab hardware before the test, the JSON contains a path to
>   a script/binary that has to be called to do so. Again this may be a
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
>

[1] https://github.com/gengcixi/kernel_feature_check
