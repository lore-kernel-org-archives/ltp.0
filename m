Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B1AC7EE22
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 17:43:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB4FB3CE4B7
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 19:43:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0D263CB1F5
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 19:43:18 +0200 (CEST)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C4DE2200246
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 19:43:17 +0200 (CEST)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-555f6759323so143665047b3.2
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1682617396; x=1685209396;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=M9qC7sBNhWxjAncgjmRgJ8gGeWKYKrcTmTzOdQR/P6g=;
 b=uBsRA/+OUf/JfTdC4ehMZuxAhhLtLDVbTibAb8GCdPSreYhmqO912m4u3PFxZ8xtrN
 /2aydz9eIc9B/B6PLJirhIwBTQnU6b1qEwQ2IwMsAXFxqYpTazA/Ovs2o3RAa0zhCl8H
 1/WrWlep5WkGji0+4w9DZ2+6ZOzwVGFObaLpTaajAf4UNAvDTHHFxG8vSAbqOJfJs90w
 9wZFKQusCohmyH7iPhGYI4I9WwUMwORlZswTGEplUVzkGREnfktQoDjAIuVjwSnvaQmk
 vwb5M2nNGz17lJzHnCLkzQ8wyYB4HG4dQsjhuSd67/MuTx1J13Iu58Qmsve+dsmdaFUe
 4T/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682617396; x=1685209396;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M9qC7sBNhWxjAncgjmRgJ8gGeWKYKrcTmTzOdQR/P6g=;
 b=MfRQbRDMzk3ubV+qJnauoTbwoZdkq4MulP+OCt5eNzZyYbmAoped/8irn1DdEN9m9G
 exyPpic2xfZakGw1d82HIr6j18NI9lE7CpawrKNPg7Idlzb06FdEWWQDZ+Ue4F+lwmNL
 viuoKED/AVXvk0mOv68muYdZkjEn5WkCHI9gtaFV4lVvkZ+R/HkmwWhrSxXUPGXzjhFq
 0ANfalPSjy8Stikzuhy2YvKSWx00NuDh2nhx20HjtfUMM+yEG6L1H0ge30nyICNfSN0J
 r7vf3WuvH7phZ7+WkbQi+a6qjQHb2Fg0eh1dxRlE87vW1zU/OsrshuYbjGthgFh6rbTf
 OxTQ==
X-Gm-Message-State: AC+VfDxrUIRUDUoy3ssRpjd5Nw6MWrYDNM+196B/CfX13uOpu7IMhV5G
 yse7LBuZsWGrGsPWtXZIzgM0gYZEPo4foGF7cWwa9F2uJPNQSwcsqRJJ7w0dh+P4lgKT8vZ7++i
 mNM9Bl8bP2wcYbRfqFzuZoUo/FoWLMNqr2BEI1xOQ8DYU3LEav4faQ+Jd
X-Google-Smtp-Source: ACHHUZ4uYqkD+tvikWHb8aL4oRmy3aQ9c6pZqv9Quxg+gsIV989+3QlvI2ruFogVQmK5ltFdimmB9KY74n8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a81:af27:0:b0:555:fecb:bd14 with SMTP id
 n39-20020a81af27000000b00555fecbbd14mr1645434ywh.4.1682617396403; Thu, 27 Apr
 2023 10:43:16 -0700 (PDT)
Date: Thu, 27 Apr 2023 17:43:08 +0000
In-Reply-To: <20230427174309.1479093-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230427174309.1479093-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427174309.1479093-2-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] fcntl{34, 36}: Only use fcntl64 with 32bit abi
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

On Android arm64, tst_kernel_bits returns 64, so when compiling with the
32bit abi, the test makes the fcntl syscall instead of fcntl64.  The
fcntl syscall is not compatible with the flock64 struct being passed on
arm64 (x86_64 uses compat_sys_fcntl64 whereas arm64 uses sys_fcntl).

Before 7643115aaacb, compiling with FILE_OFFSET_BITS=64 and the 32bit
abi would also use fcntl instead of fcntl64.

This changes it to only use the fcntl64 compat syscall with the 32bit
abi.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/fcntl/fcntl_common.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl_common.h b/testcases/kernel/syscalls/fcntl/fcntl_common.h
index 5c130a784..56e871167 100644
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
@@ -26,8 +31,7 @@ struct my_flock64 {
  * pass the flock sturct directly to the kernel even if it had 32-bit
  * offsets.
  *
- * Also, if and only if, we are on 32-bit kernel we need to use the
- * fcntl64 compat syscall.
+ * If we are on 32-bit abi we need to use the fcntl64 compat syscall.
  *
  * See:
  * glibc: 06ab719d30 Fix Linux fcntl OFD locks for non-LFS architectures (BZ#20251)
@@ -43,8 +47,8 @@ static inline int fcntl_compat(const char *file, const int line, const char *cmd
 		.l_len = lck->l_len,
 		.l_pid = lck->l_pid,
 	};
-	const int sysno = tst_kernel_bits() > 32 ? __NR_fcntl : __NR_fcntl64;
-	const int ret = tst_syscall(sysno, fd, cmd, &l64);
+
+	const int ret = tst_syscall(__NR_fcntl64, fd, cmd, &l64);
 
 	lck->l_type = l64.l_type;
 	lck->l_whence = l64.l_whence;
@@ -56,8 +60,7 @@ static inline int fcntl_compat(const char *file, const int line, const char *cmd
 		return ret;
 
 	tst_brk_(file, line, TBROK | TERRNO,
-		 "%s(%d, %s, { %d, %d, %"PRId64", %"PRId64", %d })",
-		 tst_kernel_bits() > 32 ? "fcntl" : "fcntl64",
+		 "fcntl64(%d, %s, { %d, %d, %"PRId64", %"PRId64", %d })",
 		 fd,
 		 cmd_name,
 		 l64.l_type, l64.l_whence, l64.l_start, l64.l_len, l64.l_pid);
@@ -67,5 +70,6 @@ static inline int fcntl_compat(const char *file, const int line, const char *cmd
 
 #define FCNTL_COMPAT(fd, cmd, flock) \
 	fcntl_compat(__FILE__, __LINE__, #cmd, fd, cmd, flock)
+#endif
 
 #endif /* FCNTL_COMMON_H__ */
-- 
2.40.1.495.gc816e09b53d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
