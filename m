Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1076EECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 15:43:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C2413CA991
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 17:43:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F6E93CA8F1
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:48 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A67EE60082A
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:47 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id k9so11909294wri.0
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=/2TpWBuCG9kNmJPBfzJIYFAoFGWDCLc2w7hz1elXk44=;
 b=CCrHNjZlUHCHHoWyMQkHMhNjDnC57KjiOVz4/r/ZaUQJV8V+13gyhxDlDr6IieQt3W
 pg9P8r1NogupfP79ts5LIBUTw5Hzb+lU2Gxr1SaNScfzu3bzKLXxo9vx6tamuulY1gWG
 +mYgCHNWhodK4dyOqsH9FedO6i+Fn0zsC3ZRNsVmeYQD1yCL9GSdi9JQtwsPYgIum54N
 vY/kFCvEPRIH1fTjjTExnkZcQNL4M8fycVBAt+/bFv1ipOMUE1THr0Wt8Uf9fBLpydsl
 ODZOHIC1Nn5Jmz8xS5FuXTIFzv8UQzQA7rNwSWBC1PCdxTNVstWXERGtIrJZL2DjM7gZ
 RW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=/2TpWBuCG9kNmJPBfzJIYFAoFGWDCLc2w7hz1elXk44=;
 b=YoaiU5O/RYh9hM0LqIwIMr+SssUYb1D+vAG3ixV60wvlbSL55G0kt2J3Uak4NYSW1k
 I00Ki4KrLQv/s/yUlWyxF8xrb8aeUlbwhw/zwcY538Xye/5SiudDTmppWMzPm4BEQKHm
 t2w/ey05/FYCd7MSrMdQl3jt4jEw0btesVuhyfDqqpigbmVnxeFg8zDjiXWCJ5XEOEgK
 oevFvT3ClUgMwYgK98Iypry/xnA8WqCqa1VmlSUMkcHKU0JhxQDo2QNbpUidcXSMgS5y
 gYcDvi4dmoJIthmB/ME0266PTA6Iv4JNUgkInl2XT4CQyQnafQEoUSU+gFDng6O5lj1t
 2tAg==
X-Gm-Message-State: ACgBeo0MYG1PfFGk6ZkQiopj4hJ8+5Fz6MaOoXk8xpAGYD5c3pInzx38
 U5cR1F6a7I1zVoU7dWRHbuZ3qGS1sRE=
X-Google-Smtp-Source: AA6agR7IhSZKht4KcuWAagS8tguxyh9IVnjG7wlp1RK9szHVzoPY8szmdH5nRE/3EdUvZ/SsT8rG+w==
X-Received: by 2002:a05:6000:1a86:b0:226:fd9b:7357 with SMTP id
 f6-20020a0560001a8600b00226fd9b7357mr10810619wry.458.1662392567015; 
 Mon, 05 Sep 2022 08:42:47 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 e5-20020adfe7c5000000b0022862e037e3sm5790023wrn.38.2022.09.05.08.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 08:42:46 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Sep 2022 18:42:31 +0300
Message-Id: <20220905154239.2652169-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905154239.2652169-1-amir73il@gmail.com>
References: <20220905154239.2652169-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/9] syscalls/fanotify09: Add test cases for
 FAN_MARK_IGNORE
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

Verify the semantics of the new FAN_MARK_IGNORE flag:

1. Verify that ignore mask ignores events on dir only
   when FAN_ONDIR flag is set in ignore mask

2. Verify that ignore mask ignores events on child only
   when FAN_EVENT_ON_CHILD flag is set in ignore mask

3. Verify that ignore mask ignores events on subdir only
   when both FAN_EVENT_ON_CHILD and FAN_ONDIR flags are
   set in ignore mask

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h |   6 ++
 .../kernel/syscalls/fanotify/fanotify09.c     | 102 +++++++++++++++---
 2 files changed, 95 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index a118fbd9e..d67c079af 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -106,6 +106,12 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 #ifndef FAN_MARK_EVICTABLE
 #define FAN_MARK_EVICTABLE	0x00000200
 #endif
+#ifndef FAN_MARK_IGNORE
+#define FAN_MARK_IGNORE		0x00000400
+#endif
+#ifndef FAN_MARK_IGNORE_SURV
+#define FAN_MARK_IGNORE_SURV	(FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY)
+#endif
 
 /* New dirent event masks */
 #ifndef FAN_ATTRIB
diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 0eb83e2f8..e40916c08 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -73,12 +73,14 @@ static char event_buf[EVENT_BUF_LEN];
 static int mount_created;
 
 static int fan_report_dfid_unsupported;
+static int ignore_mark_unsupported;
 
 static struct tcase {
 	const char *tname;
 	struct fanotify_mark_type mark;
 	unsigned int ondir;
 	unsigned int ignore;
+	unsigned int ignore_flags;
 	unsigned int report_name;
 	const char *close_nowrite;
 	int nevents;
@@ -88,7 +90,7 @@ static struct tcase {
 		"Events on non-dir child with both parent and mount marks",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		0,
-		0,
+		0, 0,
 		0,
 		DIR_NAME,
 		1, 0,
@@ -97,7 +99,7 @@ static struct tcase {
 		"Events on non-dir child and subdir with both parent and mount marks",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_ONDIR,
-		0,
+		0, 0,
 		0,
 		DIR_NAME,
 		2, 0,
@@ -106,7 +108,7 @@ static struct tcase {
 		"Events on non-dir child and parent with both parent and mount marks",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_ONDIR,
-		0,
+		0, 0,
 		0,
 		".",
 		2, 0
@@ -115,7 +117,7 @@ static struct tcase {
 		"Events on non-dir child and subdir with both parent and subdir marks",
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_ONDIR,
-		0,
+		0, 0,
 		0,
 		DIR_NAME,
 		2, 0,
@@ -124,7 +126,7 @@ static struct tcase {
 		"Events on non-dir children with both parent and mount marks",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		0,
-		0,
+		0, 0,
 		0,
 		FILE2_NAME,
 		2, FAN_CLOSE_NOWRITE,
@@ -133,7 +135,7 @@ static struct tcase {
 		"Events on non-dir child with both parent and mount marks and filename info",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		0,
-		0,
+		0, 0,
 		FAN_REPORT_DFID_NAME,
 		FILE2_NAME,
 		2, FAN_CLOSE_NOWRITE,
@@ -142,7 +144,7 @@ static struct tcase {
 		"Events on non-dir child with ignore mask on parent",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		0,
-		FAN_MARK_IGNORED_MASK,
+		FAN_MARK_IGNORED_MASK, 0,
 		0,
 		DIR_NAME,
 		1, 0,
@@ -151,11 +153,75 @@ static struct tcase {
 		"Events on non-dir children with surviving ignore mask on parent",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		0,
-		FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
+		FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY, 0,
+		0,
+		FILE2_NAME,
+		2, FAN_CLOSE_NOWRITE,
+	},
+	/* FAN_MARK_IGNORE test cases: */
+	{
+		"Events on dir with ignore mask that does not apply to dirs",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_ONDIR,
+		FAN_MARK_IGNORE_SURV, 0,
+		0,
+		".",
+		2, FAN_CLOSE_NOWRITE,
+	},
+	{
+		"Events on dir with ignore mask that does apply to dirs",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_ONDIR,
+		FAN_MARK_IGNORE_SURV, FAN_ONDIR,
+		0,
+		".",
+		2, 0,
+	},
+	{
+		"Events on child with ignore mask on parent that does not apply to children",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		0,
+		FAN_MARK_IGNORE_SURV, 0,
+		0,
+		FILE2_NAME,
+		2, FAN_CLOSE_NOWRITE,
+	},
+	{
+		"Events on child with ignore mask on parent that does apply to children",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		0,
+		FAN_MARK_IGNORE_SURV, FAN_EVENT_ON_CHILD,
 		0,
 		FILE2_NAME,
+		2, 0,
+	},
+	{
+		"Events on subdir with ignore mask on parent that does not apply to children",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_ONDIR,
+		FAN_MARK_IGNORE_SURV, FAN_ONDIR,
+		0,
+		DIR_NAME,
 		2, FAN_CLOSE_NOWRITE,
 	},
+	{
+		"Events on subdir with ignore mask on parent that does not apply to dirs",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_ONDIR,
+		FAN_MARK_IGNORE_SURV, FAN_EVENT_ON_CHILD,
+		0,
+		DIR_NAME,
+		2, FAN_CLOSE_NOWRITE,
+	},
+	{
+		"Events on subdir with ignore mask on parent that does apply to subdirs",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_ONDIR,
+		FAN_MARK_IGNORE_SURV, FAN_EVENT_ON_CHILD | FAN_ONDIR,
+		0,
+		DIR_NAME,
+		2, 0,
+	},
 };
 
 static void create_fanotify_groups(struct tcase *tc)
@@ -170,16 +236,19 @@ static void create_fanotify_groups(struct tcase *tc)
 		 */
 		unsigned int report_name = tc->report_name;
 		unsigned int mask_flags = tc->ondir | FAN_EVENT_ON_CHILD;
-		unsigned int parent_mask, ignore = 0;
+		unsigned int parent_mask, ignore_mask, ignore = 0;
 
 		/*
-		 * The non-first groups do not request events on children and
-		 * subdirs and may set an ignore mask on parent dir.
+		 * The non-first groups may request events on children and
+		 * subdirs only when setting an ignore mask on parent dir.
+		 * The parent ignore mask may request to ignore events on
+		 * children or subdirs.
 		 */
 		if (i > 0) {
 			ignore = tc->ignore;
 			report_name = 0;
-			mask_flags = 0;
+			if (!ignore)
+				mask_flags = 0;
 		}
 
 		fd_notify[i] = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | report_name |
@@ -206,8 +275,9 @@ static void create_fanotify_groups(struct tcase *tc)
 		 * the close event on dir.
 		 */
 		parent_mask = FAN_MODIFY | tc->ondir | mask_flags;
+		ignore_mask = FAN_CLOSE_NOWRITE | tc->ignore_flags;
 		SAFE_FANOTIFY_MARK(fd_notify[i], FAN_MARK_ADD | ignore,
-				    ignore ? FAN_CLOSE_NOWRITE : parent_mask,
+				    ignore ? ignore_mask : parent_mask,
 				    AT_FDCWD, ".");
 	}
 }
@@ -331,6 +401,11 @@ static void test_fanotify(unsigned int n)
 		return;
 	}
 
+	if (ignore_mark_unsupported && tc->ignore & FAN_MARK_IGNORE) {
+		tst_res(TCONF, "FAN_MARK_IGNORE not supported in kernel?");
+		return;
+	}
+
 	create_fanotify_groups(tc);
 
 	/*
@@ -422,6 +497,7 @@ static void setup(void)
 {
 	fan_report_dfid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME,
 									  MOUNT_PATH);
+	ignore_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_IGNORE_SURV);
 
 	SAFE_MKDIR(MOUNT_NAME, 0755);
 	SAFE_MOUNT(MOUNT_PATH, MOUNT_NAME, "none", MS_BIND, NULL);
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
