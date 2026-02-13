Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ECAEEA87E
	for <ltp@archiver.kernel.org>; Fri, 13 Feb 2026 02:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770950311; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ixHP7tGo+bybTpM+zKJkWSjfMKEYdkdq8mf/vOdoE54=;
 b=BoRjQZt6xxUSgx7ik3xcFwguE22ciCOJAdyqNflWsMTpY759o/0UW10tqMZj7hxCg7MqZ
 IAg8TMFCMs9ytvVRAXDs+ZQbmvWpG9D4boOCBnh6xlYj+fN8UCW3C0jxHqyf7QMtW7OSwmS
 H4kA47xMNOQRKDFRqqPWi92TYM7hrr8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80BE33CF6BC
	for <ltp@archiver.kernel.org>; Fri, 13 Feb 2026 03:38:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 398153C4CFE
 for <ltp@lists.linux.it>; Fri, 13 Feb 2026 03:38:05 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1F30B600846
 for <ltp@lists.linux.it>; Fri, 13 Feb 2026 03:38:05 +0100 (CET)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43767807cf3so279606f8f.1
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 18:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770950284; x=1771555084; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLq76ZF3yR/pnORkp2E0ifx/v6tkHGTcrF6Kftqs97g=;
 b=XEVxW7+mvIqdPZWpV/TOQraZFmePK3BfGK0g4Qc31MGW2uhMHE8qHTMOOc2CBZGFrZ
 FaiBoWtPVuVq91YR/7Uru/h0GLdZL/eMyMty19fYZQXVjat3hkLfJrmxbctn/bzWH15f
 fbplUMCShrI2W8VyhOQDu6i/HMoRBZ44G2EM87tTFUcB1vEL5CzhBobo2I6d1XhI/nTD
 /KdmnZ2YO2s5gCV3QRswIyFuWea92jbwh0GyTezx3vHHq62Vt9kRpgbligBRDh4DtHWv
 6IU5b8v+sXGdntR2+5Y7HF5+LSVyKHEZTDR8/y0KDPErlW7ebUb2h9aOPaiPAURVEB4R
 r5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770950284; x=1771555084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DLq76ZF3yR/pnORkp2E0ifx/v6tkHGTcrF6Kftqs97g=;
 b=HLY17HJtkclXq8BvmSZHpYhmzX8juWjzfq3PKoWvi8AcQXs2tdoskXvJmpd/7Ojwi+
 W3h70Ik/QFUl3MetkBDqwvtQzZxI7ePXJLF2q5i/c03o/HAb8UOC11SHkCGAyRRJ8o9w
 9lxnpNnBcZ8He+n0mvwen7Invb8xoIIZ8A//bs4EmryvLZONjbrjIKquT8AhgOEoZ7KS
 4xf2u+erCBayrf82Pki4Wi1seUchIAmC+Q00iU2Ig7ihMnxqYqnD0hr8iJ27/LKUindJ
 saVmZ5lkGBeSt3QFvpIcOYGuvITGXRbfcZF2SH4cNEUK4klVxHlPGODX1x32yENm9nFi
 ow+A==
X-Gm-Message-State: AOJu0Yw/TwcTQlMNkRJezbVHoCcM6QFiX2ThzFdLDoaw7r57PclXk5uy
 AcDSqUgvbI8Qf6bBlu0KGm3+lefLIL8j+5TLEuRIkdmqoO4wzzlKGe7STulqsKTrFPqfUTmuslH
 MN7w=
X-Gm-Gg: AZuq6aLnpes9lw5Zao72dPzapp180P59QkxO5dGxRvWLieM7gfY13P3IV6LX2tWBlLV
 osx6hBDIQU5/uGEybVkBSXJpgErDnCGMIzAZxjqQbkjRlLsod6sKCp4Axuu357rxSIia3D1wPIA
 ztXRgMPBQTv9xRhVCaIgDxz12BUpwC+luum6oEL4rB7mqyO+ADD5bAZ9TcWNU7wKo3s0RvZlNrY
 H9qdcJStnntf0SXJ6ZAdI7E6yLEosRikQkcKve3z8lI0GXsNiBKws1FB8/VVIASEHvIxX1se7Nv
 nQJRpdP6KGTpz6jzIatWPZ8VkkPoUXokRD1f7I9v1yL8QGIew1k41mSvfaOCHzEFZawmUVMvRXW
 fmxFv6AlpP2iFIB053HtxjNUrB9ch40lyzgxUCzxb7fnisw+EL3FevuimUyFZq514BR5I1Nn06i
 oMyivYJwa+Os4=
X-Received: by 2002:a05:6000:2c07:b0:425:769e:515a with SMTP id
 ffacd0b85a97d-43797926f20mr740554f8f.42.1770950284231; 
 Thu, 12 Feb 2026 18:38:04 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43796a74918sm2273905f8f.17.2026.02.12.18.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 18:38:03 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri, 13 Feb 2026 02:36:49 +0000
Message-ID: <20260213023801.11713-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125063035.31171-1-wegao@suse.com>
References: <20260125063035.31171-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ioctl_pidfd02.c: fix clone3 EFAULT in 32-bit
 compat mode due to sign extension
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

Correct the 32-bit pointer u64 conversion for args->pidfd. Direct
casting from a 32-bit pointer to a 64-bit integer was causing incorrect
sign-extension. Using (uint64_t)(uintptr_t) ensures a valid zero-padded
64-bit address.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_common.h                            | 5 +++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 2 +-
 6 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/tst_common.h b/include/tst_common.h
index 473228149..430c5e171 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -86,4 +86,9 @@
 #define TST_TO_STR_(s) #s
 #define TST_TO_STR(s) TST_TO_STR_(s)
 
+/*
+ * TST_PTR_TO_UINT - Casts a pointer to a 64-bit unsigned integer.
+ */
+#define TST_PTR_TO_UINT(x) ((uint64_t)(uintptr_t)(x))
+
 #endif /* TST_COMMON_H__ */
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
index c6f8a02fe..01f9df2b1 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
@@ -27,7 +27,7 @@ static void run(unsigned int isolate)
 
 	if (isolate) {
 		args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
-		args->pidfd = (uint64_t)&pidfd;
+		args->pidfd = TST_PTR_TO_UINT(&pidfd);
 		args->exit_signal = SIGCHLD;
 
 		pid_child = SAFE_CLONE(args);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
index 2c785004c..1ae467ad0 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
@@ -24,7 +24,7 @@ static void run(void)
 	memset(args, 0, sizeof(struct tst_clone_args));
 
 	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
-	args->pidfd = (uint64_t)&pidfd;
+	args->pidfd = TST_PTR_TO_UINT(&pidfd);
 	args->exit_signal = SIGCHLD;
 
 	pid_child = SAFE_CLONE(args);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
index ff4316068..3d5566ea8 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
@@ -26,7 +26,7 @@ static void run(void)
 	info->mask = PIDFD_INFO_EXIT;
 
 	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
-	args->pidfd = (uint64_t)&pidfd;
+	args->pidfd = TST_PTR_TO_UINT(&pidfd);
 	args->exit_signal = SIGCHLD;
 
 	pid_child = SAFE_CLONE(args);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
index 278e64cef..aa69d20fa 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
@@ -36,7 +36,7 @@ static void run(void)
 	info_invalid->dummy = 1;
 
 	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
-	args->pidfd = (uint64_t)&pidfd;
+	args->pidfd = TST_PTR_TO_UINT(&pidfd);
 	args->exit_signal = SIGCHLD;
 
 	pid_child = SAFE_CLONE(args);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
index 95c09dbda..32ca0422b 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
@@ -26,7 +26,7 @@ static void run(void)
 	info->mask = PIDFD_INFO_EXIT;
 
 	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
-	args->pidfd = (uint64_t)&pidfd;
+	args->pidfd = TST_PTR_TO_UINT(&pidfd);
 	args->exit_signal = SIGCHLD;
 
 	pid_child = SAFE_CLONE(args);
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
