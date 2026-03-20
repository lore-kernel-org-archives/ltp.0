Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E7A1099B34
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774031982; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=plV74FY70zuXOcsWhC6dIbAuWRQ+jNFi3yxff4GE5oY=;
 b=CJf03Dd6RNsaw/A7LiPM9PXguKqVY5APHZ4bNZEn7Y5SViGHBCn4uqKjpPlvobVw6yAx3
 dcbeGE5ceO6umh3e3IvgyTb757+GUD4wDS7QMqscJfrHoF6wjfVtBzi+BYgTcVVr3/n1ojC
 WkSL960qxZpz9m0LNCDTUV28YjiL6gg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 564C93E5F41
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 19:39:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CBF83CD411
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 19:39:19 +0100 (CET)
Received: from mail-dy1-x1349.google.com (mail-dy1-x1349.google.com
 [IPv6:2607:f8b0:4864:20::1349])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 07168100046D
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 19:39:18 +0100 (CET)
Received: by mail-dy1-x1349.google.com with SMTP id
 5a478bee46e88-2c0f6593ef5so808589eec.1
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 11:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774031957; x=1774636757; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=I1hxX1hM2tBKeDYEXGYTMrCWGz0Q6qLKRS8vaBrx2LU=;
 b=VAhx/Me8iA/00JMg9E1RiwdS7m5btsHTaHj9hlNYo5syaPJOl16tig1lfcUfQ5FhPC
 sOJ8Fov+C3bczTKCB2JT940+uQMJBS802XPFxWzvL3Fl0nP9OfP6r0EYts+A5DlvrE4H
 zqPLHBgMpaP2axeQPWtkxWT5joSc0RLNbvhmfJ+wPvrczb/DZEjyc/S64yNp8Axr3GFA
 7zfr9/HQeJASYj46EI1pd3rUPPQzXTNh31ZTme+zLaYJFWRlJym1FCIUb11HBaqNjrni
 AnTpRW+9PpanVIZNMJZiMuUld5jaMTRtCNpyiG66w1OtFWQoWSbq6Rtr7j+lXEgnOnZd
 jb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774031957; x=1774636757;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I1hxX1hM2tBKeDYEXGYTMrCWGz0Q6qLKRS8vaBrx2LU=;
 b=T/3Z/hsnMhnpwXmJjsu0pMK9Mkss/Udwr/uNcg5XBngKCMyn29Sx5FyUQWzCFRpsHk
 DKJtBDe4jZWJM1kMriJL5RZ1vUhOGMBwONeceDPjbSXoDSww3f7D0i+4wLj+rvjqS3dF
 fqhlpBibfRuxNVGRoTXoEjRG0m+iMFt4/QIVZEuCyo8ZyqIRKDaz6ceXCcYkgEkuE2Yp
 NAMzlF6iht8TB8I9WueEx+SmRt7/xT11KYMOvPz2HP6+dJe+jK5mdvuugV7C1XXWnuTL
 CSLGHvjRJNvhMDZ5E+w4k2J+TaAXo8IM8/hRGnnMk1yfhTO/et2JDTI69gYb19oIWyLj
 ACxg==
X-Gm-Message-State: AOJu0YxaLK1MTmgqsy6fzEMVouF1UPLnmik1ZOX27E5iwUKuQxw6j6yW
 NR2xtfauV12dsiF2scIksnwOCfZgB1eAGY1kiEvhtbirht94YnljhTSkm1CA9VD4sKQzksPbOBc
 DaO4ConsFYHmRalvGH+75AllJ0hBMM6xCqYzJVoypbEtp4nRS0wHZxbZOvaKjwYAXNVuQxJTeBk
 DVgdSVtCFvSQZUFO9Pd3Mzqf090OoirOHCkMtIDoAcO5VryFLgLYk985Yv0A==
X-Received: from dltt4.prod.google.com ([2002:a05:701a:c964:b0:12a:7a40:ea24])
 (user=chriswailes job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:b97:b0:128:d5f1:d595 with SMTP id
 a92af1059eb24-12a7268c096mr1685630c88.10.1774031956880; 
 Fri, 20 Mar 2026 11:39:16 -0700 (PDT)
Date: Fri, 20 Mar 2026 11:39:07 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320183907.117127-1-chriswailes@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Update clone3 wrapper signature
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
syscall and adds a `ltp_clone3` wrapper for libc implementations that
provide `clone3`.

Signed-off-by: Chris Wailes <chriswailes@google.com>
---

Notes:
    V2: Added HAVE_STRUCT_CLONE_ARGS and updated clone304.c

 configure.ac                                |  1 +
 include/lapi/sched.h                        | 27 +++++++++++++++------
 testcases/kernel/syscalls/clone3/clone301.c |  2 +-
 testcases/kernel/syscalls/clone3/clone302.c |  2 +-
 testcases/kernel/syscalls/clone3/clone304.c |  2 +-
 5 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/configure.ac b/configure.ac
index 043640240..d753df6f2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -189,6 +189,7 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
+AC_CHECK_TYPES([struct clone_args],,,[#include <sched.h>])
 AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
 		struct fanotify_event_info_header, struct fanotify_event_info_pidfd,
 		struct fanotify_event_info_range],,,[#include <sys/fanotify.h>])
diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 36f1ecad9..05b322c1c 100644
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
+#ifndef HAVE_STRUCT_CLONE_ARGS
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
+#ifdef HAVE_CLONE3
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
index 902e89091..668c1a225 100644
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
diff --git a/testcases/kernel/syscalls/clone3/clone304.c b/testcases/kernel/syscalls/clone3/clone304.c
index f0ef7d7e8..b91a081e5 100644
--- a/testcases/kernel/syscalls/clone3/clone304.c
+++ b/testcases/kernel/syscalls/clone3/clone304.c
@@ -58,7 +58,7 @@ static void run(unsigned int n)
 		args.set_tid_size = 1;
 	}
 
-	TST_EXP_FAIL(clone3(&args, sizeof(args)), EPERM,
+	TST_EXP_FAIL(ltp_clone3_raw(&args, sizeof(args)), EPERM,
 			"clone3(%s) set_tid_size=%ld",
 			tc->sflags, args.set_tid_size);
 }
-- 
2.53.0.959.g497ff81fa9-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
