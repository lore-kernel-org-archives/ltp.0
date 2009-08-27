Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MgdIy-0001M6-LQ
	for Ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 11:38:12 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 29vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MgdIt-0005Pl-IA
	for Ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 11:38:12 +0000
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by pophost.sonytel.be (Postfix) with ESMTP id D6B9044483
	for <Ltp-list@lists.sourceforge.net>;
	Thu, 27 Aug 2009 13:38:01 +0200 (CEST)
Date: Thu, 27 Aug 2009 13:38:01 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Message-ID: <alpine.LRH.2.00.0908271336370.28293@vixen.sonytel.be>
MIME-Version: 1.0
Subject: [LTP] [PATCH] file: Autodetect RPM topdir
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

Query RPM for the location of the RPM topdir, instead of guessing,
which failed on YDEL6 (/usr/src/yellowdog) and Debian/Ubuntu (/usr/src/rpm)

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 testcases/commands/ade/file/file_test.sh |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/testcases/commands/ade/file/file_test.sh b/testcases/commands/=
ade/file/file_test.sh
index f59b0c6..5fa287b 100755
--- a/testcases/commands/ade/file/file_test.sh
+++ b/testcases/commands/ade/file/file_test.sh
@@ -474,13 +474,8 @@ export TST_COUNT=3D9
 $LTPBIN/tst_resm TINFO "TEST #9: file command recognizes RPM files"
 `type rpm &> /dev/null`
 if [ $? =3D 0 ]; then
-if [ -f /etc/redhat-release ]; then
-	bDIR=3D/usr/src/redhat
-	bCMD=3Drpmbuild
-else
-	bDIR=3D/usr/src/packages
-	bCMD=3Drpmbuild
-fi
+bDIR=3D$(rpm --eval "%{_topdir}")
+bCMD=3Drpmbuild
 =

 rpmversion=3D`rpm --version | awk -F ' ' '{print $3}' | cut -d '.' -f1 `
 =

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
