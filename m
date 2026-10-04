Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B20CA5FE4
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 01:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791078851; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=10D2uEx+w/+huHEQrNnzh5uDwfkoijtMx4/zVbTsgrg=;
 b=HeecrAptXb+A7Qtawn6Wnmd28Ci9QFg5UxjTxV2q1E291n9nGEzp1XJSt2+8FXJB2N2TY
 GZG21zVOkA+/gxz2u33y5FnQbqG0UFnyfET/smdDBwe7Pb0uIm1SJsm/rX49oi6UZZEQ5Oh
 wm2w2dxW6dCeJAsDywUBPp0bAMvRwWM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D3D63E4F06
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 03:54:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 697C03E27FD
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 03:53:50 +0200 (CEST)
Received: from mail-pg1-x545.google.com (mail-pg1-x545.google.com
 [IPv6:2607:f8b0:4864:20::545])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 75404600084
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 03:53:49 +0200 (CEST)
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-cc1cade6b71so438885a12.0
 for <ltp@lists.linux.it>; Sat, 03 Oct 2026 18:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791078827; x=1791683627; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PFOtVR9INUjD2oky9H24tAPsWFgcq55ylVmM5Qh+UzQ=;
 b=QdLcyrrYBWzjftfJWDwU2kKtN9E55ueCu5fGGQOieHEgKHzvz3WI1RcdQo5W9hSs/8
 If3Pv3+H1wj1DBgqNHj4XOIk95Ixx1fQNSR661dr7G7DnTOicQujaWQfp8d2vrkuysCm
 aN8NGe+xcgu3V4f3G/v77SJGGI3YJKxRIgw+UXTxG6/eqyGPoQ8mRLVnCpLZif/z9oNa
 SKrL2TXUHBuRFgvq9BTSCPwTacZipiAT/89TpRZmViv8C4tARVkX3/3EGfxiYSQ0F83D
 CXfjjXK5UConFQteuZfmsfaaLcQ93Qsen7gJH1dFLB8MBxHd3lsNlNsejDq0tU+gGUtp
 gArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791078827; x=1791683627;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PFOtVR9INUjD2oky9H24tAPsWFgcq55ylVmM5Qh+UzQ=;
 b=JhrpiRlGMEEYZ7L+bTfkypXL2DRSR3B20L4F6zMhcdkBuEXvnYz/0UpuSjAwV9P1PP
 RBgk3HFh4sQff57HWTHx1vuJgGAQwN8C6LeFPzdx22EY7KSt5dxHqsw4CA/yKQhCx6ko
 HlWhpgMVWkHz1Y6D0F5hxzRWBqpMyMdovnlJ+6MUA1NO7o7AUcoNKO0kvXTSBBYhvLP5
 mbho5naEjGmEGWDGT4oBMsDK1kIc6jLwyZqsRImXuobe7x9jEfdHbzHLjiN9onOSZwxQ
 eea+UqrgkVyn/zqoVgFuC78F/pG0e8Bmeaifjf36jA+faLXCjULcU8bY2+CrSn+b0qr5
 PWOQ==
X-Gm-Message-State: AFuF++nBAFpv5/5sguTaDJ/XzlFUIvpDcvIIQ3/JwIWrOejDx0P/zjVD
 vEfkrSy2G3t6mB2QTovu0qppfzQChyQRGw4oERbWtk20YOkgIj5IeOnDPq226HZ9/3g5BezJDPx
 YC9FN/B71IEPInt1deSeEwvv/+OPK6b/ho/+UofjvyS4Cz9fvTmQGmlq82kGE1j/ZeOFRNFua2Z
 f5BnSjTfM4cdT0Uo6H/LQVoviiRw==
X-Received: from pgcv16.prod.google.com ([2002:a05:6a02:5310:b0:cc7:b2dd:797b])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4002:b0:3d8:e57a:5a5b
 with SMTP id adf61e73a8af0-3e0bc9ebc99mr4389715637.5.1791078826874; Sat, 03
 Oct 2026 18:53:46 -0700 (PDT)
Date: Sun,  4 Oct 2026 01:53:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261004015344.2862110-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] epoll_pwait04: Use raw syscalls to avoid SIGSEGV on
 32-bit Bionic
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
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
---
 include/lapi/epoll.h                          | 37 ++++++++++++++-----
 .../syscalls/epoll_pwait/epoll_pwait04.c      |  6 ++-
 .../syscalls/epoll_pwait/epoll_pwait_var.h    | 30 +++++++++++----
 3 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/include/lapi/epoll.h b/include/lapi/epoll.h
index 15a954175..07fb1503a 100644
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
 
@@ -40,23 +51,31 @@ static inline void epoll_pwait2_supported(void)
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
+	if (!timeout)
 		return tst_syscall(__NR_epoll_pwait2, epfd, events, maxevents,
 				   NULL, sigmask, _NSIG / 8);
 
-	struct __kernel_timespec ts;
-
 	ts.tv_sec = timeout->tv_sec;
 	ts.tv_nsec = timeout->tv_nsec;
 
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
2.56.0.rc1.315.gc6ed9934b7-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
