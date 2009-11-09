Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N7aLL-0007f3-Dl
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 19:56:03 +0000
Received: from mail-pz0-f191.google.com ([209.85.222.191])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N7aLI-00073J-UU
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 19:56:03 +0000
MIME-Version: 1.0
In-Reply-To: <200911091422.07495.vapier@gentoo.org>
References: <1257220567.10382.3.camel@munipradeep-laptop>
	<200911031130.05930.vapier@gentoo.org>
	<1257788361.7677.70.camel@subratamodak.linux.ibm.com>
	<200911091422.07495.vapier@gentoo.org>
Date: Mon, 9 Nov 2009 11:55:54 -0800
Message-ID: <364299f40911091155t15fbae6am766e5e0b7b53387c@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Got warning message on ltp-full-20091031 while running
	./configure
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
Cc: ltp-list <ltp-list@lists.sf.net>

On Mon, Nov 9, 2009 at 11:22 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Monday 09 November 2009 12:39:21 Subrata Modak wrote:
>> On Tue, 2009-11-03 at 12:30 -0400, Mike Frysinger wrote:
>> > On Tuesday 03 November 2009 11:05:10 Garrett Cooper wrote:
>> > > On Tue, Nov 3, 2009 at 7:50 AM, Mike Frysinger wrote:
>> > > > On Tuesday 03 November 2009 08:01:08 Garrett Cooper wrote:
>> > > >> >> On Tue, 2009-11-03 at 09:26 +0530, Munipradeep Beerakam wrote:
>> > > >> >> > I got the following warning messages while running
>> > > >> >> > "./configure" on the ltp-full-20091031. However, make and ma=
ke
>> > > >> >> > install worked fine.
>> > > >> >> >
>> > > >> >> > configure: WARNING: linux/genetlink.h: present but cannot be
>> > > >> >> > compiled configure: WARNING: linux/genetlink.h: =A0 =A0 chec=
k for
>> > > >> >> > missing prerequisite headers?
>> > > >> >> > configure: WARNING: linux/genetlink.h: see the Autoconf
>> > > >> >> > documentation configure: WARNING: linux/genetlink.h:
>> > > >> >> > section "Present But Cannot Be Compiled"
>> > > >> >> > configure: WARNING: linux/genetlink.h: proceeding with the
>> > > >> >> > preprocessor's result
>> > > >> >> > configure: WARNING: linux/genetlink.h: in the future, the
>> > > >> >> > compiler will take precedence
>> > > >> >> > configure: WARNING: =A0 =A0 ##
>> > > >> >> > ------------------------------------------------ ##
>> > > >> >> > configure: WARNING: =A0 =A0 ## Report this to
>> > > >> >> > ltp-results@lists.sourceforge.net ##
>> > > >> >> > configure: WARNING: =A0 =A0 ##
>> > > >> >> > ------------------------------------------------ ##
>> > > >>
>> > > >> =A0 =A0 Yeah -- I need to find the header that defines u32 (inste=
ad of
>> > > >> uint32 or uint32_t). Does anyone know which one was that again? I
>> > > >> thought it was a kernel specific datatype (and in that event it
>> > > >> shouldn't be exported).
>> > > >
>> > > > correct -- nothing in userspace should be using u32. =A0if the ker=
nel
>> > > > headers are, they're broken and need fixing, so complain to lkml/y=
our
>> > > > distro.
>> > >
>> > > =A0 =A0 That's what I figured -- ok. The test and the app should als=
o be
>> > > converted to straight linux/genetlink.h, because linux/genetlink.h is
>> > > a superset of linux/netlink.h.
>> >
>> > we should get Subrata to generate the release with newer versions of
>> > autotools (like autoconf-2.64) so that these warnings dont show up. =
=A0if
>> > the header cant
>>
>> I upgraded my system to 2.64 just now.
>>
>> $ /usr/bin/autoconf --version
>> autoconf (GNU Autoconf) 2.64
>> Copyright (C) 2009 Free Software Foundation, Inc.
>> License GPLv2+: GNU GPL version 2 or later
>> <http://gnu.org/licenses/old-licenses/gpl-2.0.html>
>> This is free software: you are free to change and redistribute it.
>> There is NO WARRANTY, to the extent permitted by law.
>> Written by David J. MacKenzie and Akim Demaille.
>>
>> Hope this would solve all such problems.
>
> well, the configure script wasnt really broken before. =A0people just cant
> handle any sort of warning message and reading the related log files can =
be
> too much.

    I think we're kind of at fault for not having AC_MSG_INFO instead
of AC_MSG_WARN, but oh well... AC_MSG_WARN is designed to be terse :].
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
