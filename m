Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MgKIx-0005WU-80
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 15:20:55 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 3b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MgKIs-0002rb-Jn
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 15:20:55 +0000
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by pophost.sonytel.be (Postfix) with ESMTP id DD52044483
	for <Ltp-list@lists.sourceforge.net>;
	Wed, 26 Aug 2009 17:20:44 +0200 (CEST)
Date: Wed, 26 Aug 2009 17:20:44 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Message-ID: <alpine.LRH.2.00.0908261719130.29807@vixen.sonytel.be>
MIME-Version: 1.0
Subject: [LTP] [PATCH] su01: Yellow Dog Linux doesn't support passwd -e
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
Is there any better way to handle this??

 testcases/commands/su/su01_s1 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/commands/su/su01_s1 b/testcases/commands/su/su01_s1
index 2fba82b..b676f84 100755
--- a/testcases/commands/su/su01_s1
+++ b/testcases/commands/su/su01_s1
@@ -406,7 +406,7 @@ if { ($displayed_error=3D=3D1) && ($exit_code!=3D0) && =
($pid>0) } {
 # Become root and expire $USER1 password
 =

 #  Skip this if Red Hat; -e option not supported.
-if { $distro !=3D "redhat" && $distro !=3D "redhat-linux" } {
+if { $distro !=3D "redhat" && $distro !=3D "redhat-linux" && $distro !=3D =
"yellowdog-linux" } {
 =

 if { $test_one_passed=3D=3D1} {
 send_user "TEST:  su to user1 with the user1 password expired.\n"
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
