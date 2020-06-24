From: Michal Simek <michal.simek@xilinx.com>
Date: Wed, 24 Jun 2020 11:21:43 +0200
Subject: [LTP] [Automated-testing] [PATCH 1/2] tst_test: Add support for
 device discovery
In-Reply-To: <20200624090523.GA29350@yuki.lan>
References: <20200623112827.10744-1-chrubis@suse.cz>
 <20200623112827.10744-2-chrubis@suse.cz>
 <574e52f4-8988-a562-57c5-274a86e6e8cb@xilinx.com>
 <20200624090523.GA29350@yuki.lan>
Message-ID: <adafab63-4390-a4a3-b3aa-923b31d5ac37@xilinx.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 24. 06. 20 11:05, Cyril Hrubis wrote:
> Hi!
>>> +++ b/device-discovery.sh
>>> @@ -0,0 +1,5 @@
>>> +#!/bin/sh
>>> +
>>> +if [ "$1" = "UART_RX-UART_TX" ]; then
>>
>> I am not getting this condition and what exactly you want to tell by that.
>>> +	echo "UART_RX=/dev/ttyUSB0 UART_TX=/dev/ttyUSB0"
>>
>> In fpga world you can connect two uart inside chip and test different
>> device drivers that's why at the end of day only user knows which uarts
>> are connected to each other and none will be able to come up with
>> universal device-deiscovery.sh script to cover all these cases.
> 
> That's the whole point of the patchset.
> 
> This is a script I've used for testing with a hardware loopback on the
> USB-to-serial bridge, it's not supposed to be included in the end
> result. I've kept it there so that people will get the idea how it
> should look like.
> 
> Also script is passed which devices the test requests, so for i2c eeprom
> the parameters would be different and the script would output, for each
> present eeprom, a line with an address, bus, etc.
> 
> The whole point of the script is to do plug into a Lab CI so that the
> information about test device, in this case UART loops, is exposed to
> the test. In a real world situation it would either do a call to a
> whatever is maintaining a lab hardware inventory, or be written down by
> a user before these tests are executed.

I understand that you want to run a script which can be wired with Lab CI.

> 
>> Not exactly sure how LTP handles this in general but I think it makes
>> sense to extend your test (txt_test) parameters to pass TX/RX channel
>> via parameters directly to test.
>>
>> Something like this
>> uart01_115200 uart01 -b 115200 -t /dev/ttyXX0 -r /dev/ttyXX1
> 
> You can pass them in an environment variables. If UART_TX and UART_RX
> are set the device discovery is not attempted at all and the test just
> uses these.
> 
> If they are not the script is executed and the test loops over the
> result(s). It would be more complicated if the devices were passed over
> command line parameters since we would have to re-execute the binary.

I didn't run LTP for quite a long time myself but on xilinx devices you
have 3 different uart instances which you can wire: cadence uart (or
pl011), ns16550 and uartlite.
That means with the same hw design you should be able to to test
cadence<=>ns16550 and ns16550<=>uartlite. It means you need to exchange
variables in the middle of testing.

Not sure if this is supported but I would simply generate runtest
description based on information I got from device discovery.
But I am far from testing at this stage.


> 
>> IIRC RX and TX device could be the same which can mean that you want to
>> use internal or external loopbacks.
> 
> The test works fine with external loopback. We will have to add a way
> how to pass "enable loopback in MCR" to the test if we want to use that,
> but that falls under the "Missing pieces" in the patch description.

I am happy with todo. :-)

Cheers,
Michal

