Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506A6CD98DA
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 18:07:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABB8A3E6A54
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 20:07:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 716C93E2037
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:06:52 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 03BDF1400069
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:06:52 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-3074adb8fcaso5741337eec.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781546810; x=1782151610; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBfdp16LEQq5lmYAcXQRGwWADdscEzkc/onUd6M6OFg=;
 b=MLNk2djhWjB+u9fvZCE7ezXmf/F7mM407mnrIb2WhFOoBPv0x45hNY6FIT0Gdv5tyR
 g5i+P9jfNIubl0KLlFLx4U+C1ebTRgyEMGg1VdpDzn+s9+BB9ANksC2Lzk2AU3xKzV3J
 C5WqdkTAWxFfiNO6l9xJkgccqhaTYJPw05t93OP6EiHxjofwn8enn0y1EFkrxkh+2ndz
 YjmBSj/vuHtezrrb1YN/S6YzXYfEF/kRHgaNS8nFTDUhFe1lc3QWoL/w4oswTfsTMBOm
 afJXWs64B7NNBnPE8Znb2YLVeApy1KAC9NNh1K5pWF2LGlU8MozKKewPZDBsUgRVmDxF
 6v0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781546810; x=1782151610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tBfdp16LEQq5lmYAcXQRGwWADdscEzkc/onUd6M6OFg=;
 b=TmVp1Ut2hDmisnNGrsH9rzo/+NLo5aPgYED/J9lx/K8imIZbkBj9+ppBQr2uiCV7nZ
 f38pizKzxufe2+FDZKjkl5cye8hnMSZKROCf3SLCRsSO14ATtBH/+lo/o0P/3wPfleG8
 dxmsSbEc1n17x6R1Y+/Z2Tg064LwDLBQsnc9K5SxT3VQxD6jRLS9KFTTHF5pt1Zd4KRW
 pv+lGwAOdGJhsMwBmTqcU++kRTQdrtTY8EpaYHpyvWSxHune9yuKGOoVbKGSpL86fehc
 hjegj1kQeJ63BHUgbVbrFKEcUo27RbdHcGH1D9DaL6koyrQN9nXlOknBQ86cRuW/TzNz
 On3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XsUhhPYs/4sIlfpRxgSTQdhLL1JdxSqw4acS1Sfg9rR2edazV+FD68hu9oPOkD/tcP3Q=@lists.linux.it
X-Gm-Message-State: AOJu0YwV8sPd7LUFx0LG2jtIndvKOtrIeUeI1eLuXJydbu7uyaie8oZQ
 n2SqO/8am5JHLSpTK9bznzWnkaCa2h5s/PD5Ireg0m4jS+ZWkDZQhRNeKA61fyYrx1s=
X-Gm-Gg: Acq92OFqpCg+WT4qmaS8PdWzPae+eSPAFWDk3sjmymrSKPbvqTes5gGgEDGAznFW1H6
 vF9QHxGoYFzYQjzpTctzMKZjo2eow6fm96ukv3PridZIez/IAQep+WLHfTck8Yi6Ih1BKmnh9qr
 4iqkMD7NWyqD6G6ZIKrFVMFwJVhVxxQFBIGx+d6WDt3XNpgURgV6121XsUxeYpnE1m9/7c1ltYF
 hnh3rv8EG5ZAZ5o6nUzOSB7XpyM1w3zkWvXEp3QjqGwaCdg+4MH3I6Yxy3dtyaTF2eD9OlCxtUC
 yoL/3ugQqSv6YR4fDnWPaeARUyKyPrL/Gj2TBceezU00GwxObwkJsfm4wZLwGL2vH6md8O3LOxP
 3A52Q0MVgA/NYB6WqBl2OE1yXZLFEa5pWMFB36JepLgysDHPTRbek0HbXSrslJn/s1VLlnditmc
 ebBSDNVuc0o0tBCp1h
X-Received: by 2002:a05:7300:5341:b0:2fc:9ae6:e5a8 with SMTP id
 5a478bee46e88-3082009c394mr10305435eec.20.1781546810208; 
 Mon, 15 Jun 2026 11:06:50 -0700 (PDT)
Received: from cirno ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea4f7a0sm14352840eec.24.2026.06.15.11.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:06:49 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Date: Tue, 16 Jun 2026 02:06:25 +0800
Message-ID: <20260615180629.7148-2-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615180629.7148-1-anonymemeow@gmail.com>
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
 <20260615180629.7148-1-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] fanotify20: Allow FAN_REPORT_PIDFD with
 FAN_REPORT_TID on v7.2+
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
Cc: amir73il@gmail.com, ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

fanotify_init() used to reject FAN_REPORT_PIDFD combined with
FAN_REPORT_TID with EINVAL. Since Linux v7.2, fanotify supports
reporting pidfds for thread IDs, so this combination is expected to
succeed.

Keep expecting EINVAL on older kernels and adjust the test expectation
based on the running kernel version.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify20.c     | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index b32ecf6aa..9a78f6ff0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -8,13 +8,14 @@
 
 /*\
  * This source file contains a test case which ensures that the
- * :manpage:`fanotify(7)` API returns an expected error code when provided an
- * invalid initialization flag alongside FAN_REPORT_PIDFD. Additionally, it
- * checks that the operability with existing FAN_REPORT_* flags is maintained
- * and functioning as intended.
+ * :manpage:`fanotify(7)` API returns an expected error code when provided
+ * unsupported initialization flags, e.g. FAN_REPORT_PIDFD combined with
+ * FAN_REPORT_TID. Additionally, it checks that the operability with
+ * supported FAN_REPORT_* flags is maintained and functioning as intended.
  *
  * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
  * af579beb666a ("fanotify: add pidfd support to the fanotify API").
+ * FAN_REPORT_PIDFD combined with FAN_REPORT_TID is supported since v7.2-rc1.
  */
 
 #define _GNU_SOURCE
@@ -26,8 +27,10 @@
 
 #define MOUNT_PATH	"fs_mnt"
 #define FLAGS_DESC(x) .flags = x, .desc = #x
+#define PIDFD_TID_FLAGS (FAN_REPORT_PIDFD | FAN_REPORT_TID)
 
 static int fd;
+static int thread_pidfd_supported;
 
 static struct test_case_t {
 	unsigned int flags;
@@ -51,17 +54,21 @@ static void do_setup(void)
 	 */
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_PIDFD,
 						    MOUNT_PATH);
+
+	thread_pidfd_supported = tst_kvercmp(7, 2, 0) >= 0;
 }
 
 static void do_test(unsigned int i)
 {
 	struct test_case_t *tc = &test_cases[i];
+	int exp_errno = (tc->flags & PIDFD_TID_FLAGS) == PIDFD_TID_FLAGS &&
+			thread_pidfd_supported ? 0 : tc->exp_errno;
 
-	tst_res(TINFO, "Test %s on %s", tc->exp_errno ? "fail" : "pass",
+	tst_res(TINFO, "Test %s on %s", exp_errno ? "fail" : "pass",
 		tc->desc);
 
 	TST_EXP_FD_OR_FAIL(fd = fanotify_init(tc->flags, O_RDONLY),
-			   tc->exp_errno);
+			   exp_errno);
 
 	if (fd > 0)
 		SAFE_CLOSE(fd);
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
