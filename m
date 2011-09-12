Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R34zF-0006uE-Am
	for ltp-list@lists.sourceforge.net; Mon, 12 Sep 2011 11:47:41 +0000
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R34zE-0006pS-Bi
	for ltp-list@lists.sourceforge.net; Mon, 12 Sep 2011 11:47:41 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p8CBen7l031623
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Sep 2011 21:40:49 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8CBlWF31974468
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Sep 2011 21:47:32 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8CBlWco032017
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Sep 2011 21:47:32 +1000
Received: from [127.0.0.1] ([9.79.197.179])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p8CBlSO8031945
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Sep 2011 21:47:31 +1000
Message-ID: <4E6DF14F.8030800@linux.vnet.ibm.com>
Date: Mon, 12 Sep 2011 17:17:27 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040003000805040806000303"
Subject: [LTP] [Patch v2] readlink03 test case fix
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

This is a multi-part message in MIME format.
--------------040003000805040806000303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In readlink03 testcase,
When 'Symlink Pathname is empty' the return value was 'ENOENT' but with 
newer kernels the return value is 'EINVAL'. The following patch will fix 
this.

readlink03:
Before patch:
...
readlink03    9  TFAIL  :  readlink() failed, Symlink Pathname is empty, 
errno=22, expected errno=2
...

After patch:
...
readlink03    9  TPASS  :  readlink(), Symlink Pathname is empty, 
returned errno 22
readlink03   10  TPASS  :  readlink(), Symlink Pathname is empty, 
returned errno 22
...

Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

-- 
Regards
R.Nageswara Sastry


--------------040003000805040806000303
Content-Type: text/plain;
 name="readlink03.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="readlink03.patch"

--- ltp.orig/testcases/kernel/syscalls/readlink/readlink03.c	2011-09-08 11:32:12.000000000 +0200
+++ ltp/testcases/kernel/syscalls/readlink/readlink03.c	2011-09-12 13:29:10.000000000 +0200
@@ -173,6 +173,11 @@ int main(int ac, char **av)
 				buf_size = sizeof(buffer);
 			}
 
+			if (strncmp(test_desc, "Symlink Pathname is empty", 25) == 0) {
+				if ((tst_kvercmp(2, 6, 39)) >= 0)
+					Test_cases[i].exp_errno = EINVAL;
+			}
+
 			/*
 			 * Call readlink(2) to test different test conditions.
 			 * verify that it fails with -1 return value and sets
@@ -358,4 +363,4 @@ void cleanup()
 
 	tst_rmdir();
 
-}
\ No newline at end of file
+}

--------------040003000805040806000303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Doing More with Less: The Next Generation Virtual Desktop 
What are the key obstacles that have prevented many mid-market businesses
from deploying virtual desktops?   How do next-generation virtual desktops
provide companies an easier-to-deploy, easier-to-manage and more affordable
virtual desktop model.http://www.accelacomm.com/jaw/sfnl/114/51426474/
--------------040003000805040806000303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040003000805040806000303--


