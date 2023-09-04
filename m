Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6121C71153
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 08:52:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EE903CBF90
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 10:52:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 374413CB850
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 10:52:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 218CF600A43
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 10:52:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 891942185D;
 Mon,  4 Sep 2023 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1693817564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nj5bEyBvbGISYcH/lV/LDoFvO5tky0kiaNoQY/0qS9A=;
 b=ZXWpxJiak1F//3t1qOZM3Ku1Io51YDcGnVFQbAx+kQxB89+JzUXUzJlZQIER1jzFvMVRFV
 JA5mfgFploAKI5tLE+dSj0F7qTjH+ryxIxTfJ0+EfQB2O3wqvsmKD2vD/aYYiIO+RkB7TE
 M6Ec5mDvK6O8xtjgxpw6Z2zT7Wykh1c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD88A1358B;
 Mon,  4 Sep 2023 08:52:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id k12zJ9ua9WTtaQAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 04 Sep 2023 08:52:43 +0000
To: ltp@lists.linux.it
Date: Mon,  4 Sep 2023 04:52:39 -0400
Message-Id: <20230904085239.18462-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230902074726.9837-1-wegao@suse.com>
References: <20230902074726.9837-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] clone302: Fix short size test
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
 include/lapi/sched.h                        | 11 +++++++++++
 testcases/kernel/syscalls/clone3/clone302.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index ac766efc5..f42b8969f 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -60,6 +60,17 @@ struct clone_args {
 	uint64_t __attribute__((aligned(8))) cgroup;
 };
 
+struct clone_args_minimal {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+};
+
 static inline int clone3(struct clone_args *args, size_t size)
 {
 	return tst_syscall(__NR_clone3, args, size);
diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
index b1b4ccebb..bd1038319 100644
--- a/testcases/kernel/syscalls/clone3/clone302.c
+++ b/testcases/kernel/syscalls/clone3/clone302.c
@@ -34,7 +34,7 @@ static struct tcase {
 } tcases[] = {
 	{"invalid args", &invalid_args, sizeof(*valid_args), 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
 	{"zero size", &valid_args, 0, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
-	{"short size", &valid_args, sizeof(*valid_args) - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
+	{"short size", &valid_args, sizeof(struct clone_args_minimal) - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
 	{"extra size", &valid_args, sizeof(*valid_args) + 1, 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
 	{"sighand-no-VM", &valid_args, sizeof(*valid_args), CLONE_SIGHAND, NULL, SIGCHLD, 0, 0, 0, EINVAL},
 	{"thread-no-sighand", &valid_args, sizeof(*valid_args), CLONE_THREAD, NULL, SIGCHLD, 0, 0, 0, EINVAL},
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
