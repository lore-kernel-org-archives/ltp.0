Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57E6C7115B
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 07:37:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72CDE3CCA7F
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 09:37:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C89493CC31D
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 09:37:22 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 10550100034E
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 09:37:22 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-60768f080d8so6810665a12.1
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 00:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750664241; x=1751269041; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kFk1RamVaXX4nJRRXkhqfXekRFD4gxoudByESikvVbA=;
 b=Hku1yInA7i+IuN2cf0vTkjZybTxot5R0A536ttGhcfpMDaYZptiSN4x2idRTq8nPT7
 K4hHCGn3eDNUMThyRSr6Umf6eT6kTmyxHRQuZCVqau6XwP5z81eezaaYPv+jA0qAfjNV
 ++bKAImZMOvXB9gQlVgvyuzUrYpb8NNnpy8dWbI0MMIeOQx0ELUEWi3BIhNvW6xRJMCC
 OLlSXl73kziYl2/Rbsd3VsK5fthWR11KM/hdbWqnMN4bcCfS2XNgr7Dp5lU9xHn78Gam
 fRdzNmlsQY/CSb+iLQQiS/oEj61cvF0OMFNmsQf6H9C42OtVkCbbRc+CZiTqzPuJn1ZW
 aWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750664241; x=1751269041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kFk1RamVaXX4nJRRXkhqfXekRFD4gxoudByESikvVbA=;
 b=iWEXEul7eV1GkTYliSoEoOwHYGqfdobeyvDvFtcRjcy5q4bLs0oH7FbFYBq5Cjga5n
 TRgHtBnng75Y4CNQwHufdUUTLjUv7jLshzMu82tXf3s4/gY42To7JW9QiCBRT8R0TmUL
 CdiEpj58hsc0c8hN0D4YJAahXe52yM8t9F+ARNLqqMay7mZB+GqQse9INgMBsFw/jQWq
 KRtNwE7/KiqhyvpkzkJWUxXnw8jeE/gQq6y/ksuW17plzwoblXVE26uvY/8uOGjDjs9c
 4joHIpPSTGy1nltkIauhrxroUOlekgDaEC+UEk19WcOQL9/TY2WHxTJ9dAA4MIoOvJ7q
 sCEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5y0hNQqWU6E/MTlu543IgY/bTp7Q9DWQ0jvCaZpvrX6Jg9HrfAzmilw+OqC+SoAxTtNw=@lists.linux.it
X-Gm-Message-State: AOJu0YyQEere8DvhcqVj3uuCsY4W3shrwfnDg4z/LjnHbARnE13vcxTy
 JUineseD2BsKRP6xUjvO/9gHbApjcV+oFyF830dTZjPniYWRZulSyMPMlKwYvk5s
X-Gm-Gg: ASbGncvUEbTyAhAjkeI3yb32hj0Emygl74N/qOy8DSCROVK9cxOqJnMNMTM8Sk3K9/e
 7Ui7h3QfoLtPRdgXYZhqXDIkZkxThu1fHxbpZrEBBreId3pUMcWIIhRLLNp/BbexsUuQuebVLY/
 vhZ1yl+5gVjg/exFTqcyYRyZYz6GFjMlTBpmA36aGyvp33Rcq+yztEDQ0vpp8UPOodBj4Q3UfJp
 gZdgUfPnWys7/vl+CsDX+THnmcWFYWSG3eUdyq76VWNNxiM5QFvo0vRl5JeATKEDuUfb5Aevckf
 WUJZ4/IxOP+/HPwkjBAelyooYFiCUGqLkhHFNQFWx+UDzTN5tyeW1gvyZrjtlxrPKzgUd0Cd1xH
 9ElUgx+UpS+71nQkJj2N71E4ipjKmp9Ok6d1LE16YW2kHgsnngsI3RwqrZME=
X-Google-Smtp-Source: AGHT+IHCTRbapJY3N46ZDL3K7mglQMPnkk3mrdYlLymxupaGqyNc29B+KF9FiYy9D5Rc1rF2vsyUmg==
X-Received: by 2002:a17:907:e846:b0:ade:3eb6:3b0 with SMTP id
 a640c23a62f3a-ae057f34d92mr1141845066b.31.1750664241096; 
 Mon, 23 Jun 2025 00:37:21 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0542080adsm661650966b.151.2025.06.23.00.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 00:37:20 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Jun 2025 09:37:17 +0200
Message-ID: <20250623073717.338178-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify10,
 fanotify23: fix cleanup of vfs_cache_pressure
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Avoid setting vfs_cache_pressure to zero if test was not run
because kernel does not support fanotify.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/linux-fsdevel/20250622215140.GX1880847@ZenIV/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify10.c | 8 ++++----
 testcases/kernel/syscalls/fanotify/fanotify23.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index ccb4f55df..2d33416f3 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -102,7 +102,6 @@ static int ignore_mark_unsupported;
 #define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
 #define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
 
-static int old_cache_pressure;
 static pid_t child_pid;
 static int bind_mount_created;
 static unsigned int num_classes = NUM_CLASSES;
@@ -925,7 +924,6 @@ static void setup(void)
 	SAFE_MKDIR(MNT2_PATH, 0755);
 	mount_cycle();
 
-	SAFE_FILE_SCANF(CACHE_PRESSURE_FILE, "%d", &old_cache_pressure);
 	/* Set high priority for evicting inodes */
 	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "500");
 }
@@ -939,8 +937,6 @@ static void cleanup(void)
 	if (bind_mount_created)
 		SAFE_UMOUNT(MNT2_PATH);
 
-	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
-
 	for (i = 0; i < max_file_multi; i++) {
 		char path[PATH_MAX];
 
@@ -972,6 +968,10 @@ static struct tst_test test = {
 		TEST_APP,
 		NULL
 	},
+	.save_restore = (const struct tst_path_val[]) {
+		{CACHE_PRESSURE_FILE, NULL, TST_SR_TCONF},
+		{}
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9bdda4e9cf2d"},
 		{"linux-git", "2f02fd3fa13e"},
diff --git a/testcases/kernel/syscalls/fanotify/fanotify23.c b/testcases/kernel/syscalls/fanotify/fanotify23.c
index 26c9e87fb..36c7779da 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify23.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify23.c
@@ -35,7 +35,6 @@
 #define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
 #define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
 
-static int old_cache_pressure;
 static int fd_notify;
 
 static unsigned long long event_set[EVENT_MAX];
@@ -234,7 +233,6 @@ static void setup(void)
 						FAN_MARK_FILESYSTEM,
 						FAN_ATTRIB, MOUNT_PATH);
 
-	SAFE_FILE_SCANF(CACHE_PRESSURE_FILE, "%d", &old_cache_pressure);
 	/* Set high priority for evicting inodes */
 	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "500");
 }
@@ -243,8 +241,6 @@ static void cleanup(void)
 {
 	if (fd_notify > 0)
 		SAFE_CLOSE(fd_notify);
-
-	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
 }
 
 static struct tst_test test = {
@@ -259,6 +255,10 @@ static struct tst_test test = {
 		{.type = "ext2"},
 		{}
 	},
+	.save_restore = (const struct tst_path_val[]) {
+		{CACHE_PRESSURE_FILE, NULL, TST_SR_TCONF},
+		{}
+	},
 };
 
 #else
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
