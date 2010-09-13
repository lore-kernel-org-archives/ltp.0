Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <romansc@us.ibm.com>) id 1OvFEk-0003kK-5L
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 20:02:46 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OvFEh-00006Y-4l
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 20:02:44 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8DJhmZR014368
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 15:43:48 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8DK2PTo1360054
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 16:02:25 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8DK2Omf024277
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 17:02:25 -0300
Received: from d01ml605.pok.ibm.com (d01ml605.pok.ibm.com [9.56.227.91])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o8DK2Osb024253
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 17:02:24 -0300
Message-ID: <OFF1F0C1E2.5151E428-ON8525779D.006DDE26-8525779D.006E152F@us.ibm.com>
From: Scott Romanowski <romansc@us.ibm.com>
Date: Mon, 13 Sep 2010 16:02:23 -0400
MIME-Version: 1.0
Subject: [LTP] 20100831 bug and patch in
	testcases/kernel/syscalls/lchown/lchown02.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8611882152915701128=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8611882152915701128==
Content-type: multipart/alternative; 
	Boundary="0__=0ABBFD0EDFFE58B68f9e8a93df938690918c0ABBFD0EDFFE58B6"
Content-Disposition: inline

--0__=0ABBFD0EDFFE58B68f9e8a93df938690918c0ABBFD0EDFFE58B6
Content-type: text/plain; charset=US-ASCII


The contents of an unitialized automatic array are undefined, so start
copying string to it with strcpy() not strcat().

diff testcases/kernel/syscalls/lchown/lchown02.c
--- a/testcases/kernel/syscalls/lchown/lchown02.c	Mon Sep 13 14:51:41
2010 -0400
+++ b/testcases/kernel/syscalls/lchown/lchown02.c	Mon Sep 13 15:59:04
2010 -0400
@@ -343,7 +343,7 @@
 	strcat(Path_name, "/" TEST_FILE1);

 	/* Get the command name to be executed as setuid to root */
-	strcat((char *)Cmd_buffer, main_test_dir);
+	strcpy((char *)Cmd_buffer, main_test_dir);
 	strcat((char *)Cmd_buffer, (const char *)"/create_link ");
 	strcat((char *)Cmd_buffer, Path_name);

--
Scott Romanowski
--0__=0ABBFD0EDFFE58B68f9e8a93df938690918c0ABBFD0EDFFE58B6
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p>The contents of an unitialized automatic array are undefined, so start copying string to it with strcpy() not strcat().<br>
<br>
diff testcases/kernel/syscalls/lchown/lchown02.c<br>
--- a/testcases/kernel/syscalls/lchown/lchown02.c	Mon Sep 13 14:51:41 2010 -0400<br>
+++ b/testcases/kernel/syscalls/lchown/lchown02.c	Mon Sep 13 15:59:04 2010 -0400<br>
@@ -343,7 +343,7 @@<br>
 	strcat(Path_name, &quot;/&quot; TEST_FILE1);<br>
 <br>
 	/* Get the command name to be executed as setuid to root */<br>
-	strcat((char *)Cmd_buffer, main_test_dir);<br>
+	strcpy((char *)Cmd_buffer, main_test_dir);<br>
 	strcat((char *)Cmd_buffer, (const char *)&quot;/create_link &quot;);<br>
 	strcat((char *)Cmd_buffer, Path_name);<br>
 <br>
--<br>
Scott Romanowski<br>
</body></html>
--0__=0ABBFD0EDFFE58B68f9e8a93df938690918c0ABBFD0EDFFE58B6--



--===============8611882152915701128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing
http://p.sf.net/sfu/novell-sfdev2dev

--===============8611882152915701128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8611882152915701128==--


