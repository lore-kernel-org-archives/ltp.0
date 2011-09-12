Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R34xV-0006l2-Sm
	for ltp-list@lists.sourceforge.net; Mon, 12 Sep 2011 11:45:53 +0000
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R34xU-0007PP-KN
	for ltp-list@lists.sourceforge.net; Mon, 12 Sep 2011 11:45:53 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p8CBihri014963
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Sep 2011 21:44:43 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8CBi2x91503382
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Sep 2011 21:44:02 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8CBjjjS029083
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Sep 2011 21:45:45 +1000
Received: from [127.0.0.1] ([9.79.197.179])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p8CBjfP3029006
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Sep 2011 21:45:44 +1000
Message-ID: <4E6DF0E4.1040004@linux.vnet.ibm.com>
Date: Mon, 12 Sep 2011 17:15:40 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090604030202010809010201"
Subject: [LTP] [Patch v2] sockioctl01 test case fix
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
--------------090604030202010809010201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In sockioctl01 testcase,
Current 'inappropriate ioctl operation returning EINVAL'
With the git commit '41c31f318a5209922d051e293c61e4724daad11c' more 
details at http://permalink.gmane.org/gmane.linux.kernel.commits.head/296060
'inappropriate ioctl operation returning ENOTTY'

The following patch will fix this.


sockioctl01:
Before patch:
...
sockioctl01    4  TFAIL  :  ATMARK on UDP ; returned -1 (expected -1), 
errno 25 (expected 22)
...

After patch:
...
sockioctl01    4  TPASS  :  ATMARK on UDP successful
...

P.S. patch has ran through checkpatch.pl

Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

-- 
Regards
R.Nageswara Sastry


--------------090604030202010809010201
Content-Type: text/plain;
 name="sockioctl01.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sockioctl01.patch"

--- ltp.orig/testcases/kernel/syscalls/sockioctl/sockioctl01.c	2011-09-08 11:32:12.000000000 +0200
+++ ltp/testcases/kernel/syscalls/sockioctl/sockioctl01.c	2011-09-12 13:27:24.000000000 +0200
@@ -227,6 +227,11 @@ void setup1(void)
 			 strerror(errno));
 	}
 	sinlen = sizeof(fsin1);
+
+	if (strncmp(tdat[testno].desc, "ATMARK on UDP", 14) == 0) {
+		if ((tst_kvercmp(2, 6, 39)) >= 0)
+			tdat[testno].experrno = ENOTTY;
+	}
 }
 
 void setup2(void)
@@ -254,4 +259,4 @@ void cleanup1(void)
 {
 	(void)close(s);
 	s = -1;
-}
\ No newline at end of file
+}

--------------090604030202010809010201
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
--------------090604030202010809010201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090604030202010809010201--


