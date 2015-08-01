Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZLOsX-0007ks-1W
	for ltp-list@lists.sourceforge.net; Sat, 01 Aug 2015 04:58:37 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZLOsQ-0006tB-ER
	for ltp-list@lists.sourceforge.net; Sat, 01 Aug 2015 04:58:37 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Sat, 1 Aug 2015 12:58:31 +0800
Message-ID: <1438405111-6640-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] define CLONE_NEWNS in case a standard library isn't
	installed.
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
To: jstancek@redhat.com
Cc: ltp-list@lists.sourceforge.net

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 testcases/kernel/containers/libclone/libclone.c | 2 +-
 testcases/kernel/containers/libclone/libclone.h | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/containers/libclone/libclone.c b/testcases/kernel/containers/libclone/libclone.c
index 239674f..fdd9ff8 100644
--- a/testcases/kernel/containers/libclone/libclone.c
+++ b/testcases/kernel/containers/libclone/libclone.c
@@ -121,7 +121,7 @@ int do_clone_unshare_test(int use_clone, unsigned long clone_flags,
 }
 
 /*
- * Run fn1 in a unshared environmnent, and fn2 in the original context
+ * Run fn1 in a unshared environment, and fn2 in the original context
  */
 int do_clone_unshare_tests(int use_clone, unsigned long clone_flags,
 			   int (*fn1) (void *arg), void *arg1,
diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/kernel/containers/libclone/libclone.h
index 3a38bc9..60e9e54 100644
--- a/testcases/kernel/containers/libclone/libclone.h
+++ b/testcases/kernel/containers/libclone/libclone.h
@@ -75,8 +75,12 @@
 #define CLONE_NEWNET		0x40000000
 #endif
 
+#ifndef CLONE_NEWNS
+#define CLONE_NEWNS		0x00020000
+#endif
+
 /*
- * Run fn1 in a unshared environmnent, and fn2 in the original context
+ * Run fn1 in a unshared environment, and fn2 in the original context
  * Fn2 may be NULL.
  */
 
-- 
1.9.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
