From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Mar 2021 12:57:58 +0100
Subject: [LTP] [Automated-testing] [PATCH v2 0/5] Another attempt at
 hardware discovery
In-Reply-To: <BYAPR13MB2503F63EE761C8A8FC98E3DDFD9D9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20210224165045.17738-1-chrubis@suse.cz>
 <BYAPR13MB2503F63EE761C8A8FC98E3DDFD9D9@BYAPR13MB2503.namprd13.prod.outlook.com>
Message-ID: <YDzWxnjM3NmXnhTY@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > * Test that needs particular hardware sets the needs_hardware filed in
> >   the test test structure. This is a free form string, in the uart
> >   example it's called 'UART-loopback'. If we ever add a test for i2c
> >   eeprom it would be probably called 'I2C-eeprom', etc.
> 
> Sounds good.  It will be good to standardize on these strings
> in the long run.  For now, just picking strings and trying to reconcile
> them later seems OK.

That's what I'm expecting there as well.

> > 
> > * The test library takes this and passes it to the hardware discovery
> >   script/binary.
> 
> This is probably in the patch set, but how is this invoked?
> Does the script have a well-known name or location?

There is a fallback to a well-known location that can be overrided with
an environment varible. This is not well designed at this point, I just
wrote a minimal amount of code for the prototype to run.

> > The example script that is included in this patchset
> >   just hardcodes configuration for a usb-to-serial cable. In real world
> >   lab this would be either prepared for each board specifically and
> >   injected to the filesystem before the test happens, or may be a simple
> >   script that calls curl with a request to a lab sever, etc.
> 
> Either of these seem like workable approaches.  In the case of
> injecting it into the filesystem, do you have any
> ideas where you would inject these?  For example,
> would they go somewhere under /etc, or in /usr/test/conf?

No idea, so far my patchset just puts it into $LTPROOT, but I guess that
/usr/test/ would be much better place. Do we have a proposal for the
/usr/test/ hierarchy somewhere?

> Is this something that only the hardware discovery program
> needs to know?  Or do tests use this data directly?

Currently it's used by the LTP test library, so it's executed by the
test binary before it forks a child that actually runs the test.

In the future it could be executed by the test driver (e.g. replacement
for ltp-pan I'm working on), which could then pass the pieces of the
JSON that describe the hardware to the test for each test invocation.
This is still under development, but I do not think that these details
matter at all, what we need at this point is to describe generic enough
information flow.

> This seems like a rendezvous point between
> the hardware discovery program and the lab management
> system, so IMHO it should be well-defined.

Couldn't agree more.

> > 
> > * The output from the script is a JSON object. If there is a need to
> >   reconfigure lab hardware before the test, the JSON contains a path to
> >   a script/binary that has to be called to do so.
> 
> That's interesting.
> 
> > Again this may be a
> >   script that calls curl with a request to a lab sever which would, for
> >   example, interconnect different serial ports with relays.
> > 
> >   The parameter to that script is an unique ID for the hardware
> >   configuration that is listed in each hardware configuration in the
> >   hwconfs array of objects that follows.
> > 
> >   I'm not sure if this actually belongs there, maybe it would be
> >   cleaner to have one reconfigure script for the whole LTP and we would
> >   pass the needs_hardware content as well as the unique ID, e.g.
> > 
> >   'hardware-reconfigure.sh UART-loopback ttyUSB0-ttyS0'
> > 
> >   but that is a minor detail that could be easily sorted out later.
> > 
> > 
> >   The most important part of the JSON is the hwconfs array, which
> >   consists of hardware description objects, which, apart form the uid,
> >   are not interpreted by the library, but rather passed to the test. The
> >   test library loops over the array and forks a testrun for each entry
> >   in the array.
> > 
> >   Each iteration of the test then gets it's parameters as a JSON object.
> >   In the case of the UART one of the objects in the array looks like:
> > 
> >   {
> >     "uid": "ttyUSB0-ttyUSB0-01",
> >     "rx": "ttyUSB0",
> >     "tx": "ttyUSB0",
> >     "hwflow": 0,
> >     "baud_rates": [
> >      9600,
> >      19200
> >     ]
> >   }
> > 
> >   Which is mostly self-explanatory, the test then parses the structure
> >   and executes one test per each baud rate.
> > 
> >   What is still missing is the ability to pass the JSON hardware
> >   description directly to the test, so that we can execute the test
> >   manually, but that would be fairly easy to add.
> 
> OK - let me describe what I had in mind for a test where the serial
> port was not in loopback mode, to see how it relates to the proposed
> architecture.  The gpio version of this is implemented in the board
> farm REST API, but the serial port testing version of this is still
> under consideration:
> 
> Here's how the test would work, for a serial port transmission test where
> the transmitting side of the serial line was on the DUT and the other side was
> managed by the lab hardware:
>  - 1) the test discovers the hardware for DUT endpoint of the serial line
>     using the hardware discovery program
>  - 2) the test discovers the hardware for the lab endpoint (receiving end)
>     of the serial line using the hardware discovery program
>  - 3) the test discovers the available baud rates from the hardware discovery
>     program
>  - 4) the test configures the lab endpoint for reception
>  - 5) the test configures the DUT endpoint for transmission
>  - 6) the test loops over the baud rate values, doing the following (7-13):
>     - 7) use a curl interface or local program to set the receive baud rate of the lab endpoint
>     - 8) use a curl interface or local program to request serial capture of the lab endpoint
>     - 9) configure the baud rate of the DUT endpoint
>     - 10) send data through the DUT endpoint
>     - 11) use a curl interface or local program to cause the lab endpoint to stop capturing data
>     - 12) use a curl interface or local program to request the capture data from the lab endpoint
>     - 13) compare data that was received with the data that was intended to be transmitted
> 
> These roles could also be reversed (ie, have the lab endpoint be the sender
> and the DUT endpoint be the receiver).
> 
> The process of configuring the baud rate seems like it corresponds
> with the hardware_reconfigure.sh script.  But maybe you were only
> thinking of have this actually set up physical connections, and not
> manage connection/bus settings.
> 
> In any event, maybe the hardware_reconfigure.sh script could know
> about 'start data capture', 'stop data capture', and 'get captured data'
> operations, or maybe this should be a separate script.
>
> This is structured in a generic way, because I think different tests
> (such as audio testing, video testing, power measurement testing,
> CAN bus testing, i2C testing, gpio testing, etc. can all be fit into this
> model of testing by:
>   discovering bus endpoints, configuring bus parameters,
>   transmitting or generating data, capturing data
>   comparing data

I guess that we need two more generic scripts in the format then, one
called before the test starts and one called after the test has
finished.

So something as:

{
  "pre_test": "/path/to/pre_script.sh",
  "post_test": "/path/to/post_script.sh",
  "hwconfs": [
    ...
  ]
}

And these scripts would need to actually be called before each test and
get JSON as a parameter as well.

e.g. for a serial port described as:

{
  "uid": "ttyUSB0-ttyUSB0-01",
  "rx": "ttyUSB0",
  "tx": "ttyUSB0",
  "hwflow": 0,
  "baud_rates": [
   9600,
   19200
  ]
}

We would get following:

------------------------------

* pre_script.sh gets passed following JSON:

{
  "uid": "ttyUSB0-ttyUSB0-01",
  "rx": "ttyUSB0",
  "tx": "ttyUSB0",
  "hwflow": 0,
  "baud_rate": 9600
}

* test is executed

* post_script.sh gets passed following JSON

{
  "uid": "ttyUSB0-ttyUSB0-01",
}

------------------------------

* pre_script.sh gets passed following JSON

{
  "uid": "ttyUSB0-ttyUSB0-01",
  "rx": "ttyUSB0",
  "tx": "ttyUSB0",
  "hwflow": 0,
  "baud_rate": 19200
}

* test is executed

* post_script.sh gets passed following JSON

{
  "uid": "ttyUSB0-ttyUSB0-01",
}

------------------------------

This changes things a bit, this means that the pre_script has to be
executed before each test execution and it's actually passed a JSON data
rather than simple value. So the test would need to serialize the data
and send the request instead.

The question is how should we propagate data to the test from a
post_script.sh. I guess that the output should be JSON as well and in a
case of binary data it should include a path to a file, since binary
does not work well for JSON.

So in the case of UART capture test the output from post_script.sh would
be something as:

{
	"capture": "/path/to/capture/file.bin"
}

Also in a case that we want the lab to send some binary data to the UART
during the test the pre_script.sh would get something as:

{
  "uid": "ttyUSB0-ttyUSB0-01",
  "hwflow": 0,
  "baud_rate": 19200,
  "transmit": "/path/to/transmit/file.bin"
}

However this means that the test needs to listen even before we call
this script, which again complicates things a bit.

> So far, I don't see anything in LTP proposal that precludes this model of testing.
> There may be more to add - either extending hardware_reconfigure.sh
> or adding a new command that a test would use interactively to
> cause data to be exchanged and allow it to be compared.

Indeed, this is hard to desing especially since I do have very limited
set of usecases at the moment. But at least your UART case helped a lot,
thanks!

-- 
Cyril Hrubis
chrubis@suse.cz
