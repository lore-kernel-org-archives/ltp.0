From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 15 Feb 2018 16:56:08 +0100
Subject: [LTP] Running LTP on kernel space level
In-Reply-To: <AM6PR0402MB360578DF56B563C98863641DACF70@AM6PR0402MB3605.eurprd04.prod.outlook.com>
References: <AM6PR0402MB360503053318028A05D51B39ACF70@AM6PR0402MB3605.eurprd04.prod.outlook.com>
 <20180212102100.GD9145@rei.lan>
 <AM6PR0402MB360578DF56B563C98863641DACF70@AM6PR0402MB3605.eurprd04.prod.outlook.com>
Message-ID: <87zi4aw8kn.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Islam Helmy writes:

> Hello,
>
> Sorry for not being that clear,
>
> Currently what I am trying to achieve is to use ltp to isolate the testing of an embedded linux SW to test only and verify the updates @ Kernel space level, for example, we are developing some device drivers which handles the communication protocols or Buses like PCIe,spi, ..etc. Another use case is if we enabled some specific kernel configuration options to add a new feature to the kernel we want to test the impact of this change only on (startup time, kernel image size, general performance behaviour)
>

So you have your own kernel branch? Then you atleast want to run
./runltp -f syscalls and ./runltp -f cve. You should also be running the
kernel self tests.

> Aside from that, we have also a set of user-space application, rfs, and libraries on top of this kernel space layer, in which it serves for the end user functionality.
>
> What i needed to check if it's feasible to isolate the testing of
> kernel space layer and to execute some tests to verify the stability
> of the updates we add to the kernel, so i was asking if ltp can do
> such thing or not.
> For sure there are some tests which tests some userspace functions, and file system tests but those are not the tests i am interested in.
>
> I hope that was a bit clear

The LTP runs in userspace (except for a couple of kernel modules), but
it makes system calls to test inside kernel space.

> ________________________________________
> From: Cyril Hrubis <chrubis@suse.cz>
> Sent: Monday, February 12, 2018 12:21 PM
> To: Islam Helmy
> Cc: ltp@lists.linux.it
> Subject: Re: [LTP] Running LTP on kernel space level
>
> Hi!
>> I need to know what is the feasibility for running ltps only on kernel
>> space level , so now i have a kernel space sw and user space sw so i
>> needed to know whether i can use ltps for testing only the kernel
>> space level and the updates introduced by my team and use ltp as a
>> regression test suite , is that possible ?
>
> Sorry I do not understand what you are trying to achieve. Can you
> elaborate a bit more what you are trying to do and be more specific
> about the actual end goal?
>
> --
> Cyril Hrubis
> chrubis@suse.cz


--
Thank you,
Richard.
