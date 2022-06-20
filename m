Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9928AC43334
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 13:28:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09A703C926F
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 15:28:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5C363C93AF
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 15:27:47 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2DE671400188
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 15:27:47 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id m1so6930393wrb.2
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rDaZNAqyjcycuwbwOMXHoa4OSlTBOGaRzBULsoapsK0=;
 b=OIuUGxHY4j8ExMnkXguBnMGnMc3bRNJVTTHxihLZ1U/KShF3TLAmmb3jM9Dusl86e5
 M0pQ6+Sm6rXfNfkc01PmkXtfKVF2mlIhACtJEUs3eGotDNWinABIycJ/VN1XUhxlzLBv
 2iI3zU19ZOkBQjCM1WwL/GRIHoDh1sW+gBcCQlscjDHRU2tWV8Xj1QE7bo3Pj7HIxUxQ
 a5Exxve6dtGAS+uG/BntfN1xdGJtrSHf+urX6A0dsU1ny4VTB58RyzQ41oADa2pHtaeI
 qszKjKYaw7804pldPtKC8PNhwGAVyIx/pEvgHc+m5IRjs5ubcCczhCoVJUgbLPaDEBai
 AsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rDaZNAqyjcycuwbwOMXHoa4OSlTBOGaRzBULsoapsK0=;
 b=sHObRwCSKPZirVJcsfyAUosuOuv6aePHhuScutGayLCgrUFKsqR2TT9BU0vLYOWElI
 qNRvzJV+ph2NGJTCQjA+CWzoOpRHIT987MXPyuJl8AMI4Nz0PVcRuZhvupMHZ3iVxekl
 BcHFG8yAsGUSYVSuqfsjrkBk2H0eHyAtyO1W3SNBCh68sjPllk2iO4EnCpsCmJonUM3Y
 obRk7rE81I4VLb69v56xcHDeTy+A7/8lxSTjcVUp6lsD9UZaLDrkv7H10l/a9V/sn4/P
 1GDuZQ3P410+Iw3hDYhpTumvoZciYG/kgr7qHTK+l76JfSeslvOOMIDyQMH99p9KXtqB
 i9kA==
X-Gm-Message-State: AJIora9OXeOJMvnL5HjH21ao7Pj5hAiWxYjckJ7Izg04P9Ba20QtAIjq
 puTxwLISq6SSectwmnwKQTQ=
X-Google-Smtp-Source: AGRyM1vL40kAaIfIeAiDIZM1xjoIsC5NkogoXUZQM8hN/L3IQaZxzbxBEDC/iQJEYoG27xhedQoBRA==
X-Received: by 2002:a05:6000:186e:b0:218:5f5d:9c55 with SMTP id
 d14-20020a056000186e00b002185f5d9c55mr21879774wri.128.1655731666694; 
 Mon, 20 Jun 2022 06:27:46 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a5d4f85000000b0021b862ad439sm9086556wru.9.2022.06.20.06.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 06:27:46 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jun 2022 16:27:36 +0300
Message-Id: <20220620132737.2015073-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620132737.2015073-1-amir73il@gmail.com>
References: <20220620132737.2015073-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] syscalls/fanotify09: Tidy up the test to make it
 more readable
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

Document and tidy up the code dealing with mask flags FAN_ONDIR
and FAN_EVENT_ONCHILD.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify09.c     | 44 ++++++++++++-------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index a8d56c10b..070ad9933 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -12,21 +12,21 @@
  */
 
 /*
- * This is a regression test for commit 54a307ba8d3c:
+ * This is a regression test for commit:
  *
- *      fanotify: fix logic of events on child
+ *      54a307ba8d3c fanotify: fix logic of events on child
  *
- * Test case #1 is a regression test for commit b469e7e47c8a:
+ * Test case #1 is a regression test for commit:
  *
- *      fanotify: fix handling of events on child sub-directory
+ *      b469e7e47c8a fanotify: fix handling of events on child sub-directory
  *
- * Test case #2 is a regression test for commit 55bf882c7f13:
+ * Test case #2 is a regression test for commit:
  *
- *      fanotify: fix merging marks masks with FAN_ONDIR
+ *      55bf882c7f13 fanotify: fix merging marks masks with FAN_ONDIR
  *
- * Test case #5 is a regression test for commit 7372e79c9eb9:
+ * Test case #5 is a regression test for commit:
  *
- *      fanotify: fix logic of reporting name info with watched parent
+ *      7372e79c9eb9 fanotify: fix logic of reporting name info with watched parent
  */
 
 #define _GNU_SOURCE
@@ -131,13 +131,26 @@ static struct tcase {
 static void create_fanotify_groups(struct tcase *tc)
 {
 	struct fanotify_mark_type *mark = &tc->mark;
-	unsigned int i, onchild, report_name, ondir = tc->ondir;
+	int i;
 
 	for (i = 0; i < NUM_GROUPS; i++) {
 		/*
-		 * The first group may request events with filename info.
+		 * The first group may request events with filename info and
+		 * events on subdirs and always request events on children.
 		 */
-		report_name = (i == 0) ? tc->report_name : 0;
+		unsigned int report_name = tc->report_name;
+		unsigned int mask_flags = tc->ondir | FAN_EVENT_ON_CHILD;
+		unsigned int parent_mask;
+
+		/*
+		 * The non-first groups do not request events on children and
+		 * subdirs.
+		 */
+		if (i > 0) {
+			report_name = 0;
+			mask_flags = 0;
+		}
+
 		fd_notify[i] = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | report_name |
 						  FAN_NONBLOCK, O_RDONLY);
 
@@ -145,21 +158,20 @@ static void create_fanotify_groups(struct tcase *tc)
 		 * Add subdir or mount mark for each group with CLOSE event,
 		 * but only the first group requests events on dir.
 		 */
-		onchild = (i == 0) ? FAN_EVENT_ON_CHILD | ondir : 0;
 		SAFE_FANOTIFY_MARK(fd_notify[i],
 				    FAN_MARK_ADD | mark->flag,
-				    FAN_CLOSE_NOWRITE | onchild,
+				    FAN_CLOSE_NOWRITE | mask_flags,
 				    AT_FDCWD, tc->close_nowrite);
 
 		/*
 		 * Add inode mark on parent for each group with MODIFY event,
 		 * but only the first group requests events on child.
 		 * The one mark with FAN_EVENT_ON_CHILD is needed for
-		 * setting the DCACHE_FSNOTIFY_PARENT_WATCHED dentry
-		 * flag.
+		 * setting the DCACHE_FSNOTIFY_PARENT_WATCHED dentry flag.
 		 */
+		parent_mask = FAN_MODIFY | tc->ondir | mask_flags;
 		SAFE_FANOTIFY_MARK(fd_notify[i], FAN_MARK_ADD,
-				    FAN_MODIFY | ondir | onchild,
+				    parent_mask,
 				    AT_FDCWD, ".");
 	}
 }
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
