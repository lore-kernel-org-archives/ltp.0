Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681C1C47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 10:27:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E051D3CE23A
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 11:27:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 677453CF91C
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:25:35 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5C5501BB8776
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:25:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706696732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vISjC7VY+lps7MfS08MsoCQfPNZRL8yNbyUD7GH8PxU=;
 b=KrEzgNuxrWfbkryKLjQx8KxkvVwjabZyuCoTN43oV1rVboe8/aQZGfg/rUeV0zoXPWqiFj
 0NuoNs2A8eVMQaYbrY0k9fDJllIZE2m6/5dxt6bmS5SEFuplGJQtoqU2KgiBw6rSjNIhTr
 BjM8fTGk4aXMLGDYT/XOM6hZOpMQknQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-fp6BP9EYN_qA3YoSLFqrwQ-1; Wed,
 31 Jan 2024 05:25:31 -0500
X-MC-Unique: fp6BP9EYN_qA3YoSLFqrwQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E76B43C14945
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 10:25:30 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09293487
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 10:25:29 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 18:25:13 +0800
Message-Id: <20240131102514.2739270-8-liwang@redhat.com>
In-Reply-To: <20240131102514.2739270-1-liwang@redhat.com>
References: <20240131102514.2739270-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [Patch v6 7/8] swapon/off: enable all_filesystem in swap test
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/swapoff/swapoff01.c | 16 ++++++++---
 testcases/kernel/syscalls/swapoff/swapoff02.c | 20 ++++++++------
 testcases/kernel/syscalls/swapon/swapon02.c   | 27 ++++++++++++-------
 testcases/kernel/syscalls/swapon/swapon03.c   |  8 +++++-
 4 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index e3b445d05..af2a759cb 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -17,15 +17,19 @@
 #include "lapi/syscalls.h"
 #include "libswap.h"
 
+#define MNTPOINT	"mntpoint"
+#define TEST_FILE	MNTPOINT"/testswap"
+#define SWAP_FILE	MNTPOINT"/swapfile"
+
 static void verify_swapoff(void)
 {
-	if (tst_syscall(__NR_swapon, "./swapfile01", 0) != 0) {
+	if (tst_syscall(__NR_swapon, SWAP_FILE, 0) != 0) {
 		tst_res(TFAIL | TERRNO, "Failed to turn on the swap file"
 			 ", skipping test iteration");
 		return;
 	}
 
-	TEST(tst_syscall(__NR_swapoff, "./swapfile01"));
+	TEST(tst_syscall(__NR_swapoff, SWAP_FILE));
 
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "Failed to turn off swapfile,"
@@ -38,17 +42,21 @@ static void verify_swapoff(void)
 
 static void setup(void)
 {
-	is_swap_supported("./tstswap");
+	is_swap_supported(TEST_FILE);
 
 	if (!tst_fs_has_free(".", 64, TST_MB))
 		tst_brk(TBROK,
 			"Insufficient disk space to create swap file");
 
-	if (make_swapfile("swapfile01", 65536, 1))
+	if (make_swapfile(SWAP_FILE, 65536, 1))
 		tst_brk(TBROK, "Failed to create file for swap");
 }
 
 static struct tst_test test = {
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.dev_min_size = 512,
+	.all_filesystems = 1,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.test_all = verify_swapoff,
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index cd940b1e7..89ffd6ece 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -18,6 +18,10 @@
 #include "lapi/syscalls.h"
 #include "libswap.h"
 
+#define MNTPOINT	"mntpoint"
+#define TEST_FILE	MNTPOINT"/testswap"
+#define SWAP_FILE	MNTPOINT"/swapfile"
+
 static int setup01(void);
 static void cleanup01(void);
 
@@ -32,8 +36,8 @@ static struct tcase {
 	void (*cleanup)(void);
 } tcases[] = {
 	{"path does not exist", ENOENT, "ENOENT", "./doesnotexist", NULL, NULL},
-	{"Invalid file", EINVAL, "EINVAL", "./swapfile01", NULL, NULL},
-	{"Permission denied", EPERM, "EPERM", "./swapfile01", setup01, cleanup01}
+	{"Invalid file", EINVAL, "EINVAL", SWAP_FILE, NULL, NULL},
+	{"Permission denied", EPERM, "EPERM", SWAP_FILE, setup01, cleanup01}
 };
 
 static void verify_swapoff(unsigned int i)
@@ -82,16 +86,16 @@ static void setup(void)
 	nobody = SAFE_GETPWNAM("nobody");
 	nobody_uid = nobody->pw_uid;
 
-	is_swap_supported("./tstswap");
-
-	if (!tst_fs_has_free(".", 1, TST_KB))
-		tst_brk(TBROK, "Insufficient disk space to create swap file");
+	is_swap_supported(TEST_FILE);
 
-	if (tst_fill_file("./swapfile01", 0x00, 1024, 1))
-		tst_brk(TBROK, "Failed to create swapfile");
+	if (make_swapfile(SWAP_FILE, 10, 1))
+		tst_brk(TBROK, "Failed to create file for swap");
 }
 
 static struct tst_test test = {
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.test = verify_swapoff,
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index f5b0d6d56..d8ff16b08 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -20,6 +20,12 @@
 #include "lapi/syscalls.h"
 #include "libswap.h"
 
+#define MNTPOINT	"mntpoint"
+#define TEST_FILE	MNTPOINT"/testswap"
+#define NOTSWAP_FILE	MNTPOINT"/notswap"
+#define SWAP_FILE	MNTPOINT"/swapfile"
+#define USED_FILE	MNTPOINT"/alreadyused"
+
 static uid_t nobody_uid;
 static int do_swapoff;
 
@@ -29,9 +35,9 @@ static struct tcase {
 	char *path;
 } tcases[] = {
 	{"Path does not exist", ENOENT, "./doesnotexist"},
-	{"Invalid path", EINVAL, "./notswap"},
-	{"Permission denied", EPERM, "./swapfile01"},
-	{"File already used", EBUSY, "./alreadyused"},
+	{"Invalid path", EINVAL, NOTSWAP_FILE},
+	{"Permission denied", EPERM, SWAP_FILE},
+	{"File already used", EBUSY, USED_FILE},
 };
 
 static void setup(void)
@@ -41,13 +47,13 @@ static void setup(void)
 	nobody = SAFE_GETPWNAM("nobody");
 	nobody_uid = nobody->pw_uid;
 
-	is_swap_supported("./tstswap");
+	is_swap_supported(TEST_FILE);
 
-	SAFE_TOUCH("notswap", 0777, NULL);
-	make_swapfile("swapfile01", 10, 0);
-	make_swapfile("alreadyused", 10, 0);
+	SAFE_TOUCH(NOTSWAP_FILE, 0777, NULL);
+	make_swapfile(SWAP_FILE, 10, 0);
+	make_swapfile(USED_FILE, 10, 0);
 
-	if (tst_syscall(__NR_swapon, "alreadyused", 0))
+	if (tst_syscall(__NR_swapon, USED_FILE, 0))
 		tst_res(TWARN | TERRNO, "swapon(alreadyused) failed");
 	else
 		do_swapoff = 1;
@@ -55,7 +61,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (do_swapoff && tst_syscall(__NR_swapoff, "alreadyused"))
+	if (do_swapoff && tst_syscall(__NR_swapoff, USED_FILE))
 		tst_res(TWARN | TERRNO, "swapoff(alreadyused) failed");
 }
 
@@ -78,6 +84,9 @@ static void verify_swapon(unsigned int i)
 }
 
 static struct tst_test test = {
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.test = verify_swapon,
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index e13009111..72f39e7c7 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -22,6 +22,9 @@
 #include "swaponoff.h"
 #include "libswap.h"
 
+#define MNTPOINT	"mntpoint"
+#define TEST_FILE	MNTPOINT"/testswap"
+
 static int setup_swap(void);
 static int clean_swap(void);
 static int check_and_swapoff(const char *filename);
@@ -256,7 +259,7 @@ static void setup(void)
 	if (access("/proc/swaps", F_OK))
 		tst_brk(TCONF, "swap not supported by kernel");
 
-	is_swap_supported("./tstswap");
+	is_swap_supported(TEST_FILE);
 }
 
 static void cleanup(void)
@@ -265,6 +268,9 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
