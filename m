Return-Path: <SRS0=xZdR=PI=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349B3C433EF
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 06:32:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B98260E76
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 06:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B98260E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F9413C5460
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 08:32:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4610D3C14F3
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 08:32:32 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1B32F1401244
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 08:32:31 +0200 (CEST)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DB01F3FFFE
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 06:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1634711549;
 bh=LX/lKqSZXDJSVlrZObePmykpU91aBYxHKaJTWb2Nuns=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=bZlq2vyk0FYWAbXiAyyeB/siq5U9C2/5MEBvMaHhkj5ukClUqxT/HK7L194qINU6V
 ad6XHLqe+ddzaE5uxMbmPCyNDBkhu/ikh/cw+BzsMP1Cww42By8ehO2nsOd/0i1t5+
 bcNpeAX8dss136R4cGsN9atOrxar00bzL/0xhYc6qvTN5gf8h/CnQ1R8HFbV21jOfK
 trRjbngP9KJ8Rjf235hz+wxIQYwdQtFe7cSwKw4ZTjGrkdUv5q8YmaKIOda/QhME2e
 c3KQdYt9N28zIAbmrG9xiWHF38QMhMqp8bJ1NbbrnhTam3cB6ZyzhQvXlfXBplsz28
 V6gPHJveDhlOg==
Received: by mail-lf1-f70.google.com with SMTP id
 c41-20020a05651223a900b003fdb648a156so2651882lfv.15
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 23:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LX/lKqSZXDJSVlrZObePmykpU91aBYxHKaJTWb2Nuns=;
 b=W81JU2Xcz9KtT+mjcLm1nUkux1qpP6wGxJC+/cNb8QnFWTg6o1RLg6HCgaWxZIYTAz
 ZduM7pM3urp15f3wpFhnEHtlBqneglCFlaFQ2cwzOhqQb/E/E3rFWkZKCFoLaJCXgad7
 C5LduUjCUuqCYUna0cfyiJnO29jZB5iDndfLYq39Rexx6ODMny+jppkAkIjoAgWP7Lf7
 bSO36RhZUtQEkOJZYJmfJoJuBpIGIVVIRahr3lNbM953GEPrQHBu91EGpYds5Y48M3zz
 BuNR/b3KhEe0GUb0K/3+pQqcEKN4Acz3UIif/Zwy22SE6vXkM2XTcvfZ4Ls2Lduc8nqZ
 rPlw==
X-Gm-Message-State: AOAM533yoPrQmHbJPqeijrTXzXQGr9zR1GxR2WuXsCsbAeueZ4lUJZ9M
 EvoaAssLcma1oPSLResPHIJ7ovOIbeenjYNOnDaKUg66YyeVbI2C+ZOn8/WdlAL39nQH4PEutLd
 BsLZRH+INkW949T610JJordx8cjCN
X-Received: by 2002:a05:6512:b81:: with SMTP id
 b1mr10315119lfv.301.1634711549041; 
 Tue, 19 Oct 2021 23:32:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLyBzYCJSyN08kGk+20w3JegOcPcPuJVv0lcXgwFwCA2FsCVzCaB59AcTzulfavRmrpeHQvA==
X-Received: by 2002:a05:6512:b81:: with SMTP id
 b1mr10315099lfv.301.1634711548751; 
 Tue, 19 Oct 2021 23:32:28 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id
 m27sm112565lfo.48.2021.10.19.23.32.28 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 23:32:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: ltp@lists.linux.it
Date: Wed, 20 Oct 2021 08:32:20 +0200
Message-Id: <20211020063220.5885-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib: memutils: respect minimum memory watermark
 when polluting memory
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
Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Liu Xinpeng <liuxp11@chinatelecom.cn>

---

Changes since v1:
1. Add static and rename to count_min_pages().
---
 lib/tst_memutils.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index af132bcc6c24..97f3b8275a42 100644
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
 
+static unsigned long count_min_pages(void)
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
+	safety = MAX(safety, count_min_pages() * pagesize);
 	safety /= info.mem_unit;
 
 	if (info.freeswap > safety)
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
