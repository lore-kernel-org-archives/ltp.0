Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MgbbM-0004ys-4z
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 09:49:04 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 1b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MgbbH-0004Dr-Uj
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 09:49:04 +0000
Date: Thu, 27 Aug 2009 11:48:53 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <200908261548.58741.vapier@gentoo.org>
Message-ID: <alpine.LRH.2.00.0908271148120.22490@vixen.sonytel.be>
References: <alpine.LRH.2.00.0908261651080.29020@vixen.sonytel.be>
	<200908261548.58741.vapier@gentoo.org>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] LTP must be extracted to an accessible location
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Wed, 26 Aug 2009, Mike Frysinger wrote:
> On Wednesday 26 August 2009 10:51:29 Geert Uytterhoeven wrote:
> > --- a/INSTALL
> > +++ b/INSTALL
> > @@ -67,6 +67,9 @@ contributions are welcome.
> >  2. Untar the ltp tarball into a spare directory.  There is not a
> >     standard location for it yet.  We put it in our home directory
> >     while we're working on it.
> > +   Note that this location must be accessible for unprivileged users, =
as
> > +   some tests are run as a different user than root.  Hence /root is n=
ot a
> > +   good choice on several distributions.
> =

> i would use the phrase "full path to this location".  non-root could acce=
ss =

> ./foo/, but it could not access $PWD/foo/ ...
> -mike

Thanks, that's indeed better!

From 741d03a6753015ba6373d1f629f4117f978d6129 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date: Wed, 26 Aug 2009 16:24:59 +0200
Subject: [PATCH] LTP must be extracted to an accessible location

If extracted to /root and /root has permissions 750, the following
tests will fail:

  - cron02:

    bash: /root/ltp-cvs/testcases/bin/cron_pos_tests.sh: Permission denied

  - cron_allow01:

    bash: /root/ltp-cvs/testcases/bin/cron_allow01: Permission denied
    bash: /root/ltp-cvs/testcases/bin/cron_allow01: Permission denied

  - cron_deny01:

    bash: /root/ltp-cvs/testcases/bin/cron_deny01: Permission denied
    bash: /root/ltp-cvs/testcases/bin/cron_deny01: Permission denied

  - su01:

    bash: /root/ltp-cvs/testcases/bin/su01_s1: Permission denied

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 INSTALL |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/INSTALL b/INSTALL
index 98883fb..73ff29c 100644
--- a/INSTALL
+++ b/INSTALL
@@ -67,6 +67,9 @@ contributions are welcome.
 2. Untar the ltp tarball into a spare directory.  There is not a
    standard location for it yet.  We put it in our home directory
    while we're working on it.
+   Note that the full path to this location must be accessible for
+   unprivileged users, as some tests are run as a different user than root.
+   Hence /root is not a good choice on several distributions.
 =

 3. Run "make" to build everything.
    *NOTE: Some of the Makefiles (example: pan/Makefile) require the lex (or
-- =

1.6.2.4

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
