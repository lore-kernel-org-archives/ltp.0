Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A988BE6B26D
	for <ltp@archiver.kernel.org>; Tue, 23 Dec 2025 02:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766455766; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=TVubq4eTAD97KYSvPsVae+kPoxDVcwb0HoKCu0k3Amo=;
 b=RKkqEqHEajhzNyMgl8l/4NWM50obkXK7lJNP3ZqRRJXyr5P/tHCkCnBiVGupw94uB0Iv+
 v1x5Bx+6cCeUZ9Ak6ZuF7haX6E2tqulqYy2MtVhrrtv289YpI8jhBEVGqHdyEmBTOt/cOQc
 rUEODw+otSmYFAVGlSRgkuivHco4mXQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17E683D044E
	for <ltp@archiver.kernel.org>; Tue, 23 Dec 2025 03:09:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DA293D044E
 for <ltp@lists.linux.it>; Tue, 23 Dec 2025 03:08:42 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 858C720007D
 for <ltp@lists.linux.it>; Tue, 23 Dec 2025 03:08:41 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so51916255e9.3
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 18:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766455721; x=1767060521; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4B3D6K6bFnp083dfvj04nK/Pls0m+982SXUMXzLkP4=;
 b=PKq+fPcW7wpnJHm6zygDwZ/rA3A/jtN0rAKnQxIYGMA8X37O9g9Ep1zvlV8LAigk36
 FfpvvUmTMtY9KXx2Ejm/qeeaquMckf4hqmCPb4jqIst9LI/pyXjrnF2UdjfIFnMcZOaS
 IaiZTsrh47UFq2IboijxQ4VSsw9DDpMyLCiI7+kuU0HFN5R0h144w0lmWwidnI5+VAyg
 FKaXAWF83Qdm+Mt+81k8eBbGVATp6coD0Kv4fLlee1VvSz5wEv3qqXvrrUvjip+U5imb
 YILW8bAq3tESZAxHNDuEjwvrVWuFwtxo3g1NUdzjT/XePA5LBluwfBE9Y4XI+ewVGth2
 h0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766455721; x=1767060521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H4B3D6K6bFnp083dfvj04nK/Pls0m+982SXUMXzLkP4=;
 b=qAeJQ8FCT1DQDhz2hcQtkRNIgPCRjg24kKga3BiVMWn+qdIQkXUUm1IAwf7aP04/r5
 D9jlZHWTP8Hb8hX438XjwVbbtKzbVR3KSwbYOFMvU8kiBPiWB7K0603c+YeK2l8zn6jz
 Ik89h8/YPGqgqz/kvhy/vchHg+kmYi0ZYLAZHqQOraeUBb0kSzGnZwIQIszRP9Le6oYG
 3ZNJBdrBRq07AuSrQ/n1Jj3iwwPkEMbU05FZ8flqpw7hgCUXf3QgRzwsGUVZT4nmUKOS
 fIf5zGeL0EdAh9/53m18LniRzUoOxTubi4n3IU2L2vC/hE4bUvlZD7Fzvi33dQqTH5f/
 NKhA==
X-Gm-Message-State: AOJu0YyaL8egMh7443SB+hux3U4xf+bHADFqhXbmgjyKLMZvlZTShjym
 BP2yN0hPneHYXCBR7n/Phb3ch/J9vwcD7ilbHURBVE2unfTLzBO5/bINQLj5sdHe267H+uSBFkE
 dMP0=
X-Gm-Gg: AY/fxX6r8aykmIrpDa26YysX64w+OmIlNlbyXKRndiX+1yFUFcLDDn8wxY/nXMs1Jtr
 Ai1hIUXH7AaW1WUD7yK7wii9l97jyADxoPyoB3U8ewvOVQ3MC/6us1quncwGKhToQduZFPz/Yqz
 zzU9LYW+kq+OdxDca+IiT0D2vLg6RtcleVLOia9/z4llyPLo/9D1J/7RME7DeV9M94N8ZxXKhcg
 M6JskV4YK4tqUJKoI2Ib8fck6KIzDNNnM34tsI1Q/4C0obIpfYhweeOsJ+j4SUr71hpXwv6jkcG
 Kg+JX2ZGZwBpT6JIkCZSccHstQgsnt/KUs7hfAcVkbbyf7O75q6RPNOvK3rcLOCMLg7ASCpAHlb
 mWkfY3bHDZ5ZzZSwzA94yMO9sNxvysnZoTP3C/iTbFxj5MvxEwsJdPZXa4lgg3M0JDpME8zs7zV
 gDhvc8o6hecQ==
X-Google-Smtp-Source: AGHT+IE10lytp1MQZrFgbpCFN8R354sOZOKOi/lrt+kAn0BVZkBCAh/g4fHlD7uFz4flQW4wVBKtig==
X-Received: by 2002:a05:600c:6489:b0:46e:7e22:ff6a with SMTP id
 5b1f17b1804b1-47d1956f5c2mr125103515e9.15.1766455720670; 
 Mon, 22 Dec 2025 18:08:40 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4324ea8311fsm25039435f8f.28.2025.12.22.18.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 18:08:40 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 23 Dec 2025 02:08:15 +0000
Message-ID: <20251223020836.9439-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223020836.9439-1-wegao@suse.com>
References: <20251110024805.31070-1-wegao@suse.com>
 <20251223020836.9439-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/4] lib: Add support option for .needs_cmds
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
 include/tst_test.h                            |  4 +-
 lib/newlib_tests/tst_needs_cmds01.c           | 16 ++---
 lib/newlib_tests/tst_needs_cmds02.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds03.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds04.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds05.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds06.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds07.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds08.c           |  8 +--
 lib/tst_test.c                                |  9 +--
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
 27 files changed, 160 insertions(+), 87 deletions(-)

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
index 9c21c1728..38a9d0d54 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -524,7 +524,7 @@ struct tst_fs {
  *
  * @tags: A {} terminated array of test tags. See struct tst_tag for details.
  *
- * @needs_cmds: A NULL terminated array of commands required for the test to run.
+ * @needs_cmds: A NULL terminated array of :ref:`struct tst_cmd` required for the test to run.
  *
  * @needs_cgroup_ver: If set the test will run only if the specified cgroup
  *                    version is present on the system.
@@ -617,7 +617,7 @@ struct tst_fs {
 
 	const struct tst_tag *tags;
 
-	const char *const *needs_cmds;
+	struct tst_cmd *needs_cmds;
 
 	const enum tst_cg_ver needs_cgroup_ver;
 
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
index da5314c50..42a54621e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1439,11 +1439,12 @@ static void do_setup(int argc, char *argv[])
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
index c046d8959..21e16efb6 100644
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
index 91f34127d..f3786a4a5 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -179,6 +179,23 @@ static ujson_obj fs_obj = {
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
@@ -256,6 +273,48 @@ static struct tst_fs *parse_filesystems(ujson_reader *reader, ujson_val *val)
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
@@ -450,7 +509,7 @@ static void parse_metadata(void)
 				ujson_err(&reader, "ABI bits must be 32 or 64");
 		break;
 		case NEEDS_CMDS:
-			test.needs_cmds = parse_strarr(&reader, &val);
+			test.needs_cmds = parse_cmds(&reader, &val);
 		break;
 		case NEEDS_DEVFS:
 			test.needs_devfs = val.val_bool;
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
