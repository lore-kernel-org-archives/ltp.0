Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MgJqe-0002EJ-BI
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 14:51:40 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 72vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MgJqY-0005cH-UY
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 14:51:40 +0000
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by pophost.sonytel.be (Postfix) with ESMTP id 5D7A744483
	for <Ltp-list@lists.sourceforge.net>;
	Wed, 26 Aug 2009 16:51:29 +0200 (CEST)
Date: Wed, 26 Aug 2009 16:51:29 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Message-ID: <alpine.LRH.2.00.0908261651080.29020@vixen.sonytel.be>
MIME-Version: 1.0
Subject: [LTP] [PATCH] LTP must be extracted to an accessible location
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
To: Linux Test Project <Ltp-list@lists.sourceforge.net>

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
index 98883fb..33edddf 100644
--- a/INSTALL
+++ b/INSTALL
@@ -67,6 +67,9 @@ contributions are welcome.
 2. Untar the ltp tarball into a spare directory.  There is not a
    standard location for it yet.  We put it in our home directory
    while we're working on it.
+   Note that this location must be accessible for unprivileged users, as
+   some tests are run as a different user than root.  Hence /root is not a
+   good choice on several distributions.
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
