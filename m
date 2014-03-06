Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <root@localhost.localdomain>) id 1WLVRh-0003Ay-3L
	for ltp-list@lists.sourceforge.net; Thu, 06 Mar 2014 10:22:33 +0000
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WLVRf-0005hH-2Y
	for ltp-list@lists.sourceforge.net; Thu, 06 Mar 2014 10:22:33 +0000
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail7.fujitsu.co.jp (Postfix) with ESMTP id 75E141793019
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:09 +0900 (JST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 210B33EE0AE
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:02 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0F7DD45DEBA
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:02 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id EB99745DD77
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:01 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id DA8EAE08002
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:01 +0900 (JST)
Received: from s00.gw.fujitsu.co.jp (s00.gw.nic.fujitsu.com [133.161.11.15])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6106C1DB8038
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:01 +0900 (JST)
Received: from s00.gw.fujitsu.co.jp (kw-mxio2.gw.nic.fujitsu.com
	[10.0.237.142])
	by s00.gw.fujitsu.co.jp (Postfix) with ESMTP id 418151180F4
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:01 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.127])
	by s00.gw.fujitsu.co.jp (Postfix) with ESMTP id 0CA5D8A002
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Mar 2014 19:04:01 +0900 (JST)
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Thu,  6 Mar 2014 18:04:21 +0800
Message-Id: <1394100261-12596-2-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1394100261-12596-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1394100261-12596-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2 2/2] madvise/madvise02.c: extend EINVAL test for
	MADV_MERGEABLE and MADV_UNMERGEABLE advice
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

extend EINVAL test for MADV_MERGEABLE and MADV_UNMERGEABLE advice

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/madvise/madvise02.c | 64 +++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index f6d47f6..a777bd9 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -1,6 +1,6 @@
 /*
  *  Copyright (c) International Business Machines  Corp., 2004
- *  Copyright (c) Linux Test Project, 2013
+ *  Copyright (c) Linux Test Project, 2014
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -27,14 +27,16 @@
  *  2. advice is not a valid value
  *  3. application is attempting to release
  *     locked or shared pages (with MADV_DONTNEED)
+ *  4. MADV_MERGEABLE or MADV_UNMERGEABLE was specified in advice,
+ *     but the kernel was not configured with CONFIG_KSM.
  *
  * (B) Test Case for ENOMEM
- *  4. addresses in the specified range are not currently mapped
+ *  5. addresses in the specified range are not currently mapped
  *     or are outside the address space of the process
  *  b. Not enough memory - paging in failed
  *
  * (C) Test Case for EBADF
- *  5. the map exists,
+ *  6. the map exists,
  *     but the area maps something that isn't a file.
  */
 
@@ -55,6 +57,8 @@
 #define TEST_FILE "testfile"
 #define STR "abcdefghijklmnopqrstuvwxyz12345\n"
 
+#define KSM_SYS_DIR	"/sys/kernel/mm/ksm"
+
 static void setup(void);
 static void cleanup(void);
 static void check_and_print(int expected_errno);
@@ -64,6 +68,12 @@ static void test_advice_einval(void);
 #if !defined(UCLINUX)
 static void test_lock_einval(void);
 #endif /* if !defined(UCLINUX) */
+#if defined(MADV_MERGEABLE)
+static void test_mergeable_einval(void);
+#endif
+#if defined(MADV_UNMERGEABLE)
+static void test_unmergeable_einval(void);
+#endif
 static void test_enomem(void);
 static void test_ebadf(void);
 
@@ -73,6 +83,12 @@ static void (*test_func[])(void) = {
 #if !defined(UCLINUX)
 	test_lock_einval,
 #endif /* if !defined(UCLINUX) */
+#if defined(MADV_MERGEABLE)
+	test_mergeable_einval,
+#endif
+#if defined(MADV_UNMERGEABLE)
+	test_unmergeable_einval,
+#endif
 	test_enomem,
 	test_ebadf,
 };
@@ -199,6 +215,48 @@ static void test_lock_einval(void)
 }
 #endif /* if !defined(UCLINUX) */
 
+#if defined(MADV_MERGEABLE)
+static void test_mergeable_einval(void)
+{
+	char *file;
+
+	if (access(KSM_SYS_DIR, F_OK) >= 0) {
+		tst_resm(TCONF, "kernel configured with CONFIG_KSM, "
+				 "skip EINVAL test for MADV_MERGEABLE.");
+		return;
+	}
+
+	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
+					 MAP_SHARED, fd, 0);
+
+	TEST(madvise(file, st.st_size, MADV_MERGEABLE));
+	check_and_print(EINVAL);
+
+	SAFE_MUNMAP(cleanup, file, st.st_size);
+}
+#endif
+
+#if defined(MADV_UNMERGEABLE)
+static void test_unmergeable_einval(void)
+{
+	char *file;
+
+	if (access(KSM_SYS_DIR, F_OK) >= 0) {
+		tst_resm(TCONF, "kernel configured with CONFIG_KSM, "
+				 "skip EINVAL test for MADV_UNMERGEABLE.");
+		return;
+	}
+
+	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
+					 MAP_SHARED, fd, 0);
+
+	TEST(madvise(file, st.st_size, MADV_UNMERGEABLE));
+	check_and_print(EINVAL);
+
+	SAFE_MUNMAP(cleanup, file, st.st_size);
+}
+#endif
+
 static void test_enomem(void)
 {
 	char *low;
-- 
1.8.3.1


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
