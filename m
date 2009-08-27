Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MgguV-0002aq-Ru
	for Ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 15:29:11 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 29vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MgguR-0001hj-L7
	for Ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 15:29:11 +0000
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by pophost.sonytel.be (Postfix) with ESMTP id D965F44483
	for <Ltp-list@lists.sourceforge.net>;
	Thu, 27 Aug 2009 17:29:00 +0200 (CEST)
Date: Thu, 27 Aug 2009 17:29:00 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
Message-ID: <alpine.LRH.2.00.0908271709060.22490@vixen.sonytel.be>
References: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Annotate tst_*() helpers with __attribute__ ((format
 (printf, M,
 N))) (was: Re:  [PATCH] quotactl01: Fix tst_resm() format  causing crash)
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

On Thu, 27 Aug 2009, Geert Uytterhoeven wrote:
> When the quotactl syscall fails, quotactl01 crashes with a segmentation f=
ault
> due to an incorrect printf()-style format.

This bug encouraged me to add annotations to the test helpers that take
printf()-style formats, cfr. the patch below.

It causes a massive amount of compiler warnings, most of them caused by
TEST_ERRNO being long. According to CVS history, both TEST_RETURN and
TEST_ERRNO have been changed from int to long to accomodate 64-bit platform=
s,
but to me the change of TEST_ERRNO looks bogus.
As errno is int according to C99, TEST_ERRNO should actually be int too, ri=
ght? =


Note that there are also a few other cases where integers are used on point=
er
type format specifiers. These will cause crashes when the code path is
executed.

From 601578f79c05779acefe023fd499726d9fe4ce03 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 27 Aug 2009 17:08:18 +0200
Subject: [PATCH] Annotate tst_*() helpers with __attribute__ ((format (prin=
tf, M, N)))

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 include/test.h |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/test.h b/include/test.h
index 34ed5d2..03b0d46 100644
--- a/include/test.h
+++ b/include/test.h
@@ -186,12 +186,18 @@
  * Functions from lib/tst_res.c
  */
 const char *strttype(int ttype);
-void tst_res(int ttype, char *fname, char *arg_fmt, ...);
-void tst_resm(int ttype, char *arg_fmt, ...);
-void tst_brk(int ttype, char *fname, void (*func)(void), char *arg_fmt, ..=
.);
-void tst_brkloop(int ttype, char *fname, void (*func)(void), char *arg_fmt=
, ...);
-void tst_brkm(int ttype, void (*func)(void), char *arg_fmt, ...);
-void tst_brkloopm(int ttype, void (*func)(void), char *arg_fmt, ...);
+void tst_res(int ttype, char *fname, char *arg_fmt, ...)
+	__attribute__ ((format (printf, 3, 4)));
+void tst_resm(int ttype, char *arg_fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
+void tst_brk(int ttype, char *fname, void (*func)(void), char *arg_fmt, ..=
.)
+	__attribute__ ((format (printf, 4, 5)));
+void tst_brkloop(int ttype, char *fname, void (*func)(void), char *arg_fmt=
, ...)
+	__attribute__ ((format (printf, 4, 5)));
+void tst_brkm(int ttype, void (*func)(void), char *arg_fmt, ...)
+	__attribute__ ((format (printf, 3, 4)));
+void tst_brkloopm(int ttype, void (*func)(void), char *arg_fmt, ...)
+	__attribute__ ((format (printf, 3, 4)));
 void tst_require_root(void (*func)(void));
 int  tst_environ(void);
 void tst_exit(void) LTP_ATTRIBUTE_NORETURN;
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
