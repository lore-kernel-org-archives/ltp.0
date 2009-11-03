Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N5Myl-0006Dr-34
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 17:15:35 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N5Myd-0005hi-BT
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 17:15:35 +0000
Received: by pwj6 with SMTP id 6so2732779pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Nov 2009 09:15:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f40911030834w463f6aa3ga4a24d273f0142bd@mail.gmail.com>
References: <1257168835.4977.46.camel@subratamodak.linux.ibm.com>
	<200911021702.09153.vapier@gentoo.org>
	<200911031130.53505.vapier@gentoo.org>
	<364299f40911030834w463f6aa3ga4a24d273f0142bd@mail.gmail.com>
Date: Tue, 3 Nov 2009 09:15:21 -0800
Message-ID: <364299f40911030915j5848d426j1d9d14cc266457d2@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Build Fails on some archs
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Tue, Nov 3, 2009 at 8:34 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Tue, Nov 3, 2009 at 8:30 AM, Mike Frysinger <vapier@gentoo.org> wrote:
>> On Monday 02 November 2009 17:02:08 Mike Frysinger wrote:
>>> On Monday 02 November 2009 08:33:55 Subrata Modak wrote:
>>> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>>> > -I/root/subrata/ltp/ltp-full-20091031/testcases/kernel/include
>>> > -I../../../../include -I../../../../include =A0 -L../../../../lib
>>> > ptrace04.c =A0 -lltp -o ptrace04
>>> > ptrace03.c: In function 'main':
>>> > ptrace03.c:182: warning: format '%d' expects type 'int', but argument=
 3
>>> > has type 'long int'
>>> > ptrace04.c: In function 'compare_registers':
>>> > ptrace04.c:50: error: storage size of 'pt_regs' isn't known
>>> > ptrace04.c:50: warning: unused variable 'pt_regs'
>>> > make[4]: *** [ptrace04] Error 1
>>>
>>> the ptrace stuff has always been fairly unfriendly to cross-arch work.
>>> =A0we'll probably have to add header tests for a bunch of files and uni=
fy it
>>> =A0in a local ptrace.h header.
>>>
>>> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>>> > -I../../../../include -I../../../../include =A0 -L../../../../lib
>>> > tomoyo_file_test.c =A0 -o tomoyo_file_test
>>> > /tmp/ccvzdsNd.o: In function `main':
>>> > /root/subrata/ltp/ltp-full-20091031/testcases/kernel/security/tomoyo/=
newn
>>> >s. c:43: undefined reference to `clone' collect2: ld returned 1 exit
>>> > status
>>>
>>> these test cases need to be changed to the new common ltp clone code. =
=A0as
>>> =A0part of that, we should probably add a macro that changes clone() to=
 a
>>> =A0compile error so that people stop using it by accident
>>> #define clone(...) DO_NOT_USE_CLONE
>>
>> i'll take care of both of these issues if you want to look at the others
>
> Sounds good.

    I've identified the 6 issues with numa, posted a patch for one
issue, and I'll take care of the rest of them later on tonight after I
get back from work.
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
