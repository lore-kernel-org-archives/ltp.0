Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R0WF6-0000jW-40
	for ltp-list@lists.sourceforge.net; Mon, 05 Sep 2011 10:17:28 +0000
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R0WF4-0005VD-U8
	for ltp-list@lists.sourceforge.net; Mon, 05 Sep 2011 10:17:28 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p85AAcLN031587
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:10:38 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p85AFlAN716914
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:15:47 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p85AHJXW002392
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:17:19 +1000
Received: from [127.0.0.1] ([9.124.33.206])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p85AHHk3002328
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:17:18 +1000
Message-ID: <4E64A1AD.3040104@linux.vnet.ibm.com>
Date: Mon, 05 Sep 2011 15:47:17 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080903040409090406020100"
Subject: [LTP] [Patch 3/4] KSM test case fixes - mmap10
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
--------------080903040409090406020100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If the option for (-s) is selected then checking whether ksm related 
directory exists in sysfs or not.

mmap10_2:
Before patch:
...
mmap10      0  TINFO  :  add to KSM regions.
mmap10      0  TINFO  :  use /dev/zero.
mmap10      0  TINFO  :  start tests.
mmap10      1  TBROK  :  madvise: errno=EINVAL(22): Invalid argument
mmap10      2  TBROK  :  Remaining cases broken
...

After patch:
...
mmap10      1  TCONF  :  KSM configuration is not enabled
mmap10      2  TCONF  :  Remaining cases not appropriate for configuration
...


mmap10_3, mmap10_4, mmap10_5:
Before patch:
...
mmap10      0  TINFO  :  add to KSM regions.
mmap10      0  TINFO  :  use anonymous pages.
mmap10      0  TINFO  :  start tests.
mmap10      1  TBROK  :  madvise: errno=EINVAL(22): Invalid argument
mmap10      2  TBROK  :  Remaining cases broken
...

After patch:
...
mmap10      1  TCONF  :  KSM configuration is not enabled
mmap10      2  TCONF  :  Remaining cases not appropriate for configuration
...

Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

-- 
Regards
R.Nageswara Sastry


--------------080903040409090406020100
Content-Type: text/plain;
 name="mmap10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mmap10.patch"

--- ltp.orig/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-05 08:42:12.000000000 +0200
+++ ltp/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-05 08:46:53.000000000 +0200
@@ -94,6 +94,11 @@ int main(int argc, char *argv[])
 
 	if (opt_ksm)
 	{
+                char *fname = "/sys/kernel/mm/ksm/";
+
+                if( access( fname, F_OK ) == -1 ) {
+                        tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+                }
 #ifdef HAVE_MADV_MERGEABLE
 		tst_resm(TINFO, "add to KSM regions.");
 #else

--------------080903040409090406020100
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
--------------080903040409090406020100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080903040409090406020100--


