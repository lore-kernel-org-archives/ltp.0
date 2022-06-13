Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CB3C43334
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 14:39:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76DD73C9442
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 16:39:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D84173C9443
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:38:36 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6D74E600807
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:38:36 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id z17so3101116wmi.1
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZmDm+wfXNRlCKKusawM8Hq7PWe2kcgml5UcY4PykNWg=;
 b=lKxUgrMdl0DkDWf1x40u50TQA7G1fDTOpLUMqHiZ9WjpTtyALp4SlgHdItSMZB9xdW
 +ZmmdlMNi9NAR0ptAfyPu/aHxhBE1/0y+oK6etotV52wptSzYS2o6Tn7LNSm6SK27WD7
 qBHJqCOh2VDhJbvOrvBo8/Xk8eO9hRdbNSAaJ53+96bnv2EMa8NyGzl/wpfx+BM+A5mH
 BktnktWfiOCJ4r+Z2Webq5U1jZCLZZ2o8EJwn/SQxXeOy43rbn6x7H46TbVkIM4Rp9JE
 JTxAwcZTS83eU7K6cohOVlU7NUmOtf+292V0FeJHqlOnSEE3cvwD2hnqs8R2XU5p3pv7
 WBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZmDm+wfXNRlCKKusawM8Hq7PWe2kcgml5UcY4PykNWg=;
 b=1rtfIc1ktU+b3IHQlDXW2MlDxiMAd2ITDptheCrdkYFm2QV/67cETcdgP5sLdwqfNZ
 yrTtCam7lLpfpDvR0T5EgxDvdPY2haVr96mQXz0jNs+SYbBf09GsDJl1afplFe1erj/F
 VLAJrzRbMt/x+ZsReEIdrRN3Zbehi2/QmwkBLYIfvF48dJPX3nayXNPUkPl7y21Ej3Jl
 b2mKnFT6yn64HMPaaVFF7DbmFzpg8l2CfJdLLoXy5jwBtW8/4QLupsaY4fsxNBGwn3mS
 fc68SwlbCZoAZCpKllOTg/Wz/r6+Jx8ht+oYqrMaf3Ge8EeTaJhJBtosynUXJijxLXSJ
 h37w==
X-Gm-Message-State: AOAM53008zlaFvGVJ4NQSOGqRJP1U6seyW0STg5rDT6M5RU+z668l5Wi
 3Kboh4cKUo3K2y2A4OqDJDk=
X-Google-Smtp-Source: ABdhPJz+jUZWzcO0HiCHp6gFy60yHZcCvSJ4tLvsO//CLtBeSI8e9IX70i14OzvpW+hHPDZTr+5+Tw==
X-Received: by 2002:a05:600c:4e0c:b0:39c:519f:9f35 with SMTP id
 b12-20020a05600c4e0c00b0039c519f9f35mr14860392wmq.153.1655131115997; 
 Mon, 13 Jun 2022 07:38:35 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c4fd300b0039c55bc2c97sm14833072wmq.16.2022.06.13.07.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 07:38:35 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Jun 2022 17:38:24 +0300
Message-Id: <20220613143826.1328830-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613143826.1328830-1-amir73il@gmail.com>
References: <20220613143826.1328830-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] syscalls/fanotify10: Watch directory that is not
 the mount path
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

Move the test file into a test directory, so we won't set a mark
on the mount path when watching the children of a directory.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify10.c     | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 067dd65ae..efef25135 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -74,16 +74,19 @@ static int filesystem_mark_unsupported;
 
 #define MOUNT_PATH "fs_mnt"
 #define MNT2_PATH "mntpoint"
+#define DIR_NAME "testdir"
 #define FILE_NAME "testfile"
 #define FILE2_NAME "testfile2"
 #define TEST_APP "fanotify_child"
 #define TEST_APP2 "fanotify_child2"
-#define FILE_PATH MOUNT_PATH"/"FILE_NAME
-#define FILE2_PATH MOUNT_PATH"/"FILE2_NAME
+#define DIR_PATH MOUNT_PATH"/"DIR_NAME
+#define FILE_PATH DIR_PATH"/"FILE_NAME
+#define FILE2_PATH DIR_PATH"/"FILE2_NAME
 #define FILE_EXEC_PATH MOUNT_PATH"/"TEST_APP
 #define FILE2_EXEC_PATH MOUNT_PATH"/"TEST_APP2
-#define FILE_MNT2 MNT2_PATH"/"FILE_NAME
-#define FILE2_MNT2 MNT2_PATH"/"FILE2_NAME
+#define DIR_MNT2 MNT2_PATH"/"DIR_NAME
+#define FILE_MNT2 DIR_MNT2"/"FILE_NAME
+#define FILE2_MNT2 DIR_MNT2"/"FILE2_NAME
 #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
 #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
 
@@ -239,50 +242,50 @@ static struct tcase {
 	},
 	{
 		"ignore events on children of directory created on a specific file",
-		MNT2_PATH, FANOTIFY_INODE,
-		FILE_PATH, FANOTIFY_INODE,
+		DIR_MNT2, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_INODE,
 		FAN_EVENT_ON_CHILD,
 		FILE_PATH, 0, FAN_OPEN
 	},
 	{
 		"ignore events on file created inside a parent watching children",
 		FILE_PATH, FANOTIFY_INODE,
-		MNT2_PATH, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_INODE,
 		FAN_EVENT_ON_CHILD,
 		FILE_PATH, 0, FAN_OPEN
 	},
 	{
 		"don't ignore events on file created inside a parent not watching children",
 		FILE_PATH, FANOTIFY_INODE,
-		MNT2_PATH, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_INODE,
 		0,
 		FILE_PATH, FAN_OPEN, FAN_OPEN
 	},
 	{
 		"ignore mount events created inside a parent watching children",
 		FILE_PATH, FANOTIFY_MOUNT,
-		MNT2_PATH, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_INODE,
 		FAN_EVENT_ON_CHILD,
 		FILE_PATH, 0, FAN_OPEN
 	},
 	{
 		"don't ignore mount events created inside a parent not watching children",
 		FILE_PATH, FANOTIFY_MOUNT,
-		MNT2_PATH, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_INODE,
 		0,
 		FILE_PATH, FAN_OPEN, FAN_OPEN
 	},
 	{
 		"ignore fs events created inside a parent watching children",
 		FILE_PATH, FANOTIFY_FILESYSTEM,
-		MNT2_PATH, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_INODE,
 		FAN_EVENT_ON_CHILD,
 		FILE_PATH, 0, FAN_OPEN
 	},
 	{
 		"don't ignore fs events created inside a parent not watching children",
 		FILE_PATH, FANOTIFY_FILESYSTEM,
-		MNT2_PATH, FANOTIFY_INODE,
+		DIR_PATH, FANOTIFY_INODE,
 		0,
 		FILE_PATH, FAN_OPEN, FAN_OPEN
 	},
@@ -525,6 +528,7 @@ static void setup(void)
 	SAFE_MOUNT(MOUNT_PATH, MNT2_PATH, "none", MS_BIND, NULL);
 	bind_mount_created = 1;
 
+	SAFE_MKDIR(DIR_PATH, 0755);
 	SAFE_FILE_PRINTF(FILE_PATH, "1");
 	SAFE_FILE_PRINTF(FILE2_PATH, "1");
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
