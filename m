Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R0WFL-0003qh-GW
	for ltp-list@lists.sourceforge.net; Mon, 05 Sep 2011 10:17:43 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R0WFI-00067W-TF
	for ltp-list@lists.sourceforge.net; Mon, 05 Sep 2011 10:17:43 +0000
Received: from /spool/local by au.ibm.com with XMail ESMTP
	for <ltp-list@lists.sourceforge.net> from <rnsastry@linux.vnet.ibm.com>;
	Mon, 5 Sep 2011 11:14:14 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p85AHVp71740824
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:17:31 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p85AHUrh003061
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:17:30 +1000
Received: from [127.0.0.1] ([9.124.33.206])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p85AHSpP002954
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:17:29 +1000
Message-ID: <4E64A1B8.6070501@linux.vnet.ibm.com>
Date: Mon, 05 Sep 2011 15:47:28 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000700050605090300070804"
Subject: [LTP] [Patch] readlink03 test case fix
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
--------------000700050605090300070804
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


--------------000700050605090300070804
Content-Type: text/plain;
 name="readlink03.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="readlink03.patch"

--- ltp.orig/testcases/kernel/syscalls/readlink/readlink03.c	2011-09-05 08:42:12.000000000 +0200
+++ ltp/testcases/kernel/syscalls/readlink/readlink03.c	2011-09-05 08:49:28.000000000 +0200
@@ -172,7 +172,11 @@ int main(int ac, char **av)
 			if (buf_size == 1) {
 				buf_size = sizeof(buffer);
 			}
-
+                        if (strncmp(test_desc, "Symlink Pathname is empty", 25) == 0) {
+                                if ( tst_kvercmp(2,6,39) >= 0 || tst_kvercmp(3,0,0) >= 0 ) {
+                                        Test_cases[i].exp_errno = EINVAL;
+                                }
+                        }
 			/*
 			 * Call readlink(2) to test different test conditions.
 			 * verify that it fails with -1 return value and sets
@@ -358,4 +362,4 @@ void cleanup()
 
 	tst_rmdir();
 
-}
\ No newline at end of file
+}

--------------000700050605090300070804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
--------------000700050605090300070804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------000700050605090300070804--


