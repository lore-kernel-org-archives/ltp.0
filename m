Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56F0C52D7B
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 02:58:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A00023D20C3
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 04:58:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AD853D1D35
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 04:58:38 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 21178601027
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 04:58:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=0hr4G
 +RPjLuLo4doFFCe7xvashRjorgn+nRh+WxmW7k=; b=ZKRC3fkWZcdMbATWH+hZg
 /9Ovq0LiTRhQai0H7dj5wWWJoI/ORA/w/4R75IuxuswcZ22ndlfNrG0ovyJq5V4e
 nLUBZnWR8t4s2PkOw75hMB2PbkMcAgVEJSVDhnKeGw0nEmqdzFUae30ORl56/g0l
 5iffiQn652tTh0+eq4BUrA=
Received: from fedora-40.. (unknown [106.146.79.134])
 by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3H53ThbVmfArWBA--.8739S2; 
 Fri, 09 Aug 2024 10:58:29 +0800 (CST)
From: Xiao Yang <ice_yangxiao@163.com>
To: ltp@lists.linux.it
Date: Fri,  9 Aug 2024 11:58:25 +0900
Message-ID: <20240809025825.4055-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-CM-TRANSID: _____wD3H53ThbVmfArWBA--.8739S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr47XFyxtFWrGryxAF4fKrg_yoWrXFyDp3
 y3Ka4xZa1ftFZIyr40vwsYyw18uF15Jw1Fyr4qva1SqF1YkF95Xw4vqa4fZrWjqrWSv345
 C3yUJr1rZ3yq9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR_HUhUUUUU=
X-Originating-IP: [106.146.79.134]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbB0g02XmWXzlkoHQABsm
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/{fanotify17,
 getxattr05}: simplify code by using save_restore
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

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 .../kernel/syscalls/fanotify/fanotify17.c     | 23 ++++---------------
 .../kernel/syscalls/getxattr/getxattr05.c     | 20 +++++-----------
 2 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify17.c b/testcases/kernel/syscalls/fanotify/fanotify17.c
index 3ecb31b6e..f432dff36 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify17.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify17.c
@@ -31,7 +31,6 @@
 #define MOUNT_PATH	"fs_mnt"
 #define TEST_FILE	MOUNT_PATH "/testfile"
 #define SELF_USERNS	"/proc/self/ns/user"
-#define MAX_USERNS	"/proc/sys/user/max_user_namespaces"
 #define UID_MAP		"/proc/self/uid_map"
 
 #define GLOBAL_MAX_GROUPS "/proc/sys/fs/fanotify/max_user_groups"
@@ -47,7 +46,6 @@
 #define DEFAULT_MAX_GROUPS 129
 #define DEFAULT_MAX_MARKS  8192
 
-static int orig_max_userns = -1;
 static int user_ns_supported = 1;
 static int max_groups = DEFAULT_MAX_GROUPS;
 static int max_marks = DEFAULT_MAX_MARKS;
@@ -216,16 +214,8 @@ static void setup(void)
 	/* Check for kernel fanotify support */
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, TEST_FILE);
 
-	/*
-	 * The default value of max_user_namespaces is set to 0 on some distros,
-	 * We need to change the default value to call unshare().
-	 */
-	if (access(SELF_USERNS, F_OK) != 0) {
+	if (access(SELF_USERNS, F_OK) != 0)
 		user_ns_supported = 0;
-	} else if (!access(MAX_USERNS, F_OK)) {
-		SAFE_FILE_SCANF(MAX_USERNS, "%d", &orig_max_userns);
-		SAFE_FILE_PRINTF(MAX_USERNS, "%d", 10);
-	}
 
 	/*
 	 * In older kernels those limits were fixed in kernel and fanotify is
@@ -244,21 +234,18 @@ static void setup(void)
 	setup_rlimit(max_groups * 2);
 }
 
-static void cleanup(void)
-{
-	if (orig_max_userns != -1)
-		SAFE_FILE_PRINTF(MAX_USERNS, "%d", orig_max_userns);
-}
-
 static struct tst_test test = {
 	.test = test_fanotify,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
-	.cleanup = cleanup,
 	.needs_root = 1,
 	.forks_child = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{}
+	},
 };
 #else
 	TST_TEST_TCONF("system doesn't have required fanotify support");
diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
index d9717a695..3dff8e27f 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr05.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
@@ -40,11 +40,9 @@
 
 #define TEST_FILE	"testfile"
 #define SELF_USERNS	"/proc/self/ns/user"
-#define MAX_USERNS	"/proc/sys/user/max_user_namespaces"
 #define UID_MAP	"/proc/self/uid_map"
 
 static acl_t acl;
-static int orig_max_userns = -1;
 static int user_ns_supported = 1;
 
 static struct tcase {
@@ -149,23 +147,13 @@ static void setup(void)
 		tst_brk(TBROK | TERRNO, "acl_set_file(%s) failed", TEST_FILE);
 	}
 
-	/* The default value of max_user_namespaces is set to 0 on some distros,
-	 * We need to change the default value to call unshare().
-	 */
-	if (access(SELF_USERNS, F_OK) != 0) {
+	if (access(SELF_USERNS, F_OK) != 0)
 		user_ns_supported = 0;
-	} else if (!access(MAX_USERNS, F_OK)) {
-		SAFE_FILE_SCANF(MAX_USERNS, "%d", &orig_max_userns);
-		SAFE_FILE_PRINTF(MAX_USERNS, "%d", 10);
-	}
 
 }
 
 static void cleanup(void)
 {
-	if (orig_max_userns != -1)
-		SAFE_FILE_PRINTF(MAX_USERNS, "%d", orig_max_userns);
-
 	if (acl)
 		acl_free(acl);
 }
@@ -181,7 +169,11 @@ static struct tst_test test = {
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "82c9a927bc5d"},
 		{}
-},
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{}
+	},
 };
 
 #else /* HAVE_SYS_XATTR_H && HAVE_LIBACL*/
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
