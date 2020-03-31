From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Mar 2020 20:08:16 +0200
Subject: [LTP] [PATCH 2/2] device_drivers/uart01: Add uart01 test
In-Reply-To: <20200330152122.GA2699@yuki.lan>
References: <20200327134707.4532-1-chrubis@suse.cz>
 <20200327134707.4532-3-chrubis@suse.cz>
 <CAF12kFteeJ6nerju6kwX+Ebzrzd_JPCiJ9jKW4tX9F4Y4s7FEg@mail.gmail.com>
 <20200330152122.GA2699@yuki.lan>
Message-ID: <20200331180816.GE2900@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Thank you porting the serialcheck.c into LTP
> > I am sorry to find the serialcheck have not LOOPBACK mode support
> > the LOOPBACK mode is a better test than HW flow , because most machine's
> > uart have not connect the Rx & TX
> > in LOOPBACK mode. we test the uart port directly, So we can test one uart
> > port Rx and Tx functions at the same time .
> > here is the diff  serialcheck with loopback patch
> > So I'd prefer use loopback mode test the uart in case.
> > $ diff serialcheck.c serialcheck-with-loopback.c
> 
> Thanks for the hint, I had no idea that subset serial port hardware has
> a loopback test that could be enabled in modem control register which is
> meant for testing. I will have a closer look tomorrow.

If I understand this properly if we set a bit in the modem control
register we will test mostly the circuits between CPU and UART
controller which is better than nothing, but we are not really testing
if the port speed was set correctly since the data are just being copied
between registers in the UART controller, so it does not make sense to
change the speed in this mode. Or am I mistaken?

Also it does not seem to work for me and I've tried with both serial
ports on my desktop PC as well as with USB-to-Serial dongle. I can set
the bit just fine but loopback does not work.

-- 
Cyril Hrubis
chrubis@suse.cz
