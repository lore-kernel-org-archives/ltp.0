Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9547C46CD2
	for <ltp@archiver.kernel.org>; Sun, 28 Jan 2024 02:50:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F2AF3CE9DF
	for <ltp@archiver.kernel.org>; Sun, 28 Jan 2024 03:50:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 661CA3CE6C2
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 03:48:58 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A005B1036E5F
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 03:48:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706410136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UuEHZOwarWNWJLs9BLL7IqH547YDp6AV/jHcW7pRiE4=;
 b=P9xr5YWMMZAz5RX1AqRzc9bLBfOcmC0CHnSmImOdJEpAMGgDRkNC4JlvF0aROROcDx+7Zd
 6vXrqmtJIDLN9+jer4rUHM7LQRr9eK3jUHzQBxEbepnmvBfeMJb5ROGwO1954XJ1Ly69Ya
 5+HeU11GeOVlAprhNnVg8InGwAMXR84=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-Dwe9xIIMNVqdccH49cPqbQ-1; Sat, 27 Jan 2024 21:48:53 -0500
X-MC-Unique: Dwe9xIIMNVqdccH49cPqbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B52FB837224
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 02:48:53 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB71C1C060B1
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 02:48:52 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 28 Jan 2024 10:48:36 +0800
Message-Id: <20240128024838.2699248-7-liwang@redhat.com>
In-Reply-To: <20240128024838.2699248-1-liwang@redhat.com>
References: <20240128024838.2699248-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 6/8] libswap: customize swapfile size
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The key change is the modification of the make_swapfile function to
accept an additional parameter blocks, specifying the number of
blocks to allocate for the swap file. This change allows for more
granular control over the size of swap files created during tests.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/libswap.h                             |  2 +-
 libs/libltpswap/libswap.c                     | 23 +++++++++++++------
 testcases/kernel/syscalls/swapoff/swapoff01.c |  5 +---
 testcases/kernel/syscalls/swapon/swapon01.c   |  2 +-
 testcases/kernel/syscalls/swapon/swapon02.c   |  4 ++--
 testcases/kernel/syscalls/swapon/swapon03.c   |  4 ++--
 6 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/include/libswap.h b/include/libswap.h
index d4b5301a5..e67d65756 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -14,7 +14,7 @@
 /*
  * Make a swap file
  */
-int make_swapfile(const char *swapfile, int safe);
+int make_swapfile(const char *swapfile, int blocks, int safe);
 
 /*
  * Check swapon/swapoff support status of filesystems or files
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index 95d4f59b0..8aecad48d 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -4,6 +4,7 @@
  * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
  */
 
+#include <sys/statvfs.h>
 #include <linux/fs.h>
 #include <errno.h>
 #include <linux/fiemap.h>
@@ -129,19 +130,27 @@ out:
 /*
  * Make a swap file
  */
-int make_swapfile(const char *swapfile, int safe)
+int make_swapfile(const char *swapfile, int blocks, int safe)
 {
-	if (!tst_fs_has_free(".", sysconf(_SC_PAGESIZE) * 10, TST_BYTES))
+	struct statvfs fs_info;
+	unsigned long blk_size;
+
+	if (statvfs(".", &fs_info) == -1)
+		return -1;
+
+	blk_size = fs_info.f_bsize;
+
+	if (!tst_fs_has_free(".", blk_size * blocks, TST_BYTES))
 		tst_brk(TBROK, "Insufficient disk space to create swap file");
 
 	/* create file */
-	if (prealloc_contiguous_file(swapfile, sysconf(_SC_PAGESIZE), 10) != 0)
+	if (prealloc_contiguous_file(swapfile, blk_size, blocks) != 0)
 		tst_brk(TBROK, "Failed to create swapfile");
 
-	/* Full the file to make old xfs happy*/
+	/* Fill the file if needed (specific to old xfs filesystems) */
 	if (tst_fs_type(swapfile) == TST_XFS_MAGIC) {
-		if (tst_fill_file(swapfile, 0, sysconf(_SC_PAGESIZE), 10) != 0)
-			tst_brk(TBROK, "Failed to create swapfile");
+		if (tst_fill_file(swapfile, 0, blk_size, blocks) != 0)
+			tst_brk(TBROK, "Failed to fill swapfile");
 	}
 
 	/* make the file swapfile */
@@ -162,7 +171,7 @@ int make_swapfile(const char *swapfile, int safe)
 void is_swap_supported(const char *filename)
 {
 	int i, sw_support = 0;
-	int ret = make_swapfile(filename, 1);
+	int ret = make_swapfile(filename, 10, 1);
 	int fi_contiguous = file_is_contiguous(filename);
 	long fs_type = tst_fs_type(filename);
 	const char *fstype = tst_fs_type_name(fs_type);
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index b27eecdad..e3b445d05 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -44,11 +44,8 @@ static void setup(void)
 		tst_brk(TBROK,
 			"Insufficient disk space to create swap file");
 
-	if (tst_fill_file("swapfile01", 0x00, 1024, 65536))
+	if (make_swapfile("swapfile01", 65536, 1))
 		tst_brk(TBROK, "Failed to create file for swap");
-
-	if (system("mkswap swapfile01 > tmpfile 2>&1") != 0)
-		tst_brk(TBROK, "Failed to make swapfile");
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index a74a5171e..d406e4bd9 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -38,7 +38,7 @@ static void verify_swapon(void)
 static void setup(void)
 {
 	is_swap_supported(SWAP_FILE);
-	make_swapfile(SWAP_FILE, 0);
+	make_swapfile(SWAP_FILE, 10, 0);
 
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index fceea77be..f5b0d6d56 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -44,8 +44,8 @@ static void setup(void)
 	is_swap_supported("./tstswap");
 
 	SAFE_TOUCH("notswap", 0777, NULL);
-	make_swapfile("swapfile01", 0);
-	make_swapfile("alreadyused", 0);
+	make_swapfile("swapfile01", 10, 0);
+	make_swapfile("alreadyused", 10, 0);
 
 	if (tst_syscall(__NR_swapon, "alreadyused", 0))
 		tst_res(TWARN | TERRNO, "swapon(alreadyused) failed");
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index dc633ebc6..e13009111 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -155,7 +155,7 @@ static int setup_swap(void)
 			}
 
 			/* Create the swapfile */
-			make_swapfile(filename, 0);
+			make_swapfile(filename, 10, 0);
 
 			/* turn on the swap file */
 			res = tst_syscall(__NR_swapon, filename, 0);
@@ -178,7 +178,7 @@ static int setup_swap(void)
 
 	/* Create all needed extra swapfiles for testing */
 	for (j = 0; j < testfiles; j++)
-		make_swapfile(swap_testfiles[j].filename, 0);
+		make_swapfile(swap_testfiles[j].filename, 10, 0);
 
 	return 0;
 }
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
