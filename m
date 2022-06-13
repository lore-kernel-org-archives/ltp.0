Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2129EC43334
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 14:39:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE5203C9411
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 16:39:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B55223C9482
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:38:39 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C7DBE20097B
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:38:38 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 m32-20020a05600c3b2000b0039756bb41f2so3220580wms.3
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/X/3/8LtuWNwE35gaqAiUG2XB5kTzPPMY2wFRjxgBVg=;
 b=OJJ6PipFDVq0jJcSC8JpJCchwmr1zHHfa87xP8mWnxO7BLa8G3gYKrHh80Vs27Lf77
 6kqh9zChrokdi0OMSqFwo562rOlEBcfRNmjuLYrz1rXSDsrQnT4IaGtHhtX2BdUd8m5J
 jmzV45w8K58yKbXo0DmtTN7ORsz9n5BxMf816dadbNxa2arTMGJXvBXp4heIbSPdtVOK
 vvS2c4aJ2ryzLCCCAqvZqY2i3jpV/9k7y7Xh8UwPDTS4pHNFISTNyLkZ9nWIlM1Sz3OL
 eWzQcZF0tuw7OlaMpiqx/y0S//I1TkUTFML/qQrbRQAZNe3ATAgGmtjN/4DmlogIiS7E
 kYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/X/3/8LtuWNwE35gaqAiUG2XB5kTzPPMY2wFRjxgBVg=;
 b=XV2qIik94+DHxmh2bZnDNPYbgI6lmTzVr/2Jg5Gr6eg1rZVOorShVCgYkXwSgZZuvL
 kyTUO1RbwHf2VXeaKJbFQZP4EeBZblKyU7wYnJLzZxcNFrQVr5bJCDfRmM6ftoiVO2FX
 yxvqO88NattcA3JMeYz1Evf0V2fuXYtsCE5ZvTbXulOmBMg/vHAqQokgup3yjmwobMRO
 iFB0vLSIKzkWcgCbmaOI3m79OHi14Ta5B1l9hwSvoyInpo6EFCapoml3PEvkWYCLgaKP
 llsdy23fNC68E5E9Gc5n0Ayi1Aa2gLQEK9ksrIkkEwZ02XPa9CG6BgPNRmusIWIboUaC
 aJ7Q==
X-Gm-Message-State: AOAM532TyZIJ61OHysJXmK8phPd8AYsmB3rcpVBRxMTHDAN2Fs9PkosG
 3UmhrqJiNpu0KXYqqK9z8Lo=
X-Google-Smtp-Source: ABdhPJx8CtxS/YEg9K/D61c2qv53gyK7OHnaRyZ6JadJIFT6EFikXp4JORZOKdXa41YtEmGZOa+xuw==
X-Received: by 2002:a05:600c:acb:b0:397:bdb:ffea with SMTP id
 c11-20020a05600c0acb00b003970bdbffeamr15538824wmr.56.1655131118336; 
 Mon, 13 Jun 2022 07:38:38 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c4fd300b0039c55bc2c97sm14833072wmq.16.2022.06.13.07.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 07:38:37 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Jun 2022 17:38:26 +0300
Message-Id: <20220613143826.1328830-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613143826.1328830-1-amir73il@gmail.com>
References: <20220613143826.1328830-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] syscalls/fanotify10: Add test cases for evictable
 ignore mark
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test multiple groups with evictable mark with ignore mask

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify10.c     | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index b9a50672d..52277d0b7 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -71,6 +71,7 @@ static char event_buf[EVENT_BUF_LEN];
 static int exec_events_unsupported;
 static int fan_report_dfid_unsupported;
 static int filesystem_mark_unsupported;
+static int evictable_mark_unsupported;
 
 #define MOUNT_PATH "fs_mnt"
 #define MNT2_PATH "mntpoint"
@@ -90,6 +91,10 @@ static int filesystem_mark_unsupported;
 #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
 #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
 
+#define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
+#define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
+
+static int old_cache_pressure;
 static pid_t child_pid;
 static int bind_mount_created;
 static unsigned int num_classes = NUM_CLASSES;
@@ -98,12 +103,14 @@ enum {
 	FANOTIFY_INODE,
 	FANOTIFY_MOUNT,
 	FANOTIFY_FILESYSTEM,
+	FANOTIFY_EVICTABLE,
 };
 
 static struct fanotify_mark_type fanotify_mark_types[] = {
 	INIT_FANOTIFY_MARK_TYPE(INODE),
 	INIT_FANOTIFY_MARK_TYPE(MOUNT),
 	INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+	INIT_FANOTIFY_MARK_TYPE(EVICTABLE),
 };
 
 static struct tcase {
@@ -289,14 +296,59 @@ static struct tcase {
 		0,
 		FILE_PATH, FAN_OPEN, FAN_OPEN
 	},
+	/* Evictable ignore mark test cases */
+	{
+		"don't ignore mount events created on file with evicted ignore mark",
+		MOUNT_PATH, FANOTIFY_MOUNT,
+		FILE_PATH, FANOTIFY_EVICTABLE,
+		0,
+		FILE_PATH, FAN_OPEN, FAN_OPEN
+	},
+	{
+		"don't ignore fs events created on a file with evicted ignore mark",
+		MOUNT_PATH, FANOTIFY_FILESYSTEM,
+		FILE_PATH, FANOTIFY_EVICTABLE,
+		0,
+		FILE_PATH, FAN_OPEN, FAN_OPEN
+	},
+	{
+		"don't ignore mount events created inside a parent with evicted ignore mark",
+		MOUNT_PATH, FANOTIFY_MOUNT,
+		DIR_PATH, FANOTIFY_EVICTABLE,
+		FAN_EVENT_ON_CHILD,
+		FILE_PATH, FAN_OPEN, FAN_OPEN
+	},
+	{
+		"don't ignore fs events created inside a parent with evicted ignore mark",
+		MOUNT_PATH, FANOTIFY_FILESYSTEM,
+		DIR_PATH, FANOTIFY_EVICTABLE,
+		FAN_EVENT_ON_CHILD,
+		FILE_PATH, FAN_OPEN, FAN_OPEN
+	},
 };
 
+static void show_fanotify_marks(int fd)
+{
+	unsigned int mflags, mask, ignored_mask;
+	char procfdinfo[100];
+
+	sprintf(procfdinfo, "/proc/%d/fdinfo/%d", (int)getpid(), fd);
+	if (FILE_LINES_SCANF(procfdinfo, "fanotify ino:%*x sdev:%*x mflags: %x mask:%x ignored_mask:%x",
+				&mflags, &mask, &ignored_mask)) {
+		tst_res(TPASS, "No fanotify inode marks as expected");
+	} else {
+		tst_res(TFAIL, "Unexpected inode mark (mflags=%x, mask=%x ignored_mask=%x)",
+				mflags, mask, ignored_mask);
+	}
+}
+
 static int create_fanotify_groups(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 	struct fanotify_mark_type *mark, *ignore_mark;
 	unsigned int mark_ignored, mask;
 	unsigned int p, i;
+	int evictable_ignored = (tc->ignore_mark_type == FANOTIFY_EVICTABLE);
 
 	mark = &fanotify_mark_types[tc->mark_type];
 	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
@@ -345,6 +397,20 @@ add_mark:
 			}
 		}
 	}
+
+	/*
+	 * drop_caches should evict inode from cache and remove evictable marks
+	 */
+	if (evictable_ignored) {
+		SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
+		for (p = 0; p < num_classes; p++) {
+			for (i = 0; i < GROUPS_PER_PRIO; i++) {
+				if (fd_notify[p][i] > 0)
+					show_fanotify_marks(fd_notify[p][i]);
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -439,6 +505,11 @@ static void test_fanotify(unsigned int n)
 		return;
 	}
 
+	if (evictable_mark_unsupported && tc->ignore_mark_type == FANOTIFY_EVICTABLE) {
+		tst_res(TCONF, "FAN_MARK_EVICTABLE not supported in kernel?");
+		return;
+	}
+
 	if (tc->ignored_onchild && tst_kvercmp(5, 9, 0) < 0) {
 		tst_res(TCONF, "ignored mask in combination with flag FAN_EVENT_ON_CHILD"
 				" has undefined behavior on kernel < 5.9");
@@ -527,6 +598,7 @@ static void setup(void)
 	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
 								      FAN_CLASS_CONTENT, 0);
 	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
+	evictable_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_EVICTABLE);
 	fan_report_dfid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME,
 									  MOUNT_PATH);
 	if (fan_report_dfid_unsupported) {
@@ -545,6 +617,10 @@ static void setup(void)
 	/* Create another bind mount at another path for generating events */
 	SAFE_MKDIR(MNT2_PATH, 0755);
 	mount_cycle();
+
+	SAFE_FILE_SCANF(CACHE_PRESSURE_FILE, "%d", &old_cache_pressure);
+	/* Set high priority for evicting inodes */
+	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "500");
 }
 
 static void cleanup(void)
@@ -553,6 +629,8 @@ static void cleanup(void)
 
 	if (bind_mount_created)
 		SAFE_UMOUNT(MNT2_PATH);
+
+	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
 }
 
 static const char *const resource_files[] = {
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
