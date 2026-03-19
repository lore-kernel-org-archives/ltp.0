Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8403F109190F
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773946526; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=eSaE4zXm3hon/mjiDDu04xcHAgA71pwwIdtczoqkpnw=;
 b=hmYE/8PxEVwZPxzI4lXcqrP2jKnloBpM5LpyqE0FbTJW6faKDp4L/ZDGqlwB3Azd3F8Ah
 0Wo9+X8PnrXmFWdDw17RRAcUnvPbIEcXvaWS4OhNKoeSaTfEWep/s1QUt/qzgMuDGDmWScW
 aEO30VfNU203P6PSWSSWflc3sQeks9A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB0C03E30C1
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 19:55:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D17FA3E1CEA
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 19:55:02 +0100 (CET)
Received: from mail-dy1-x134a.google.com (mail-dy1-x134a.google.com
 [IPv6:2607:f8b0:4864:20::134a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DF2601401248
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 19:55:01 +0100 (CET)
Received: by mail-dy1-x134a.google.com with SMTP id
 5a478bee46e88-2c0f6593ef5so914231eec.1
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773946500; x=1774551300; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jz1+l9mLRvsD7OBkFrY1MChudUEOXqgJw4FMrCn2AIE=;
 b=pVWviM3NwefyZvoCZe3w/UDFJXgPIHI4aP7kMNU0GuZVkUwmDziBMG6O7E2jWsqS/y
 9VkYXh6GIc72Ch2mk0n5PsbkTSgOfd7p7gVebcJt3DrUobzktkFA/4BL5Pt/wvsH3oBx
 wpiW6AEIOhyUN1fHrqlffdYMc0bZ2txtMy8WBVPeX96/JiVKqqdcE0rvwjDZwZK+zaIp
 tQSvvq9yS9jUR6tZHPVtwfA4pxdes2/WnsFRFEbWPg/vXcZEiU8AnzmqUE5rDvJbziF1
 6vQCEKVBTIgCAiZAhIviSBClkqbY78cO9Far0CDxShvzM9fMkUOUuqpPAavHZhkhHKhb
 UHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773946500; x=1774551300;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jz1+l9mLRvsD7OBkFrY1MChudUEOXqgJw4FMrCn2AIE=;
 b=fwMy4/COyeKt3dTpgkRhfcTwD9dXWSQnQabQ/a6dnnH04RdR4D19Jg9mu67MSEoL2b
 AmzEi1+F6nUjhcL/W/+ojsC2lDnU7QEGLpZ2JDPnvakXTmHNTCrVpR/fx2kCfGqGjl96
 eJExl4b9nn1RSSQvdxBLuoDNxO2ammv0sbzf+TjD9kungMChZGuIkJPdacweqwDaUv2h
 OlpkH9xMdI3Eo+dvW9lkRl8+O+rwxgImKkZbdMD6EkKOcdQXn9cM9aPmWKgi+kDJT46g
 WdEKT3qDtZFKdEV7GaScfFZYLyuXexdEhHZhA/hXmUe0iYETmtCEsJaW6EpqbTuFyCJq
 9GdA==
X-Gm-Message-State: AOJu0Yzd5TcmYUTVlGryNxyRwQUNWdfEEgudD5aDd4fzRvDzbHpCPeJv
 rQF4UL8u/6x0bhy6Ka+Epl5jKIX+5/BbfGdLqvd1Rl5mH2nC6fMrY40lrT285wPkndIMFljZpCA
 0e3h4jqXSgXM0QhUnm+tYcNWdr6CDYS13mci+P/2CT9rXJs4OEKIrvLUfZOPjysTLtpZhj8hFYE
 w+2ps15y1Uk0XL5nLQZqt5GEMihk11WaPJ8zE9GWf6UeyEFTjlU1DkXN8RmA==
X-Received: from dycmq9.prod.google.com ([2002:a05:7301:789:b0:2c0:be02:79e8])
 (user=chriswailes job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:ed06:b0:2c0:dae2:9c5f with SMTP id
 5a478bee46e88-2c109563c3fmr246844eec.2.1773946499319; 
 Thu, 19 Mar 2026 11:54:59 -0700 (PDT)
Date: Thu, 19 Mar 2026 11:54:55 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319185455.3683566-1-chriswailes@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Update clone3 wrapper signature
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
From: Chris Wailes via ltp <ltp@lists.linux.it>
Reply-To: Chris Wailes <chriswailes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This CL adds the `ltp_clone3_raw` wrapper for direct testing of the
syscall, conditionally defines `clone_args_minimal`, and adds a
`ltp_clone3` wrapper for libc implementations that provide `clone3`.
---
 include/lapi/sched.h                        | 27 +++++++++++++++------
 testcases/kernel/syscalls/clone3/clone301.c |  2 +-
 testcases/kernel/syscalls/clone3/clone302.c |  2 +-
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 36f1ecad9..fc367f772 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -49,8 +49,7 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
 # define SCHED_ATTR_SIZE_VER0 48	/* sizeof first published struct */
 #endif
 
-#ifndef HAVE_CLONE3
-struct clone_args {
+struct clone_args_minimal {
 	uint64_t __attribute__((aligned(8))) flags;
 	uint64_t __attribute__((aligned(8))) pidfd;
 	uint64_t __attribute__((aligned(8))) child_tid;
@@ -59,12 +58,10 @@ struct clone_args {
 	uint64_t __attribute__((aligned(8))) stack;
 	uint64_t __attribute__((aligned(8))) stack_size;
 	uint64_t __attribute__((aligned(8))) tls;
-	uint64_t __attribute__((aligned(8))) set_tid;
-	uint64_t __attribute__((aligned(8))) set_tid_size;
-	uint64_t __attribute__((aligned(8))) cgroup;
 };
 
-struct clone_args_minimal {
+#ifndef HAVE_CLONE_ARGS
+struct clone_args {
 	uint64_t __attribute__((aligned(8))) flags;
 	uint64_t __attribute__((aligned(8))) pidfd;
 	uint64_t __attribute__((aligned(8))) child_tid;
@@ -73,12 +70,28 @@ struct clone_args_minimal {
 	uint64_t __attribute__((aligned(8))) stack;
 	uint64_t __attribute__((aligned(8))) stack_size;
 	uint64_t __attribute__((aligned(8))) tls;
+	uint64_t __attribute__((aligned(8))) set_tid;
+	uint64_t __attribute__((aligned(8))) set_tid_size;
+	uint64_t __attribute__((aligned(8))) cgroup;
 };
+#endif
 
-static inline int clone3(struct clone_args *args, size_t size)
+static inline int ltp_clone3_raw(struct clone_args *args, size_t size)
 {
 	return tst_syscall(__NR_clone3, args, size);
 }
+
+#ifdef HAVE_CLONE3_WRAPPER
+static inline int ltp_clone3(struct clone_args *cl_args, size_t size,
+               int (*fn)(void *), void *arg) {
+	return clone3(cl_args, size, fn, arg);
+}
+#else
+static inline int ltp_clone3(struct clone_args *cl_args, size_t size,
+                             int (*fn)(void *), void *arg)
+{
+	return -1;
+}
 #endif
 
 static inline void clone3_supported_by_kernel(void)
diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel/syscalls/clone3/clone301.c
index deed30b9f..58fc1702e 100644
--- a/testcases/kernel/syscalls/clone3/clone301.c
+++ b/testcases/kernel/syscalls/clone3/clone301.c
@@ -123,7 +123,7 @@ static void run(unsigned int n)
 	parent_received_signal = 0;
 	SAFE_SIGACTION(tc->exit_signal, &psig_action, NULL);
 
-	TEST(pid = clone3(args, sizeof(*args)));
+	TEST(pid = ltp_clone3_raw(args, sizeof(*args)));
 	if (pid < 0) {
 		tst_res(TFAIL | TTERRNO, "clone3() failed (%d)", n);
 		return;
diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
index 9e98f1954..883112183 100644
--- a/testcases/kernel/syscalls/clone3/clone302.c
+++ b/testcases/kernel/syscalls/clone3/clone302.c
@@ -83,7 +83,7 @@ static void run(unsigned int n)
 		args->tls = tc->tls;
 	}
 
-	TEST(clone3(args, tc->size));
+	TEST(ltp_clone3_raw(args, tc->size));
 
 	if (!TST_RET)
 		exit(EXIT_SUCCESS);
-- 
2.53.0.959.g497ff81fa9-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
