Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667A6CCFA13
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 00:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762475521; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=p8ryqXvkphOLIV5k8PozRAH70Pm7Cy7ANi4vUgOnrYc=;
 b=ACq+yegSx8m2KEcH9FLone3WQDcllPR3WMXLbHyXiJepkncmjrEUcPVplVRm6pQuMffK0
 gtIM9O3Snc8MbpqtMzkpVVWddBOOtcZu7POoq8r+FuoAn9Kc5zfQZGAjAfp3hG1MJb0aVhS
 XtBYpC0UbWX1s3rnrhTrt7ZG/cEkdmQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0565E3C6EAC
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 01:32:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3830E3CED01
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 01:30:53 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4BE55600D63
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 01:30:52 +0100 (CET)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-640e9a53ff6so415102a12.0
 for <ltp@lists.linux.it>; Thu, 06 Nov 2025 16:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762475451; x=1763080251; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLURZZlg4MjZCU3aMCUcHdeP0CfV7LAUNpCy7JVe0OM=;
 b=KMfI03Il5JyQzHjRmczd5czm3zpLz2I37rA+jgz5C5ZgN2YfEuGiZ7X4vY/SiPtrcF
 oxgSAsRNlT75KI/Ew+9NFtV2QYNeGGB+Ac+UB0AeX+XkPN43RPpiCD6T8zc1I1xTdrz/
 j9milutfzxFymtFsJcGJaFGZUCju+uMpfDVUTFi1iAzSAA/EhqxPW/1UiqJktZ5yupB3
 UBR0SzIkMJnwMOm68Z3SL6oSrNbj3TdOEsqTzdP4eGwqJaQ5oc9JqL/CYGSzJZbizNGn
 B3VEGPNSUKIB+4VOx9z1at1JLqZRh585T/1K88H0OEEQyNH8/gd8cXKUU1izOk4Jq5Zf
 KTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762475451; x=1763080251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mLURZZlg4MjZCU3aMCUcHdeP0CfV7LAUNpCy7JVe0OM=;
 b=g6qsyS+e1M1R4YcQAN4xnooYMmiGJ1OHRFrtoYb0L0B7wavKISR0t2zdWWgBCaynki
 uqt7gvxzKTXImnm1+SpIMZF9YzDliuJO04ue8BaFrKA7IACYbUcqP20eD7byHtA6Eh0f
 xTWzMtQRTWwejsLQQm4WsVnPhIMv7S+8gBln4BgZTVYKv6MLurjK40FklJkC/RMcGFob
 kLJUZ8CmA0ro4WB0m5JREBpLvH4KL3HBVgxHKbOlIZA5BFctYYi3QEKZLOyJPA874c7A
 CnopBJI+ICoIEZuWvBRw1jhE5bxQhaw15zJ/hCnbGICAZm1P9PQAa54LXpTt3SDT2mEL
 4Akw==
X-Gm-Message-State: AOJu0YyKbJUGoP+jnwGXdBxIkxxhykgDw0W3pbCJiOtIAUYnEUZyzoST
 tMN+txqaLK+R3S14oh8iZB/f70R/m4JPjKvEulOOzg95HExX5cbUwxNqRmKUU9f+S4dlA06jGjP
 g3j8=
X-Gm-Gg: ASbGncvjOsJgeiFumgerzctaDGcpXsAOMWAxjvGp/IvUqLJvMHSLo4e2djUBrwKH5ao
 7H2dRlpRi2hPRYjmPZmVAL/0R+DD+uOEiCxN9r6EOVdiq2PdEVT7mHQ8Pyps6sZ1oUTXVJfGBpc
 YvL7tkkUDUE8Bgr3kLsxWbqrl4vJGH+U/++fV1iS2HBV10WboNss3kbs0t3cKRFuWlOd8QJvuVh
 Qktv3lisUwkfKFTLe+QLCGGH4stqukHoyuztkzIWQd6IBJNbnhzKjF6kU2zepve68NBBcPVddtP
 F/F0zdbVu8etaUIQ4qTquouTyi3x+QJZxZJ2MjQ6d44qynRnUQ9IVRqUB8bJ06DDfVTpW1AQ3n4
 Z3Cmwz/+WEbDLmXWlHzXgri11swCSxBGXd6SvUd4J2SRYIuUMhD2V5qi31gqgWDIFQWxW24I/Kx
 8=
X-Google-Smtp-Source: AGHT+IE06nuDu5Od7lon8DqUk5Qtv/IJQ8EKSUNg4WOp8PM2rPBVibL/DPkpMh3sBMTIcRBEZhn+gA==
X-Received: by 2002:a17:906:f582:b0:b40:5752:16b7 with SMTP id
 a640c23a62f3a-b72c0d08229mr117147066b.51.1762475451399; 
 Thu, 06 Nov 2025 16:30:51 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf97e457sm85731066b.43.2025.11.06.16.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 16:30:51 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri,  7 Nov 2025 00:30:25 +0000
Message-ID: <20251107003041.28929-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107003041.28929-1-wegao@suse.com>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251107003041.28929-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/4] lib: Add support option for .needs_cmds
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
