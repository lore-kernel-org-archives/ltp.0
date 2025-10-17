Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CB4CCD19A
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760695881; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=EZOyonS790LVaMxhW/R//kgOzKOEVz3onF0sOrXIhB4=;
 b=OWAOFxy5M+qeFH0yHJvGUIYP9N2CWSDSkcG0Xd/McpVXwE9x6bS5rm8yjMfqlmfbdLwaU
 8bM9OWfzk+e9In46aOJGrHNWqoW+M4G59pYpfBGt/s2XKUEqaJqfD5IPEO8TFB3/wnnsGi0
 nIhFR4LOYCLps3Yi4N+UY0dft9MZABs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 894613CEE71
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 12:11:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FFD73CEE36
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 12:10:21 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4BB6F1A01012
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 12:10:20 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so12595085e9.2
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760695819; x=1761300619; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0J1Z8B9tDpD3LWGqSigplalObxoX9TuTOrHHMRvKAz4=;
 b=ICWruq/vrbmX5In32j9N5UF4WedBa40aUzLXbNB+leqZztXMVVTTG6WRRryjdOzE26
 hL8KQruFp+ak2vC7JM6YuBcdYpT+7+m/y/gmi0/Bw1yKJ9bOL1Dvl8LDtMAJuUwCo/FC
 MEe/Ibhps96iWHtbirLH6rDsMnm+WAEnzqOD2SsL3BPRzMyXStiO8iMHNN0UIoz9MyGs
 887vLMF19B6nG2ZM27t999EyI45lynh1hJHxUZcerXfUycoIo8s2ZTHtJ3IowD9sivIU
 7JBL82U/3P16c5fEvV/Jvq+32pSIX4bvY9o/Ap1DQyRZ7ayFCSkvuKTtRN8t6B0rG1Jo
 851w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760695819; x=1761300619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0J1Z8B9tDpD3LWGqSigplalObxoX9TuTOrHHMRvKAz4=;
 b=hoszFWgmaX1S07SFFMuoYYqnoYQKdLuE1rIvFeF+BQZaRgZyazRIIkMjjom4pwqFzR
 c+XvW8DHrd3xwHXW2THx6EfsRDDMbE9zOMRN1X+YeZJeIxgXOc+GwaGwwIUyWTwFHn2p
 MTxf6WOySOy4y5/F23ItWBQGt39Upahs72ote4n14ziArG2BpU8+D4QOgScQVAkz2Id0
 dq1TTYVApUh6raD/Wj5YvtT153/ZYCrnFUeu3baLj/IuYikQRScrdTs9d1mBjtQYdaDn
 L8J3ClM6s0c6/SLJDSvzYKlT6ZYRDXT9oI+ZEmgVF1UPS/+69cnS2KkyRCp8UDQE2YMZ
 CwHQ==
X-Gm-Message-State: AOJu0YyzGPqL7GbQsBlYppyHBZfRRJjfwI801olF6sGbbRRGDzXLe/oO
 Jw6rP6QEC35nVe0jgOhirPvLG+9zjF68ldzV0khsCm5E3MdCzf0gtCB5lQbuvy2kAcmdQP47dMv
 m4mU=
X-Gm-Gg: ASbGncurXiLrJOk7WiY0mehFlF0/8tAOVlamZZfIEVrtDluuAETfSUqSTx1J+qSVAy9
 amlZ9CYG4+Mph2yiHnEkQGvOUS2Hl/r6jjS5Gp9B9RjxXqTeiW85iAPbAUG+EIXzTLcdklWgH9c
 L4jGVjQLSzlfkIFxFFZDVaG4x1UN83A2N5PLZShD4jqUWyPyR8/vGzG9VdtT71mC0HcnQj/Rd1i
 golMnjsdtXZAir1HBIj/OZAiUEODtYOYsqcZ2thiUZcyoIjQRa6B0XZi+yl03xei1vyAoc8icsy
 Xp8AhqqvKRMlCXH4C6NP/OZ3eROzeuJQruv2RGfFhZzZpyjD24wfNYQ1dSAjA8MG0E/7qKAOkuN
 eKwq9+m9h9qf2Eindo/hnIV9Lr9XduzuKhCEZZKn0jW4+hVI9mGCgI+YigyGfBBsjZfHI0hyU/G
 E=
X-Google-Smtp-Source: AGHT+IHa0hGFDpkP9rwVoeUPC0INlhQC8rXXhv/oOIo7KznmbMcdDtj1tdjVVQXRfSogbdyZslY1bA==
X-Received: by 2002:a05:600c:3513:b0:46f:b43a:aef3 with SMTP id
 5b1f17b1804b1-47117920953mr20031305e9.39.1760695819335; 
 Fri, 17 Oct 2025 03:10:19 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-426fb279857sm10769256f8f.20.2025.10.17.03.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 03:10:19 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 17 Oct 2025 10:09:57 +0000
Message-ID: <20251017101011.3811-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017101011.3811-1-wegao@suse.com>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/3] Update test cases use new needs_cmds
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
 lib/newlib_tests/tst_needs_cmds01.c           | 16 +++++------
 lib/newlib_tests/tst_needs_cmds02.c           |  6 ++--
 lib/newlib_tests/tst_needs_cmds03.c           |  6 ++--
 lib/newlib_tests/tst_needs_cmds04.c           |  6 ++--
 lib/newlib_tests/tst_needs_cmds05.c           |  6 ++--
 lib/newlib_tests/tst_needs_cmds06.c           |  6 ++--
 lib/newlib_tests/tst_needs_cmds07.c           |  6 ++--
 lib/newlib_tests/tst_needs_cmds08.c           |  8 +++---
 testcases/kernel/device-drivers/zram/zram03.c |  8 +++---
 testcases/kernel/fs/squashfs/squashfs01.c     |  6 ++--
 testcases/kernel/security/aslr/aslr01.c       |  6 ++--
 testcases/kernel/syscalls/add_key/add_key05.c | 10 +++----
 .../kernel/syscalls/fanotify/fanotify22.c     |  6 ++--
 testcases/kernel/syscalls/ioctl/ioctl09.c     |  6 ++--
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 28 +++++++++----------
 testcases/kernel/syscalls/madvise/madvise11.c |  8 +++---
 .../kernel/syscalls/quotactl/quotactl01.c     |  6 ++--
 .../kernel/syscalls/quotactl/quotactl04.c     |  6 ++--
 .../kernel/syscalls/quotactl/quotactl06.c     |  6 ++--
 .../kernel/syscalls/quotactl/quotactl08.c     |  6 ++--
 .../kernel/syscalls/quotactl/quotactl09.c     |  6 ++--
 testcases/kernel/syscalls/statx/statx05.c     |  8 +++---
 testcases/kernel/syscalls/statx/statx07.c     |  6 ++--
 testcases/kernel/syscalls/statx/statx09.c     |  6 ++--
 24 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/lib/newlib_tests/tst_needs_cmds01.c b/lib/newlib_tests/tst_needs_cmds01.c
index 777c69505..592456da6 100644
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
+		{.cmd = "mkfs.ext4"},
+		{.cmd = "mkfs.ext4 >= 1.0.0"},
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
index f86355f2c..1bd60fc84 100644
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
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index cb1b506d2..fe62e7e5a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -78,21 +78,7 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)
 
 static void verify_ioctl_loop(void)
 {
-	int ret;
-	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
-					"primary", "ext4", "1M", "10M", NULL};
-
-	tst_fill_file("test.img", 0, 1024 * 1024, 10);
 	tst_attach_device(dev_path, "test.img");
-
-	ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
-	if (!ret)
-		parted_sup = 1;
-	else if (ret == 255)
-		tst_res(TCONF, "parted binary not installed or failed");
-	else
-		tst_res(TCONF, "parted exited with %i", ret);
-
 	attach_flag = 1;
 
 	TST_ASSERT_INT(partscan_path, 0);
@@ -112,10 +98,20 @@ static void verify_ioctl_loop(void)
 
 static void setup(void)
 {
+	parted_sup = tst_cmd_present("parted");
+
+	const char *const cmd_parted[] = {"parted", "-s", "test.img", "mklabel", "msdos", "mkpart",
+	                                  "primary", "ext4", "1M", "10M", NULL};
+
 	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
 	if (dev_num < 0)
 		tst_brk(TBROK, "Failed to find free loop device");
 
+	tst_fill_file("test.img", 0, 1024 * 1024, 10);
+
+	if (parted_sup)
+		SAFE_CMD(cmd_parted, NULL, NULL);
+
 	sprintf(partscan_path, "/sys/block/loop%d/loop/partscan", dev_num);
 	sprintf(autoclear_path, "/sys/block/loop%d/loop/autoclear", dev_num);
 	sprintf(backing_path, "/sys/block/loop%d/loop/backing_file", dev_num);
@@ -148,5 +144,9 @@ static struct tst_test test = {
 		{"linux-git", "6ac92fb5cdff"},
 		{}
 	},
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "parted", .optional = 1},
+		{}
+	},
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
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
