Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E587DCA0FFE
	for <ltp@archiver.kernel.org>; Sat,  2 Sep 2023 07:47:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1FA03CE011
	for <ltp@archiver.kernel.org>; Sat,  2 Sep 2023 09:47:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BFA63CBA12
 for <ltp@lists.linux.it>; Sat,  2 Sep 2023 09:47:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 266F42005F7
 for <ltp@lists.linux.it>; Sat,  2 Sep 2023 09:47:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E7871F74B;
 Sat,  2 Sep 2023 07:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1693640853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y58iM1koSnddINsybeRWRjek7M6T5OMkOyLYLa7OlRM=;
 b=gPZepxzCL/P/rh+hn39yvCienVDC3quz9BArVvEtKc21ueRgeh98ZvqIhCJ2vK9YKVO6ql
 XNgL9Cmjx1vIR9w/sAkBpANISVOO39BrgH67C1HJXZG+zNb1oCQT237771e3WXKYBrLwIb
 Z5o2fiVwF0hysyO6ntz2FEIIFDl4zK8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 155F913441;
 Sat,  2 Sep 2023 07:47:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IDFSMJPo8mRbdAAAMHmgww
 (envelope-from <wegao@suse.com>); Sat, 02 Sep 2023 07:47:31 +0000
To: ltp@lists.linux.it
Date: Sat,  2 Sep 2023 03:47:26 -0400
Message-Id: <20230902074726.9837-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230902055638.14256-1-wegao@suse.com>
References: <20230902055638.14256-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] clone302: Fix short size test
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
 include/lapi/sched.h                        | 4 ++++
 testcases/kernel/syscalls/clone3/clone302.c | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index ac766efc5..f1133ca12 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -46,6 +46,10 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
 }
 
 #ifndef HAVE_CLONE3
+
+#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
+#define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
+
 struct clone_args {
 	uint64_t __attribute__((aligned(8))) flags;
 	uint64_t __attribute__((aligned(8))) pidfd;
diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
index b1b4ccebb..02ccb3c29 100644
--- a/testcases/kernel/syscalls/clone3/clone302.c
+++ b/testcases/kernel/syscalls/clone3/clone302.c
@@ -34,7 +34,8 @@ static struct tcase {
 } tcases[] = {
 	{"invalid args", &invalid_args, sizeof(*valid_args), 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
 	{"zero size", &valid_args, 0, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
-	{"short size", &valid_args, sizeof(*valid_args) - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
+	{"short size", &valid_args, CLONE_ARGS_SIZE_VER0 - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
+	{"short size for clone_into_group flag", &valid_args, CLONE_ARGS_SIZE_VER2 - 1, CLONE_INTO_CGROUP, NULL, SIGCHLD, 0, 0, 0, EINVAL},
 	{"extra size", &valid_args, sizeof(*valid_args) + 1, 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
 	{"sighand-no-VM", &valid_args, sizeof(*valid_args), CLONE_SIGHAND, NULL, SIGCHLD, 0, 0, 0, EINVAL},
 	{"thread-no-sighand", &valid_args, sizeof(*valid_args), CLONE_THREAD, NULL, SIGCHLD, 0, 0, 0, EINVAL},
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
