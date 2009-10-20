Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1N0NNA-0006HP-MM
	for ltp-list@lists.sourceforge.net; Tue, 20 Oct 2009 22:40:08 +0000
Received: from [206.112.117.47] (helo=gateway-1237.mvista.com)
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1N0NMx-00038F-96
	for ltp-list@lists.sourceforge.net; Tue, 20 Oct 2009 22:40:03 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 20 Oct 2009 15:41:58 -0700
Message-ID: <8368651DACC1964480F951191B94A0780153DA1C@svexch01.mvista.com>
In-Reply-To: <364299f40910201351t5ccb6ei9828b41823d007d1@mail.gmail.com>
References: <8368651DACC1964480F951191B94A0780153D7EE@svexch01.mvista.com>
	<1255890114.5359.16.camel@subratamodak.linux.ibm.com>
	<364299f40910181839w5c5dc73agfa147469881d4cc3@mail.gmail.com>
	<8368651DACC1964480F951191B94A0780153D9A8@svexch01.mvista.com>
	<364299f40910201351t5ccb6ei9828b41823d007d1@mail.gmail.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] [PATCH][runtest/fs] modify fs scenario to use working
	directory specified by runltp
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Tuesday, October 20, 2009 1:52 PM
> To: Henry Yei
> Cc: subrata@linux.vnet.ibm.com; LTP Mailing List
> Subject: Re: [LTP] [PATCH][runtest/fs] modify fs scenario to use
> working directory specified by runltp
> =

> On Tue, Oct 20, 2009 at 10:53 AM, Henry Yei <hyei@mvista.com> wrote:
> >> -----Original Message-----
> >> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> >> Sent: Sunday, October 18, 2009 6:39 PM
> >> To: subrata@linux.vnet.ibm.com
> >> Cc: Henry Yei; LTP Mailing List
> >> Subject: Re: [LTP] [PATCH][runtest/fs] modify fs scenario to use
> >> working directory specified by runltp
> >>
> >> On Sun, Oct 18, 2009 at 11:21 AM, Subrata Modak
> >> <subrata@linux.vnet.ibm.com> wrote:
> >> > On Fri, 2009-10-16 at 17:03 -0700, Henry Yei wrote:
> >> >> This patch modifies the fs scenario to remove hard coded paths
> with
> >> /tmp as well as make sure that tests that take directory arguments
> use
> >> the temporary directory specified by runltp.
> >> >>
> >> >> I've chosen to pass in the temporary directory rather than change
> >> the tests themselves for certain tests take a path as an argument.
> >> >>
> >> >> Signed-off by: Henry Yei <hyei@mvista.com>
> >> >
> >> > Thanks.
> >>
> >> =A0 =A0 Dumb question (and this is part of the reason why I didn't rep=
ly
> >> earlier or check this into cvs) -- what happens if TMPDIR is unset
> or
> >> is an empty value? Another function and/or set of bourne shell calls
> >> should be added to tst_setup() in cmdlib.sh so it checks for this
> >> directory and creates it as necessary, similar to what I did in
> >> linktest.sh.
> >> Thanks,
> >> -Garrett
> >
> > AFAIK, ff the user does not use the -d command when start the tests
> from the runltp script, $TMPDIR defaults to '/tmp/'. I'm not aware of
> another way to run execute the commands in the runtest files without
> the use of runltp so I did not take that into account.
> =

>     Ah, but what about standalone execution. This is currently broken,
> is it not? Then again, this was broken even before your change I
> think...
> Thanks,
> -Garrett

When you mean standalone execution, you mean running a specific testcase on=
 the command line like below?:
growfiles -W gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glse=
ek20.2

In that case, the temporary files will be created in the current working di=
rectory that the command was invoked from.

One reason I didn't just modify the growfiles to use tst_tmpdir internally =
was because of the large amount of testcases that rely on it (all gf* and r=
wtest* testcases), some of which needs to know which directory it is workin=
g in even before growfiles is executed such as the example below. I took th=
e easy way out :)

Ex)
gf12 mkfifo gffifo17; growfiles -b -W gf12 -e 1 -u -i 0 -L 30 gffifo17














---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
