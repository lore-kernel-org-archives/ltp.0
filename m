From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Jun 2020 11:29:40 +0200
Subject: [LTP] [Automated-testing] [PATCH 1/2] tst_test: Add support for
 device discovery
In-Reply-To: <adafab63-4390-a4a3-b3aa-923b31d5ac37@xilinx.com>
References: <20200623112827.10744-1-chrubis@suse.cz>
 <20200623112827.10744-2-chrubis@suse.cz>
 <574e52f4-8988-a562-57c5-274a86e6e8cb@xilinx.com>
 <20200624090523.GA29350@yuki.lan>
 <adafab63-4390-a4a3-b3aa-923b31d5ac37@xilinx.com>
Message-ID: <20200624092940.GA30917@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> Not exactly sure how LTP handles this in general but I think it makes
> >> sense to extend your test (txt_test) parameters to pass TX/RX channel
> >> via parameters directly to test.
> >>
> >> Something like this
> >> uart01_115200 uart01 -b 115200 -t /dev/ttyXX0 -r /dev/ttyXX1
> > 
> > You can pass them in an environment variables. If UART_TX and UART_RX
> > are set the device discovery is not attempted at all and the test just
> > uses these.
> > 
> > If they are not the script is executed and the test loops over the
> > result(s). It would be more complicated if the devices were passed over
> > command line parameters since we would have to re-execute the binary.
> 
> I didn't run LTP for quite a long time myself but on xilinx devices you
> have 3 different uart instances which you can wire: cadence uart (or
> pl011), ns16550 and uartlite.
> That means with the same hw design you should be able to to test
> cadence<=>ns16550 and ns16550<=>uartlite. It means you need to exchange
> variables in the middle of testing.

The whole point of the script is that it returns one configuration per
line and the test then loops over these, which is a bit more flexible
than runtest files.

> Not sure if this is supported but I would simply generate runtest
> description based on information I got from device discovery.
> But I am far from testing at this stage.

The direction I would like to take in the long term is to slowly get rid
of runtest files and replace them with database that would be used by
the test execution framework to execute tests. There are too many
limitations that are imposed by runtest files, which in the end shape
the ways we think about tests. We should have get rid of these long time
ago...

-- 
Cyril Hrubis
chrubis@suse.cz
