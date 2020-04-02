From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Apr 2020 13:23:09 +0200
Subject: [LTP] [PATCH 2/2] device_drivers/uart01: Add uart01 test
In-Reply-To: <CAF12kFvDv8ksxMLDyniwQ=hty6J4Oy5-wvErX=DLrfWmhiwT0w@mail.gmail.com>
References: <20200327134707.4532-1-chrubis@suse.cz>
 <20200327134707.4532-3-chrubis@suse.cz>
 <CAF12kFteeJ6nerju6kwX+Ebzrzd_JPCiJ9jKW4tX9F4Y4s7FEg@mail.gmail.com>
 <20200330152122.GA2699@yuki.lan> <20200331180816.GE2900@yuki.lan>
 <CAF12kFs6H1FgU_77MAMhrn1pK15fp1cx+9wox4k9LN5GxCN=nA@mail.gmail.com>
 <20200401131220.GA3627@yuki.lan>
 <CAF12kFsFsG6Jk0citiGmicq+dyB90i_cG_bcDAMhHiyVPafRdA@mail.gmail.com>
 <20200402093127.GA28452@yuki.lan>
 <CAF12kFvDv8ksxMLDyniwQ=hty6J4Oy5-wvErX=DLrfWmhiwT0w@mail.gmail.com>
Message-ID: <20200402112309.GA5732@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am sorry that when I run the serialcheck on my laptop,
> there always has some error as follow,which mean I cannot
> verify the serialcheck on my computer for now.
> Failed to ioctl(,TIOCGICOUNT,)  -- test ttyUSB0

This one can be ignored, that just means that the counters are not
implemented and the statistics are not printed at the test end.

> tcgetattr() failed: Input/output error -- test ttyS0
> I am trying to find available machine and then run test.

That looks like there is no UART to begin with.

-- 
Cyril Hrubis
chrubis@suse.cz
