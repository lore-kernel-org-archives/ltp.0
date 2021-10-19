Return-Path: <SRS0=AfES=PH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFB3C43219
	for <ltp@archiver.kernel.org>; Tue, 19 Oct 2021 15:02:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901C0610E5
	for <ltp@archiver.kernel.org>; Tue, 19 Oct 2021 15:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 901C0610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E71313C4F89
	for <ltp@archiver.kernel.org>; Tue, 19 Oct 2021 17:02:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 562893C2EFC
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 17:02:17 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 743E81001272
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 17:02:16 +0200 (CEST)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E7D4B3F4BA
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1634655732;
 bh=Zu9uQiA/2TKk1qLdO/3Dar9Pn4DfGOB4r7wZAGLbBfg=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=FwPojoNP2A7OlaSlBwnWfG/0l3OJWlGlKXJCnwIhH8LtY0EZqcSEiD46fROUZmENz
 RduyOhlGZUX+oQSyyyzu3mRgWN9B8USyk7MGTbShJr+3ZrG+uT24Ts2DlQOWx84/6C
 dKTkyWKyaRtu1Qv+Nf4pCE2UEhKgXvXa6R0bg0DZZtKVQY0s61pvFf/99Gse64v7pJ
 4gJewFh1PikCac7I7znDaEuq23FQWfO/7N0tuX621q25CN4BMVxkJL0O/yvnZFmqkz
 IS9tP0jjIFqLnab9F4r+Mbeueq3conJXd5cdGEiJV5v+WEWEpef1/CJP0FUjhmD/Pb
 cdXZrxtKT8V2g==
Received: by mail-lf1-f70.google.com with SMTP id
 h8-20020a056512220800b003fdf2283e82so1542130lfu.10
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 08:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zu9uQiA/2TKk1qLdO/3Dar9Pn4DfGOB4r7wZAGLbBfg=;
 b=JIH5MDIs/jeX8ag7jP7dDXNmyBuVW3DG17a3kU8Js9YQ+7b8tCutvAjBEexxN9NRqk
 LfESq475mVfL/u29kdF6X91jmurPJRN6SEzl3GKHqnV67oVZIGq23Ox/UKsqi/aUStpy
 FJCE+BUVwm0eMWk5ji6j7OuOiE0XelecHRY/XqlVeIzZsUPGxAoizsnShl6+z09ioYe5
 ZtUgxOtgA3b+jSSYlHQAFuSG9LVwIXiAGhpOiUdQvoAeEseYOToVy2pdxZOGiKc4KXmm
 87/VAV9XPK0J36U2tlkTdJxqc5O7ZtErsZgSAp88K/pq2rTYBSiFZT7+/izHIPYCiXMu
 uVHw==
X-Gm-Message-State: AOAM5322aFhZrzRPogUoXgUHreIIiqeHkShhOnrNsVtniOP1mTKx/70/
 lfgvVaZtCcy5yJFwqk+MymmgBHGdfkNicycfkIIPyHjyK/NM8+FBmaOXpOJ2e2Z+YxqJJDlePbn
 haOB/RbhAw1hHvCGkRX1ZZ3gPPxCQ
X-Received: by 2002:ac2:538a:: with SMTP id g10mr6619484lfh.90.1634655731806; 
 Tue, 19 Oct 2021 08:02:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJgrJyCeiGpxl4iVV1LRn7WwlTpeKACE5zDOuXTygE0PT60WBfsXBxbkFUsJAQIYDY0p950Q==
X-Received: by 2002:ac2:538a:: with SMTP id g10mr6619407lfh.90.1634655731178; 
 Tue, 19 Oct 2021 08:02:11 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id
 c19sm1970936ljj.130.2021.10.19.08.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 08:02:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: ltp@lists.linux.it
Date: Tue, 19 Oct 2021 17:02:06 +0200
Message-Id: <20211019150206.90335-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: memutils: respect minimum memory watermark when
 polluting memory
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

Previous fix for an out-of-memory killer killing ioctl_sg01 process
in commit 4d2e3d44fad5 ("lib: memutils: don't pollute
entire system memory to avoid OoM") was not fully effective.  While it
covers most of the cases, an ARM64 machine with 128 GB of memory, 64 kB
page size and v5.11 kernel hit it again.  Polluting the memory fails
with OoM:

  LTP: starting ioctl_sg01
  ioctl_sg01 invoked oom-killer: gfp_mask=0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), order=0, oom_score_adj=0
  ...
  Mem-Info:
  active_anon:309 inactive_anon:1964781 isolated_anon:0
                  active_file:94 inactive_file:0 isolated_file:0
                  unevictable:305 dirty:0 writeback:0
                  slab_reclaimable:1510 slab_unreclaimable:5012
                  mapped:115 shmem:339 pagetables:463 bounce:0
                  free:112043 free_pcp:1 free_cma:3159
  Node 0 active_anon:19776kB inactive_anon:125745984kB active_file:6016kB inactive_file:0kB unevictable:19520kB ...
  Node 0 DMA free:710656kB min:205120kB low:256384kB high:307648kB reserved_highatomic:0KB active_anon:0kB inactive_anon:3332032kB ...
  lowmem_reserve[]: 0 0 7908 7908 7908
  Node 0 Normal free:6460096kB min:6463168kB low:8078912kB high:9694656kB reserved_highatomic:0KB active_anon:19776kB inactive_anon:122413952kB ...
  lowmem_reserve[]: 0 0 0 0 0

The important part are details of memory on Node 0 in Normal zone:
1. free memory: 6460096 kB
2. min (minimum watermark): 6463168 kB

Parse the /proc/zoneinfo and include the "min" data when counting safety
(free memory which should not be polluted).  This way we also include
minimum memory for DMA zones and all nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 lib/tst_memutils.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index af132bcc6c24..f34ba582ec93 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -6,22 +6,49 @@
 #include <unistd.h>
 #include <limits.h>
 #include <sys/sysinfo.h>
+#include <stdio.h>
 #include <stdlib.h>
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
+#include "tst_safe_stdio.h"
 
 #define BLOCKSIZE (16 * 1024 * 1024)
 
+unsigned long tst_min_memory(void)
+{
+	FILE *fp;
+	int ret;
+	unsigned long total_pages = 0;
+	unsigned long pages;
+	char line[BUFSIZ];
+
+	fp = SAFE_FOPEN("/proc/zoneinfo", "r");
+
+	while (fgets(line, BUFSIZ, fp) != NULL) {
+		ret = sscanf(line, " min %lu", &pages);
+		if (ret == 1)
+			total_pages += pages;
+	}
+
+	SAFE_FCLOSE(fp);
+
+	/* Apply a margin because we cannot get below "min" watermark */
+	total_pages += (total_pages / 10);
+
+	return total_pages;
+}
+
 void tst_pollute_memory(size_t maxsize, int fillchar)
 {
 	size_t i, map_count = 0, safety = 0, blocksize = BLOCKSIZE;
+	long pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
 	void **map_blocks;
 	struct sysinfo info;
 
 	SAFE_SYSINFO(&info);
-	safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
-	safety = MAX(safety, (info.freeram / 64));
+	safety = MAX(4096 * pagesize, 128 * 1024 * 1024);
+	safety = MAX(safety, tst_min_memory() * pagesize);
 	safety /= info.mem_unit;
 
 	if (info.freeswap > safety)
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
