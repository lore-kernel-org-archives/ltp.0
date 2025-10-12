Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48378CCD184
	for <ltp@archiver.kernel.org>; Sun, 12 Oct 2025 19:41:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 071B83CEB0B
	for <ltp@archiver.kernel.org>; Sun, 12 Oct 2025 21:41:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0E263CEA90
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 21:40:22 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4CDA360082E
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 21:40:20 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo665211966b.0
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760298020; x=1760902820; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=089nLUzKSIJUdEMKHFhS7Z2tr18R6f3ov8pDTKN9cys=;
 b=V1RotOXQaHEqWpTvotD0u1F4LI9gzwEchXayqzpWxUvgLa8seZ44mXDrQWiF7Warff
 Lt1ZZnCp40+obHQTmL/5X8kELvgAPupOfTNdFExvtDB5RvpOLfv/vhTXn5YwCiqbGuzq
 8UzAzO4xq3Pp33KqGKTm+YK4kQXrU31R4t7RHdSehKnyiuhx4mkPydig0loX6xEhGs36
 SZ7CSqzx6FY54WkV6XrJ+xgKIlmiH98g6xcD20M2ukYvdE0GjeMp+2U424nuDM4GCqMl
 vpjpPRq+oW6hyTPPEZVqhbe6wx9oScp9OBFXoT6lxOkIgB4XflENjXptf558k/FOYAoS
 I/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760298020; x=1760902820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=089nLUzKSIJUdEMKHFhS7Z2tr18R6f3ov8pDTKN9cys=;
 b=DMhRCtIfdUOEKzF6bn5KRANPfBePy/BrKCOmn7FyG2Dhc8YOCiNtHW2+rl+kz2CEBZ
 mfkI/F9dNVn5ttX6UOWjt5BPcqg6VdtwebVs1flE5WkW9EYPzJ6Dzq9eRBa6YKJOMmRf
 fy0AMOpxEoWIemXuUZse/oZngjYSxMiTxfDxKEzjpp7ZBHJnexqVnRzfuOwIdiPl+d41
 fyMEtkJsCwTNMHu+MpMN6cIDinA2R6JyV34YDoRH5UW1HPh2idf5H8OCqVWFCkf/d+WJ
 1YLskW7i02iT5gwt6XiWjAf6cQftwNW7JSDbprcN3LmLEXW+zKttyHz074ToLHS16MF7
 p+tg==
X-Gm-Message-State: AOJu0YyoLIzYnaPEz75MJHq67AdRGkcd3y9LU91TuZ7/7I1HiRvN7P4F
 iEsvrIVtx91i9Az7M6boeKBtdmfPoaaChRzV8FWqsyU7svH1Y3XvB+UZOT37eXcU
X-Gm-Gg: ASbGncvpLNefVwwHrxgnRVXgf5CF3Opkft2jB5xHLfqOc+xPpZPpqEIrrgENytBCDC7
 aGiunIh4iRpE5l3fGQdYSM/qR9zaIZfjn1v3kjkg8iUI1ArGMQrZcitDItc2I8CYMNwQ4+kj7Vo
 +AkeGAuipHaiBsSJxAKZc+mD/oCK34wp2aJ1bRWJQ5MIpcw+K39FOg7Sd80dIWdYClwGvGkkB7e
 AaKIRGbTtfk8fY0bgkr3in5OBkb08CZ4FCJp4GkKrKlho/0rGy2qMguBYcKScyQqRhbiN5bk7wX
 0g6kuAFIUGNw5yn7i0VpC2GsovYP28qmWTMCn6l6zsk+TdMw7Z9vQcg2GuXTIV21xrJgZxkUM3k
 crSO7oBuKiyAqKwGpX9XvC7r9/6bCKFUfOwXsUhZq0AitVsNP4SKdfx8=
X-Google-Smtp-Source: AGHT+IFd3xNU0u2XAzF3HA/rYhpfZQCG6cEL1m0rHVsZsV8rAh2YFmjhX/8JIs3JhflR90Odg0uO3Q==
X-Received: by 2002:a17:907:9408:b0:b3e:151b:849b with SMTP id
 a640c23a62f3a-b50abaa46a5mr2091477466b.33.1760298019593; 
 Sun, 12 Oct 2025 12:40:19 -0700 (PDT)
Received: from x230 (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d8c12a8esm769901666b.42.2025.10.12.12.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Oct 2025 12:40:19 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 12 Oct 2025 21:40:07 +0200
Message-ID: <20251012194007.370008-3-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012194007.370008-1-petr.vorel@gmail.com>
References: <20251012194007.370008-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] hugemmap15: Check for __clear_cache()
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
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
index 1dde9e87ba..641c021809 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -46,7 +46,10 @@ static void cacheflush(void *p)
 #if defined(__powerpc__)
 	asm volatile("dcbst 0,%0; sync; icbi 0,%0; isync" : : "r"(p));
 #elif defined(__arm__) || defined(__aarch64__) || defined(__riscv) || defined(__loongarch__)
+# ifdef HAVE_CLEAR_CACHE
 	__clear_cache(p, p + COPY_SIZE);
+# else
+	tst_brk(TCONF, "compiler doesn't have __clear_cache()");
 #else
 	(void)p;
 #endif
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
