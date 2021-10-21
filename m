Return-Path: <SRS0=SXDC=PJ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0BFC433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 08:36:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDBF61056
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 08:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EFDBF61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BF073C55AC
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 10:36:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8653F3C5543
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 10:35:56 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AA3621400F91
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 10:35:55 +0200 (CEST)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 300BA402E8
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 08:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1634805355;
 bh=yciDB58AxTca60YtxfPO7qCtvE3HKpruHKmzYqv7n30=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=hQuJxK1i+EKn5aPhieZgmmOy9TN6Rb5VCiJHaoMDMevdYQIswSIrBRoOtK9AIic9j
 xlYAeKP/jfkHVo378IQBNU1s0LewTT2/MrXvm13UCGfUaChdbanEBjlgAFWndLqV3e
 tjqhjODFBmiGt+euMzNmYDACGIrPYVKBRtLOjb+0McbPDSlhqVvpMdyBM8rTv0/ZhH
 n2ED4zOPFTqOShJBAHmUoc2I0IH46oZrxMtynL2b3KiSNWE9bFWtVuEN/MfGCbBGwb
 wLKyO5z6gQAIDRyhbE3bQvOxl7zVcAXaHGWmDv7wW6rxlIlqcdO3WqD0qgw1iOV6JW
 itq4qLbQ8D6Xg==
Received: by mail-lj1-f197.google.com with SMTP id
 e26-20020a2e985a000000b00211109b97e6so2576279ljj.0
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 01:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yciDB58AxTca60YtxfPO7qCtvE3HKpruHKmzYqv7n30=;
 b=mJfa31Iry0fJzuSsS/SWR/JItKvBN1UAEnrBzV3SxBk0U5SrnfhKpVH9LKYRXpvJiI
 BgnAKRdRVL1nbB86ydfu+3+JH9yEUqjsz5od32R15ODg905Bb1pdbX66aA+41ZQW8QaP
 MBAKe1sLxzWrEcv7F+d/LqKeND5I8rZMwyKksRvw6nJGJugb4EglkgaizBbNjjCMafup
 KNQvomzBFObNVJidXU3WxUjzlgTxq4Wiyq55mX2Zm7XnoU/AVXzfPbi1Lbx0FIYlI/Rx
 s5BrSyBpouKo8tebHw2T+PA0h7N0op9McUlmJEvBPxBJLiIu+AawkGDKitE9F1rDs9VS
 +GAQ==
X-Gm-Message-State: AOAM5332xeyaEO9Cp43zwEpy6tsFRCWnL0fTYSm97w9DjFaB7KQ0Cemc
 /JagHnsTLeixxB8Gg0YbudG2XDYsEYJBj0SlsVQ1bkQoHI2dnZNquAHTKbT6smyTW6k4l2O9hKv
 /pCncBU4xctBluMz0XQEJ56/fyuH2
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr4071078lfn.318.1634805354236; 
 Thu, 21 Oct 2021 01:35:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlD2vwSLeUNoozYdjZfLOEb8q/cS6zRshfRgPxMHQlk2nojwaJ1dOkl+kQCNR3Dg1tYiNasg==
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr4071065lfn.318.1634805354024; 
 Thu, 21 Oct 2021 01:35:54 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id
 h6sm462794ljc.107.2021.10.21.01.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Oct 2021 01:35:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: ltp@lists.linux.it
Date: Thu, 21 Oct 2021 10:35:47 +0200
Message-Id: <20211021083547.111590-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021083547.111590-1-krzysztof.kozlowski@canonical.com>
References: <20211021083547.111590-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] lib: memutils: include also available memory
 when polluting
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Usually available memory (MemAvailable from /proc/meminfo) is higher
than free memory, although not always. On kernel v5.14 the formula is
approximately:
  available = free - reserved + pagecache + reclaimable

The reserved part comes from vm.min_free_kbytes (already included in
previous patch: lib: memutils: respect minimum memory watermark when
polluting memory) and vm.lowmem_reserve_ratio. If user set specific
vm.lowmem_reserve_ratio (sysctl), the available memory could be actually
lower than free.

Use lower value of these (free/available), to avoid out-of-memory killer
for such system configurations.

Reported-by: Li Wang <liwang@redhat.com>
Reported-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v3:
1. New patch
---
 lib/tst_memutils.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index df53c542d239..bd09cf6fad9b 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -16,6 +16,7 @@
 void tst_pollute_memory(size_t maxsize, int fillchar)
 {
 	size_t i, map_count = 0, safety = 0, blocksize = BLOCKSIZE;
+	unsigned long long freeram;
 	unsigned long min_free;
 	void **map_blocks;
 	struct sysinfo info;
@@ -33,15 +34,24 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
 	if (info.freeswap > safety)
 		safety = 0;
 
+	/*
+	 * MemFree usually is lower than MemAvailable, although when setting
+	 * sysctl vm.lowmem_reserve_ratio, this could reverse.
+	 *
+	 * Use the lower value of both for pollutable memory. Usually this
+	 * means we will not evict any caches.
+	 */
+	freeram = MIN(info.freeram, (tst_available_mem() * 1024));
+
 	/* Not enough free memory to avoid invoking OOM killer */
-	if (info.freeram <= safety)
+	if (freeram <= safety)
 		return;
 
 	if (!maxsize)
 		maxsize = SIZE_MAX;
 
-	if (info.freeram - safety < maxsize / info.mem_unit)
-		maxsize = (info.freeram - safety) * info.mem_unit;
+	if (freeram - safety < maxsize / info.mem_unit)
+		maxsize = (freeram - safety) * info.mem_unit;
 
 	blocksize = MIN(maxsize, blocksize);
 	map_count = maxsize / blocksize;
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
