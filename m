Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351F4ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 15:44:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E76813CA964
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 17:44:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B192C3CA952
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:58 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 30FA11A00A3E
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:55 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id t7so6829312wrm.10
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=SUKK3/lEm4yM+FKMNoMR65cnxytjb5+VkL/IWRsDcyA=;
 b=FcjNf3ihFs/88okbpSd8PCTqXdKSl6/qczUhJXCCmZotClU7h4HzeRdofYxO1XGB3G
 qZmtAtHQAJCQI0/SM5rDRbHFqM9GhgpiHJyMpDJWPC92p60W2g/51ObVVcUW/Mi/VPAY
 MUOd4Id0OHLU12WzUtTO5hAy55DvZOtVnpbWa1ErQuzw5iS3KM0sVU21bxN2LtZ/mz7R
 Cy937n9SVjttMF3Gv0Gvg44Se8x33vulpmJwcN5BFQV5NGHxLu4APaM96pSM3S9xe3KH
 1uIbdHXzoouiS4uQ39ljoPat3R3+k64khihc7tkw+AcJ5vR3Ri62WlCAAmTZbleCib2M
 LKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=SUKK3/lEm4yM+FKMNoMR65cnxytjb5+VkL/IWRsDcyA=;
 b=e+pxBnoK+piebPrIcaK3GhqxdpcyKkbB3M4Y7wdBp3CcWGyIGn2rzOIARpfw+Z/3f4
 zhNYWRBcy5FyR0xp5Z/7gjX1e4z9G3AoWGAnPRx4C53Qr0oJYu5YOUnNat+5HJbyVP7A
 l+ZV32+DRVqmzTVTQaho2KIhHCRVJ4HCMul+HcIVgF85wOF1zMncvUyoXHtXpbZWnp6l
 5pd42xaERKlJ+KiAKawdYRy8RLxDIqoSF9XBJFTD1rmPrKfCKZwZ2PkXlaaWnSnQjVnq
 s3sGqBHb/UGcYHW+CNu+M7+kJfxuqONlqf2LqApGLxK76nYJrpfrrrnIYOknMp+JCSfl
 f8+A==
X-Gm-Message-State: ACgBeo3NAwTBQKxYoYqrugcfl8aT0Yfo05xPWGgU9QHlgGC5ncev9ekF
 MiWuw6vwdeTToUu33OCUUBqPWv1Mfls=
X-Google-Smtp-Source: AA6agR5N+huQCQb5DyrsLByIOjWaG94jdNTszb3aZLMR4fyvRidjY/TY67sCKEYBjCrwvksEcGLm1w==
X-Received: by 2002:adf:f4cc:0:b0:228:ab76:fa13 with SMTP id
 h12-20020adff4cc000000b00228ab76fa13mr2148890wrp.110.1662392574729; 
 Mon, 05 Sep 2022 08:42:54 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 e5-20020adfe7c5000000b0022862e037e3sm5790023wrn.38.2022.09.05.08.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 08:42:54 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Sep 2022 18:42:37 +0300
Message-Id: <20220905154239.2652169-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905154239.2652169-1-amir73il@gmail.com>
References: <20220905154239.2652169-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/9] syscalls/fanotify10: Run tests with two ignore
 mask variants
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

Run test with legacy FAN_MARK_IGNORED_MASK variant and new
FAN_MARK_IGNORE variant if kernel supports it.

When running the new variant, do not need to use the hack of
setting events and flags in both mask and ignored mask.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h |  3 ++
 .../kernel/syscalls/fanotify/fanotify10.c     | 34 ++++++++++++++-----
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 936d6787e..6fbd96d11 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -113,6 +113,9 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 #define FAN_MARK_IGNORE_SURV	(FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY)
 #endif
 /* Non-uapi convenience macros */
+#ifndef FAN_MARK_IGNORED_SURV
+#define FAN_MARK_IGNORED_SURV	(FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY)
+#endif
 #ifndef FAN_MARK_PARENT
 #define FAN_MARK_PARENT		FAN_MARK_ONLYDIR
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 5d7b90e58..96c63c4ba 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -73,6 +73,7 @@ static int exec_events_unsupported;
 static int fan_report_dfid_unsupported;
 static int filesystem_mark_unsupported;
 static int evictable_mark_unsupported;
+static int ignore_mark_unsupported;
 
 #define MOUNT_PATH "fs_mnt"
 #define MNT2_PATH "mntpoint"
@@ -393,24 +394,27 @@ static int create_fanotify_groups(unsigned int n)
 			if (p == 0)
 				continue;
 
-			mask = FAN_OPEN;
-			mark_ignored = FAN_MARK_IGNORED_MASK |
-					FAN_MARK_IGNORED_SURV_MODIFY;
+			/*
+			 * Run tests in two variants:
+			 * 1. Legacy FAN_MARK_IGNORED_MASK
+			 * 2. FAN_MARK_IGNORE
+			 */
+			mark_ignored = tst_variant ? FAN_MARK_IGNORE_SURV : FAN_MARK_IGNORED_SURV;
+			mask = FAN_OPEN | tc->ignored_onchild;
 add_mark:
 			SAFE_FANOTIFY_MARK(fd_notify[p][i],
 					    FAN_MARK_ADD | ignore_mark->flag | mark_ignored,
 					    mask, AT_FDCWD, tc->ignore_path);
 
 			/*
-			 * If ignored mask is on a parent watching children,
-			 * also set the flag FAN_EVENT_ON_CHILD in mark mask.
+			 * FAN_MARK_IGNORE respects FAN_EVENT_ON_CHILD flag, but legacy
+			 * FAN_MARK_IGNORED_MASK does not. When using legacy ignore mask,
+			 * if ignored mask is on a parent watching children, we need to
+			 * also set the event and flag FAN_EVENT_ON_CHILD in mark mask.
 			 * This is needed to indicate that parent ignored mask
 			 * should be applied to events on children.
 			 */
-			if (tc->ignored_onchild && mark_ignored) {
-				mask = tc->ignored_onchild;
-				/* XXX: temporary hack may be removed in the future */
-				mask |= FAN_OPEN;
+			if (tc->ignored_onchild && mark_ignored & FAN_MARK_IGNORED_MASK) {
 				mark_ignored = 0;
 				goto add_mark;
 			}
@@ -535,6 +539,11 @@ static void test_fanotify(unsigned int n)
 		return;
 	}
 
+	if (ignore_mark_unsupported && tst_variant) {
+		tst_res(TCONF, "FAN_MARK_IGNORE not supported in kernel?");
+		return;
+	}
+
 	if (tc->ignored_onchild && tst_kvercmp(5, 9, 0) < 0) {
 		tst_res(TCONF, "ignored mask in combination with flag FAN_EVENT_ON_CHILD"
 				" has undefined behavior on kernel < 5.9");
@@ -628,6 +637,7 @@ static void setup(void)
 								      FAN_CLASS_CONTENT, 0);
 	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
 	evictable_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_EVICTABLE);
+	ignore_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_IGNORE_SURV);
 	fan_report_dfid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME,
 									  MOUNT_PATH);
 	if (fan_report_dfid_unsupported) {
@@ -660,11 +670,17 @@ static void cleanup(void)
 		SAFE_UMOUNT(MNT2_PATH);
 
 	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
+
+	SAFE_UNLINK(FILE_PATH);
+	SAFE_UNLINK(FILE2_PATH);
+	SAFE_RMDIR(DIR_PATH);
+	SAFE_RMDIR(MNT2_PATH);
 }
 
 static struct tst_test test = {
 	.test = test_fanotify,
 	.tcnt = ARRAY_SIZE(tcases),
+	.test_variants = 2,
 	.setup = setup,
 	.cleanup = cleanup,
 	.mount_device = 1,
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
