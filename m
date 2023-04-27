Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5751DC77B60
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 00:29:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A91673CE4CD
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 02:29:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E4A13CBFAF
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 02:29:31 +0200 (CEST)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 88D0F1A00981
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 02:29:30 +0200 (CEST)
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-517baf1bc93so7704829a12.0
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 17:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1682555369; x=1685147369;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xvLVIpEtbEhbI8/Ore/Z8JPmtlBF8S/oxC18r3bKGkU=;
 b=5iiDJcfyCfU9VfP/n8RxlpMsHNMOI3GQU/0+4llkUNsvxOfZOqwKNM3SptTKc+ERIk
 i2lbmS/LwTzygQoUa3X/WIoYJOXV8GwDCnjkxoTwqmcZgygRETdhzSLoWIw77Sehs8cs
 a6oxfNxAUHmKPONCHXvyAn8M0bXa7h5kIt6Ge0WroEnmOQVdPZoM18fcBx7EdLGotlLe
 BM4YhxfSjCvhFbg0wSMoZVEdWiOCBmnBNXpn5AsymFqidKy51PyL59F6LVeooCbPS4PF
 zrtz0mLD6M+cPh53l/yxKABoumH2CpUIkqNJEoB6Eo+pQYtIdTuReWyw9YebJomjcvGz
 QL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682555369; x=1685147369;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xvLVIpEtbEhbI8/Ore/Z8JPmtlBF8S/oxC18r3bKGkU=;
 b=JpVHszcnf2avFh5lrjhqu7Nct3x8anjP4eKRMvCqht7vWq6gcUgelNgc9QD3X4xVV0
 74iOjElN3c6oYjVJaSERjfAUSxkGh/sG/aBXn95BV6O8ktHp4ydFVKXSOnQtMX0iwZn1
 yjKOOBbB1/ReUIbsRkGJaXheTf+SmjoPOa5Ory4TseCLqKzoja5A39RrU7sR1IVfIElx
 2l2N7qd7nIRwjAhKO4zXHU4j3SRdjsJy3ss7mtfDWgDb82qi9bRaFZM6Zn6PKTbuFq/h
 i89ym7/HPkPB6H8psJSXDG6bFTbw6bCib/LGqch85cuMh7K6+sx++EPIgOyfwI1NcK8F
 xZsQ==
X-Gm-Message-State: AAQBX9f7qIUT8GrATpKDORBtiHTgiyeuZECCtH/Ew8oDfUlSrQfDdKsL
 4cqDkWM853ngJOg4nWTTmYqDMxlEPlq1RZ30Qka8eqLf7ByCJ4SUhhJEzZr8Yr+SBEVB9JMGzRz
 6o9+7WGLn0zdcwTe0bRh/418a8PSmyW0mIw7lnQXse1gcQ7mmvtmAMiFN
X-Google-Smtp-Source: AKy350ZJGpH3HYynrc1ekVxU0Y2F+yPIGy05yVCwyHJg5X2vqTijBAZ4SqeqLxPSF0apAYkxCUMTTnlmOXg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:dd0c:0:b0:513:efd4:d76 with SMTP id
 t12-20020a63dd0c000000b00513efd40d76mr3860991pgg.5.1682555368730; Wed, 26 Apr
 2023 17:29:28 -0700 (PDT)
Date: Thu, 27 Apr 2023 00:29:04 +0000
In-Reply-To: <20230427002905.1354207-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230427002905.1354207-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427002905.1354207-2-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] fcntl{34, 36}: Only use fcntl64 with 32bit abi
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixes: 7643115aaacb ("fcntl{34,36}: Always use 64-bit flock struct to avoid EINVAL")

On Android arm64, tst_kernel_bits is disregarding the abi, so compiling
with the 32bit abi is calling the fcntl syscall instead of fcntl64.  The
fcntl syscall is not compatible with the flock64 struct being passed
(this doesn't seem to be the case with x86_64, only with arm64).

This changes it to only use the fcntl64 compat syscall with the 32bit
abi.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/fcntl/fcntl_common.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl_common.h b/testcases/kernel/syscalls/fcntl/fcntl_common.h
index 5c130a784..485a31367 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl_common.h
+++ b/testcases/kernel/syscalls/fcntl/fcntl_common.h
@@ -10,6 +10,11 @@
 #include "lapi/abisize.h"
 #include "lapi/fcntl.h"
 
+#if defined(TST_ABI64)
+#define FCNTL_COMPAT(fd, cmd, flock) \
+	SAFE_FCNTL(fd, cmd, flock)
+
+#else
 struct my_flock64 {
 	int16_t l_type;
 	int16_t l_whence;
@@ -43,8 +48,8 @@ static inline int fcntl_compat(const char *file, const int line, const char *cmd
 		.l_len = lck->l_len,
 		.l_pid = lck->l_pid,
 	};
-	const int sysno = tst_kernel_bits() > 32 ? __NR_fcntl : __NR_fcntl64;
-	const int ret = tst_syscall(sysno, fd, cmd, &l64);
+
+	const int ret = tst_syscall(__NR_fcntl64, fd, cmd, &l64);
 
 	lck->l_type = l64.l_type;
 	lck->l_whence = l64.l_whence;
@@ -57,7 +62,7 @@ static inline int fcntl_compat(const char *file, const int line, const char *cmd
 
 	tst_brk_(file, line, TBROK | TERRNO,
 		 "%s(%d, %s, { %d, %d, %"PRId64", %"PRId64", %d })",
-		 tst_kernel_bits() > 32 ? "fcntl" : "fcntl64",
+		 "fcntl64",
 		 fd,
 		 cmd_name,
 		 l64.l_type, l64.l_whence, l64.l_start, l64.l_len, l64.l_pid);
@@ -67,5 +72,6 @@ static inline int fcntl_compat(const char *file, const int line, const char *cmd
 
 #define FCNTL_COMPAT(fd, cmd, flock) \
 	fcntl_compat(__FILE__, __LINE__, #cmd, fd, cmd, flock)
+#endif
 
 #endif /* FCNTL_COMMON_H__ */
-- 
2.40.1.495.gc816e09b53d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
