Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54E0C54E60
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 10:09:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C19A3CE6A4
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 11:09:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D34893CFC11
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 11:08:40 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5475E6011FF
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 11:08:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710842913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ve7GcdR+Exy+7BYx51VAWaHb+CAwH/r6IPxwQr7o63g=;
 b=IiF8TnvhfsA6pNFUdGZQoupBXfzeBTY2s8W75Ey1IAB055dNzUtuvuzKHugwrMEhPBiehP
 BLwIfJC7Mcf/6nrZm8Rdmc+BOt4M7tD3/czEzPty0e3pn1cBU/OCoqUNxMtUeYZb3+CJ0B
 B/6vD4udCepJSUC8FDwvPOVrD+jQ7vk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-bgLJsy1JOhy2utk-0QFHXg-1; Tue,
 19 Mar 2024 06:08:30 -0400
X-MC-Unique: bgLJsy1JOhy2utk-0QFHXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F107E3806708;
 Tue, 19 Mar 2024 10:08:29 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 648ED17A90;
 Tue, 19 Mar 2024 10:08:28 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 19 Mar 2024 18:08:21 +0800
Message-Id: <20240319100822.3243785-2-liwang@redhat.com>
In-Reply-To: <20240319100822.3243785-1-liwang@redhat.com>
References: <20240319100822.3243785-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] libswap: add two methods to create swapfile
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

This introduces new functionality to the libswap library by adding
two methods for creating a swapfile: SWAPFILE_BY_SIZE and SWAPFILE_BY_BLOCKS.
The make_swapfile function is updated to accept an additional enum
swapfile_method parameter to specify the creation method.

Two macros, MAKE_SWAPFILE_SIZE and MAKE_SWAPFILE_BLKS, are defined
to simplify the interface for creating swapfiles by size and by
blocks respectively.

Signed-off-by: Li Wang <liwang@redhat.com>
Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Wei Gao <wegao@suse.com>
---
 include/libswap.h                             | 16 ++++++++++++++--
 libs/libltpswap/libswap.c                     | 14 +++++++++++---
 testcases/kernel/syscalls/swapoff/swapoff01.c |  2 +-
 testcases/kernel/syscalls/swapoff/swapoff02.c |  2 +-
 testcases/kernel/syscalls/swapon/swapon01.c   |  2 +-
 testcases/kernel/syscalls/swapon/swapon02.c   |  4 ++--
 testcases/kernel/syscalls/swapon/swapon03.c   |  4 ++--
 7 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/include/libswap.h b/include/libswap.h
index 8c75e20ae..85ba88ed6 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -11,10 +11,22 @@
 #ifndef __LIBSWAP_H__
 #define __LIBSWAP_H__
 
+enum swapfile_method {
+    SWAPFILE_BY_SIZE,
+    SWAPFILE_BY_BLKS
+};
+
 /*
- * Make a swap file
+ * Create a swapfile of a specified size or number of blocks.
  */
-int make_swapfile(const char *swapfile, int blocks, int safe);
+int make_swapfile(const char *swapfile, unsigned int num,
+			int safe, enum swapfile_method method);
+
+#define MAKE_SWAPFILE_SIZE(swapfile, size, safe) \
+    make_swapfile(swapfile, size, safe, SWAPFILE_BY_SIZE)
+
+#define MAKE_SWAPFILE_BLKS(swapfile, blocks, safe) \
+    make_swapfile(swapfile, blocks, safe, SWAPFILE_BY_BLKS)
 
 /*
  * Check swapon/swapoff support status of filesystems or files
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index a26ea25e4..0e2476ec2 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -133,18 +133,26 @@ out:
 	return contiguous;
 }
 
-int make_swapfile(const char *swapfile, int blocks, int safe)
+int make_swapfile(const char *swapfile, unsigned int num, int safe, enum swapfile_method method)
 {
 	struct statvfs fs_info;
 	unsigned long blk_size, bs;
 	size_t pg_size = sysconf(_SC_PAGESIZE);
 	char mnt_path[100];
+	unsigned int blocks = 0;
 
 	if (statvfs(".", &fs_info) == -1)
 		return -1;
 
 	blk_size = fs_info.f_bsize;
 
+	if (method == SWAPFILE_BY_SIZE)
+		blocks = num * 1024 * 1024 / blk_size;
+	else if (method == SWAPFILE_BY_BLKS)
+		blocks = num;
+	else
+		tst_brk(TBROK, "Invalid method, please see include/libswap.h");
+
 	/* To guarantee at least one page can be swapped out */
 	if (blk_size * blocks < pg_size)
 		bs = pg_size;
@@ -175,13 +183,13 @@ int make_swapfile(const char *swapfile, int blocks, int safe)
 	argv[2] = NULL;
 
 	return tst_cmd(argv, "/dev/null", "/dev/null", safe ?
-				   TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING : 0);
+			TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING : 0);
 }
 
 bool is_swap_supported(const char *filename)
 {
 	int i, sw_support = 0;
-	int ret = make_swapfile(filename, 10, 1);
+	int ret = MAKE_SWAPFILE_BLKS(filename, 10, 1);
 	int fi_contiguous = file_is_contiguous(filename);
 	long fs_type = tst_fs_type(filename);
 	const char *fstype = tst_fs_type_name(fs_type);
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index 2a0b683c1..d0d7c3c1f 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -44,7 +44,7 @@ static void setup(void)
 {
 	is_swap_supported(TEST_FILE);
 
-	if (make_swapfile(SWAP_FILE, 65536, 1))
+	if (MAKE_SWAPFILE_BLKS(SWAP_FILE, 65536, 1))
 		tst_brk(TBROK, "Failed to create file for swap");
 }
 
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index 52906848f..b57290386 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -88,7 +88,7 @@ static void setup(void)
 
 	is_swap_supported(TEST_FILE);
 
-	if (make_swapfile(SWAP_FILE, 10, 1))
+	if (MAKE_SWAPFILE_BLKS(SWAP_FILE, 10, 1))
 		tst_brk(TBROK, "Failed to create file for swap");
 }
 
diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index d406e4bd9..2e399db61 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -38,7 +38,7 @@ static void verify_swapon(void)
 static void setup(void)
 {
 	is_swap_supported(SWAP_FILE);
-	make_swapfile(SWAP_FILE, 10, 0);
+	MAKE_SWAPFILE_BLKS(SWAP_FILE, 10, 0);
 
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index 7e876d26a..f76bb28cf 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -50,8 +50,8 @@ static void setup(void)
 	is_swap_supported(TEST_FILE);
 
 	SAFE_TOUCH(NOTSWAP_FILE, 0777, NULL);
-	make_swapfile(SWAP_FILE, 10, 0);
-	make_swapfile(USED_FILE, 10, 0);
+	MAKE_SWAPFILE_BLKS(SWAP_FILE, 10, 0);
+	MAKE_SWAPFILE_BLKS(USED_FILE, 10, 0);
 
 	if (tst_syscall(__NR_swapon, USED_FILE, 0))
 		tst_res(TWARN | TERRNO, "swapon(alreadyused) failed");
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 6f47fc01f..aaaedfa11 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -49,7 +49,7 @@ static int setup_swap(void)
 
 			/* Create the swapfile */
 			snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
-			make_swapfile(filename, 10, 0);
+			MAKE_SWAPFILE_BLKS(filename, 10, 0);
 
 			/* turn on the swap file */
 			TST_EXP_PASS_SILENT(swapon(filename, 0));
@@ -62,7 +62,7 @@ static int setup_swap(void)
 		tst_brk(TFAIL, "Failed to setup swap files");
 
 	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
-	make_swapfile(TEST_FILE, 10, 0);
+	MAKE_SWAPFILE_BLKS(TEST_FILE, 10, 0);
 
 	return 0;
 }
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
