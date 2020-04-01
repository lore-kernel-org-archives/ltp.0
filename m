From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Apr 2020 15:12:21 +0200
Subject: [LTP] [PATCH 2/2] device_drivers/uart01: Add uart01 test
In-Reply-To: <CAF12kFs6H1FgU_77MAMhrn1pK15fp1cx+9wox4k9LN5GxCN=nA@mail.gmail.com>
References: <20200327134707.4532-1-chrubis@suse.cz>
 <20200327134707.4532-3-chrubis@suse.cz>
 <CAF12kFteeJ6nerju6kwX+Ebzrzd_JPCiJ9jKW4tX9F4Y4s7FEg@mail.gmail.com>
 <20200330152122.GA2699@yuki.lan> <20200331180816.GE2900@yuki.lan>
 <CAF12kFs6H1FgU_77MAMhrn1pK15fp1cx+9wox4k9LN5GxCN=nA@mail.gmail.com>
Message-ID: <20200401131220.GA3627@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >If I understand this properly if we set a bit in the modem control
> >register we will test mostly the circuits between CPU and UART
> >controller which is better than nothing, but we are not really testing
> >if the port speed was set correctly since the data are just being copied
> >between registers in the UART controller, so it does not make sense to
> >change the speed in this mode. Or am I mistaken?
> 
> >Also it does not seem to work for me and I've tried with both serial
> >ports on my desktop PC as well as with USB-to-Serial dongle. I can set
> >the bit just fine but loopback does not work.
> 
> In the loopback mode , the data will be transferred in buffer ,and back to
> CPU
> by FIFO way.
> I understand the test flow is CPU->uart Tx-> buffer file->uart Rx->CPU,
> so it does make sense to the uart driver .

Indeed but it does not make sense tu run it with a different baud rates,
since the data are not transmitted at all.

>  BTW??? I found the latest seriacheck git is
> https://github.com/nsekhar/serialcheck.git
> and I test on my arm64 machine of sprdtream. and it does works.
> the test log I had send in another patch
> https://patchwork.ozlabs.org/patch/1264553/

Unfortunately it does not seem to work on my AMD based desktop at all,
my guess is that the loopback bit is silently ignored by the hardware.

Which means that we cannot enable the test by default in loopback mode
after all.

-- 
Cyril Hrubis
chrubis@suse.cz
