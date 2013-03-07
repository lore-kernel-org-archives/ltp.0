Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UDVnh-0007y8-1U
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:03:41 +0000
Received: from mail-pa0-f42.google.com ([209.85.220.42])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UDVne-0001fu-KX
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:03:41 +0000
Received: by mail-pa0-f42.google.com with SMTP id kq12so276028pab.15
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Mar 2013 00:03:32 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Thu,  7 Mar 2013 15:38:34 +0800
Message-Id: <0da7f15cb693ea31f3f5cb1512713ae0562b4f17.1362641893.git.caspar@casparzhang.com>
In-Reply-To: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
References: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
In-Reply-To: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
References: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.8.1.4"
Subject: [LTP] [PATCH 3/3] syscalls/madvise02: fix madvise case due to
	kernel change
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.8.1.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


since kernel commit 1998cc0 (after kernel-3.8 released),
madvise(MADV_WILLNEED) to anonymous memory doesn't return -EBADF now, as
now we support swap prefetch. Thus the 5th testcase in madvise02 will
not pass. This patch fixes this by adding a tst_kvercmp() condition, and
will give a pass if kernel is >=3.9 (including the RCs).

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/syscalls/madvise/madvise02.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


--------------1.8.1.4
Content-Type: text/x-patch;
	name="0003-syscalls-madvise02-fix-madvise-case-due-to-kernel-ch.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0003-syscalls-madvise02-fix-madvise-case-due-to-kernel-ch.patch"

diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index 87d26c3..f68fb0b 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -187,7 +187,15 @@ int main(int argc, char *argv[])
 
 		TEST(madvise
 		     (tmp_memory_allocated, 5 * pagesize, MADV_WILLNEED));
-		check_and_print(EBADF);
+		if (tst_kvercmp(3, 9, 0) < 0)
+			check_and_print(EBADF);
+		/* in kernel commit 1998cc0, madvise(MADV_WILLNEED) to anon
+		 * mem doesn't return -EBADF now, as now we suuport swap
+		 * prefretch.
+		 */
+		else
+			tst_resm(TPASS, "madvise succeeded as expected, see "
+					"kernel commit 1998cc0 for details.");
 		free((void *)ptr_memory_allocated);
 
 		close(fd);

--------------1.8.1.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
--------------1.8.1.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.8.1.4--



