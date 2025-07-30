Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DF4C87FCB
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 07:14:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A7873CAE35
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 09:14:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 007FD3C79EE
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 09:13:48 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 597AC2009D0
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 09:13:48 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b78127c5d1so2316565f8f.3
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 00:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753859627; x=1754464427; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tiRueV2gmzlDOhnB/nTG1zYZCIVXS+Thg7/A717DhTc=;
 b=cA29PJ5eGwCbndCqlIwXkg14HiUe9WPqkImi3tuOrHXtMgmlYy5jdKsi++y/XecJll
 xMH0bs+2IrIgKhZDh3P8fUohEKJP8yt94Up0wQk2YGW+v1HUZf+JoCc/6wdXfKMj1nep
 9KcgZyqs5iktjzA+owkftacyKnseii/gMBOC/pphQ5IRlsP6KOhkHqj0Kx70X/K0zHQv
 sEtYH9C+zT58mYKYbjSrTBLGHBR01VY52WRUykGPEk6ecu7Dh1Klb/eG9jfBI+PzI697
 vikptE2O8euB2i32GA32rBKgKzoId6xogYd0nUOlmAAROgLOFoHopFyqQXS5JpAxJCBe
 NMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753859627; x=1754464427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tiRueV2gmzlDOhnB/nTG1zYZCIVXS+Thg7/A717DhTc=;
 b=ZUY5GDvHo+sLNF25eyNdQykw6mFSeqanrdVelqDLBsLsypWUof5V4nrsURob220aMg
 Qw3WYWJtFD+Hl4Vzpyy2juWqaPQr5WpOYUs+ztBaz0ctVtvSiWIO23DR+FgCsuetqHUp
 hbap6g+bTNFW4nXdhbpFIlgRkXDeKNhwZnZhavXQtxWB+4Cbw4eD8sbPbxUwLRjDBDWi
 pqtbrjsYarMQGKNZzqPxBAlFGGhXFl/QEW7YstlflHL1F7GA2TZmc9zIAU81zuaiI33T
 /em6KEEbvIgHIpAnp/VmHSbkxs19JzcMbgzjQB/L7m0nqpVkWhviLFYYuI96Zl5oI8Yg
 cVTg==
X-Gm-Message-State: AOJu0YyBcbLwaWVzJdtmdpN2x3WU82VcA6IzqGIiV182zXWIP/x+fq5G
 pDGoccFw7zCiDYFWFpUs64ZxYrFmgbuyXa7l5HyeWtlZ6VwGc9lvfHpUbi2bmzRTd6ciX1qkhvi
 SuKDolQ==
X-Gm-Gg: ASbGnctUF5hKs4Ol56UeLlf8gDdjb3izRtVwMT5/5iOfNeiPRQOHG99D0yM4ZfjAABh
 R0j6lem3zi1XvjKPhNQnLAl5MEHafMPDToI6dwMMs7jqdcT6IPmw57VZGtdI3VpfCOCt+2SolYE
 2cXZV9xtrj3A3Z9uCHMOndY5CSnyPdskf1XL5h9yjxZCOAN7i8NixL9oDdeuoF8AUPRfLQ5AKZp
 NUmkQ3+QeCA5FA5zsUigBK8iWyOYRuYY2OES5dszZWlLDUxcvJm24sUmKEwa1ej5cHfMc8ojkkB
 lJ8d9s0yZ8KjkmqudAt14MB7vGyOOaAg8LEOr6vEZX1ZWiCQ/lkXIPn14zxbVyPuGDulCoCT1d0
 FR1SQP5NQerGsaY3B0OZ93Ylidx0tSLqW5Gf8BscqLmrBgCigGjaU
X-Google-Smtp-Source: AGHT+IGxeKQl8ibIgV4ns5cPoU/lwTrWzGJXDNykxdbYgMvIv07VYwTBkVK0ywIelGoBHuq1GLrd1A==
X-Received: by 2002:a05:6000:2003:b0:3b7:6d94:a032 with SMTP id
 ffacd0b85a97d-3b794fb5753mr1775290f8f.3.1753859626964; 
 Wed, 30 Jul 2025 00:13:46 -0700 (PDT)
Received: from pickles.copeland.me.uk ([213.152.161.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b788ec4580sm8943541f8f.45.2025.07.30.00.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 00:13:46 -0700 (PDT)
From: Ben Copeland <ben.copeland@linaro.org>
To: ltp@lists.linux.it
Date: Wed, 30 Jul 2025 08:13:42 +0100
Message-ID: <20250730071342.817400-1-ben.copeland@linaro.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] vma05: Fix false positives from stripped system
 libraries
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
Cc: dan.carpenter@linaro.org, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The vma05 test was producing false positive failures by flagging any
"??" symbols in gdb backtraces as vDSO kernel bugs, including those
from normal stripped system libraries.

This caused widespread false failures in production environments where
system libraries like libc.so.6 are typically stripped of debug symbols.

The fix filters out "??" symbols that originate from system libraries
(paths containing "/lib/" or "/usr/lib/") while still detecting genuine
unresolved symbols in application code that could indicate real vDSO bugs.

Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
---
 testcases/kernel/mem/vma/vma05.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index c560eecbc..09757a0fe 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -64,11 +64,14 @@ tst_test()
 	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
 		vma05_vdso ./core* 2> /dev/null)
 
-	if echo "$TRACE" | grep -qF "??"; then
-		tst_res TFAIL "[vdso] bug not patched"
+	# Only check for ?? symbols in application code, not system libraries
+	APP_UNKNOWN=$(echo "$TRACE" | grep -F "??" | grep -v "from /lib/" | grep -v "from /usr/lib/")
+	if [ -n "$APP_UNKNOWN" ]; then
+		tst_res TFAIL "[vdso] bug not patched - unknown symbols in application code"
 	else
 		tst_res TPASS "[vdso] backtrace complete"
 	fi
+	fi
 }
 
 . tst_run.sh
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
