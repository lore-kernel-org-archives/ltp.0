Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <madanvs@linux.vnet.ibm.com>) id 1WiddC-0006l9-S1
	for ltp-list@lists.sourceforge.net; Fri, 09 May 2014 05:46:02 +0000
Received: from e28smtp01.in.ibm.com ([122.248.162.1])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WiddB-0002JI-A4
	for ltp-list@lists.sourceforge.net; Fri, 09 May 2014 05:46:02 +0000
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <madanvs@linux.vnet.ibm.com>; 
	Fri, 9 May 2014 11:15:53 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id E1B96394004E
	for <ltp-list@lists.sourceforge.net>;
	Fri,  9 May 2014 11:15:50 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	s495jwKN59310236
	for <ltp-list@lists.sourceforge.net>; Fri, 9 May 2014 11:15:58 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	s495jn28008016
	for <ltp-list@lists.sourceforge.net>; Fri, 9 May 2014 11:15:49 +0530
Received: from openstack.linuxxx (openstack.in.ibm.com [9.193.66.112])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	s495jnjr008000
	for <ltp-list@lists.sourceforge.net>; Fri, 9 May 2014 11:15:49 +0530
Message-ID: <536C6B8D.9070804@linux.vnet.ibm.com>
Date: Fri, 09 May 2014 11:15:49 +0530
From: Madan <madanvs@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP]  readahead02: change the test pass to 2M
Reply-To: madanvs@linux.vnet.ibm.com
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
To: ltp-list@lists.sourceforge.net

Max readahead size has been limited since commit:
   commit 6d2be915e589b58cb11418cbe1f22ff90732b6ac
   Author: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
   Date:   Thu Apr 3 14:48:23 2014 -0700
     mm/readahead.c: fix readahead failure for memoryless NUMA nodes
                     and limit readahead pages

Updating the change in the readahead behaviour of max 2M cache.
http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=c7252018cef0da5db35cd03aa7b6c44ab597a0b7

Signed-off-by:Hoisaleshwara Madan V S <hoisalvs@in.ibm.com>

Patch :

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahe
index 66158f0..dc6a191 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -306,13 +306,14 @@ static void test_readahead(void)
         tst_resm(TINFO, "cache can hold at least: %ld kB", cached_max);
         tst_resm(TINFO, "read_testfile(0) used cache: %ld kB", cached);
         tst_resm(TINFO, "read_testfile(1) used cache: %ld kB", cached_ra);
-
-       if (cached_max * 1024 >= testfile_size) {
+
+        /* readahead will cache max of 2 M */
+       if (cached_max * 1024 >= 2 * 1024) {
                 /*
                  * if cache can hold ~testfile_size then cache increase
                  * for readahead should be at least testfile_size/2
                  */
-               if (cached_ra * 1024 > testfile_size / 2)
+               if (cached_ra * 1024 > 2 * 1024)
                         tst_resm(TPASS, "using cache as expected");
                 else
                         tst_resm(TWARN, "using less cache than expected");



------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
