Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53661C64EC7
	for <ltp@archiver.kernel.org>; Sun, 26 Feb 2023 00:36:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE8EC3CBB12
	for <ltp@archiver.kernel.org>; Sun, 26 Feb 2023 01:36:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1831F3CB919
 for <ltp@lists.linux.it>; Sun, 26 Feb 2023 01:36:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CE2EC600645
 for <ltp@lists.linux.it>; Sun, 26 Feb 2023 01:36:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF62D336A8;
 Sun, 26 Feb 2023 00:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677371767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bM3R6LBoozp/qV5QavMFXhsKYAconLYz4xTTa1Vzfds=;
 b=OZx+hFHDlcXOaIeRdHhym0YvmAwG96XZtpCDzM7OEMMNz62o5D1bgnyuLYSXz+MntTUDj1
 SjfMkygc/5PpoOBquSlTu+ErtLHFQB9FPZvBOEKxF7zm9tP2rngrFqJUWQ4P8q80VVEhyL
 z/4UpsbvWj8jkkxt9o9M/Q5qfQsrR3c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38D0F139B5;
 Sun, 26 Feb 2023 00:36:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WWN6BHep+mNESwAAMHmgww
 (envelope-from <wegao@suse.com>); Sun, 26 Feb 2023 00:36:07 +0000
To: ltp@lists.linux.it
Date: Sat, 25 Feb 2023 19:35:26 -0500
Message-Id: <20230226003526.8733-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] clone3: Add clone3's clone_args cgroup
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
 include/lapi/sched.h | 3 +++
 include/tst_clone.h  | 1 +
 lib/tst_clone.c      | 1 +
 3 files changed, 5 insertions(+)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 1065665d1..3ad16d136 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -54,6 +54,9 @@ struct clone_args {
 	uint64_t __attribute__((aligned(8))) stack;
 	uint64_t __attribute__((aligned(8))) stack_size;
 	uint64_t __attribute__((aligned(8))) tls;
+	uint64_t __attribute__((aligned(8))) set_tid;
+	uint64_t __attribute__((aligned(8))) set_tid_size;
+	uint64_t __attribute__((aligned(8))) cgroup;
 };
 
 static inline int clone3(struct clone_args *args, size_t size)
diff --git a/include/tst_clone.h b/include/tst_clone.h
index 9ffdc68d1..7b278dfa7 100644
--- a/include/tst_clone.h
+++ b/include/tst_clone.h
@@ -11,6 +11,7 @@
 struct tst_clone_args {
 	uint64_t flags;
 	uint64_t exit_signal;
+	uint64_t cgroup;
 };
 
 /* clone3 with fallbacks to clone when possible. Be aware that it
diff --git a/lib/tst_clone.c b/lib/tst_clone.c
index ecc84408c..2aa00beb1 100644
--- a/lib/tst_clone.c
+++ b/lib/tst_clone.c
@@ -15,6 +15,7 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
 	struct clone_args args = {
 		.flags = tst_args->flags,
 		.exit_signal = tst_args->exit_signal,
+		.cgroup = tst_args->cgroup,
 	};
 	int flags;
 	pid_t pid = -1;
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
