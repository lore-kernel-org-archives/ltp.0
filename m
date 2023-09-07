Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6B0EE14D4
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 10:02:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57AB13CE9AD
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 12:02:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A6F53C2A65
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 12:01:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E37F14088E0
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 12:01:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B42DF1F45F;
 Thu,  7 Sep 2023 10:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1694080914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=itCh+6aUSolSG2koDbszcrpr+hd8W7/FtvrDxhUWDSQ=;
 b=IT3ghdNL6Jx4hp0RztdKayuwCc0btes0kz7+gSM0U/OllevINaV2HNKzwAWL0MX7nBA1W0
 yTCUFDDBCHF0CRpuLpnNgqZamdKMvmSYuHJCwN2PA286jz1Z4a0cTaMOHSE85eij281C2M
 f615L8tMq+3a+eH2ILYwaDUeIZh/lP4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C6AD138F9;
 Thu,  7 Sep 2023 10:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Wo5WOZGf+WSgSwAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 07 Sep 2023 10:01:53 +0000
To: ltp@lists.linux.it
Date: Thu,  7 Sep 2023 06:01:49 -0400
Message-Id: <20230907100149.12090-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230905101444.3365-1-wegao@suse.com>
References: <20230905101444.3365-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] clone302: Fix short size test
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
 testcases/kernel/syscalls/clone3/clone302.c |  5 ++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index ac766efc5..26fdb628d 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -60,6 +60,17 @@ struct clone_args {
 	uint64_t __attribute__((aligned(8))) cgroup;
 };
 
+struct clone_args_minimal {
+	uint64_t __attribute__((aligned(8))) flags;
+	uint64_t __attribute__((aligned(8))) pidfd;
+	uint64_t __attribute__((aligned(8))) child_tid;
+	uint64_t __attribute__((aligned(8))) parent_tid;
+	uint64_t __attribute__((aligned(8))) exit_signal;
+	uint64_t __attribute__((aligned(8))) stack;
+	uint64_t __attribute__((aligned(8))) stack_size;
+	uint64_t __attribute__((aligned(8))) tls;
+};
+
 static inline int clone3(struct clone_args *args, size_t size)
 {
 	return tst_syscall(__NR_clone3, args, size);
diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
index b1b4ccebb..48b831554 100644
--- a/testcases/kernel/syscalls/clone3/clone302.c
+++ b/testcases/kernel/syscalls/clone3/clone302.c
@@ -12,6 +12,7 @@
 #define _GNU_SOURCE
 
 #include <stdlib.h>
+#include <assert.h>
 
 #include "tst_test.h"
 #include "lapi/sched.h"
@@ -34,7 +35,7 @@ static struct tcase {
 } tcases[] = {
 	{"invalid args", &invalid_args, sizeof(*valid_args), 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
 	{"zero size", &valid_args, 0, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
-	{"short size", &valid_args, sizeof(*valid_args) - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
+	{"short size", &valid_args, sizeof(struct clone_args_minimal) - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
 	{"extra size", &valid_args, sizeof(*valid_args) + 1, 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
 	{"sighand-no-VM", &valid_args, sizeof(*valid_args), CLONE_SIGHAND, NULL, SIGCHLD, 0, 0, 0, EINVAL},
 	{"thread-no-sighand", &valid_args, sizeof(*valid_args), CLONE_THREAD, NULL, SIGCHLD, 0, 0, 0, EINVAL},
@@ -59,6 +60,8 @@ static void setup(void)
 {
 	clone3_supported_by_kernel();
 
+	TST_EXP_EQ_SZ(sizeof(struct clone_args_minimal), 64);
+
 	void *p = tst_get_bad_addr(NULL);
 
 	invalid_args = p;
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
