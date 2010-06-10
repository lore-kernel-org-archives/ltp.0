Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1OMcG7-0005c2-SD
	for ltp-list@lists.sourceforge.net; Thu, 10 Jun 2010 07:33:03 +0000
Received: from out20.sjc.mx.trendmicro.com ([216.99.131.77])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OMcG3-0004zE-Rg
	for ltp-list@lists.sourceforge.net; Thu, 10 Jun 2010 07:33:03 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.27])
	by out20.sjc.mx.trendmicro.com (Postfix) with ESMTP id BDADE980437
	for <ltp-list@lists.sourceforge.net>;
	Thu, 10 Jun 2010 07:32:52 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 129863DD01B
	for <ltp-list@lists.sourceforge.net>;
	Thu, 10 Jun 2010 07:32:51 +0000 (UTC)
Message-ID: <000001cb086a$f2fc55d0$d8f50170$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 10 Jun 2010 16:02:54 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_16_02_55_Thursday_June_10_2010_28441"
Content-Language: ja
Subject: [LTP] [PATCH] fix "mail" test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: kamimura@ryobi.co.jp

This is a multi-part message in MIME format.

----=_NextPart_ST_16_02_55_Thursday_June_10_2010_28441
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I want to suggest a patch for #2 test of "mail_tests.sh".

The failure of #2 is as following:
------------
mail_tests::mail02    0  TINFO  :  Test #2: mail u...@bad-domain will result
in failure
mail_tests::mail02    0  TINFO  :  Test #2: to deliver the mail. Mailer
daemon should
mail_tests::mail02    0  TINFO  :  Test #2: report this failure.
mail_tests::mail02    2  TFAIL  :  Test #2: No new mail for root. Reason:
No mail for root
------------

I use RHEL5.4, RHEL4.8 systems and x86, x86_64, ia64 architectures.
"#2" test failed in all combinations.

At "#2" test, there is "No mail for root" in "tst_mail.res" file.
I want to add this condition to judgment for "tst_mail.res".

The other day, I made a question  whether #2 test failed or not 
in other systems. 
 -->http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10184.html
But I have received no reply yet. Therefore I don't know about other 
systems, and I made this revision to become effective for only RHEL 
systems.


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

============
--- a/testcases/commands/mail/mail_tests.sh	2010-06-02
21:46:46.000000000 +0900
+++ b/testcases/commands/mail/mail_tests.sh	2010-06-09
15:33:19.000000000 +0900
@@ -140,14 +140,18 @@
 
 export TCID=mail_tests::mail02
 export TST_COUNT=2
-RC=0
 RC1=0
 RC2=0
+RC3=0
+RC4=0
 
 tst_resm TINFO "Test #2: mail user@bad-domain will result in failure"
 tst_resm TINFO "Test #2: to deliver the mail. Mailer daemon should"
 tst_resm TINFO "Test #2: report this failure."
 
+tvar=${MACHTYPE%-*}
+tvar=${tvar#*-}
+
 # Don't use underscores in domain names (they're illegal)...
 mail -s "Test" root@thisdomaindoesnotexist < $LTPTMP/tst_mail.in \
 	> $LTPTMP/tst_mail.out 2>&1
@@ -190,9 +194,16 @@
 		    $LTPTMP/tst_mail.res)
 	fi
 	if [ -z "$RC1" -a -z "$RC2" -a -z "$RC3" ]; then
-		tst_res TFAIL $LTPTMP/tst_mail.res \
-		    "Test #2: No new mail for root. Reason:"
-		: $(( TFAILCNT += 1 ))
+		RC4=$(awk '{print match($1 $2 $3, "Nomailfor")}' \
+        	    $LTPTMP/tst_mail.res)
+		if [ \( "$tvar" = "redhat" -o "$tvar" = "redhat-linux" \) -a
-n "$RC4" ]; then
+			tst_resm TPASS \
+				"Test #2: No new mail for root as expected"
+		else
+			tst_res TFAIL $LTPTMP/tst_mail.res \
+			    "Test #2: No new mail for root. Reason:"
+			: $(( TFAILCNT += 1 ))
+		fi
 	else
 
 		if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 -ne 0 -a $RC3 -ne
0 ]; then
============



Regards--

-Tomonori Mitani

----=_NextPart_ST_16_02_55_Thursday_June_10_2010_28441
Content-Type: application/octet-stream;
	name="mail_tests.sh.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mail_tests.sh.patch"

--- a/testcases/commands/mail/mail_tests.sh=092010-06-02 21:46:46.000000000=
 +0900=0A+++ b/testcases/commands/mail/mail_tests.sh=092010-06-09 15:33:19.=
000000000 +0900=0A@@ -140,14 +140,18 @@=0A =0A export TCID=3Dmail_tests::ma=
il02=0A export TST_COUNT=3D2=0A-RC=3D0=0A RC1=3D0=0A RC2=3D0=0A+RC3=3D0=0A+=
RC4=3D0=0A =0A tst_resm TINFO "Test #2: mail user@bad-domain will result in=
 failure"=0A tst_resm TINFO "Test #2: to deliver the mail. Mailer daemon sh=
ould"=0A tst_resm TINFO "Test #2: report this failure."=0A =0A+tvar=3D${MAC=
HTYPE%-*}=0A+tvar=3D${tvar#*-}=0A+=0A # Don't use underscores in domain nam=
es (they're illegal)...=0A mail -s "Test" root@thisdomaindoesnotexist < $LT=
PTMP/tst_mail.in \=0A =09> $LTPTMP/tst_mail.out 2>&1=0A@@ -190,9 +194,16 @@=
=0A =09=09    $LTPTMP/tst_mail.res)=0A =09fi=0A =09if [ -z "$RC1" -a -z "$R=
C2" -a -z "$RC3" ]; then=0A-=09=09tst_res TFAIL $LTPTMP/tst_mail.res \=0A-=09=
=09    "Test #2: No new mail for root. Reason:"=0A-=09=09: $(( TFAILCNT +=3D=
 1 ))=0A+=09=09RC4=3D$(awk '{print match($1 $2 $3, "Nomailfor")}' \=0A+    =
    =09    $LTPTMP/tst_mail.res)=0A+=09=09if [ \( "$tvar" =3D "redhat" -o "=
$tvar" =3D "redhat-linux" \) -a -n "$RC4" ]; then=0A+=09=09=09tst_resm TPAS=
S \=0A+=09=09=09=09"Test #2: No new mail for root as expected"=0A+=09=09els=
e=0A+=09=09=09tst_res TFAIL $LTPTMP/tst_mail.res \=0A+=09=09=09    "Test #2=
: No new mail for root. Reason:"=0A+=09=09=09: $(( TFAILCNT +=3D 1 ))=0A+=09=
=09fi=0A =09else=0A =0A =09=09if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 -ne=
 0 -a $RC3 -ne 0 ]; then=0A
----=_NextPart_ST_16_02_55_Thursday_June_10_2010_28441
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
----=_NextPart_ST_16_02_55_Thursday_June_10_2010_28441
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_16_02_55_Thursday_June_10_2010_28441--

