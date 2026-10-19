Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9153606A319
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=dWXz/c2a;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AsXgPoeI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792659531; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=6n6BNjm/WxUBUorRGVJmPaPORWeZCXXtnKNmYHQNgko=;
 b=dWXz/c2alxEJmxWAtyaDecBctAhsHqwGzdaJm+9UKAfSQSZ4WLuqSMDaKoa5Kj3exwvxg
 VPuD3Vmkzqb2qVGpHxpTqW4mUA9tYHARO6FmhjHoFqOxNJd794Yfpn8frR5Vj/rnFyvybJ2
 d403d4pnhnH7O3GXrb3gyKPSkwww3pQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FFCC3D2384
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 10:58:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4C5B3E2832
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 08:22:13 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AE73F1A00646
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 08:22:12 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4844F4385F;
 Mon, 19 Oct 2026 06:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2ACDEC2BCF7;
 Mon, 19 Oct 2026 06:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792390929;
 bh=TJwuQKLBSwqKkQIi87bPu6kQRKS0t9rFMGUns3kqZlw=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=AsXgPoeIV4t1h/kil7jr8Natv8NGeMWnIRstNiZBdo/1wMFw7WmLznUnnbPdON2Pj
 5cYcPXWNqvkeXKALyyQ4bGt5MNflbiaFDF03Sma6mdjflxZEMdJ82fm2LHNBO/j+Tp
 /W5jcpc5vueMKj10K9hf6Mqmnf7RJNOG9Pj2zw0kh3+uQijo+4Vaylmn7gbU0AbvxZ
 zgOjdmPznAU83jXHqYWrnyZdlehZ5XnUJ1ug4OLcWm81/fQJADEDXP+wRjE6/z6nlJ
 kLj9P4cuGk6gOb8nLGMxivN9jtJ4DmlTNkqPURx0qNdhh9+wdxWyt7+O+h4rmrUaH2
 Ap/tS0eUleLzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 18ACCCCF2DB;
 Mon, 19 Oct 2026 06:22:09 +0000 (UTC)
Date: Mon, 19 Oct 2026 14:22:08 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261019-research-select-time64-rk3576-v1-1-a65d6b72e21f@gmail.com>
X-B4-Tracking: v=1; b=H4sIABC31WoC/yWMQQ6CQAxFr0K6thEGB6NXMS46Q4WqDKRFY0K4u
 4Mu389/bwFjFTY4Fwsov8VkTBmqXQGxp9QxSpsZXOmaqqxOqGxMGns0fnKccZaBmwPqo/bHBr0
 nosC1L10LuTEp3+Tz61+uf7ZXuGdxi26PQMYYlFLst2lU6STtB7KZFdb1C0zQRAChAAAA
X-Change-ID: 20261019-research-select-time64-rk3576-55aaabe3502d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792390928; l=2457;
 i=berringtoni36@gmail.com; s=ltp-20261019; h=from:subject:message-id;
 bh=SIoimnh8+2U5EXodlYXh0YMeysiNIjwnnrmbsPWjNZY=;
 b=59JfaGd0PGhEhjdENijlxH/Q9Vwg/nIEjSzsg7hbKGTYIjsqtP/NQxtkWjw+88FiQEEGjZ6Bv
 /hRGySrbbN2Cq3l7kE4cokNAg5TYq2eDfSZQNfo7NLEwdTy+Sdn1OKe
X-Developer-Key: i=berringtoni36@gmail.com; a=ed25519;
 pk=+YVmSxpz14KiDkWu3zCQ25HCYntxcdWyEAOBmZ859K0=
X-Endpoint-Received: by B4 Relay for berringtoni36@gmail.com/ltp-20261019
 with auth_id=1236
X-Original-From: Wenqiang Zhao <berringtoni36@gmail.com>
X-Spam-Status: No, score=-22.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_REPLYTO_END_DIGIT,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 22 Oct 2026 10:58:13 +0200
Subject: [LTP] [PATCH] syscalls/select: use kernel timeval for _newselect
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wenqiang Zhao via B4 Relay via ltp <ltp@lists.linux.it>
Reply-To: berringtoni36@gmail.com
Cc: Wenqiang Zhao via B4 Relay <devnull+berringtoni36.gmail.com@kernel.org>,
 Wenqiang Zhao <berringtoni36@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Wenqiang Zhao <berringtoni36@gmail.com>

With _TIME_BITS=64, struct timeval has 64-bit fields on 32-bit ARM,
but _newselect still expects the old kernel timeval layout. Passing
the libc structure directly makes a subsecond timeout appear as zero.

Convert valid timeouts to struct __kernel_old_timeval before the syscall
and copy the remaining time back afterwards. Pass NULL and deliberately
faulty timeout pointers through unchanged.

On an RK3576 running a 6.1.118-rt36 aarch64 kernel with CONFIG_COMPAT=y,
the unmodified ARM32 time64 select02 reports 22 passes and 6 failures.
With this change it reports 28 passes and no failures. Both runs skip
the unsupported SYS_select variant.

Tested select01-select04 on the same board with ARM32 time32, ARM32
time64 and AArch64 static builds: 250 passes, 55 configuration skips,
no failures or broken tests. Additional local checks cover timeout
copy-back, ready fds, NULL, EFAULT, EINVAL and EINTR.

Closes: https://github.com/linux-test-project/ltp/issues/1314
Signed-off-by: Wenqiang Zhao <berringtoni36@gmail.com>
---
syscalls/select: use kernel timeval for _newselect
---
 testcases/kernel/syscalls/select/select_var.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/select/select_var.h b/testcases/kernel/syscalls/select/select_var.h
index a945fa6..e23f1fa 100644
--- a/testcases/kernel/syscalls/select/select_var.h
+++ b/testcases/kernel/syscalls/select/select_var.h
@@ -84,14 +84,30 @@ static int do_select_faulty_to(int nfds, fd_set *readfds, fd_set *writefds,
 #endif
 		return ret;
 	}
-	case 4:
+	case 4: {
 #ifdef __NR__newselect
-		return tst_syscall(__NR__newselect, nfds, readfds, writefds, exceptfds, timeout);
+		struct __kernel_old_timeval _tv;
+		void *tv = timeout;
+		int ret;
+
+		if (timeout && !faulty_to) {
+			_tv.tv_sec = timeout->tv_sec;
+			_tv.tv_usec = timeout->tv_usec;
+			tv = &_tv;
+		}
+
+		ret = tst_syscall(__NR__newselect, nfds, readfds, writefds, exceptfds, tv);
+		if (timeout && !faulty_to) {
+			timeout->tv_sec = _tv.tv_sec;
+			timeout->tv_usec = _tv.tv_usec;
+		}
+		return ret;
 #else
 		tst_brk(TCONF, "__NR__newselect not implemented");
 #endif
 	break;
 	}
+	}
 
 	return -1;
 }

---
base-commit: 1255a3be50a69950607ed76fd2e9566189447f7a
change-id: 20261019-research-select-time64-rk3576-55aaabe3502d

Best regards,
--  
Wenqiang Zhao <berringtoni36@gmail.com>



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
