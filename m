Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BC1CCD184
	for <ltp@archiver.kernel.org>; Sun, 12 Oct 2025 19:50:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5646A3CEB38
	for <ltp@archiver.kernel.org>; Sun, 12 Oct 2025 21:50:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C15413CEA90
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 21:49:55 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 096DE140097E
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 21:49:55 +0200 (CEST)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b3b27b50090so654867366b.0
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 12:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760298594; x=1760903394; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEN5kGpQ3gTXg0ywT5Vwin7v+rFvKczgKPDyPZ6ooAM=;
 b=jLS7jrPBkfXIkczls2NlrgiVbUERflHsimiLe18SFZritxK3UUyi1pkSPWg+qXi41Q
 3AU4DaXotH5eWGe1Oj7IeZZCSZKedZyGTcrkoS64aaTsK1Y1GWLF+/+1CgFZL2qt4CCI
 15XcjZxE6nGwJtLOa08L778p6yF6pR/7f2eF5MdPRE0aRdT98k03zeh02BryfkNY/HS+
 MN0s8LwuceAJLHirbxsqDVWxw4fscfHe7F2xn9gOwzRc59UpRAgrohVIXRXaVF7UImj2
 ge3OfDUVc6l06s1sJ0eeKJYM7CF6ldctQhxddl2DQfISLjG9EW644NBaGXLPtgftpdOi
 h6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760298594; x=1760903394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xEN5kGpQ3gTXg0ywT5Vwin7v+rFvKczgKPDyPZ6ooAM=;
 b=H/1sItNjD1gWmG+2FVK6QuM1/4EIN1Itb2+1aQ+LOAUFJKsmICDdtSMF47lepsE+Py
 0OUBx5bDqNhg71++uBhXPNDEAhOBJeB207DLH8kUviHQwD+lLXcZt2NPWXGVBtSVUNDz
 Pv/Uds/R0TZBsXgz4oCfWflMZ6Gr/ff1LbEfQb7hNLC6177YSYFg+tFu/Pz3jyVEvYtr
 bWluBMmNSa8nBM9EYDvsG1mm1uIM5PL469AYV3ACEFACj95ET1SnI1PPbkOchjouL4Av
 MdnBwZQfdKmVfoBlCnj6q2rar9dzkz9pgiYvIgd2j+GCiviPOG2yhbClguHu2Q7b8Dvp
 Np9A==
X-Gm-Message-State: AOJu0YxLnZ7x3Pw1uH6EttdZlVk9SAfTZRLxrFdFPVTYBJJu0CRBsK99
 B8KD37c4QFdeFMRuKpVwXKhsdTnY14JKYUwSXjnPXjrRCsfZG5JelBkeQPy7Onfc
X-Gm-Gg: ASbGncvLtSFgCQrJ5cxWloM3W8k2tSgmgwLaI3R2tVhOxxZWt1CwGq93OlPfx8leMBl
 rE5FIid+o4ADMaIU1ppOXMr8+eCOsTCwDmRLdWPUPDs4Yx+W/S9PXASTBUzve5lYHyBBudEcDW0
 L7b+SZdGZ7Xw5Cho/eAbyOgPm7H7BDRsiRy3D1XV3xRsy4XpTFnwExmhnYh3pTnsNeuA86JY5LS
 XyBDNkoEFdRNU4LCB0Ay0VE9cNmqzFIndgcfB8CgadYfpYBSYeNKbOo9pAKs8GvjKBfaLWwVqz3
 LoO4qjlm7iaBEXY+Mcqgd08n/Sin87Xx+jFl6no2Uv0FNJSjc7ondMs0JKZkFHWKmn5avMihIoQ
 qVrSYBYw0suZ9ftKrut/bUoBH03CSLM2tZOmu9GZ4e2rJXV0WxNKh51A=
X-Google-Smtp-Source: AGHT+IF8E3JGcxl6MezMd36Pcv1DhBTL7r6Av41Qpg2KBlW/8vvSAUMqd8NXOLld/Q7b6yi7r2M6FQ==
X-Received: by 2002:a17:907:1c0d:b0:b3d:b8c3:768d with SMTP id
 a640c23a62f3a-b50aa490851mr1918471066b.7.1760298594337; 
 Sun, 12 Oct 2025 12:49:54 -0700 (PDT)
Received: from x230 (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d5cad938sm767759466b.2.2025.10.12.12.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Oct 2025 12:49:54 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 12 Oct 2025 21:49:46 +0200
Message-ID: <20251012194946.370905-3-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012194946.370905-1-petr.vorel@gmail.com>
References: <20251012194946.370905-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] hugemmap15: Check for __clear_cache()
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

It fails to compile at least on riscv64 with older compiler.
It looks like it requires clang >= 20.1.0.

Reported-by: Khem Raj <raj.khem@gmail.com>
Cc: Hui Min Mina Chou <minachou@andestech.com>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Changes v1->v2:
* Add missing #endif

 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
index 1dde9e87ba..f2984e2dc0 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -46,7 +46,11 @@ static void cacheflush(void *p)
 #if defined(__powerpc__)
 	asm volatile("dcbst 0,%0; sync; icbi 0,%0; isync" : : "r"(p));
 #elif defined(__arm__) || defined(__aarch64__) || defined(__riscv) || defined(__loongarch__)
+# ifdef HAVE_CLEAR_CACHE
 	__clear_cache(p, p + COPY_SIZE);
+# else
+	tst_brk(TCONF, "compiler doesn't have __clear_cache()");
+# endif
 #else
 	(void)p;
 #endif
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
