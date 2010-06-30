Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1OTpo7-0000i9-Vo
	for ltp-list@lists.sourceforge.net; Wed, 30 Jun 2010 05:25:59 +0000
Received: from out21.sjc.mx.trendmicro.com ([216.99.131.78])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OTpo5-0002bx-MZ
	for ltp-list@lists.sourceforge.net; Wed, 30 Jun 2010 05:25:59 +0000
Received: from relay04.sjc.mx.trendmicro.com (unknown [10.30.239.5])
	by out21.sjc.mx.trendmicro.com (Postfix) with ESMTP id 8C75C98041C
	for <ltp-list@lists.sourceforge.net>;
	Wed, 30 Jun 2010 05:25:51 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay04.sjc.mx.trendmicro.com (Postfix) with ESMTP id E69EB1D784A
	for <ltp-list@lists.sourceforge.net>;
	Wed, 30 Jun 2010 05:25:50 +0000 (UTC)
Message-ID: <000001cb1810$23753ba0$6a5fb2e0$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 30 Jun 2010 13:53:10 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_13_53_10_Wednesday_June_30_2010_2617"
Content-Language: ja
Subject: [LTP] [PATCH] fix hugetlb tests
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

----=_NextPart_ST_13_53_10_Wednesday_June_30_2010_2617
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I want to suggest a patch for hugetlb tests.

There are "-c" options in this "${LTPROOT}/runtest/hugetlb" file:
------------
hugeshmat01 hugeshmat01 -i 5
hugeshmat02 hugeshmat02 -i 5
hugeshmat03 hugeshmat03 -i 5

hugeshmctl01 hugeshmctl01 -i 5 -c 3
hugeshmctl02 hugeshmctl02 -i 5 -c 3
hugeshmctl03 hugeshmctl03 -i 5 -c 3

hugeshmdt01 hugeshmdt01 -I 5 -c10

hugeshmget01 hugeshmget01 -c 10 -i 10
hugeshmget02 hugeshmget02 -c 10 -i 10
hugeshmget03 hugeshmget03 -c 10 -i 10
hugeshmget05 hugeshmget05 -c 10 -i 10

------------

But I think that these "-c" options have not important meanings.
I think that the test for several times may not be necessary.
For example, the purpose of "hugeshmget02" is the error case test of 
shmget(). In this case, if the expected failure occurred once, it is 
enough, and the repetition of test is unnecessary anymore, I think.
And, depending on a case, there may be a system without enough memory 
for these repetition tests.
Therefore I want to suggest reducing the "-c" option.

I got an answer that these "hugetlb" tests were not complete test programs.
--> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10171.html
Therefore, this revision is a temporary.


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

============
--- a/runtest/hugetlb	2010-06-14 21:29:09.000000000 +0900
+++ b/runtest/hugetlb	2010-06-30 09:32:01.000000000 +0900
@@ -7,14 +7,14 @@
 hugeshmat02 hugeshmat02 -i 5
 hugeshmat03 hugeshmat03 -i 5
 
-hugeshmctl01 hugeshmctl01 -i 5 -c 3
-hugeshmctl02 hugeshmctl02 -i 5 -c 3
-hugeshmctl03 hugeshmctl03 -i 5 -c 3
+hugeshmctl01 hugeshmctl01 -i 5
+hugeshmctl02 hugeshmctl02 -i 5
+hugeshmctl03 hugeshmctl03 -i 5
 
-hugeshmdt01 hugeshmdt01 -I 5 -c10
+hugeshmdt01 hugeshmdt01 -I 5
 
-hugeshmget01 hugeshmget01 -c 10 -i 10
-hugeshmget02 hugeshmget02 -c 10 -i 10
-hugeshmget03 hugeshmget03 -c 10 -i 10
-hugeshmget05 hugeshmget05 -c 10 -i 10
+hugeshmget01 hugeshmget01 -i 10
+hugeshmget02 hugeshmget02 -i 10
+hugeshmget03 hugeshmget03 -i 10
+hugeshmget05 hugeshmget05 -i 10
 
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-06-14
21:29:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-06-30
09:12:00.000000000 +0900
@@ -78,14 +78,14 @@
 		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
 	}
 
-	setup();			/* global setup */
-
 	/* The following loop checks looping state if -i option given */
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
              tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
         else             
               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
         
+	setup();			/* global setup */
+
         for (lc = 0; TEST_LOOPING(lc); lc++) {
 		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
============



Regards--

-Tomonori Mitani

----=_NextPart_ST_13_53_10_Wednesday_June_30_2010_2617
Content-Type: application/octet-stream;
	name="hugetlb.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hugetlb.patch"

--- a/runtest/hugetlb=092010-06-14 21:29:09.000000000 +0900=0A+++ b/runtest=
/hugetlb=092010-06-30 09:32:01.000000000 +0900=0A@@ -7,14 +7,14 @@=0A huges=
hmat02 hugeshmat02 -i 5=0A hugeshmat03 hugeshmat03 -i 5=0A =0A-hugeshmctl01=
 hugeshmctl01 -i 5 -c 3=0A-hugeshmctl02 hugeshmctl02 -i 5 -c 3=0A-hugeshmct=
l03 hugeshmctl03 -i 5 -c 3=0A+hugeshmctl01 hugeshmctl01 -i 5=0A+hugeshmctl0=
2 hugeshmctl02 -i 5=0A+hugeshmctl03 hugeshmctl03 -i 5=0A =0A-hugeshmdt01 hu=
geshmdt01 -I 5 -c10=0A+hugeshmdt01 hugeshmdt01 -I 5=0A =0A-hugeshmget01 hug=
eshmget01 -c 10 -i 10=0A-hugeshmget02 hugeshmget02 -c 10 -i 10=0A-hugeshmge=
t03 hugeshmget03 -c 10 -i 10=0A-hugeshmget05 hugeshmget05 -c 10 -i 10=0A+hu=
geshmget01 hugeshmget01 -i 10=0A+hugeshmget02 hugeshmget02 -i 10=0A+hugeshm=
get03 hugeshmget03 -i 10=0A+hugeshmget05 hugeshmget05 -i 10=0A =0A--- a/tes=
tcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c=092010-06-14 21:29:09.0=
00000000 +0900=0A+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01=
=2Ec=092010-06-30 09:12:00.000000000 +0900=0A@@ -78,14 +78,14 @@=0A =09=09t=
st_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);=0A =09}=0A =0A-=09=
setup();=09=09=09/* global setup */=0A-=0A =09/* The following loop checks =
looping state if -i option given */=0A         if ( get_no_of_hugepages() <=
=3D 0 || hugepages_size() <=3D 0 )=0A              tst_brkm(TCONF, cleanup,=
 "Not enough available Hugepages");=0A         else             =0A        =
       huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() * hugepag=
es_size() * 1024) / 2 ;=0A         =0A+=09setup();=09=09=09/* global setup =
*/=0A+=0A         for (lc =3D 0; TEST_LOOPING(lc); lc++) {=0A =09=09/* rese=
t Tst_count in case we are looping */=0A =09=09Tst_count =3D 0;=0A
----=_NextPart_ST_13_53_10_Wednesday_June_30_2010_2617
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
----=_NextPart_ST_13_53_10_Wednesday_June_30_2010_2617
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_13_53_10_Wednesday_June_30_2010_2617--

