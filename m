Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1Othzm-0003jy-Kq
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 14:20:58 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Othzf-0008EC-KT
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 14:20:58 +0000
Message-ID: <4C88EFFF.8020607@bull.net>
Date: Thu, 09 Sep 2010 16:32:31 +0200
From: "Jacky.Malcles" <Jacky.Malcles@bull.net>
MIME-Version: 1.0
Subject: [LTP] a few failures Running dio_sparse & miscellaneous tests using
 ltp-aiodio.part4 scenario
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

Hi Garet,

Running dio_sparse & miscellaneous tests we get a few failures:
Testcase                       Result     Exit Value
--------                       ------     ----------
AD007                          PASS       0
DIO00                          PASS       0
DI009                          PASS       0
DOR000                         FAIL       1
...etc

detail:
tag=DOR000 stime=1284029770
cmdline="ltp-diorh $TMPDIR/aiodio.$$/file2"
contacts=""
analysis=exit
<<<test_output>>>
open: No such file or directory
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no

we still do have data files location difficulties, so, if you agree I 
suggest the folling change,
(note: in the coming days I should be able to check the 2 remaining 
scenarios)

many thanks,


--- ltp-aiodio.part4.original    2010-09-09 13:15:53.000000000 +0200
+++ ltp-aiodio.part4    2010-09-09 13:18:57.000000000 +0200
@@ -34,16 +34,16 @@ DIO07 dio_sparse
 DIO08 dio_sparse
 DIO09 dio_sparse
 #Running aiodio_append
-AD000 aiodio_append $TMPDIR/aiodio.$$/file2
-AD001 aiodio_append $TMPDIR/aiodio.$$/file2
-AD002 aiodio_append $TMPDIR/aiodio.$$/file2
-AD003 aiodio_append $TMPDIR/aiodio.$$/file2
-AD004 aiodio_append $TMPDIR/aiodio.$$/file2
-AD005 aiodio_append $TMPDIR/aiodio.$$/file2
-AD006 aiodio_append $TMPDIR/aiodio.$$/file2
-AD007 aiodio_append $TMPDIR/aiodio.$$/file2
-AD008 aiodio_append $TMPDIR/aiodio.$$/file2
-AD009 aiodio_append $TMPDIR/aiodio.$$/file2
+AD000 aiodio_append /test/aiodio/file2
+AD001 aiodio_append /test/aiodio/file2
+AD002 aiodio_append /test/aiodio/file2
+AD003 aiodio_append /test/aiodio/file2
+AD004 aiodio_append /test/aiodio/file2
+AD005 aiodio_append /test/aiodio/file2
+AD006 aiodio_append /test/aiodio/file2
+AD007 aiodio_append /test/aiodio/file2
+AD008 aiodio_append /test/aiodio/file2
+AD009 aiodio_append /test/aiodio/file2
 #Running dio_append
 ADI000 dio_append
 ADI001 dio_append
@@ -62,7 +62,7 @@ DIT002 dio_truncate
 #Running read_checkzero
 #gread_checkzero
 #Running ltp-diorh
-DOR000 ltp-diorh $TMPDIR/aiodio.$$/file2
-DOR001 ltp-diorh $TMPDIR/aiodio.$$/file3
-DOR002 ltp-diorh $TMPDIR/aiodio.$$/file4
-DOR003 ltp-diorh $TMPDIR/aiodio.$$/file5
+DOR000 ltp-diorh /test/aiodio/file2
+DOR001 ltp-diorh /test/aiodio/file3
+DOR002 ltp-diorh /test/aiodio/file4
+DOR003 ltp-diorh /test/aiodio/file5


-- 
 Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
 Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
 Tel : 04.76.29.73.14


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
