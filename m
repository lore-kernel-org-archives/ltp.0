Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1OFQJo-0004Q8-Od
	for ltp-list@lists.sourceforge.net; Fri, 21 May 2010 11:23:08 +0000
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OFQJn-0004Ey-Dx
	for ltp-list@lists.sourceforge.net; Fri, 21 May 2010 11:23:08 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4LBJNU8001506
	for <ltp-list@lists.sourceforge.net>; Fri, 21 May 2010 21:19:23 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4LBFjrd1347666
	for <ltp-list@lists.sourceforge.net>; Fri, 21 May 2010 21:15:46 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4LBMxGI032126
	for <ltp-list@lists.sourceforge.net>; Fri, 21 May 2010 21:22:59 +1000
Received: from [9.124.158.27] (E67wks351462wss.in.ibm.com [9.124.158.27] (may
	be forged))
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o4LBMwdb032123
	for <ltp-list@lists.sourceforge.net>; Fri, 21 May 2010 21:22:59 +1000
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Content-Type: multipart/mixed; boundary="=-hjl5tA9WqFqSS7163vsH"
Date: Fri, 21 May 2010 16:52:52 +0530
Message-ID: <1274440972.5471.6.camel@munipradeep-laptop>
Mime-Version: 1.0
Subject: [LTP] Patch for proc01 testcase
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


--=-hjl5tA9WqFqSS7163vsH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

We need to add the below entry 
{"read", "/proc/powerpc/rtas/error_log", EINVAL},
to the "Mapping known_issues[]" array, as the new kernels are
having /proc/powerpc directory along with /proc/ppc64.

Attached the patch to this mail.

Please correct me if any thing is wrong.

Thanks
Muni

--=-hjl5tA9WqFqSS7163vsH
Content-Disposition: attachment; filename="proc01_fix.patch"
Content-Type: text/x-patch; name="proc01_fix.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

--- testcases/kernel/fs/proc/proc01.c	2010-05-07 10:28:15.000000000 +0530
+++ testcases/kernel/fs/proc/proc01_new.c	2010-05-21 16:34:14.921961185 +0530
@@ -96,6 +96,7 @@
     {"read", "/proc/self/attr/*", EINVAL},
     {"read", "/proc/self/task/[0-9]*/attr/*", EINVAL},
     {"read", "/proc/ppc64/rtas/error_log", EINVAL},
+    {"read", "/proc/powerpc/rtas/error_log", EINVAL},
     {"read", "/proc/fs/nfsd/unlock_filesystem", EINVAL},
     {"read", "/proc/fs/nfsd/unlock_ip", EINVAL},
     {"read", "/proc/fs/nfsd/filehandle", EINVAL},

--=-hjl5tA9WqFqSS7163vsH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------


--=-hjl5tA9WqFqSS7163vsH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=-hjl5tA9WqFqSS7163vsH--


