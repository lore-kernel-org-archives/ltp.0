Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1Oif45-0006Jm-1q
	for ltp-list@lists.sourceforge.net; Tue, 10 Aug 2010 02:59:45 +0000
Received: from out07.sjc.mx.trendmicro.com ([216.99.131.23])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Oif43-000718-DO
	for ltp-list@lists.sourceforge.net; Tue, 10 Aug 2010 02:59:44 +0000
Received: from relay04.sjc.mx.trendmicro.com (unknown [10.30.239.5])
	by out07.sjc.mx.trendmicro.com (Postfix) with ESMTP id 0839395246E
	for <ltp-list@lists.sourceforge.net>;
	Tue, 10 Aug 2010 02:59:37 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay04.sjc.mx.trendmicro.com (Postfix) with ESMTP id 918D21D7839
	for <ltp-list@lists.sourceforge.net>;
	Tue, 10 Aug 2010 02:59:36 +0000 (UTC)
Message-ID: <000001cb3834$4969dac0$dc3d9040$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 10 Aug 2010 11:32:32 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_11_32_33_Tuesday_August_10_2010_21081"
Content-Language: ja
Subject: [LTP] [PATCH] fix "hugeshmat01" test
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
Cc: =?iso-2022-jp?B?GyRCYUQ6QhsoQiAbJEI3cjtUGyhC?= <toza@ryobi.co.jp>

This is a multi-part message in MIME format.

----=_NextPart_ST_11_32_33_Tuesday_August_10_2010_21081
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi,

I tried to run hugeshmat01 testcase, but it failed.
This testcase failed in following systems.
   - RHEL5.5-ia64
   - RHEL4.8-x86_64
   - RHEL4.8-ia64

I used latest git:
   ltp-dev-7c67a09a10268b5f9f503e0254f1f0f9f5ac2b69.tar.gz
This testcase failed also in previous gits.


RHEL5.5-ia64 log:
------------
hugeshmat01    1  TPASS  :  conditions and functionality are correct
hugeshmat01    2  TFAIL  :  hugeshmat01 call failed - errno = 22 : Invalid
argument
hugeshmat01    3  TBROK  :  Remaining cases broken
------------

It is caused by "EINVAL" failure of shmat().

---(hugeshmat01.c)---------
[...]
                for (i=0; i<TST_TOTAL; i++) {

                        /*
                         * Use TEST macro to make the call
                         */
                        errno = 0;
                        addr = shmat(*(TC[i].shmid), (void *)(TC[i].addr),
                                   TC[i].flags);
[...]
------------

In second loop (i=1), arguments of shemat() are followings:

   shmat(id, 0x10000000eee, SHM_RND)

This test expects that the return value of shmat() is rounded down to 
a multiple of SHMLBA.
But shmat() failed in some systems.
I deduced that "0x10000000eee" address may be outside of hugepages area.

So I used the return value of first loop's shmat() instead of fixed 
address ("0x10000000eee").
And the test succeeded.

Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

============
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c	2010-08-05
22:28:15.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c	2010-08-06
15:19:05.000000000 +0900
@@ -67,6 +67,7 @@
 #define CASE0		10		/* values to write into the shared
*/
 #define CASE1		20		/* memory location.		
*/
 
+/* This value will be replaced in main() */
 #if __WORDSIZE==64
 #define UNALIGNED      0x10000000eee
 #else
@@ -124,6 +125,12 @@
 			 * Use TEST macro to make the call
 			 */
 			errno = 0;
+
+			/* When TC1, replace UNALIGNED to (TC0's addr +
0xeee) */
+			if (i == 1) {
+				TC[i].addr = addr + 0xeee;
+			}
+
 			addr = shmat(*(TC[i].shmid), (void *)(TC[i].addr),
 				   TC[i].flags);
 			TEST_ERRNO = errno;
============



Regards--


-Tomonori Mitani

----=_NextPart_ST_11_32_33_Tuesday_August_10_2010_21081
Content-Type: application/octet-stream;
	name="hugeshmat01.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hugeshmat01.patch"

--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c=092010-08-05 22:=
28:15.000000000 +0900=0A+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugesh=
mat01.c=092010-08-06 15:19:05.000000000 +0900=0A@@ -67,6 +67,7 @@=0A #defin=
e CASE0=09=0910=09=09/* values to write into the shared */=0A #define CASE1=
=09=0920=09=09/* memory location.=09=09   */=0A =0A+/* This value will be r=
eplaced in main() */=0A #if __WORDSIZE=3D=3D64=0A #define UNALIGNED      0x=
10000000eee=0A #else=0A@@ -124,6 +125,12 @@=0A =09=09=09 * Use TEST macro t=
o make the call=0A =09=09=09 */=0A =09=09=09errno =3D 0;=0A+=0A+=09=09=09/*=
 When TC1, replace UNALIGNED to (TC0's addr + 0xeee) */=0A+=09=09=09if (i =3D=
=3D 1) {=0A+=09=09=09=09TC[i].addr =3D addr + 0xeee;=0A+=09=09=09}=0A+=0A =09=
=09=09addr =3D shmat(*(TC[i].shmid), (void *)(TC[i].addr),=0A =09=09=09=09 =
  TC[i].flags);=0A =09=09=09TEST_ERRNO =3D errno;=0A
----=_NextPart_ST_11_32_33_Tuesday_August_10_2010_21081
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
----=_NextPart_ST_11_32_33_Tuesday_August_10_2010_21081
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_11_32_33_Tuesday_August_10_2010_21081--

