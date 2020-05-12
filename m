From: Cixi Geng <gengcixi@gmail.com>
Date: Tue, 12 May 2020 10:32:52 +0800
Subject: [LTP] [PATCH 2/2] device_drivers/uart01: Add uart01 test
In-Reply-To: <20200511093730.GD3070@yuki.lan>
References: <CAF12kFs6H1FgU_77MAMhrn1pK15fp1cx+9wox4k9LN5GxCN=nA@mail.gmail.com>
 <20200401131220.GA3627@yuki.lan>
 <CAF12kFsFsG6Jk0citiGmicq+dyB90i_cG_bcDAMhHiyVPafRdA@mail.gmail.com>
 <20200402093127.GA28452@yuki.lan>
 <CAF12kFvDv8ksxMLDyniwQ=hty6J4Oy5-wvErX=DLrfWmhiwT0w@mail.gmail.com>
 <20200402112309.GA5732@yuki.lan>
 <CAF12kFsCfb12Yi=rhAqKSLPUBLkaWPs_-JCQOcucvyu=whYFsw@mail.gmail.com>
 <CAF12kFvV=a5HJgDOAOGgdr2CMJhtVsYJ199T=SM1kyQSp-Js=w@mail.gmail.com>
 <20200408141853.GB10178@yuki.lan>
 <CAF12kFuJ=bC2ByRN7ihk=CZnA48zVW9KeAoDJO3+VcOJ13C=ug@mail.gmail.com>
 <20200511093730.GD3070@yuki.lan>
Message-ID: <CAF12kFuaM4os0aPok0YkQAqxuXDffO1mnYKxuL-8H7H_i9oFxg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> ?2020?5?11??? ??5:37???
>
> Hi!
> > I had study the ltp execution framework and found that the LTP
> > detection device is
> > not suitable for device driver test at present.
> > Like the UART test, I want have a auto-detect way to find the device
> > needed to test
> >  in the current running LtP machines.
> > Now I have test the uart case in several sprdtream Soc
> > these board  have different /dev/tty* device???and I nedd run in CI
> > manual export device puzzled me to do the auto-test-job.
> > moreover I wil  porting other device driver testcases in the future.
> > So can We expand the LTP detection ?
>
> Sorry I haven't managed to work on this before it was time for LTP
> release. I will resume my work on this once LTP is released.
>
> My generall idea is that the LTP framework will get a path to a
> directory with scripts that would be evaluated at test runtime and will
> return list of devices to test. These scripts will have to be supplied
> by the user as managing lab hardware is out of scope of the LTP
> framework.
>
> --
> Cyril Hrubis
> chrubis@suse.cz

Thank you for your guidance?In the Next time, I will try to fork a
process in serialcheck.c
So it can be test Tx & Rx at one time.And then  to develop the
detection scripts if hava a time
 I'll keep you posted on the status.
