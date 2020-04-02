From: Cixi Geng <gengcixi@gmail.com>
Date: Thu, 2 Apr 2020 19:16:32 +0800
Subject: [LTP] [PATCH 2/2] device_drivers/uart01: Add uart01 test
In-Reply-To: <20200402093127.GA28452@yuki.lan>
References: <20200327134707.4532-1-chrubis@suse.cz>
 <20200327134707.4532-3-chrubis@suse.cz>
 <CAF12kFteeJ6nerju6kwX+Ebzrzd_JPCiJ9jKW4tX9F4Y4s7FEg@mail.gmail.com>
 <20200330152122.GA2699@yuki.lan> <20200331180816.GE2900@yuki.lan>
 <CAF12kFs6H1FgU_77MAMhrn1pK15fp1cx+9wox4k9LN5GxCN=nA@mail.gmail.com>
 <20200401131220.GA3627@yuki.lan>
 <CAF12kFsFsG6Jk0citiGmicq+dyB90i_cG_bcDAMhHiyVPafRdA@mail.gmail.com>
 <20200402093127.GA28452@yuki.lan>
Message-ID: <CAF12kFvDv8ksxMLDyniwQ=hty6J4Oy5-wvErX=DLrfWmhiwT0w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi
I am sorry that when I run the serialcheck on my laptop,
there always has some error as follow,which mean I cannot
verify the serialcheck on my computer for now.
Failed to ioctl(,TIOCGICOUNT,)  -- test ttyUSB0
tcgetattr() failed: Input/output error -- test ttyS0
I am trying to find available machine and then run test.

Cyril Hrubis <chrubis@suse.cz> ?2020?4?2??? ??5:31???

> Hi!
> > >Indeed but it does not make sense tu run it with a different baud rates,
> > >since the data are not transmitted at all.
> > The data exchanged between Tx|Rx and buffer have nothing to do with
> > baudrate?
> > I think the baudrate is control Tx|Rx send and receive date rate to|from
> > buffer.
>
> That's what I'm not sure about, the documentation says that in loopback
> mode data written to the port immediatelly appears on the receiving end,
> which would mean that the uart speed does not matter at all.
>
> Can you try a quick test? If you measure the time the test spends
> writing data in loopback mode for a different uart speeds and they do
> not differ the uart speed does not matter.
>
> > >Unfortunately it does not seem to work on my AMD based desktop at all,
> > >my guess is that the loopback bit is silently ignored by the hardware.
> > >Which means that we cannot enable the test by default in loopback mode
> > >after all
> > I will test on my laptop and feedback result today, if it does no work ,
> we
> > should check the uart driver what different between x86 and arm64.
>
> I bet that this differs chipset by chipset and I do not think there is
> anything wrong with the uart driver per se.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200402/d38d2ef0/attachment.htm>
