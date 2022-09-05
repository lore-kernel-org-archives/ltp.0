Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFB2ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 15:44:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B80713CA992
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 17:44:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 293F83CA9AD
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:57 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0BC441400DF6
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:54 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 az24-20020a05600c601800b003a842e4983cso5935203wmb.0
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=Kcedx62aIqvD+JaY6xfm6pl3oWjRMCAVSSTW2aJxUkE=;
 b=not7efgmUSAwM+lvw3EAgHMoDCR6uGA4rsvLSfnUrOzRumsOpN8JGY61cUTQ02NzYG
 kUV3zB4/Om/GGojdwJ+NflAuax9erFyzOg6A7ay4wqviilMyqCXc+AFmb6PvNzepNUeN
 fKBSu6gozj4FzZHgu5GAjRcHb6AKYiji6rkd+MB1UC6WNTAPrPiN7iLxMJkzxRGljR2f
 mHpyH5Tty/ShITF4xr+DJn0+6pAlKKBswTmX0MzpgqVfDMOk6XZKj3k1ZcG9ADHcpiU/
 VMGqEgBSbwGSgBJZBWtdXezoBBJVnFIeVmLjnaweJdq6RVlOGr2+fJtlO1ngNgPXR+1r
 ukBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=Kcedx62aIqvD+JaY6xfm6pl3oWjRMCAVSSTW2aJxUkE=;
 b=IFTb4w1MA6UR3PwxtQbdAyIGYONn6BkMthP6U+nqHUP0NN5DWO4z44e2YtZz6LSnHT
 s6FEeYVmTOO9o2hfjM89+CbeICeDpYp0r1Tlh/VJMrzi9Z1BfQWxFb0dkgULXMIiOpe+
 I7do6922uhwr4kHLfPf+4sGaOXS4/0t/oCcv14PrF6889oG7pHkqQoFailjO2TbmyDw+
 airgvAxcl8a5RK+LXOZDpQ5RBmoLxt1qrbYS6C2A9h4pDdxjAPdAy6EM0CadJemb49sx
 SgxCdDfeE1FmcBZWZimc+74SEzdmzdR1R1jy4yRS3QDwfz3axyvj44ghRod/dXRQ2ZfT
 p98Q==
X-Gm-Message-State: ACgBeo2PIE+wEJ9zrOqAKd6O+DM4v0V+uqkm/s+qR7fTdzmV/8bdn8Dh
 wviag80ZyvOk/SSTHK4wZUk=
X-Google-Smtp-Source: AA6agR4zxvU0LL9DMRThFM+NXNfPQ/tMDB1G5Bq/1EL9T9hfzwF0ZEEgZiopxej7k+Gf/9cbsWdceg==
X-Received: by 2002:a05:600c:502c:b0:3a8:41e9:cd32 with SMTP id
 n44-20020a05600c502c00b003a841e9cd32mr10971946wmr.177.1662392573615; 
 Mon, 05 Sep 2022 08:42:53 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 e5-20020adfe7c5000000b0022862e037e3sm5790023wrn.38.2022.09.05.08.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 08:42:53 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Sep 2022 18:42:36 +0300
Message-Id: <20220905154239.2652169-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905154239.2652169-1-amir73il@gmail.com>
References: <20220905154239.2652169-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/9] syscalls/fanotify10: Use dedicated mark type for
 inode mark on parent
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

This highlights the test cases that use a directory inode mark on parent
in contrast to the test cases that use non-dir inode marks.

One test case that uses DIR_MNT2 for no reason (there are no mount marks
in this test case) was changed to use the standard DIR_PATH.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h |  3 +++
 .../kernel/syscalls/fanotify/fanotify10.c     | 20 ++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 810a48e81..936d6787e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -113,6 +113,9 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 #define FAN_MARK_IGNORE_SURV	(FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY)
 #endif
 /* Non-uapi convenience macros */
+#ifndef FAN_MARK_PARENT
+#define FAN_MARK_PARENT		FAN_MARK_ONLYDIR
+#endif
 #ifndef FAN_MARK_TYPES
 #define FAN_MARK_TYPES (FAN_MARK_INODE | FAN_MARK_MOUNT | FAN_MARK_FILESYSTEM)
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index ea05e4ff0..5d7b90e58 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -102,6 +102,7 @@ static unsigned int num_classes = NUM_CLASSES;
 
 enum {
 	FANOTIFY_INODE,
+	FANOTIFY_PARENT,
 	FANOTIFY_MOUNT,
 	FANOTIFY_FILESYSTEM,
 	FANOTIFY_EVICTABLE,
@@ -109,6 +110,7 @@ enum {
 
 static struct fanotify_mark_type fanotify_mark_types[] = {
 	INIT_FANOTIFY_MARK_TYPE(INODE),
+	INIT_FANOTIFY_MARK_TYPE(PARENT),
 	INIT_FANOTIFY_MARK_TYPE(MOUNT),
 	INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
 	INIT_FANOTIFY_MARK_TYPE(EVICTABLE),
@@ -243,57 +245,57 @@ static struct tcase {
 	},
 	{
 		"ignore child exec events created on a specific mount point",
-		MOUNT_PATH, FANOTIFY_INODE,
+		MOUNT_PATH, FANOTIFY_PARENT,
 		MOUNT_PATH, FANOTIFY_MOUNT,
 		0,
 		FILE_EXEC_PATH, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		"ignore events on children of directory created on a specific file",
-		DIR_MNT2, FANOTIFY_INODE,
-		DIR_PATH, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_PARENT,
+		DIR_PATH, FANOTIFY_PARENT,
 		FAN_EVENT_ON_CHILD,
 		FILE_PATH, 0, FAN_OPEN
 	},
 	{
 		"ignore events on file created inside a parent watching children",
 		FILE_PATH, FANOTIFY_INODE,
-		DIR_PATH, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_PARENT,
 		FAN_EVENT_ON_CHILD,
 		FILE_PATH, 0, FAN_OPEN
 	},
 	{
 		"don't ignore events on file created inside a parent not watching children",
 		FILE_PATH, FANOTIFY_INODE,
-		DIR_PATH, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_PARENT,
 		0,
 		FILE_PATH, FAN_OPEN, FAN_OPEN
 	},
 	{
 		"ignore mount events created inside a parent watching children",
 		FILE_PATH, FANOTIFY_MOUNT,
-		DIR_PATH, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_PARENT,
 		FAN_EVENT_ON_CHILD,
 		FILE_PATH, 0, FAN_OPEN
 	},
 	{
 		"don't ignore mount events created inside a parent not watching children",
 		FILE_PATH, FANOTIFY_MOUNT,
-		DIR_PATH, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_PARENT,
 		0,
 		FILE_PATH, FAN_OPEN, FAN_OPEN
 	},
 	{
 		"ignore fs events created inside a parent watching children",
 		FILE_PATH, FANOTIFY_FILESYSTEM,
-		DIR_PATH, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_PARENT,
 		FAN_EVENT_ON_CHILD,
 		FILE_PATH, 0, FAN_OPEN
 	},
 	{
 		"don't ignore fs events created inside a parent not watching children",
 		FILE_PATH, FANOTIFY_FILESYSTEM,
-		DIR_PATH, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_PARENT,
 		0,
 		FILE_PATH, FAN_OPEN, FAN_OPEN
 	},
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
