Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PFNs8-0002Xy-No
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 09:18:40 +0000
Received: from out20.sjc.mx.trendmicro.com ([216.99.131.77])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PFNs7-0004o3-1t
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 09:18:40 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001cb7c0a$343bc2c0$9cb34840$@co.jp>
	<AANLkTi=3PpaGkchzV7Zw282=+nRjtLjBqHug+cVQAywq@mail.gmail.com>
In-Reply-To: <AANLkTi=3PpaGkchzV7Zw282=+nRjtLjBqHug+cVQAywq@mail.gmail.com>
Date: Mon, 8 Nov 2010 18:18:27 +0900
Message-ID: <000001cb7f25$e73440f0$b59cc2d0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] About "make autotools" failure
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Friday, November 05, 2010 10:16 AM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] About "make autotools" failure
> =

> On Thu, Nov 4, 2010 at 3:22 AM, Mitani <mitani@ryobi.co.jp> wrote:
> > Hi,
> >
> >
> > I tried to build LTP with today's git "ltp-40be648.tar.gz".
> > But "make autotools" failed in my all systems.
> >
> > ------------
> > sed -n '1{s:LTP-:m4_define([LTP_VERSION],[:;s:$:]):;p;q}'
> ChangeLog >
> > m4/ltp-version.m4
> > aclocal -I m4
> > autoconf
> > autoheader
> > automake -c -a
> > configure.ac:18: installing `./config.guess'
> > configure.ac:18: installing `./config.sub'
> > configure.ac:4: installing `./install-sh'
> > configure.ac:4: installing `./missing'
> > set -x; \
> > =A0 =A0 =A0 =A0cd testcases/kernel/syscalls/pcllib && \
> > =A0 =A0 =A0 =A0aclocal && \
> > =A0 =A0 =A0 =A0autoconf && \
> > =A0 =A0 =A0 =A0autoheader && \
> > =A0 =A0 =A0 =A0automake --add-missing
> > + cd testcases/kernel/syscalls/pcllib
> > + aclocal
> > + autoconf
> > configure.in:11: error: possibly undefined macro: AC_PROG_LIBTOOL
> > =A0 =A0 =A0If this token and others are legitimate, please use
> m4_pattern_allow.
> > =A0 =A0 =A0See the Autoconf documentation.
> > make: *** [testcases/kernel/syscalls/pcllib/configure] Error 1
> > ------------
> >
> > The environments of my systems are as follows:
> > =A0- RHEL4.8 (kernel version 2.6.9-89) =A0 --- (x86, x86_64, ia64)
> > =A0- RHEL5.5 (kernel version 2.6.18-194) --- (x86, x86_64, ia64)
> >
> >
> > I use "automake", "autoconf" and "m4" whose versions are same as
> > written in "INSTALL" file:
> > ------------
> > [root@RHEL55-64-LTP ~]# automake --version
> > automake (GNU automake) 1.10.2
> > Copyright (C) 2008 Free Software Foundation, Inc.
> > License GPLv2+: GNU GPL version 2 or later
> > <http://gnu.org/licenses/gpl.html>
> > This is free software: you are free to change and redistribute it.
> > There is NO WARRANTY, to the extent permitted by law.
> >
> > Written by Tom Tromey <tromey@redhat.com>
> > =A0 =A0 =A0 and Alexandre Duret-Lutz <adl@gnu.org>.
> > [root@RHEL55-64-LTP ~]# autoconf --version
> > autoconf (GNU Autoconf) 2.61
> > Copyright (C) 2006 Free Software Foundation, Inc.
> > This is free software. =A0You may redistribute copies of it under the
> terms of
> > the GNU General Public License
> <http://www.gnu.org/licenses/gpl.html>.
> > There is NO WARRANTY, to the extent permitted by law.
> >
> > Written by David J. MacKenzie and Akim Demaille.
> > [root@RHEL55-64-LTP ~]# m4 --version
> > GNU M4 1.4.7
> > Copyright (C) 2006 Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions. =A0There
> is NO
> > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> PURPOSE.
> >
> > Written by Rene' Seindal.
> > [root@RHEL55-64-LTP ~]#
> > ------------
> >
> >
> >
> > By the way, in today's git "ltp-40be648.tar.gz",
> "${LTPROOT}/testcases/
> > kernel/syscalls/pcllib/aclocal.m4" is overwritten after failure of
> > "make autotools" command.
> > But, in older gits "ltp-7e2cbbd", "${LTPROOT}/testcases/kernel/
> > syscalls/pcllib/aclocal.m4" is not overwritten after success of
> > "make autotools" command.
> > Why?
> =

>     I was trying to get rid of autogenerated files, but unfortunately
> I was only half successful. I'll restore the original files if I can't
> get the whole thing to work tonight (please try installing the libtool
> package to see if the problem goes away though first).
> Thanks and sorry for the inconvenience,
> -Garrett


I'm sorry for late reply.
I succeeded "make autotools" with today's git "ltp-882ad81.tar.gz".

Thank you--

-Tomonori Mitani



---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
