Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1OWPA0-0006Ij-Mr
	for ltp-list@lists.sourceforge.net; Wed, 07 Jul 2010 07:35:12 +0000
Received: from out13.sjc.mx.trendmicro.com ([216.99.131.50])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OWP9y-0002YN-8v
	for ltp-list@lists.sourceforge.net; Wed, 07 Jul 2010 07:35:12 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.131])
	by out13.sjc.mx.trendmicro.com (Postfix) with ESMTP id ECA0D980417
	for <ltp-list@lists.sourceforge.net>;
	Wed,  7 Jul 2010 07:35:03 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 40A7B114B837
	for <ltp-list@lists.sourceforge.net>;
	Wed,  7 Jul 2010 07:35:02 +0000 (UTC)
Message-ID: <000301cb1da6$69538910$3bfa9b30$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 7 Jul 2010 16:31:27 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_16_31_28_Wednesday_July_07_2010_14885"
Content-Language: ja
Subject: [LTP] [PATCH] fix hugeshmget01
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

----=_NextPart_ST_16_31_28_Wednesday_July_07_2010_14885
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,


Sorry!!

I mistook to make following patch for hugetlb tests:
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10249.html

After the patch was applied, hugeshmget01 test will FAIL under the 
condition that hugepages isn't effective.

In this patch, I moved the timing of "setup()" calling after the judgment 
of hugepages.
------------
        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char
*)NULL){
                tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
        }

        /* The following loop checks looping state if -i option given */
        if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
             tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
        else
              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size()
* 1024) / 2 ;

        setup();                        /* global setup */
------------

At first, the "cleanup()" function was called in exit handling when 
hugepages was not effective.
But I didn't change "cleanup" into "tst_exit".
Therefore, in "cleanup()", exit handling fails to delete a non-existing 
temporary directory.


I maked patch for the latest git.
I tested it in both conditions that hugepages is effective/ineffective.

Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

============
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-07-04
03:15:03.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-07-05
16:37:41.000000000 +0900
@@ -80,7 +80,7 @@
 
 	/* The following loop checks looping state if -i option given */
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
-             tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
+             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
         else             
               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
         
============



Regards--

-Tomonori Mitani

----=_NextPart_ST_16_31_28_Wednesday_July_07_2010_14885
Content-Type: application/octet-stream;
	name="hugeshmget01.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hugeshmget01.patch"

--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c=092010-07-04 0=
3:15:03.000000000 +0900=0A+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hug=
eshmget01.c=092010-07-05 16:37:41.000000000 +0900=0A@@ -80,7 +80,7 @@=0A =0A=
 =09/* The following loop checks looping state if -i option given */=0A    =
     if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=0A-    =
         tst_brkm(TCONF, cleanup, "Not enough available Hugepages");=0A+   =
          tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");=0A  =
       else             =0A               huge_pages_shm_to_be_allocated =3D=
 ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;=0A         =0A
----=_NextPart_ST_16_31_28_Wednesday_July_07_2010_14885
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
----=_NextPart_ST_16_31_28_Wednesday_July_07_2010_14885
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_16_31_28_Wednesday_July_07_2010_14885--

