Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E522F606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=ahRE8g5X;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fvYkn0a2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793345941; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lMuH6bvG71M5aVnnHNmrB8VsBKWLVNhQ/w7I1BAbfRk=;
 b=ahRE8g5XRp2yXxZ201qyNuNJXwlok2H9a862EX4bYYHRzj4INLWmrUoEeLRiTuW//VkZ6
 KbSB8BLIi3CdHdKO6dGXZS9pSwX7LQETDI1EhgQJNzLSK3Ee4t08Dumo77KednWkXdnKQ5u
 X4srbmBCE00k7lVY85MFZNkyLlhPtzA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C9D83E1E9D
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 08:39:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 951733CFD25
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 08:38:41 +0100 (CET)
Received: from mail-pg1-x546.google.com (mail-pg1-x546.google.com
 [IPv6:2607:f8b0:4864:20::546])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EED9F10001B9
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 08:38:40 +0100 (CET)
Received: by mail-pg1-x546.google.com with SMTP id
 41be03b00d2f7-cd60a365440so328871a12.2
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793345919; x=1793950719; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ugpd/g9IH48yUU9UMi4kdyjfL6jV36cn0lAeYoRR9gs=;
 b=fvYkn0a2pF0Zhzql238+N1Q14p67dh44xe6bj8J6PL1F6O+zMQoRSXRWyv7qpxBmwf
 wwcDtlteyFIUanF7u0S8F/sXNsPsSdccCTndCStqM3YM3GF+hmrvDbEU8uQOc8V8HQXW
 gy+kyIJJikoyVulee4uUEKtzceC21Wj6GAdcGubnCaL+wF4tUrVKPTfZhH7svEcIYtCX
 an/gKEiB+sdfPpoSiN3kn/vSAh8LQ/hyo9tt/8VO1XlMnTKJYWc0LGQJVjSKez9zXIFb
 0Ex6oRcPVxdTMN3uIV8+Hu/EdoBIifnbQA9wPjwst6TRRCdGJD5df/e2nXylCYyjBhOP
 uZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793345919; x=1793950719;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ugpd/g9IH48yUU9UMi4kdyjfL6jV36cn0lAeYoRR9gs=;
 b=c/tjq/Tb4rGUKSedPC697uz59roOYqN3UNjCfg0zaGgtjbewuhxhtb5OS+N/icaqzp
 ypNPR3nNFsQt1OapZiECWJnTH8Xnvo1TVIt9tLKzcVv2T9edG5ytBFdf85WtCUlME7jO
 FaotWGdqGSs/tNeLwlyCasY1Pn2Kc1c1HICJ3hTb8fVhuIBT/MVspVnRZAbRI/75kS0K
 Ah0ZBaPa/iUZGAM84xe6e5wqmaxsKe1ew/QLRgS6ocO8JJT2iki4eOAn8IiBU7mYtYzY
 YgVolk57dIfgVZsiwGzM51XA/pCIVv7jJ2+fbEpZe+6Ivj45Y19nT8fuEPzY5wJA2cuu
 lueQ==
X-Gm-Message-State: AFq9FYI9zFfVnXglJpBlX3s6Zl9sEkRer4N6QY0dxc247U+RpjGcglB/
 xDSWliGAH4yyf1G2m5rwWbDx8a2lXQcqob1dL1oZT58SJCLNGvjMJbcdO8Xny112SDLZpUwIDk5
 PyyJWpdLjBVrqB4x2GDFtIu26oFqjQVTOphDKz26em0Oi37ZeAnl+ovajTyUY+vQIUqJxGkM1YL
 il+pg5va4emRfqZbNKJb9CW4KimQ==
X-Received: from pfkm12.prod.google.com ([2002:a05:6a00:80c:b0:8a0:5d5d:e180])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7346:b0:3de:4a1c:a95
 with SMTP id adf61e73a8af0-3e929050ccamr1407477637.91.1793345918926; Fri, 30
 Oct 2026 00:38:38 -0700 (PDT)
Date: Fri, 30 Oct 2026 07:38:37 +0000
In-Reply-To: <20261004015344.2862110-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261004015344.2862110-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030073837.658209-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] epoll_pwait04: Use raw syscalls to avoid SIGSEGV
 on 32-bit Bionic
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

epoll_pwait04 passes an unmapped address from tst_get_bad_addr() as the
sigmask argument to verify that the kernel returns EFAULT. However,
do_epoll_pwait() invokes the libc epoll_pwait() and epoll_pwait2()
wrappers when available.

On 32-bit Android Bionic, sizeof(sigset_t) is 4 bytes whereas the
kernel expects an 8-byte (_NSIG / 8) signal set. The 32-bit Bionic
wrappers therefore dereference the sigmask pointer in userspace to
zero-extend it into a sigset64_t on the stack before issuing the
syscall. Passing an unmapped bad_addr thus causes a SIGSEGV in
userspace before reaching the kernel. As passing an invalid pointer
to a libc function is undefined behavior anyway, the EFAULT check
should call the syscalls directly.

Expose sys_epoll_pwait() and sys_epoll_pwait2() in lapi/epoll.h and add
do_sys_epoll_pwait() in epoll_pwait_var.h so epoll_pwait04 invokes the
raw syscalls directly. do_epoll_pwait() is made static inline to avoid
a -Wunused-function warning now that epoll_pwait04 no longer uses it.

Fixes: 9d083e3a286b ("epoll_pwait: Add invalid sigmask test for epoll_pwait04")
Signed-off-by: Wake Liu <wakel@google.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- Add braces around the multi-line if statement in sys_epoll_pwait2()
  (Andrea).
- Add Reviewed-by tags from Petr and Andrea.

v1: https://lore.kernel.org/ltp/20261004015344.2862110-1-wakel@google.com/

 include/lapi/epoll.h                          | 38 ++++++++++++++-----
 .../syscalls/epoll_pwait/epoll_pwait04.c      |  6 ++-
 .../syscalls/epoll_pwait/epoll_pwait_var.h    | 30 +++++++++++----
 3 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/include/lapi/epoll.h b/include/lapi/epoll.h
index 15a954175..547395d41 100644
--- a/include/lapi/epoll.h
+++ b/include/lapi/epoll.h
@@ -24,13 +24,24 @@ static inline void epoll_pwait_supported(void)
 	tst_syscall(__NR_epoll_pwait);
 }
 
+/*
+ * Note: The kernel expects an _NSIG / 8 bytes signal set, which may be larger
+ * than sizeof(sigset_t) on some 32-bit libcs (e.g. 4 bytes on 32-bit Bionic).
+ */
+static inline int sys_epoll_pwait(int epfd, struct epoll_event *events,
+				  int maxevents, int timeout,
+				  const sigset_t *sigmask)
+{
+	return tst_syscall(__NR_epoll_pwait, epfd, events, maxevents,
+			   timeout, sigmask, _NSIG / 8);
+}
+
 #ifndef HAVE_EPOLL_PWAIT
 static inline int epoll_pwait(int epfd, struct epoll_event *events,
 			      int maxevents, int timeout,
 			      const sigset_t *sigmask)
 {
-	return tst_syscall(__NR_epoll_pwait, epfd, events, maxevents,
-			   timeout, sigmask, _NSIG / 8);
+	return sys_epoll_pwait(epfd, events, maxevents, timeout, sigmask);
 }
 #endif
 
@@ -40,16 +51,17 @@ static inline void epoll_pwait2_supported(void)
 	tst_syscall(__NR_epoll_pwait2);
 }
 
-#ifndef HAVE_EPOLL_PWAIT2
-static inline int epoll_pwait2(int epfd, struct epoll_event *events,
-			       int maxevents, const struct timespec *timeout,
-			       const sigset_t *sigmask)
+static inline int sys_epoll_pwait2(int epfd, struct epoll_event *events,
+				   int maxevents,
+				   const struct timespec *timeout,
+				   const sigset_t *sigmask)
 {
-	if (timeout == NULL)
+	struct __kernel_timespec ts;
+
+	if (!timeout) {
 		return tst_syscall(__NR_epoll_pwait2, epfd, events, maxevents,
 				   NULL, sigmask, _NSIG / 8);
-
-	struct __kernel_timespec ts;
+	}
 
 	ts.tv_sec = timeout->tv_sec;
 	ts.tv_nsec = timeout->tv_nsec;
@@ -57,6 +69,14 @@ static inline int epoll_pwait2(int epfd, struct epoll_event *events,
 	return tst_syscall(__NR_epoll_pwait2, epfd, events, maxevents,
 			   &ts, sigmask, _NSIG / 8);
 }
+
+#ifndef HAVE_EPOLL_PWAIT2
+static inline int epoll_pwait2(int epfd, struct epoll_event *events,
+			       int maxevents, const struct timespec *timeout,
+			       const sigset_t *sigmask)
+{
+	return sys_epoll_pwait2(epfd, events, maxevents, timeout, sigmask);
+}
 #endif
 
 #endif /* LAPI_EPOLL_H__ */
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
index b399225b9..4b77c3bd0 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
@@ -20,7 +20,11 @@ static void *bad_addr;
 
 static void run(void)
 {
-	TST_EXP_FAIL(do_epoll_pwait(efd, &e, 1, NULL, bad_addr),
+	/*
+	 * Use raw syscalls, libc wrappers may dereference sigmask in
+	 * userspace (e.g. 32-bit Bionic) and crash with SIGSEGV.
+	 */
+	TST_EXP_FAIL(do_sys_epoll_pwait(efd, &e, 1, NULL, bad_addr),
 		     EFAULT, "with an invalid sigmask pointer");
 }
 
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
index e215a6540..07d2ac8ca 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
@@ -13,21 +13,35 @@
 #define MSEC_PER_SEC (1000L)
 #define NSEC_PER_MSEC (1000000L)
 
-static int do_epoll_pwait(int epfd, struct epoll_event *events, int
-	maxevents, struct timespec *timeout, const sigset_t *sigmask)
+static inline int epoll_timeout_ms(const struct timespec *timeout)
+{
+	if (!timeout)
+		return -1;
+
+	return timeout->tv_sec * MSEC_PER_SEC +
+		(timeout->tv_nsec + NSEC_PER_MSEC - 1) / NSEC_PER_MSEC;
+}
+
+static inline int do_epoll_pwait(int epfd, struct epoll_event *events,
+	int maxevents, struct timespec *timeout, const sigset_t *sigmask)
 {
 	if (tst_variant == 1)
 		return epoll_pwait2(epfd, events, maxevents, timeout, sigmask);
 
-	int timeout_ms = -1;
+	return epoll_pwait(epfd, events, maxevents, epoll_timeout_ms(timeout),
+			   sigmask);
+}
 
-	if (timeout) {
-		timeout_ms = timeout->tv_sec * MSEC_PER_SEC;
-		timeout_ms += (timeout->tv_nsec + NSEC_PER_MSEC - 1) /
-			NSEC_PER_MSEC;
+static inline int do_sys_epoll_pwait(int epfd, struct epoll_event *events,
+	int maxevents, struct timespec *timeout, const sigset_t *sigmask)
+{
+	if (tst_variant == 1) {
+		return sys_epoll_pwait2(epfd, events, maxevents, timeout,
+					sigmask);
 	}
 
-	return epoll_pwait(epfd, events, maxevents, timeout_ms, sigmask);
+	return sys_epoll_pwait(epfd, events, maxevents,
+			       epoll_timeout_ms(timeout), sigmask);
 }
 
 static void epoll_pwait_init(void)
-- 
2.56.0.317.g454f8302e1-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
