Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE4FCCA476
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 06:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760078964; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=k0dMRmZYIbS4alh/BJfGa8yGJoEaqp/KbZWcfymJg7I=;
 b=cTJ69FtWRnKaQZEOwUzcN5POVAN2EgWJVgPTNGqg44ShVQFeUG6s43Xau/LP0hnxUeAw2
 p1bjcK7N3Y+rmOWX5eiXrG6piL4BcRYWwmnp0MEbkPh3c2wxKeDDJB5298iG4Qv0kQFqJMk
 jv1q2XrTMKdHw93J1e369zfqftmqJzY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 844B73CE981
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 08:49:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03F5F3CE970
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 08:48:03 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8ED501400244
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 08:48:02 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46faa5b0372so10776025e9.1
 for <ltp@lists.linux.it>; Thu, 09 Oct 2025 23:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760078882; x=1760683682; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qiqp88orf02z5Ewv8XUZXmbBzdSR75mT8QdMYJpxj+U=;
 b=dIsHvQMm+bcgI1wjzTekz2MzAywoJfgfl8rRczOd+fnaOdabGPNgzoKz/LJ2BcIAOv
 lcefX3oI1AT5ECQIy/BW5U0v6nz3NrXeZ2z064PTzBYZ8VsrKhklDnhaV5mvB0PZtfHs
 pXFObTsCoQYzbUeB8RsgxJbyTu8p6DdgdrBDHQZEeG3y6yIQbopXgUKtIrp4zyxud5+W
 jwh/Q695bqm1kDdov3zSrSIC35NUQnRkQc25mnZMgC5kPPnLcFgXmzCpsTBAe9u9WnWN
 1nrOXLPVN+Gc4NFPC9jmSZfT2pDErNiNAXqYeJ25Cn4fwR2Fm+ajtsX5G3Oghpi8bx20
 b4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760078882; x=1760683682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qiqp88orf02z5Ewv8XUZXmbBzdSR75mT8QdMYJpxj+U=;
 b=pC9JYeC/kepcoCg8ASf2/NaXOcXBXc07wcT/H8DqNu2ykmouK3W4eaH6umXfqP6PhD
 Pyp3lieXDyQ4gtfJ1W7e+c1fuDzNGpFG5ktmtUJkZ4jleNQ1YO1jQQ35WHQ3Db3go6vx
 FHyGSzYmVWKyncCyppzjaA+69m6kPrUWVacrf84jw9SIgEekzaGtEauqIKWKohdgTijM
 DVHF+QnMwRUU8H/ETmxHSENFJFHF50RZ7bNvr21950Jh0N4OrL+ss9FMA9QE9vKmUPUf
 FyuhhrHAnKN4VMlB1pLCC1fwW7UkuzIpQ6bUF6F4GucwD3lMjyydCjqQwe0kNkd+geZK
 QuMQ==
X-Gm-Message-State: AOJu0YzZoCI7rurLOG2d+FqumoqQQvxfkVRAghK8XQI5JimX+VAX/Ny7
 6ujfr8GTodTc/9tTdpDibW9AcBE/rf1G4t8yOwFKNtgbdccPkEKMeb3qJHvfGennzOK4MaOl8Jm
 uzsE=
X-Gm-Gg: ASbGncu2dsS57JpIUjQgA8jux9D+tJazpQn9+cV6k/aMFkdDiTLI7uF90rCt1VKmAMQ
 n+BAo9e/eXgbvdFo4F8RJX2W2uiJndPPJOK+/JkPSKwrV1UNl34CSRxxOMMd9/O7KfNKLcsF53R
 FWq59+L07SUl0m5nP1moDu1sY3MvpREuENkGWz9yL59nED6MUxIILzdBFOccVlyrGFBxLLrGyv/
 E40qQnHF5PDXT1vAAjRtqnhSHza/ksNzt49PUO5log3XMk39Ve9UI20UqBSGAk7zr02PbrPvgsb
 Rn5kM/VkZ7KMFkHjL+mS0ajRCz5TVkVxqqxtAQOvKaVdymQqe5dzaxa6UY+n9eBM+RBEH4wUqrC
 uJFR05b4sDrJO2/xcLcjpAMh80QElCA==
X-Google-Smtp-Source: AGHT+IF5WRIiMtWKavaLI5Wg4GhNQpjwJanMKDPxa7IKMrEaK+MUnuVxXkVdeFTvJH/5A0hkvIQo6w==
X-Received: by 2002:a05:600c:3e1a:b0:46e:1d8d:cfa2 with SMTP id
 5b1f17b1804b1-46fa9af9842mr68911435e9.20.1760078881678; 
 Thu, 09 Oct 2025 23:48:01 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-46fb484d056sm32014455e9.9.2025.10.09.23.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 23:48:01 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 10 Oct 2025 06:45:49 +0000
Message-ID: <20251010064745.31361-4-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010064745.31361-1-wegao@suse.com>
References: <20250928232708.24007-2-wegao@suse.com>
 <20251010064745.31361-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] Update test cases use new needs_cmds
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/newlib_tests/tst_needs_cmds01.c             | 16 ++++++++--------
 lib/newlib_tests/tst_needs_cmds02.c             |  6 +++---
 lib/newlib_tests/tst_needs_cmds03.c             |  6 +++---
 lib/newlib_tests/tst_needs_cmds04.c             |  6 +++---
 lib/newlib_tests/tst_needs_cmds05.c             |  6 +++---
 lib/newlib_tests/tst_needs_cmds06.c             |  6 +++---
 lib/newlib_tests/tst_needs_cmds07.c             |  6 +++---
 lib/newlib_tests/tst_needs_cmds08.c             |  8 ++++----
 testcases/kernel/device-drivers/zram/zram03.c   |  8 ++++----
 testcases/kernel/fs/squashfs/squashfs01.c       |  6 +++---
 testcases/kernel/security/aslr/aslr01.c         |  6 +++---
 testcases/kernel/syscalls/add_key/add_key05.c   | 10 +++++-----
 testcases/kernel/syscalls/fanotify/fanotify22.c |  6 +++---
 testcases/kernel/syscalls/ioctl/ioctl09.c       |  6 +++---
 testcases/kernel/syscalls/madvise/madvise11.c   |  8 ++++----
 testcases/kernel/syscalls/quotactl/quotactl01.c |  6 +++---
 testcases/kernel/syscalls/quotactl/quotactl04.c |  6 +++---
 testcases/kernel/syscalls/quotactl/quotactl06.c |  6 +++---
 testcases/kernel/syscalls/quotactl/quotactl08.c |  6 +++---
 testcases/kernel/syscalls/quotactl/quotactl09.c |  6 +++---
 testcases/kernel/syscalls/statx/statx05.c       |  8 ++++----
 testcases/kernel/syscalls/statx/statx07.c       |  6 +++---
 testcases/kernel/syscalls/statx/statx09.c       |  6 +++---
 23 files changed, 80 insertions(+), 80 deletions(-)

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
