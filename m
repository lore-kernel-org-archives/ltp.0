From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Mar 2020 17:21:22 +0200
Subject: [LTP] [PATCH 2/2] device_drivers/uart01: Add uart01 test
In-Reply-To: <CAF12kFteeJ6nerju6kwX+Ebzrzd_JPCiJ9jKW4tX9F4Y4s7FEg@mail.gmail.com>
References: <20200327134707.4532-1-chrubis@suse.cz>
 <20200327134707.4532-3-chrubis@suse.cz>
 <CAF12kFteeJ6nerju6kwX+Ebzrzd_JPCiJ9jKW4tX9F4Y4s7FEg@mail.gmail.com>
Message-ID: <20200330152122.GA2699@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thank you porting the serialcheck.c into LTP
> I am sorry to find the serialcheck have not LOOPBACK mode support
> the LOOPBACK mode is a better test than HW flow , because most machine's
> uart have not connect the Rx & TX
> in LOOPBACK mode. we test the uart port directly, So we can test one uart
> port Rx and Tx functions at the same time .
> here is the diff  serialcheck with loopback patch
> So I'd prefer use loopback mode test the uart in case.
> $ diff serialcheck.c serialcheck-with-loopback.c

Thanks for the hint, I had no idea that subset serial port hardware has
a loopback test that could be enabled in modem control register which is
meant for testing. I will have a closer look tomorrow.

-- 
Cyril Hrubis
chrubis@suse.cz
