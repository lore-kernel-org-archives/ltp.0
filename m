Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N3wjG-0002YQ-9W
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 19:01:42 +0000
Received: from mail-pw0-f48.google.com ([209.85.160.48])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N3wj8-0006Jt-Cs
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 19:01:42 +0000
MIME-Version: 1.0
In-Reply-To: <4AEAF762.3050205@linux.vnet.ibm.com>
References: <1256909081.13702.14.camel@subratamodak.linux.ibm.com>
	<4AEAF762.3050205@linux.vnet.ibm.com>
Date: Fri, 30 Oct 2009 12:01:28 -0700
Message-ID: <364299f40910301201x3e185385ndf8a33b892426773@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP fails to build for Application Code Coverage
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>, ltp-coverage <ltp-coverage@lists.sourceforge.net>

On Fri, Oct 30, 2009 at 7:25 AM, Peter Oberparleiter
<oberpar@linux.vnet.ibm.com> wrote:
> Hi Subrata,
>
> Subrata Modak wrote:
>> # make CFLAGS=3D\ -fprofile-arcs\ -ftest-coverage\ -Wall
> [...]
>> gcc =A0 ltp-pan.o zoolib.o splitstr.o -lm =A0-o ltp-pan
>> ltp-pan.o: In function `run_child':
>> ltp-pan.c:(.text+0x6d54): undefined reference to `__gcov_fork'
>
> we already solved this issue via ST but I'll still post the result here
> for reference: to prevent this particular error, you'll need to also
> provide the additional linker option -coverage.
>
> As not all ltp Makefile work well when specifying CFLAGS and LDFLAGS on
> the make command line, you'll need to specify those during the configure
> step, i.e.
>
> ./configure CFLAGS=3D"-fprofile-arcs -ftest-coverage" LDFLAGS=3D"-coverag=
e"
> make

    Correct. I updated INSTALL to explicitly state `do not define
CFLAGS, CPPFLAGS, etc' on the command line with make. People need to
either specify the right values to configure, and/or modify the values
in include/mk/config.mk (which gets produced by configure).
Thanks,
-Garrett

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
