Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730BCCD5BD1
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 01:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780362503; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=DsXLwfIqeRySysCc4JbJ5gIII0hSOqE+DeMzydC8hz0=;
 b=YbVzD1ek4ROa5t9HD4VUvUV2pkCyajb79GQuFtDS/JONG3J7W5olSkTobuMEKkyMDSfzL
 ymZuqrSgmpe4c4EOofld/at6bKANXw6wd8AjSevj2I6A9dFBKKZ8Lir/ImXtzFDP5jpM43D
 gGCe8HMnXyWlRQjFKavIyXZ6wuqBuFk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF6BB3E18F5
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 03:08:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 228FC3E18F5
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 03:08:01 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 716AA100115F
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 03:08:01 +0200 (CEST)
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-8422a0eee68so3301031b3a.0
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 18:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780362480; x=1780967280; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=zOS0DNzqZLNehz/EUMxb0BEDjqjlk8DeUaA9hnhhxP4=;
 b=skKQoHo9FDDs+j6s/d6Dmq2tzsfwum1AT7uyoKwfT39/odXEb2y+OxRJKEbpkMuwL2
 1IQ/sXktB6xRD7DS5w7CWveL0kZjRULL/ezqEOepymSCNNlh3cWjBCoo5PQXbBVBZ8FE
 EXLvLHuv0//IUM9gnHHna/s1Y6YsZa2Jc5xJN2BmZAL6v5fyHIWRrxCZv8PyBYFJObpC
 QtLYxhwnNk3+IKE5WSHW1FW2XUZ+xyyPFkIwllc1nBFOQvnstiamc8bnzS/hSoa+j82z
 XrZSQPl+qXx7Cd1frKhVqqpifKMv8bYzVbAMxY8CIDbDGg+e3MpybUTsVc0JmNviEs8d
 H0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780362480; x=1780967280;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zOS0DNzqZLNehz/EUMxb0BEDjqjlk8DeUaA9hnhhxP4=;
 b=NrHiQA5NKaZS1wxioNQSma0FK1lBPaJYJK0F52kNcpZqIesIN0SjaKn4riKeq0NQp/
 9lz7p6FxAd3BJOOXndLkT4PYcVAe2aeWneJGMBgarWIfVaso7ib0/zrncBn8epjUAkAT
 Oj4HWNJhOF2aCJaxkHgYcf58DaUrjTVM9SYB+zNjQ169HNFpCPeu60GtCyjZiQ6ggels
 bQwVgDsrPLSJk1K/ls42x37EB8nqb6+PMQhFfwtXqFG29wMJn78iOWj6hTOHBJIDIlk4
 VPfJtWbQsiZnM3K/XbRhDjd8OSscNnzwzJ5h0cMpNkJlC214e0Ruq5rqeQfLPK9U6l6P
 W/9A==
X-Gm-Message-State: AOJu0Ywn+qW6fWp8Kua1SJfXiSjsaoYFohsucYjI1G6X+fCm5+u3rr5Q
 KrAACSu9iIiFCPtrlg9MHC1jRZ+y0BiiDPyUjKYIk+UhNTarMLajZI8t3sPXue/ptC0fLr9qATR
 wYkVLqncr9etwN/32JqzE1AYXbZEDlPpU2N4VJ9AfS07b4vdd6viJfKx2RqA5TcPnuxqE1cWxTD
 xHwbY0JTUx/Ri1dvz2pJzhBNakSsB/DbmMyM143A6Kp7x/8HM=
X-Received: from pfbki2.prod.google.com ([2002:a05:6a00:9482:b0:842:3d2d:1e7e])
 (user=chihsheng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a908:b0:836:3f6a:3e77 with SMTP id
 d2e1a72fcca58-8422578c834mr12655294b3a.17.1780362479303; 
 Mon, 01 Jun 2026 18:07:59 -0700 (PDT)
Date: Tue,  2 Jun 2026 01:07:54 +0000
In-Reply-To: <20260601165331.4077251-1-chihsheng@google.com>
Mime-Version: 1.0
References: <20260601165331.4077251-1-chihsheng@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602010754.190896-1-chihsheng@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] syscalls/xattr: Add runtime probe for socket xattr
 backports
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
From: Darren Chang via ltp <ltp@lists.linux.it>
Reply-To: Darren Chang <chihsheng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Upstream commit dc0876b9846d ("xattr: support extended attributes on
sockets") was merged in v7.1. Currently, setxattr02 and fsetxattr02
strictly expect EPERM for sockets on kernels < 7.1.

However, downstream kernels (e.g., Android mainline branches) often
backport this feature to older kernel versions (such as 7.0). On
these kernels, the strict version check causes a false positive failure:
"passed unexpectedly".

This patch introduces a runtime probe in setup() for both tests to
detect if older kernels have the backported feature. If the xattr
syscalls succeed on a socket during setup, we assume the patch is
present and adjust the expected result to pass.

Signed-off-by: Darren Chang <chihsheng@google.com>
---
 .../kernel/syscalls/fsetxattr/fsetxattr02.c   | 34 ++++++++++++++++---
 .../kernel/syscalls/setxattr/setxattr02.c     | 14 ++++++++
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index 2a48b7da7..4a0997445 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
@@ -19,10 +19,10 @@
  * - Set attribute to a block special file, fsetxattr(2) should
  *   return -1 and set errno to EPERM.
  * - Set attribute to a UNIX domain socket, fsetxattr(2) should
- *   return -1 and set errno to EPERM on kernels < 7.1.0.
- *   On kernel 7.1.0+ (dc0876b9846d "xattr: support extended
- *   attributes on sockets"), returns 0 (success) as sockets now
- *   support user.* xattrs.
+ *   return -1 and set errno to EPERM on kernels < 7.1, unless the
+ *   feature is detected at runtime (e.g. backport). On kernel 7.1+
+ *   (dc0876b9846d "xattr: support extended attributes on sockets"),
+ *   or when the backport is probed in setup(), returns 0 (success).
  */
 
 /*
@@ -209,6 +209,7 @@ static void verify_fsetxattr(unsigned int i)
 static void setup(void)
 {
 	size_t i = 0;
+	size_t socket_idx = ARRAY_SIZE(tc);
 	struct sockaddr_un sun;
 
 	dev_t dev = makedev(1, 3);
@@ -245,6 +246,31 @@ static void setup(void)
 	}
 
 	socket_xattr_supported = tst_kvercmp(7, 1, 0) >= 0;
+
+	/*
+	 * Commit dc0876b9846d "xattr: support extended attributes on sockets"
+	 * merged in 7.1 mainline, but might be backported.
+	 * Try to set xattr on socket to detect support.
+	 */
+	if (!socket_xattr_supported) {
+		for (i = 0; i < ARRAY_SIZE(tc); i++) {
+			if (tc[i].issocket) {
+				socket_idx = i;
+				break;
+			}
+		}
+
+		if (socket_idx != ARRAY_SIZE(tc)) {
+			if (fsetxattr(tc[socket_idx].fd, tc[socket_idx].key,
+				      tc[socket_idx].value, tc[socket_idx].size,
+				      tc[socket_idx].flags) == 0) {
+				tst_res(TINFO, "Socket xattr support detected (backport)");
+				socket_xattr_supported = true;
+
+				SAFE_FREMOVEXATTR(tc[socket_idx].fd, tc[socket_idx].key);
+			}
+		}
+	}
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 994ab655d..167e068cf 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -196,6 +196,20 @@ static void setup(void)
 	SAFE_MKNOD(SOCK, S_IFSOCK | 0777, 0);
 
 	socket_xattr_supported = tst_kvercmp(7, 1, 0) >= 0;
+
+	/*
+	 * Commit dc0876b9846d "xattr: support extended attributes on sockets"
+	 * merged in 7.1 mainline, but might be backported.
+	 * Try to set xattr on socket to detect support.
+	 */
+	if (!socket_xattr_supported) {
+		if (setxattr(SOCK, XATTR_TEST_KEY, XATTR_TEST_VALUE,
+			     XATTR_TEST_VALUE_SIZE, XATTR_CREATE) == 0) {
+			tst_res(TINFO, "Socket xattr support detected (backport)");
+			socket_xattr_supported = true;
+			SAFE_REMOVEXATTR(SOCK, XATTR_TEST_KEY);
+		}
+	}
 }
 
 static struct tst_test test = {
-- 
2.54.0.929.g9b7fa37559-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
