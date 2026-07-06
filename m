Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FA1C43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 10:32:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30C513E2C48
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 12:32:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C24733C96A5
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 12:32:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D3C2600566
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 12:32:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C789F73B34;
 Mon,  6 Jul 2026 10:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783333939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mcwdeXmFnxyBqapOv4qPj8dNNZY4u8lR/lacX0LRwBY=;
 b=r4lUUUb5iJ/evU9O896wZ8rKVWmfiNfJrPyTMEchPt3VVNaTm3YuTkZ1yMfCaX/T6bE6Yk
 my8T7d4UjL5zU6fTy3zb2qB+n2haSWzNJ2KlnBMVrvTHxGJwN5W4uDjIUNqH6nQO2Qgil6
 uO6G72exL36DbMT840VzU8mK9HiZ794=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783333939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mcwdeXmFnxyBqapOv4qPj8dNNZY4u8lR/lacX0LRwBY=;
 b=l8exUZUAN03gOVW8f4uEpzqDKjuCpp8LHkTF31VvK9zuhiydNoMdClHd+8x0/YON8GqkIG
 BeBPzVoN3TrDFJCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r4lUUUb5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=l8exUZUA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783333939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mcwdeXmFnxyBqapOv4qPj8dNNZY4u8lR/lacX0LRwBY=;
 b=r4lUUUb5iJ/evU9O896wZ8rKVWmfiNfJrPyTMEchPt3VVNaTm3YuTkZ1yMfCaX/T6bE6Yk
 my8T7d4UjL5zU6fTy3zb2qB+n2haSWzNJ2KlnBMVrvTHxGJwN5W4uDjIUNqH6nQO2Qgil6
 uO6G72exL36DbMT840VzU8mK9HiZ794=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783333939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mcwdeXmFnxyBqapOv4qPj8dNNZY4u8lR/lacX0LRwBY=;
 b=l8exUZUAN03gOVW8f4uEpzqDKjuCpp8LHkTF31VvK9zuhiydNoMdClHd+8x0/YON8GqkIG
 BeBPzVoN3TrDFJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0E9D779AA;
 Mon,  6 Jul 2026 10:32:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6dXWJDOES2qRIwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 06 Jul 2026 10:32:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 06 Jul 2026 12:32:18 +0200
MIME-Version: 1.0
Message-Id: <20260706-fix_make_check_landlock-v1-1-46f821b20128@suse.com>
X-B4-Tracking: v=1; b=H4sIADGES2oC/x2MWwqEMAwAryL53kJXoT6uIkuJadRQt0oLIkjvb
 vFzYGZuSByFEwzVDZFPSbKHAt9PBbRiWFiJKwy1ro1utVGzXPaPni2tTN5uGNy2k1dNh3NPE7I
 zHZT6iFzU9zz+cn4ABawQWWkAAAA=
X-Change-ID: 20260706-fix_make_check_landlock-38af9cbaed68
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783333939; l=25300;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=YGK8ZyeVaxDHNmoR+c8nEvwq/CrXp+UoY/cBl4rGGgk=;
 b=coqZoua+hTXZztMPFRDSOyHwvpleTNNha3ti2gT0v+WEsim+ivCadKvwPwlBon3HndsYCcFig
 PbHUzqxs/npChyNsyp3eYqKQYbAoZTvmpglgaRNkJZG+I8sbPxQqrkX
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C789F73B34
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] landlock: fix make check warnings/errors
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/landlock/landlock01.c    |  7 +-
 testcases/kernel/syscalls/landlock/landlock02.c    | 17 ++---
 testcases/kernel/syscalls/landlock/landlock03.c    |  9 +--
 testcases/kernel/syscalls/landlock/landlock04.c    | 16 ++--
 testcases/kernel/syscalls/landlock/landlock05.c    | 28 +++----
 testcases/kernel/syscalls/landlock/landlock06.c    | 11 +--
 testcases/kernel/syscalls/landlock/landlock07.c    |  5 +-
 testcases/kernel/syscalls/landlock/landlock08.c    | 44 ++++-------
 testcases/kernel/syscalls/landlock/landlock09.c    |  2 +-
 .../kernel/syscalls/landlock/landlock_common.h     | 86 ++++++++--------------
 .../kernel/syscalls/landlock/landlock_tester.h     | 60 +++++++--------
 11 files changed, 104 insertions(+), 181 deletions(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock01.c b/testcases/kernel/syscalls/landlock/landlock01.c
index bf206dae7751448419407b950b2aebc3f1708211..d817d97862c98a15b055812aed3ff9ddecd3ef14 100644
--- a/testcases/kernel/syscalls/landlock/landlock01.c
+++ b/testcases/kernel/syscalls/landlock/landlock01.c
@@ -44,11 +44,8 @@ static void run(unsigned int n)
 	if (*tc->attr)
 		(*tc->attr)->handled_access_fs = tc->access_fs;
 
-	TST_EXP_FAIL(tst_syscall(__NR_landlock_create_ruleset,
-			*tc->attr, *tc->size, tc->flags),
-		tc->exp_errno,
-		"%s",
-		tc->msg);
+	TST_EXP_FAIL(tst_syscall(__NR_landlock_create_ruleset, *tc->attr, *tc->size, tc->flags),
+		     tc->exp_errno, "%s", tc->msg);
 
 	if (TST_RET >= 0)
 		SAFE_CLOSE(TST_RET);
diff --git a/testcases/kernel/syscalls/landlock/landlock02.c b/testcases/kernel/syscalls/landlock/landlock02.c
index 37dc72d32c633a2f249c5a9ef879b6d288a63259..3edddfdeb0de2378cf312a7876247eadf102ff78 100644
--- a/testcases/kernel/syscalls/landlock/landlock02.c
+++ b/testcases/kernel/syscalls/landlock/landlock02.c
@@ -136,9 +136,8 @@ static void run(unsigned int n)
 		attr = *tc->net_attr;
 	}
 
-	TST_EXP_FAIL(tst_syscall(__NR_landlock_add_rule,
-		*tc->fd, tc->rule_type, attr, tc->flags),
-		tc->exp_errno, "%s", tc->msg);
+	TST_EXP_FAIL(tst_syscall(__NR_landlock_add_rule, *tc->fd, tc->rule_type, attr, tc->flags),
+		     tc->exp_errno, "%s", tc->msg);
 }
 
 static void setup(void)
@@ -150,14 +149,14 @@ static void setup(void)
 	attr_abi6->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
 
 	if (abi_current < 4) {
-		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
-			attr_abi1, sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
+		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset, attr_abi1,
+							   sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
 	} else if (abi_current < 6) {
-		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
-			attr_abi4, sizeof(struct tst_landlock_ruleset_attr_abi4), 0));
+		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset, attr_abi4,
+							   sizeof(struct tst_landlock_ruleset_attr_abi4), 0));
 	} else {
-		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
-			attr_abi6, sizeof(struct tst_landlock_ruleset_attr_abi6), 0));
+		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset, attr_abi6,
+							   sizeof(struct tst_landlock_ruleset_attr_abi6), 0));
 	}
 }
 
diff --git a/testcases/kernel/syscalls/landlock/landlock03.c b/testcases/kernel/syscalls/landlock/landlock03.c
index 3c0cd56b0a12d1dafece3298f585f8b8ed0abcc2..cda636688c98e04f545fbd0fa7f280a6d244e259 100644
--- a/testcases/kernel/syscalls/landlock/landlock03.c
+++ b/testcases/kernel/syscalls/landlock/landlock03.c
@@ -56,15 +56,14 @@ static void run_child(struct tcase *tc)
 	if (tc->exp_errno == E2BIG) {
 		for (int i = 0; i < MAX_STACKED_RULESETS; i++) {
 			TST_EXP_PASS_SILENT(tst_syscall(__NR_landlock_restrict_self,
-				*tc->fd, tc->flags));
+							*tc->fd, tc->flags));
 			if (TST_RET == -1)
 				return;
 		}
 	}
 
 	TST_EXP_FAIL(tst_syscall(__NR_landlock_restrict_self, *tc->fd, tc->flags),
-		tc->exp_errno,
-		"%s", tc->msg);
+		     tc->exp_errno, "%s", tc->msg);
 
 	if (tc->exp_errno == EPERM)
 		tst_cap_action(&needadmin);
@@ -86,8 +85,8 @@ static void setup(void)
 
 	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
 
-	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
-		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
+	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset, ruleset_attr,
+						   sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
 
 	file_fd = SAFE_OPEN("junk.bin", O_CREAT, 0777);
 }
diff --git a/testcases/kernel/syscalls/landlock/landlock04.c b/testcases/kernel/syscalls/landlock/landlock04.c
index 86dc199942bb009beb9515b3b7d5011b864fcc58..ce1d6c37aad3125d9dca0e73463da473a1c7f5e5 100644
--- a/testcases/kernel/syscalls/landlock/landlock04.c
+++ b/testcases/kernel/syscalls/landlock/landlock04.c
@@ -6,7 +6,7 @@
 /*\
  * This test verifies that all landlock filesystem rules are working properly.
  * The way we do it is to verify that all disabled syscalls are not working but
- * the one we enabled via specifc landlock rules.
+ * the one we enabled via specific landlock rules.
  */
 
 #include "landlock_common.h"
@@ -104,7 +104,7 @@ static void enable_exec_libs(const int ruleset_fd)
 	fp = SAFE_FOPEN("/proc/self/maps", "r");
 
 	while (fgets(line, sizeof(line), fp)) {
-		if (strstr(line, ".so") == NULL)
+		if (!strstr(line, ".so"))
 			continue;
 
 		SAFE_SSCANF(line, "%*x-%*x %*s %*x %*s %*d %s", path);
@@ -131,8 +131,7 @@ static void enable_exec_libs(const int ruleset_fd)
 			LANDLOCK_ACCESS_FS_EXECUTE;
 		path_beneath_attr->parent_fd = SAFE_OPEN(path, O_PATH | O_CLOEXEC);
 
-		SAFE_LANDLOCK_ADD_RULE(
-			ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,	path_beneath_attr, 0);
+		SAFE_LANDLOCK_ADD_RULE(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,	path_beneath_attr, 0);
 
 		SAFE_CLOSE(path_beneath_attr->parent_fd);
 	}
@@ -164,8 +163,7 @@ static void setup(void)
 
 	ruleset_attr->handled_access_fs = supported_rules;
 
-	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
-		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0);
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0);
 
 	/* since our binary is dynamically linked, we need to enable dependences
 	 * to be read and executed
@@ -177,11 +175,9 @@ static void setup(void)
 		SAFE_MKDIR(SANDBOX_FOLDER, PERM_MODE);
 
 	path_beneath_attr->allowed_access = variant.access;
-	path_beneath_attr->parent_fd = SAFE_OPEN(
-		SANDBOX_FOLDER, O_PATH | O_CLOEXEC);
+	path_beneath_attr->parent_fd = SAFE_OPEN(SANDBOX_FOLDER, O_PATH | O_CLOEXEC);
 
-	SAFE_LANDLOCK_ADD_RULE(
-		ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,	path_beneath_attr, 0);
+	SAFE_LANDLOCK_ADD_RULE(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,	path_beneath_attr, 0);
 
 	SAFE_CLOSE(path_beneath_attr->parent_fd);
 }
diff --git a/testcases/kernel/syscalls/landlock/landlock05.c b/testcases/kernel/syscalls/landlock/landlock05.c
index ad5e932b077499e43a91c8e32ae6fdf5fedf23f3..527ddfa1b369d7c1c03f945bb7a0d2a0ff92cfb0 100644
--- a/testcases/kernel/syscalls/landlock/landlock05.c
+++ b/testcases/kernel/syscalls/landlock/landlock05.c
@@ -19,12 +19,12 @@
 #include "landlock_common.h"
 
 #define MNTPOINT "sandbox"
-#define DIR1 MNTPOINT"/folder1"
-#define DIR2 MNTPOINT"/folder2"
-#define DIR3 MNTPOINT"/folder3"
-#define FILENAME1 DIR1"/file"
-#define FILENAME2 DIR2"/file"
-#define FILENAME3 DIR3"/file"
+#define DIR1 MNTPOINT "/folder1"
+#define DIR2 MNTPOINT "/folder2"
+#define DIR3 MNTPOINT "/folder3"
+#define FILENAME1 DIR1 "/file"
+#define FILENAME2 DIR2 "/file"
+#define FILENAME3 DIR3 "/file"
 
 static struct tst_landlock_ruleset_attr_abi1 *ruleset_attr;
 static struct landlock_path_beneath_attr *path_beneath_attr;
@@ -65,20 +65,10 @@ static void setup(void)
 		LANDLOCK_ACCESS_FS_WRITE_FILE |
 		LANDLOCK_ACCESS_FS_REFER;
 
-	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
-		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0);
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0);
 
-	apply_landlock_fs_rule(
-		path_beneath_attr,
-		ruleset_fd,
-		LANDLOCK_ACCESS_FS_REFER,
-		DIR1);
-
-	apply_landlock_fs_rule(
-		path_beneath_attr,
-		ruleset_fd,
-		LANDLOCK_ACCESS_FS_REFER,
-		DIR2);
+	apply_landlock_fs_rule(path_beneath_attr, ruleset_fd, LANDLOCK_ACCESS_FS_REFER, DIR1);
+	apply_landlock_fs_rule(path_beneath_attr, ruleset_fd, LANDLOCK_ACCESS_FS_REFER, DIR2);
 
 	enforce_ruleset(ruleset_fd);
 
diff --git a/testcases/kernel/syscalls/landlock/landlock06.c b/testcases/kernel/syscalls/landlock/landlock06.c
index c2ac20d5939d20dd870efc6186f87d91a2476247..9d621a04791140b4d9352bee54352721e7e7717e 100644
--- a/testcases/kernel/syscalls/landlock/landlock06.c
+++ b/testcases/kernel/syscalls/landlock/landlock06.c
@@ -14,7 +14,7 @@
 #include <sys/ioctl.h>
 
 #define MNTPOINT "sandbox"
-#define FILENAME MNTPOINT"/fifo"
+#define FILENAME MNTPOINT "/fifo"
 
 static struct tst_landlock_ruleset_attr_abi1 *ruleset_attr;
 static struct landlock_path_beneath_attr *path_beneath_attr;
@@ -52,13 +52,8 @@ static void setup(void)
 
 	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV;
 
-	apply_landlock_fs_layer(
-		ruleset_attr,
-		sizeof(struct tst_landlock_ruleset_attr_abi1),
-		path_beneath_attr,
-		MNTPOINT,
-		LANDLOCK_ACCESS_FS_IOCTL_DEV
-	);
+	apply_landlock_fs_layer(ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1),
+				path_beneath_attr, MNTPOINT, LANDLOCK_ACCESS_FS_IOCTL_DEV);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/landlock/landlock07.c b/testcases/kernel/syscalls/landlock/landlock07.c
index 0dfa7ea111d8141caf6ea252f990fd0d564ceaa0..a9f8cc562dc6379ddfbb16db26c28e6a62cd841c 100644
--- a/testcases/kernel/syscalls/landlock/landlock07.c
+++ b/testcases/kernel/syscalls/landlock/landlock07.c
@@ -68,10 +68,7 @@ static void setup(void)
 	verify_landlock_is_enabled();
 
 	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_WRITE_FILE;
-	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
-		ruleset_attr,
-		sizeof(struct tst_landlock_ruleset_attr_abi1),
-		0);
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/landlock/landlock08.c b/testcases/kernel/syscalls/landlock/landlock08.c
index 7e7d8470bf49662416f7c83a444876575b29fb16..c86880cd2f334780cb53b04fac99a9a557235bc2 100644
--- a/testcases/kernel/syscalls/landlock/landlock08.c
+++ b/testcases/kernel/syscalls/landlock/landlock08.c
@@ -58,8 +58,7 @@ static void create_server(const int addr_family)
 	SAFE_CLOSE(socket.fd);
 }
 
-static void test_bind(const int addr_family, const in_port_t port,
-	const int exp_err)
+static void test_bind(const int addr_family, const in_port_t port, const int exp_err)
 {
 	struct socket_data socket;
 	struct sockaddr *addr = NULL;
@@ -68,20 +67,17 @@ static void test_bind(const int addr_family, const in_port_t port,
 	getsocket_addr(&socket, addr_family, &addr);
 
 	if (exp_err) {
-		TST_EXP_FAIL(
-			bind(socket.fd, addr, socket.address_size),
-			exp_err, "bind() access on port %u", port);
+		TST_EXP_FAIL(bind(socket.fd, addr, socket.address_size),
+			     exp_err, "bind() access on port %u", port);
 	} else {
-		TST_EXP_PASS(
-			bind(socket.fd, addr, socket.address_size),
-			"bind() access on port %u", port);
+		TST_EXP_PASS(bind(socket.fd, addr, socket.address_size),
+			     "bind() access on port %u", port);
 	}
 
 	SAFE_CLOSE(socket.fd);
 }
 
-static void test_connect(const int addr_family, const in_port_t port,
-	const int exp_err)
+static void test_connect(const int addr_family, const in_port_t port, const int exp_err)
 {
 	struct socket_data socket;
 	struct sockaddr *addr = NULL;
@@ -90,13 +86,11 @@ static void test_connect(const int addr_family, const in_port_t port,
 	getsocket_addr(&socket, addr_family, &addr);
 
 	if (exp_err) {
-		TST_EXP_FAIL(
-			connect(socket.fd, addr, socket.address_size),
-			exp_err, "connect() on port %u", port);
+		TST_EXP_FAIL(connect(socket.fd, addr, socket.address_size),
+			     exp_err, "connect() on port %u", port);
 	} else {
-		TST_EXP_PASS(
-			connect(socket.fd, addr, socket.address_size),
-			"connect() on port %u", port);
+		TST_EXP_PASS(connect(socket.fd, addr, socket.address_size),
+			     "connect() on port %u", port);
 	}
 
 	SAFE_CLOSE(socket.fd);
@@ -142,12 +136,8 @@ static void run(void)
 		tst_res(TINFO, "Enable bind() access only for port %u",
 			addr_port);
 
-		apply_landlock_net_layer(
-			ruleset_attr,
-			sizeof(struct tst_landlock_ruleset_attr_abi4),
-			net_port_attr,
-			addr_port,
-			LANDLOCK_ACCESS_NET_BIND_TCP);
+		apply_landlock_net_layer(ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi4),
+					 net_port_attr, addr_port, LANDLOCK_ACCESS_NET_BIND_TCP);
 
 		test_bind(addr_family, addr_port, 0);
 		test_bind(addr_family, addr_port + 0x80, EACCES);
@@ -165,12 +155,8 @@ static void run(void)
 		tst_res(TINFO, "Enable connect() access only on port %u",
 			*server_port);
 
-		apply_landlock_net_layer(
-			ruleset_attr,
-			sizeof(struct tst_landlock_ruleset_attr_abi4),
-			net_port_attr,
-			*server_port,
-			LANDLOCK_ACCESS_NET_CONNECT_TCP);
+		apply_landlock_net_layer(ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi4),
+					 net_port_attr, *server_port, LANDLOCK_ACCESS_NET_CONNECT_TCP);
 
 		test_connect(addr_family, *server_port, 0);
 		test_connect(addr_family, *server_port + 0x80, EACCES);
@@ -189,7 +175,7 @@ static void setup(void)
 	addr_port = TST_GET_UNUSED_PORT(AF_INET, SOCK_STREAM);
 
 	server_port = SAFE_MMAP(NULL, sizeof(in_port_t), PROT_READ | PROT_WRITE,
-		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+				MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/landlock/landlock09.c b/testcases/kernel/syscalls/landlock/landlock09.c
index 2e7f0021299152a1dbd0d7d7594487f551f04a24..09a762bb1b41b2caaddbc7a8316c47180508af8b 100644
--- a/testcases/kernel/syscalls/landlock/landlock09.c
+++ b/testcases/kernel/syscalls/landlock/landlock09.c
@@ -14,7 +14,7 @@
 #include "landlock_common.h"
 
 #define SOCKET_NAME "test.sock"
-#define ABSTRACT_SOCKET_NAME "\0"SOCKET_NAME
+#define ABSTRACT_SOCKET_NAME "\0" SOCKET_NAME
 #define SOCKET_LENGTH (offsetof(struct sockaddr_un, sun_path) + strlen(SOCKET_NAME) + 1)
 
 enum {
diff --git a/testcases/kernel/syscalls/landlock/landlock_common.h b/testcases/kernel/syscalls/landlock/landlock_common.h
index 8857745d6f1c1c30fc914924b8d0da381b36059f..dc63c0d86a5d0ce67abab6c23f20047402344d05 100644
--- a/testcases/kernel/syscalls/landlock/landlock_common.h
+++ b/testcases/kernel/syscalls/landlock/landlock_common.h
@@ -25,15 +25,11 @@ static inline int verify_landlock_is_enabled(void)
 {
 	int abi;
 
-	abi = tst_syscall(__NR_landlock_create_ruleset,
-		NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
+	abi = tst_syscall(__NR_landlock_create_ruleset, NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
 
 	if (abi < 0) {
-		if (errno == EOPNOTSUPP) {
-			tst_brk(TCONF, "Landlock is currently disabled. "
-				"Please enable it either via CONFIG_LSM or "
-				"'lsm' kernel parameter.");
-		}
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF, "Landlock is currently disabled. Please enable it either via CONFIG_LSM or 'lsm' kernel parameter.");
 
 		tst_brk(TBROK | TERRNO, "landlock_create_ruleset error");
 	}
@@ -43,38 +39,26 @@ static inline int verify_landlock_is_enabled(void)
 	return abi;
 }
 
-static inline void apply_landlock_fs_rule(
-	struct landlock_path_beneath_attr *path_beneath_attr,
-	const int ruleset_fd,
-	const int access,
-	const char *path)
+static inline void apply_landlock_fs_rule(struct landlock_path_beneath_attr *path_beneath_attr,
+					  const int ruleset_fd, const int access, const char *path)
 {
 	path_beneath_attr->allowed_access = access;
 	path_beneath_attr->parent_fd = SAFE_OPEN(path, O_PATH | O_CLOEXEC);
 
-	SAFE_LANDLOCK_ADD_RULE(
-		ruleset_fd,
-		LANDLOCK_RULE_PATH_BENEATH,
-		path_beneath_attr,
-		0);
+	SAFE_LANDLOCK_ADD_RULE(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+			       path_beneath_attr, 0);
 
 	SAFE_CLOSE(path_beneath_attr->parent_fd);
 }
 
-static inline void apply_landlock_net_rule(
-	struct landlock_net_port_attr *net_attr,
-	const int ruleset_fd,
-	const uint64_t port,
-	const uint64_t access)
+static inline void apply_landlock_net_rule(struct landlock_net_port_attr *net_attr,
+					   const int ruleset_fd, const uint64_t port,
+					   const uint64_t access)
 {
 	net_attr->port = port;
 	net_attr->allowed_access = access;
 
-	SAFE_LANDLOCK_ADD_RULE(
-		ruleset_fd,
-		LANDLOCK_RULE_NET_PORT,
-		net_attr,
-		0);
+	SAFE_LANDLOCK_ADD_RULE(ruleset_fd, LANDLOCK_RULE_NET_PORT, net_attr, 0);
 }
 
 static inline void enforce_ruleset(const int ruleset_fd)
@@ -83,11 +67,9 @@ static inline void enforce_ruleset(const int ruleset_fd)
 	SAFE_LANDLOCK_RESTRICT_SELF(ruleset_fd, 0);
 }
 
-static inline void apply_landlock_fs_layer(
-	void *ruleset_attr, size_t attr_size,
-	struct landlock_path_beneath_attr *path_beneath_attr,
-	const char *path,
-	const int access)
+static inline void apply_landlock_fs_layer(void *ruleset_attr, size_t attr_size,
+					   struct landlock_path_beneath_attr *path_beneath_attr,
+					   const char *path, const int access)
 {
 	int ruleset_fd;
 
@@ -99,11 +81,9 @@ static inline void apply_landlock_fs_layer(
 	SAFE_CLOSE(ruleset_fd);
 }
 
-static inline void apply_landlock_net_layer(
-	void *ruleset_attr, size_t attr_size,
-	struct landlock_net_port_attr *net_port_attr,
-	const in_port_t port,
-	const uint64_t access)
+static inline void apply_landlock_net_layer(void *ruleset_attr, size_t attr_size,
+					    struct landlock_net_port_attr *net_port_attr,
+					    const in_port_t port, const uint64_t access)
 {
 	int ruleset_fd;
 
@@ -115,8 +95,7 @@ static inline void apply_landlock_net_layer(
 	SAFE_CLOSE(ruleset_fd);
 }
 
-static inline void apply_landlock_scoped_layer(
-	void *ruleset_attr, size_t attr_size)
+static inline void apply_landlock_scoped_layer(void *ruleset_attr, size_t attr_size)
 {
 	int ruleset_fd;
 
@@ -126,8 +105,7 @@ static inline void apply_landlock_scoped_layer(
 	SAFE_CLOSE(ruleset_fd);
 }
 
-static inline in_port_t getsocket_port(struct socket_data *socket,
-	const int addr_family)
+static inline in_port_t getsocket_port(struct socket_data *socket, const int addr_family)
 {
 	struct sockaddr_in addr_ipv4;
 	struct sockaddr_in6 addr_ipv6;
@@ -158,30 +136,24 @@ static inline in_port_t getsocket_port(struct socket_data *socket,
 }
 
 static inline void create_socket(struct socket_data *socket,
-	const int addr_family, const in_port_t port)
+				 const int addr_family, const in_port_t port)
 {
 	memset(socket, 0, sizeof(struct socket_data));
 
 	switch (addr_family) {
 	case AF_INET:
-		if (!port) {
-			tst_init_sockaddr_inet_bin(&socket->addr_ipv4,
-				INADDR_ANY, 0);
-		} else {
-			tst_init_sockaddr_inet(&socket->addr_ipv4,
-				IPV4_LOCALHOST, port);
-		}
+		if (!port)
+			tst_init_sockaddr_inet_bin(&socket->addr_ipv4, INADDR_ANY, 0);
+		else
+			tst_init_sockaddr_inet(&socket->addr_ipv4, IPV4_LOCALHOST, port);
 
 		socket->address_size = sizeof(struct sockaddr_in);
 		break;
 	case AF_INET6:
-		if (!port) {
-			tst_init_sockaddr_inet6_bin(&socket->addr_ipv6,
-				&in6addr_any, 0);
-		} else {
-			tst_init_sockaddr_inet6(&socket->addr_ipv6,
-				IPV6_LOCALHOST, port);
-		}
+		if (!port)
+			tst_init_sockaddr_inet6_bin(&socket->addr_ipv6, &in6addr_any, 0);
+		else
+			tst_init_sockaddr_inet6(&socket->addr_ipv6, IPV6_LOCALHOST, port);
 
 		socket->address_size = sizeof(struct sockaddr_in6);
 		break;
@@ -194,7 +166,7 @@ static inline void create_socket(struct socket_data *socket,
 }
 
 static inline void getsocket_addr(struct socket_data *socket,
-	const int addr_family, struct sockaddr **addr)
+				  const int addr_family, struct sockaddr **addr)
 {
 	switch (addr_family) {
 	case AF_INET:
diff --git a/testcases/kernel/syscalls/landlock/landlock_tester.h b/testcases/kernel/syscalls/landlock/landlock_tester.h
index dcebc45cd785e7af284de9a8f27f048a40af2815..43fec39da6c24ee2ce3a9004e85018f1f7fd06ee 100644
--- a/testcases/kernel/syscalls/landlock/landlock_tester.h
+++ b/testcases/kernel/syscalls/landlock/landlock_tester.h
@@ -14,22 +14,22 @@
 #define SANDBOX_FOLDER	"sandbox"
 #define TESTAPP			"landlock_exec"
 
-#define FILE_EXEC		SANDBOX_FOLDER"/"TESTAPP
-#define FILE_READ		SANDBOX_FOLDER"/file_read"
-#define FILE_WRITE		SANDBOX_FOLDER"/file_write"
-#define FILE_REMOVE		SANDBOX_FOLDER"/file_remove"
-#define FILE_UNLINK		SANDBOX_FOLDER"/file_unlink"
-#define FILE_UNLINKAT	SANDBOX_FOLDER"/file_unlinkat"
-#define FILE_TRUNCATE	SANDBOX_FOLDER"/file_truncate"
-#define FILE_REGULAR	SANDBOX_FOLDER"/regular0"
-#define FILE_SOCKET		SANDBOX_FOLDER"/socket0"
-#define FILE_FIFO		SANDBOX_FOLDER"/fifo0"
-#define FILE_SYM0		SANDBOX_FOLDER"/symbolic0"
-#define FILE_SYM1		SANDBOX_FOLDER"/symbolic1"
-#define DIR_READDIR		SANDBOX_FOLDER"/dir_readdir"
-#define DIR_RMDIR		SANDBOX_FOLDER"/dir_rmdir"
-#define DEV_CHAR0		SANDBOX_FOLDER"/chardev0"
-#define DEV_BLK0		SANDBOX_FOLDER"/blkdev0"
+#define FILE_EXEC	SANDBOX_FOLDER "/" TESTAPP
+#define FILE_READ	SANDBOX_FOLDER "/file_read"
+#define FILE_WRITE	SANDBOX_FOLDER "/file_write"
+#define FILE_REMOVE	SANDBOX_FOLDER "/file_remove"
+#define FILE_UNLINK	SANDBOX_FOLDER "/file_unlink"
+#define FILE_UNLINKAT	SANDBOX_FOLDER "/file_unlinkat"
+#define FILE_TRUNCATE	SANDBOX_FOLDER "/file_truncate"
+#define FILE_REGULAR	SANDBOX_FOLDER "/regular0"
+#define FILE_SOCKET	SANDBOX_FOLDER "/socket0"
+#define FILE_FIFO	SANDBOX_FOLDER "/fifo0"
+#define FILE_SYM0	SANDBOX_FOLDER "/symbolic0"
+#define FILE_SYM1	SANDBOX_FOLDER "/symbolic1"
+#define DIR_READDIR	SANDBOX_FOLDER "/dir_readdir"
+#define DIR_RMDIR	SANDBOX_FOLDER "/dir_rmdir"
+#define DEV_CHAR0	SANDBOX_FOLDER "/chardev0"
+#define DEV_BLK0	SANDBOX_FOLDER "/blkdev0"
 
 #define ALL_RULES (\
 	LANDLOCK_ACCESS_FS_EXECUTE | \
@@ -50,9 +50,9 @@
 	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 
 static char *readdir_files[] = {
-	DIR_READDIR"/file0",
-	DIR_READDIR"/file1",
-	DIR_READDIR"/file2",
+	DIR_READDIR "/file0",
+	DIR_READDIR "/file1",
+	DIR_READDIR "/file2",
 };
 
 static int dev_chr;
@@ -63,8 +63,7 @@ static int tester_get_all_fs_rules(void)
 	int abi;
 	int all_rules = ALL_RULES;
 
-	abi = SAFE_LANDLOCK_CREATE_RULESET(
-		NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
+	abi = SAFE_LANDLOCK_CREATE_RULESET(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
 
 	if (abi < 2)
 		all_rules &= ~LANDLOCK_ACCESS_FS_REFER;
@@ -227,10 +226,10 @@ static void _test_readdir(const int result)
 			continue;
 
 		for (size_t i = 0; i < ARRAY_SIZE(readdir_files); i++) {
-			if (readdir_files[i] == NULL)
+			if (!readdir_files[i])
 				continue;
 
-			if (strstr(readdir_files[i], de->d_name) != NULL)
+			if (!strstr(readdir_files[i], de->d_name))
 				files_counted++;
 		}
 	}
@@ -263,11 +262,7 @@ static void _test_rmfile(const int result)
 	}
 }
 
-static void _test_make(
-	const char *path,
-	const int type,
-	const int dev,
-	const int result)
+static void _test_make(const char *path, const int type, const int dev, const int result)
 {
 	tst_res(TINFO, "Test normal or special files creation");
 
@@ -314,8 +309,7 @@ static void _test_truncate(const int result)
 			SAFE_CLOSE(fd);
 		}
 
-		TST_EXP_FAIL(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE),
-			EACCES);
+		TST_EXP_FAIL(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), EACCES);
 
 		if (TST_RET != -1)
 			SAFE_CLOSE(TST_RET);
@@ -346,7 +340,7 @@ static void tester_run_fs_rules(const int rules, const int result)
 		_test_make(FILE_REGULAR, S_IFREG, 0, result);
 
 	if (strcmp(tst_device->fs_type, "vfat") &&
-		strcmp(tst_device->fs_type, "exfat")) {
+	    strcmp(tst_device->fs_type, "exfat")) {
 		if (rules & LANDLOCK_ACCESS_FS_MAKE_CHAR)
 			_test_make(DEV_CHAR0, S_IFCHR, dev_chr, result);
 
@@ -366,9 +360,7 @@ static void tester_run_fs_rules(const int rules, const int result)
 	if (rules & LANDLOCK_ACCESS_FS_TRUNCATE) {
 		int abi;
 
-		abi = SAFE_LANDLOCK_CREATE_RULESET(
-			NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
-
+		abi = SAFE_LANDLOCK_CREATE_RULESET(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
 		if (abi < 3) {
 			tst_res(TINFO, "Skip truncate test. Minimum ABI version is 3");
 			return;

---
base-commit: 0b891ea23ed7315afa12df92fe12f1218a420bde
change-id: 20260706-fix_make_check_landlock-38af9cbaed68

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
