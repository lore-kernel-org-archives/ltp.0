Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1OvPIo-0004vu-3Z
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 06:47:38 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OvPIg-0005h8-Tg
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 06:47:38 +0000
Message-ID: <4C8F1D3D.6080208@bull.net>
Date: Tue, 14 Sep 2010 08:59:09 +0200
From: "Jacky.Malcles" <Jacky.Malcles@bull.net>
MIME-Version: 1.0
Subject: [LTP] ltp-aiodio.part4 updated and verified
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

Garret,
with the following update all went well, no error;
tail -f ltpaiodio4.logfile
ADI005                         PASS       0   
DIO06                          PASS       0   

-----------------------------------------------
Total Tests: 57
Total Failures: 0

regards,
Jacky

--- ltp-aiodio.part4.original    2010-09-13 13:22:05.000000000 +0200
+++ ltp-aiodio.part4    2010-09-13 13:23:10.000000000 +0200
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
+AD000 aiodio_append $TMP/aiodio/file2
+AD001 aiodio_append $TMP/aiodio/file2
+AD002 aiodio_append $TMP/aiodio/file2
+AD003 aiodio_append $TMP/aiodio/file2
+AD004 aiodio_append $TMP/aiodio/file2
+AD005 aiodio_append $TMP/aiodio/file2
+AD006 aiodio_append $TMP/aiodio/file2
+AD007 aiodio_append $TMP/aiodio/file2
+AD008 aiodio_append $TMP/aiodio/file2
+AD009 aiodio_append $TMP/aiodio/file2
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
+DOR000 ltp-diorh $TMP/aiodio/file2
+DOR001 ltp-diorh $TMP/aiodio/file3
+DOR002 ltp-diorh $TMP/aiodio/file4
+DOR003 ltp-diorh $TMP/aiodio/file5



-- 
 Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
 Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
 Tel : 04.76.29.73.14


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
