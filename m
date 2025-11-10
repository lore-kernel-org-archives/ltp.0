Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C16CCF9F8
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 02:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762742955; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=p8ryqXvkphOLIV5k8PozRAH70Pm7Cy7ANi4vUgOnrYc=;
 b=DmGC5Wft/3yFa2CZOwyf0ngtClW8dJbpTRDWFmtYkcve//9U18wlDlDnf07C1X+MFii41
 JTCVTkll0gU5qPCqsyv1cfJ0ezaxiyMTqCt8feZ8bsxZzraV4WZGTyYueVad2O1HGrW84JQ
 Gmq2Yp6zGNGNtwyNGFUaEgUkpdzyg9E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFA1F3CF52D
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 03:49:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F31AA3CF539
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 03:48:12 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E42B7600659
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 03:48:11 +0100 (CET)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b727f452fffso427973366b.1
 for <ltp@lists.linux.it>; Sun, 09 Nov 2025 18:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762742891; x=1763347691; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLURZZlg4MjZCU3aMCUcHdeP0CfV7LAUNpCy7JVe0OM=;
 b=hBQ6akCtPvKriFidaukS4UCUTfGtjxNVcKWxId6ZwXv0GKDzqdKM+C/ASV3ED2kGZz
 enLGfKJ367DmiJaL1r0Qwoxl/fUt679PnrOVKBXjn/ZD5deEwDpYTex7aGFI3PRf4gT6
 +7JtZ0RAQF8q/jyKRX1qKIiQ3+S5H43t5APP6FZtH1l1VI21beqefDYn4eoXauKt8kPv
 NWqS21Z6IJNELgI1asuPy8fhPFfpykQMbUHshblCuGZu1g1E+KLZrbwJvUJcDbirR0lC
 DRUttBxY9ePM+vIm3oFt4DyfA9ORpS+UpW8ob+8Ce3g6U56yoS+hd4GCL4Jylz+eX2sf
 jztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762742891; x=1763347691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mLURZZlg4MjZCU3aMCUcHdeP0CfV7LAUNpCy7JVe0OM=;
 b=Tvi+/T4b+J8rKEkdqCNX1eV0m2LWOmZRRlLGakqLroyPbHhvc/7ul+lFARhFW6MPC8
 T+skCSyVMHfRjVo3rby/Xnz/wwIKhqljaYyVnXWDWZ/6fxV1MgytOoIqOw1MUBZrs03F
 ifHS8+DdhpjC409f8NxYcVck1hwKrHMFLg0b/taHH9DdPVwmNDoHK/4nusrkyzgNOpaX
 916tZLdLkcka41zNJ9fd9DyzcWiSENNcCtEAryVclBC45PfennAUwRhjrldoOKQVcTTi
 NI1WfmFa5Ac4WnI00BV0tysQvcK6iBw5MUYOLPutiSx69TKZVry86AW15CKTmY+IntKW
 XeRQ==
X-Gm-Message-State: AOJu0Yz+t+hnW80myAn01g5XRz4bne9IFeoCEV+n2wuToNYgGFjmTBFc
 AuqL3t1dT+m7ndsaXczXYhTVd7sU/n08O9TdPLU4b+nymIGbyIYaufFGqhBOJjQyCV+rlxtlrUh
 7RdY=
X-Gm-Gg: ASbGncserHgrHNVg9hwzcKfT45AgLVIxtFcXM1yuM2cd4Xd3C4YcKoe2s6H1QfGcTx4
 /EK4tCr6aXxQZwZOWxNvbo3CsmG1iiuFP2httFb2tWNbNlIKl0WVtZmDyYj1hORGZrOcZuiZ3Yw
 w4wkUxWaoIx/fNsykSBFpAtH5Cl8meUXqCTZcz0YH8INjPICwlSHB81AnLbwvoTrhlday1AIgZI
 ontfpwj16QwQlQoH3dM92OyvqCj8OJriQJMfWRVOhJOBj+qV43zTrAh9dFAqxI22pSkFlNUMbAc
 +VGI1XEndx2drrZJ9wsRgZ74jbpbPXTqzq1LSAWYztkEEWpswl04uJUE3nn2c9YOzQuIewlx1aX
 EGoYHk2kWYGZyV+FqCa6Gp/dO3F2id2PSPm7SgYJQN2yAAFr36MGcj5Gr2bnXR60PcnOzzC0end
 s=
X-Google-Smtp-Source: AGHT+IGNBo0LFhYGXzfuV9Hf3/aGnZAV33b5Pk8YGgHA9rwdJdW48vrdTHhVHz+pl96Z3ezanmE6QA==
X-Received: by 2002:a17:907:3faa:b0:b71:60a3:a8b9 with SMTP id
 a640c23a62f3a-b72dff53b65mr564931366b.29.1762742890907; 
 Sun, 09 Nov 2025 18:48:10 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf9bd3d1sm984365366b.58.2025.11.09.18.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 18:48:10 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 10 Nov 2025 02:47:53 +0000
Message-ID: <20251110024805.31070-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110024805.31070-1-wegao@suse.com>
References: <20251107003041.28929-1-wegao@suse.com>
 <20251110024805.31070-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/3] lib: Add support option for .needs_cmds
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_cmd.h                             | 13 ++++
 include/tst_test.h                            | 16 ++++-
 lib/newlib_tests/tst_needs_cmds01.c           | 16 ++---
 lib/newlib_tests/tst_needs_cmds02.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds03.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds04.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds05.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds06.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds07.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds08.c           |  8 +--
 lib/tst_test.c                                | 22 +++++--
 testcases/kernel/device-drivers/zram/zram03.c |  8 +--
 testcases/kernel/fs/squashfs/squashfs01.c     |  6 +-
 testcases/kernel/security/aslr/aslr01.c       |  6 +-
 testcases/kernel/syscalls/add_key/add_key05.c | 10 +--
 .../kernel/syscalls/fanotify/fanotify22.c     |  6 +-
 testcases/kernel/syscalls/ioctl/ioctl09.c     |  6 +-
 testcases/kernel/syscalls/madvise/madvise11.c |  8 +--
 .../kernel/syscalls/quotactl/quotactl01.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl04.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl06.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl08.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl09.c     |  6 +-
 testcases/kernel/syscalls/statx/statx05.c     |  8 +--
 testcases/kernel/syscalls/statx/statx07.c     |  6 +-
 testcases/kernel/syscalls/statx/statx09.c     |  6 +-
 testcases/lib/tst_run_shell.c                 | 61 ++++++++++++++++++-
 27 files changed, 185 insertions(+), 87 deletions(-)

diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index cf6382955..2203241c5 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -19,6 +19,19 @@ enum tst_cmd_flags {
 	TST_CMD_TCONF_ON_MISSING = 2,
 };
 
+/**
+ * struct tst_cmd - Provides details about a command struct needed by LTP test.
+ * @cmd: The name of the command.
+ * @optional: A flag indicating if the command is optional.
+ * @present: A flag indicating if the command was found at runtime. This is an output
+ * parameter, set by the LTP library during the test setup.
+ */
+struct tst_cmd {
+	const char *cmd;
+	unsigned int optional:1;
+	unsigned int present:1;
+};
+
 /*
  * vfork() + execvp() specified program.
  *
diff --git a/include/tst_test.h b/include/tst_test.h
index 9c21c1728..9305cf39d 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -524,7 +524,7 @@ struct tst_fs {
  *
  * @tags: A {} terminated array of test tags. See struct tst_tag for details.
  *
- * @needs_cmds: A NULL terminated array of commands required for the test to run.
+ * @needs_cmds: A NULL terminated array of struct tst_cmd required for the test to run.
  *
  * @needs_cgroup_ver: If set the test will run only if the specified cgroup
  *                    version is present on the system.
@@ -617,7 +617,7 @@ struct tst_fs {
 
 	const struct tst_tag *tags;
 
-	const char *const *needs_cmds;
+	struct tst_cmd *needs_cmds;
 
 	const enum tst_cg_ver needs_cgroup_ver;
 
@@ -721,6 +721,18 @@ int tst_creat_unlinked(const char *path, int flags, mode_t mode);
  */
 const char *tst_get_tmpdir_root(void);
 
+/**
+ * tst_cmd_present() - Check if a command is present
+ * @cmd: The name of the command to check for.
+ *
+ * This function iterates through the &tst_test->needs_cmds array. It compares
+ * the given command name with each entry in the array and returns the 'present'
+ * flag for the matching command.
+ *
+ * Return: `true` if the command is present, `false` otherwise.
+ */
+bool tst_cmd_present(const char *cmd);
+
 /*
  * Validates exit status of child processes
  */
diff --git a/lib/newlib_tests/tst_needs_cmds01.c b/lib/newlib_tests/tst_needs_cmds01.c
index 777c69505..6ab1145d1 100644
--- a/lib/newlib_tests/tst_needs_cmds01.c
+++ b/lib/newlib_tests/tst_needs_cmds01.c
@@ -12,13 +12,13 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
-	.needs_cmds = (const char *[]) {
-		"mkfs.ext4",
-		"mkfs.ext4 >= 1.0.0",
-		"mkfs.ext4 <= 2.0.0",
-		"mkfs.ext4 != 2.0.0",
-		"mkfs.ext4 > 1.0.0",
-		"mkfs.ext4 < 2.0.0",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mkfs.ext4", .optional = 1},
+		{.cmd = "mkfs.ext4 >= 1.0.0", .optional = 0},
+		{.cmd = "mkfs.ext4 <= 2.0.0"},
+		{.cmd = "mkfs.ext4 != 2.0.0"},
+		{.cmd = "mkfs.ext4 > 1.0.0"},
+		{.cmd = "mkfs.ext4 < 2.0.0"},
+		{}
 	}
 };
diff --git a/lib/newlib_tests/tst_needs_cmds02.c b/lib/newlib_tests/tst_needs_cmds02.c
index 455a275ea..f1d6105c2 100644
--- a/lib/newlib_tests/tst_needs_cmds02.c
+++ b/lib/newlib_tests/tst_needs_cmds02.c
@@ -16,8 +16,8 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
-	.needs_cmds = (const char *[]) {
-		"mkfs.ext45 >= 1.43.0",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mkfs.ext45 >= 1.43.0"},
+		{}
 	}
 };
diff --git a/lib/newlib_tests/tst_needs_cmds03.c b/lib/newlib_tests/tst_needs_cmds03.c
index bdc1cdf6a..ac5f368e2 100644
--- a/lib/newlib_tests/tst_needs_cmds03.c
+++ b/lib/newlib_tests/tst_needs_cmds03.c
@@ -16,8 +16,8 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
-	.needs_cmds = (const char *[]) {
-		"mkfs.ext4 ! 1.43.0",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mkfs.ext4 ! 1.43.0"},
+		{}
 	}
 };
diff --git a/lib/newlib_tests/tst_needs_cmds04.c b/lib/newlib_tests/tst_needs_cmds04.c
index de10b8f3e..2aea51772 100644
--- a/lib/newlib_tests/tst_needs_cmds04.c
+++ b/lib/newlib_tests/tst_needs_cmds04.c
@@ -16,8 +16,8 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
-	.needs_cmds = (const char *[]) {
-		"mkfs.ext4 > 1.43",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mkfs.ext4 > 1.43"},
+		{}
 	}
 };
diff --git a/lib/newlib_tests/tst_needs_cmds05.c b/lib/newlib_tests/tst_needs_cmds05.c
index c3b2b3b9a..969d4e2f5 100644
--- a/lib/newlib_tests/tst_needs_cmds05.c
+++ b/lib/newlib_tests/tst_needs_cmds05.c
@@ -16,8 +16,8 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
-	.needs_cmds = (const char *[]) {
-		"mkfs.ext4 > 1.43.0-1",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mkfs.ext4 > 1.43.0-1"},
+		{}
 	}
 };
diff --git a/lib/newlib_tests/tst_needs_cmds06.c b/lib/newlib_tests/tst_needs_cmds06.c
index 40b1cf09c..91470ccf9 100644
--- a/lib/newlib_tests/tst_needs_cmds06.c
+++ b/lib/newlib_tests/tst_needs_cmds06.c
@@ -16,8 +16,8 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
-	.needs_cmds = (const char *[]) {
-		"mkfs.ext4 > 1.43.0 2",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mkfs.ext4 > 1.43.0 2"},
+		{}
 	}
 };
diff --git a/lib/newlib_tests/tst_needs_cmds07.c b/lib/newlib_tests/tst_needs_cmds07.c
index d0b4ce2ff..371bbdc1b 100644
--- a/lib/newlib_tests/tst_needs_cmds07.c
+++ b/lib/newlib_tests/tst_needs_cmds07.c
@@ -16,8 +16,8 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
-	.needs_cmds = (const char *[]) {
-		"mkfs.ext45",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mkfs.ext45"},
+		{}
 	}
 };
diff --git a/lib/newlib_tests/tst_needs_cmds08.c b/lib/newlib_tests/tst_needs_cmds08.c
index 38df2ef6d..412f9f293 100644
--- a/lib/newlib_tests/tst_needs_cmds08.c
+++ b/lib/newlib_tests/tst_needs_cmds08.c
@@ -18,9 +18,9 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
-	.needs_cmds = (const char *[]) {
-		"mkfs.xfs",
-		"mkfs.xfs >= 4.20.0",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mkfs.xfs"},
+		{.cmd = "mkfs.xfs >= 4.20.0"},
+		{}
 	}
 };
diff --git a/lib/tst_test.c b/lib/tst_test.c
index da5314c50..67553f65d 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1365,6 +1365,19 @@ static const char *default_fs_type(void)
 	return tst_dev_fs_type();
 }
 
+bool tst_cmd_present(const char *cmd)
+{
+	struct tst_cmd *pcmd = tst_test->needs_cmds;
+
+	while (pcmd->cmd) {
+		if (!strcmp(pcmd->cmd, cmd))
+			return pcmd->present;
+
+		pcmd++;
+	}
+	return false;
+}
+
 static void do_setup(int argc, char *argv[])
 {
 	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
@@ -1439,11 +1452,12 @@ static void do_setup(int argc, char *argv[])
 		tst_brk(TCONF, "%dbit ABI is not supported", tst_test->needs_abi_bits);
 
 	if (tst_test->needs_cmds) {
-		const char *cmd;
-		int i;
+		struct tst_cmd *pcmd = tst_test->needs_cmds;
 
-		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
-			tst_check_cmd(cmd, 1);
+		while (pcmd->cmd) {
+			pcmd->present = tst_check_cmd(pcmd->cmd, !pcmd->optional) ? 1 : 0;
+			pcmd++;
+		}
 	}
 
 	if (tst_test->needs_drivers) {
diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
index 8cf26de4c..4dcf23b4e 100644
--- a/testcases/kernel/device-drivers/zram/zram03.c
+++ b/testcases/kernel/device-drivers/zram/zram03.c
@@ -240,9 +240,9 @@ static struct tst_test test = {
 		"zram",
 		NULL
 	},
-	.needs_cmds = (const char *[]) {
-		"modprobe",
-		"rmmod",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "modprobe"},
+		{.cmd = "rmmod"},
+		{}
 	}
 };
diff --git a/testcases/kernel/fs/squashfs/squashfs01.c b/testcases/kernel/fs/squashfs/squashfs01.c
index fbcb76582..7a548d62c 100644
--- a/testcases/kernel/fs/squashfs/squashfs01.c
+++ b/testcases/kernel/fs/squashfs/squashfs01.c
@@ -102,9 +102,9 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_device = 1,
 	.dev_min_size = 1,
-	.needs_cmds = (const char *const []) {
-		"mksquashfs",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mksquashfs"},
+		{}
 	},
 	.needs_drivers = (const char *const []) {
 		"squashfs",
diff --git a/testcases/kernel/security/aslr/aslr01.c b/testcases/kernel/security/aslr/aslr01.c
index 6a396e29d..e6feb2d3c 100644
--- a/testcases/kernel/security/aslr/aslr01.c
+++ b/testcases/kernel/security/aslr/aslr01.c
@@ -277,8 +277,8 @@ static struct tst_test test = {
 		"CONFIG_HAVE_ARCH_MMAP_RND_BITS=y",
 		NULL
 	},
-	.needs_cmds = (const char *[]) {
-		"ldd",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "ldd"},
+		{}
 	},
 };
diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
index c9a2f840e..b51a84b97 100644
--- a/testcases/kernel/syscalls/add_key/add_key05.c
+++ b/testcases/kernel/syscalls/add_key/add_key05.c
@@ -231,11 +231,11 @@ static struct tst_test test = {
 		{&user_buf, .size = 64},
 		{}
 	},
-	.needs_cmds = (const char *const []) {
-		"useradd",
-		"userdel",
-		"groupdel",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "useradd"},
+		{.cmd = "userdel"},
+		{.cmd = "groupdel"},
+		{}
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a08bf91ce28"},
diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 357e74dbc..6578474a7 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -327,9 +327,9 @@ static struct tst_test test = {
 		{"linux-git", "76486b104168"},
 		{}
 	},
-	.needs_cmds = (const char *[]) {
-		"debugfs",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "debugfs"},
+		{}
 	}
 };
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
index 262d6fcab..737aee680 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl09.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
@@ -108,9 +108,9 @@ static struct tst_test test = {
 		"loop",
 		NULL
 	},
-	.needs_cmds = (const char *const []) {
-		"parted",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "parted"},
+		{}
 	},
 	.needs_tmpdir = 1,
 };
diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 422589f5b..73d2d4294 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -421,10 +421,10 @@ static struct tst_test test = {
 		HW_MODULE,
 		NULL
 	},
-	.needs_cmds = (const char *[]) {
-		"modprobe",
-		"rmmod",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "modprobe"},
+		{.cmd = "rmmod"},
+		{}
 	},
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_MEMORY_FAILURE=y",
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 9dcf74ceb..3091ac5bf 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -223,9 +223,9 @@ static struct tst_test test = {
 		{}
 	},
 	.mntpoint = MNTPOINT,
-	.needs_cmds = (const char *const []) {
-		"quotacheck",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "quotacheck"},
+		{}
 	},
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index d2d7b3f3e..a70903330 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -165,8 +165,8 @@ static struct tst_test test = {
 	},
 	.mntpoint = MNTPOINT,
 	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
-	.needs_cmds = (const char *[]) {
-		"mkfs.ext4 >= 1.43.0",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mkfs.ext4 >= 1.43.0"},
+		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 110a3aa9b..333f5720d 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -226,9 +226,9 @@ static struct tst_test test = {
 	},
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
-	.needs_cmds = (const char *const []) {
-		"quotacheck",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "quotacheck"},
+		{}
 	},
 	.needs_root = 1,
 	.test_variants = QUOTACTL_FMT_VARIANTS,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
index 63087345f..ce7a8b008 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl08.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
@@ -220,8 +220,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
-	.needs_cmds = (const char *[]) {
-		"mkfs.ext4 >= 1.43.0",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mkfs.ext4 >= 1.43.0"},
+		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c b/testcases/kernel/syscalls/quotactl/quotactl09.c
index 673666347..fd6629c0c 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl09.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
@@ -185,8 +185,8 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.needs_root = 1,
 	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
-	.needs_cmds = (const char *[]) {
-		"mkfs.ext4 >= 1.43.0",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mkfs.ext4 >= 1.43.0"},
+		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index 2a4603226..07b5e7b94 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -123,9 +123,9 @@ static struct tst_test test = {
 		{.type = "ext4"},
 		{}
 	},
-	.needs_cmds = (const char *[]) {
-		"mkfs.ext4 >= 1.43.0",
-		"e4crypt",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mkfs.ext4 >= 1.43.0"},
+		{.cmd = "e4crypt"},
+		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index bab64591f..755644cf9 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -171,8 +171,8 @@ static struct tst_test test = {
 		{}
 	},
 	.needs_root = 1,
-	.needs_cmds = (const char *[]) {
-		"exportfs",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "exportfs"},
+		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
index ee4be4250..8838d5450 100644
--- a/testcases/kernel/syscalls/statx/statx09.c
+++ b/testcases/kernel/syscalls/statx/statx09.c
@@ -162,8 +162,8 @@ static struct tst_test test = {
 		"CONFIG_FS_VERITY",
 		NULL
 	},
-	.needs_cmds = (const char *[]) {
-		"mkfs.ext4 >= 1.45.2",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "mkfs.ext4 >= 1.45.2"},
+		{}
 	}
 };
diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 7a446e004..6def36dcb 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -175,6 +175,23 @@ static ujson_obj fs_obj = {
 	.attr_cnt = UJSON_ARRAY_SIZE(fs_attrs),
 };
 
+enum cmd_ids {
+	CMD,
+	OPTIONAL,
+	PRESENT,
+};
+
+static ujson_obj_attr cmd_attrs[] = {
+	UJSON_OBJ_ATTR_IDX(CMD, "cmd", UJSON_STR),
+	UJSON_OBJ_ATTR_IDX(OPTIONAL, "optional", UJSON_INT),
+	UJSON_OBJ_ATTR_IDX(PRESENT, "present", UJSON_INT),
+};
+
+static ujson_obj cmd_obj = {
+	.attrs = cmd_attrs,
+	.attr_cnt = UJSON_ARRAY_SIZE(cmd_attrs),
+};
+
 static int parse_mnt_flags(ujson_reader *reader, ujson_val *val)
 {
 	int ret = 0;
@@ -252,6 +269,48 @@ static struct tst_fs *parse_filesystems(ujson_reader *reader, ujson_val *val)
 	return ret;
 }
 
+static struct tst_cmd *parse_cmds(ujson_reader *reader, ujson_val *val)
+{
+	unsigned int i = 0, cnt = 0;
+	struct tst_cmd *ret;
+
+	ujson_reader_state state = ujson_reader_state_save(reader);
+
+	UJSON_ARR_FOREACH(reader, val) {
+		if (val->type != UJSON_OBJ) {
+			ujson_err(reader, "Expected object!");
+			return NULL;
+		}
+		ujson_obj_skip(reader);
+		cnt++;
+	}
+
+	ujson_reader_state_load(reader, state);
+
+	ret = SAFE_MALLOC(sizeof(struct tst_cmd) * (cnt + 1));
+	memset(&ret[cnt], 0, sizeof(ret[cnt]));
+
+	UJSON_ARR_FOREACH(reader, val) {
+		UJSON_OBJ_FOREACH_FILTER(reader, val, &cmd_obj, ujson_empty_obj) {
+			switch ((enum cmd_ids)val->idx) {
+			case CMD:
+				ret[i].cmd = strdup(val->val_str);
+			break;
+			case OPTIONAL:
+				ret[i].optional = val->val_int;
+			break;
+			case PRESENT:
+				ret[i].present = val->val_int;
+			break;
+			}
+		}
+
+		i++;
+	}
+
+	return ret;
+}
+
 static struct tst_tag *parse_tags(ujson_reader *reader, ujson_val *val)
 {
 	unsigned int i = 0, cnt = 0;
@@ -440,7 +499,7 @@ static void parse_metadata(void)
 				ujson_err(&reader, "ABI bits must be 32 or 64");
 		break;
 		case NEEDS_CMDS:
-			test.needs_cmds = parse_strarr(&reader, &val);
+			test.needs_cmds = parse_cmds(&reader, &val);
 		break;
 		case NEEDS_DEVFS:
 			test.needs_devfs = val.val_bool;
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
