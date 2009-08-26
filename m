Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MgJq6-0006ui-Px
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 14:51:06 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 72vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MgJq1-0005U4-GN
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 14:51:06 +0000
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by pophost.sonytel.be (Postfix) with ESMTP id B221344483
	for <Ltp-list@lists.sourceforge.net>;
	Wed, 26 Aug 2009 16:50:52 +0200 (CEST)
Date: Wed, 26 Aug 2009 16:50:52 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Message-ID: <alpine.LRH.2.00.0908261650390.28998@vixen.sonytel.be>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Spelling fixes: excute => execute
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

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 .../sched/hyperthreading/ht_affinity/HTaffinity.c  |    2 +-
 .../sched/hyperthreading/ht_enabled/HTenabled.c    |    2 +-
 .../hyperthreading/ht_interrupt/HTinterrupt.c      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/HTaffinity.c=
 b/testcases/kernel/sched/hyperthreading/ht_affinity/HTaffinity.c
index ff96173..fa2d254 100644
--- a/testcases/kernel/sched/hyperthreading/ht_affinity/HTaffinity.c
+++ b/testcases/kernel/sched/hyperthreading/ht_affinity/HTaffinity.c
@@ -234,7 +234,7 @@ int main(int argc, char *argv[])
 {
 =

 #ifndef __i386__
-	tst_brkm(TCONF, NULL, "This test suite can only excute on i386 architectu=
re.");
+	tst_brkm(TCONF, NULL, "This test suite can only execute on i386 architect=
ure.");
 #else
 	if (!check_ht_capability())
 	{
diff --git a/testcases/kernel/sched/hyperthreading/ht_enabled/HTenabled.c b=
/testcases/kernel/sched/hyperthreading/ht_enabled/HTenabled.c
index 2cd2eb2..8cbb13c 100644
--- a/testcases/kernel/sched/hyperthreading/ht_enabled/HTenabled.c
+++ b/testcases/kernel/sched/hyperthreading/ht_enabled/HTenabled.c
@@ -23,7 +23,7 @@ int main(int argc, char *argv[])
 {
 	int ret_val =3D 1;
 #ifndef __i386__
-	tst_brkm(TCONF, NULL, "This test suite can only excute on i386 architectu=
re.");
+	tst_brkm(TCONF, NULL, "This test suite can only execute on i386 architect=
ure.");
 #else
 		ret_val =3D check_ht_capability();
 #endif
diff --git a/testcases/kernel/sched/hyperthreading/ht_interrupt/HTinterrupt=
.c b/testcases/kernel/sched/hyperthreading/ht_interrupt/HTinterrupt.c
index 4207c6d..a09fffd 100644
--- a/testcases/kernel/sched/hyperthreading/ht_interrupt/HTinterrupt.c
+++ b/testcases/kernel/sched/hyperthreading/ht_interrupt/HTinterrupt.c
@@ -112,7 +112,7 @@ int main(int argc, char *argv[])
 	tst_resm(TINFO, "Begin: HyperThreading Interrupt");
 =

 #ifndef __i386__
-	tst_brkm(TCONF, NULL, "This test suite can only excute on i386 architectu=
re.");
+	tst_brkm(TCONF, NULL, "This test suite can only execute on i386 architect=
ure.");
 #else
 	if (!check_ht_capability())
 	{
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
