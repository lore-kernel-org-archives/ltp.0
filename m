Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA235C25B76
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 05:57:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EC633D0B54
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 07:57:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9A923D0B2B
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 07:57:00 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3C6E31A0014E
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 07:57:00 +0200 (CEST)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c315b569c8so638534a91.0
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 22:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718085418; x=1718690218; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qYkHHEJp6KLGkTCmTk99meaVNVBEErYnRG8q1hCY3TE=;
 b=YMkJlc2QjvYcS18qOBBu+vRsg7Bcye4zfGo1Z/c4P6kxxkjMiFbPClCjrl2yd/EbdB
 FEenM/WSWnPtZAHKtXrm1/Y7F4E3WAyhAyswGATYpky6ibX7YTIeP2Ng8UjbjuGfTGFe
 kZHDNFbexQdRBiAyvyx/3QhWJz2A/qw6rlem21QIWR9C4/JL7hkJNsII/KC8SDnoPyI/
 fsub8GMVnsKiDjqOTLuQeIt3cb/T+S3I4YePhAyJWxRkzcNSzkG+m/Pd7d69MFeR68Jr
 XXxWRgvvV0MA1AioJWsRSCM11HckX82G0Th1TW8pXkYwcLMT913ZcOMS0sgMw1C3hjgy
 EAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718085418; x=1718690218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qYkHHEJp6KLGkTCmTk99meaVNVBEErYnRG8q1hCY3TE=;
 b=TZYnArI2TZP1YpRIjhsf4QpBe9KNRgSQ/u5PtNBwc9+i4YT3TSC388KEWTzh5fR+of
 4OiD3vYmQ3AEedmbHGrX8wDJBvG/4rSAGIOZv+49TXVQSiD3LYgV9JIJFAZ17XypnyXk
 8KtJXJ6+emT+hAxJD75+N03zzdZr75RuoBdSbk42TkefRqCtdU0lwnOcxqxaNyzi80tm
 NH+hElKpOuFTJYA84iT1EIigrrU/bgWEZt+R903hz5GV58tHnTYGeKDXCwqq5SD9dm9G
 U1vRk/lwh10rb86nxFfvPI5ywLk93OvAGXUZ1CZBpqun6bU8YkiWTpz+WdttS23ufqyi
 AUyQ==
X-Gm-Message-State: AOJu0YzauAoaXCKyWG/xgTAiveEQ3CbT6YYwKr4TF2PH/FApILF9WO4p
 jcEfCIO/k10RagH24aGov4hK1BDHEwIHB5WEZ1ueAA/zitUCKDQ8g1YSig==
X-Google-Smtp-Source: AGHT+IFkCFKGrCAFH8APhI2U79fjM8TX6KuTTjbQA3pd1skukd5/wBstzUbCfalNlTYRN29FTfOm6w==
X-Received: by 2002:a17:90a:4414:b0:2c3:d32:288a with SMTP id
 98e67ed59e1d1-2c30d322988mr4269308a91.20.1718085418439; 
 Mon, 10 Jun 2024 22:56:58 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::9980])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2c661f8basm7831502a91.12.2024.06.10.22.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 22:56:58 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: ltp@lists.linux.it
Date: Mon, 10 Jun 2024 22:56:55 -0700
Message-ID: <20240611055655.614782-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add __clear_cache declaration for clang
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
Cc: Hui Min Mina Chou <minachou@andestech.com>, Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

__clear_cache was enabled on RISCV recently with 7352ba02390116f1cd6a9b583860ba28aa0a1b7a
however it fails to compile with clang19 on RISCV
With this error

  hugemmap15.c:51:2: error: call to undeclared function '__clear_cache'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      51 |         __clear_cache(p, p + COPY_SIZE);
         |         ^

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Hui Min Mina Chou <minachou@andestech.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
index a84ba6476..856e22ff3 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -21,6 +21,7 @@
 
 #if defined(__clang__)
 	#pragma clang optimize off
+	void __clear_cache(void *start, void *end);
 #endif
 
 #define _GNU_SOURCE

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
