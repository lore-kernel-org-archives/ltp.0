From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Sep 2020 11:59:18 +0200
Subject: [LTP] LTP release
In-Reply-To: <CY4PR13MB117519BB030877EC596EDB75FD230@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <20200908153659.GA16066@yuki.lan>
 <CAEemH2eq0fwF8zt1uez5vuwM0vtrLtoFd_45sFqE=iQ8hpudfQ@mail.gmail.com>
 <CAEemH2es3sMSfAar8Xj4_Vr+2nsD0isPws4v=8=csLyYROAQGQ@mail.gmail.com>
 <20200909131327.GA3241@yuki.lan> <20200909132703.GB3241@yuki.lan>
 <CAEemH2e+Ck8M22gdgL0OQ24ekBPyDu4FwGrdG+da9E62UZWjRQ@mail.gmail.com>
 <CAEemH2eJCUuf=SQF_GdQ7U9q_8+BD9LsxPAgwuJS9wx8zBzNww@mail.gmail.com>
 <CAF12kFs+Wzm2rt5uE7WoHDXZSpdtZaZPgspKTACpYnw7zR+sgA@mail.gmail.com>
 <20200914110006.GD5524@yuki.lan>
 <CY4PR13MB117519BB030877EC596EDB75FD230@CY4PR13MB1175.namprd13.prod.outlook.com>
Message-ID: <20200915095918.GA14713@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Can we please postpone it a little bit again? I've been talking to Tim
> > Bird recenlty and he is interesting in helping to shape the interface so
> > better that it fits into existing hardware labs.
> 
> I'm very interested in this work, and how to integrate it with 
> external test frameworks that manage lab equipment (and may
> need to communicate test parameters to tests).
> 
> I'm not sure the best way to proceed.  I reviewed the device-discovery
> code on patchworks, but I'm not sure I understand the anticipated flow of
> control between the LTP test, the device discovery part, and the test
> framework.
> 
> I know you're busy with the LTP release, so I'm not sure this is the best
> time to open up a big thread asking a lot of questions about device discovery
> or describing my own proposal for this - to work towards harmonizing the two.
> 
> But I'm keen on following up on this in the short term (next 4 weeks or so).
> I'm giving a talk at Open Source Summit Europe the end of October,
> where I'll be talking about lab management APIs, and this dovetails
> into that work.
> 
> Let me know when would be a good time to try to hash this out.

I guess that I can allocate some time between pre-release testing that
will happen soon after we freeze the git.

Let me just dump what I have in mind, I guess that the proof-of-concept
and the potential directions will be easier to understand with a few
hints.

Each hardware type has a specific name that identifies it, in a case of
serial port the test requires "UART_RX" and "UART_TX" which defines an
UART loop. In a case of i2c EEPROM that would probably be
"I2C_EEPROM_ADDR" and "I2C_EEPROM_BUS" etc. This is what is going to be
used to query the lab mamagenent software and the reply would be a list
of suitable devices along with their capabilities. In a case of UART it
may be declaring supported speeds, if hardware flow is supported etc. In
a case of EEPROM it will add a device size along with the bus and
address.

The interface to the lab mamagement software was choosen to be an
executable, in the simplest cases it could be just a shell script that
enumerates all unused serial ports, in more complex cases it may connect
to a REST API on a lab management server and get the reply from there.

Once the hardware has been discovered the test will iterate over the
list of suitable devices and do a testrun for each of these. But since
some hardware needs to be possibly reserved/freed and reconfigured there
has to be hooks for that, which would be probably executables again.

The proof-of-concept that I wrote was quite simple, it includes a code
in the LTP test library that can loop over a list of available devices
returned by the discovery script and a sample empty script where the
hardware discovery code should be put into along with a UART test that
uses all that newly added functionality. There are a few open problems
with the current code though, the parameters are passed to the test via
shell variables, which is not going to work well for a more structured
data. Maybe the discovery script should return JSON which would be
translated by the shell library into a command line parameters.

Something as:

{
  "uart_tx": "/dev/ttyS0",
  "uart_rx": "/dev/ttyS1",
  "speeds": [
     "9600",
     "19200",
  ],
  "hwflow": [
   true,
   false
  ],
  "reconfigure": "/usr/bin/lab_reconfigure --connect-uart /dev/ttyS0 /dev/ttyS1"
},

Which would result in running:

	/usr/bin/lab_reconfigure --connect-uart /dev/ttyS0 /dev/ttyS1
	/opt/ltp/testcases/bin/uart01 --uart_tx "/dev/ttyS0" --uart_rx "/dev/ttyS1" --speed 9600 --hwflow true
	/opt/ltp/testcases/bin/uart01 --uart_tx "/dev/ttyS0" --uart_rx "/dev/ttyS1" --speed 9600 --hwflow false
	/opt/ltp/testcases/bin/uart01 --uart_tx "/dev/ttyS0" --uart_rx "/dev/ttyS1" --speed 19200 --hwflow true
	/opt/ltp/testcases/bin/uart01 --uart_tx "/dev/ttyS0" --uart_rx "/dev/ttyS1" --speed 19200 --hwflow false

And the test would only need to declare that it requires "UART_LOOP" or
something like that.

-- 
Cyril Hrubis
chrubis@suse.cz
