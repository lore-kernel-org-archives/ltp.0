Return-Path: <SRS0=SXDC=PJ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF19C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 08:36:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A03461056
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 08:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A03461056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 255623C5688
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 10:36:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F4023C536F
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 10:35:55 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C2F6660156D
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 10:35:54 +0200 (CEST)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F232040002
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 08:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1634805353;
 bh=c8SWBkozG+9XivV0ECnXiAH6lP+cdFjvMnjOSpKgIGA=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=nDP25AxIZg8rmVUDQQfMQ5f9KciB+HzBi4kU9nV8WKcwlXjJ+r3e8fl6nmk26wKMV
 w0jp0Db/yd2WE6yE13fsFPhvjGnhDEtxKyEL7NnvWygaIrZb+IP0iPmD46Jv7WhB9E
 /8B6KbxwCrcy2X5L0knldi5QUlEBkicxP4OTaRGnLqQ+nwCpp5CKkgTRE1OpEtYzti
 m58Tr2b0KsIjww+tM2LukXJaIPgzCawlXw/xgp4rUO5MN99yplnbuG7WNieQSRSSTX
 V5aoee0VoROtx/JrzKUbIQUgF4Zd3ND2WH/4JRXZk8v+Ex9vp8iIDKC4aA6veyJDM0
 f2blLy0COkg+A==
Received: by mail-lj1-f199.google.com with SMTP id
 w9-20020a2e9989000000b00210af61ebbdso2555749lji.2
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 01:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c8SWBkozG+9XivV0ECnXiAH6lP+cdFjvMnjOSpKgIGA=;
 b=sXnqzz1AF7Zm3kPOBDTK3GMQt/OZmtNSQuLkF36RESZ/HMYBkKg/ZOXk87cBXMouH6
 er5MRufN7bWIFZMxKM2fzQxWX8V1VNBGSp4zeF3DaIiKtR54jeN7QRuyFaTRy6tHUBvK
 9eD3YM3yivoJIVaUn7dEW5lWk4G4VewRg1d4eN8+En12yxmtroK2Is9okRyp+AbCPHqZ
 mEYbeJ6Yk6KhrZ49/FF04MkxJjrYzF0j8NYy7cfrxuGRpuUhvnuPqHblr+FKcqvGrPyD
 t/gk75PWKt+nG/e+ak1EwuUJZZoXbAW5oIN+RohwqwuoA7I/IutDLOihFDhzaeWEXNDB
 86GA==
X-Gm-Message-State: AOAM533UspyJgq+N6osMPqgHe+q9dT3Ul1rugPRo/8FtPbWSEKUR7UsK
 Ae71gsG1Zx8SEQ6rxXvJ5vZP4wQ8vTpPzoSa+hQoCI6/5oSsFunZfG5pFNW3f2Qbm4LjkHfP7dC
 xUEePCwmhT2UqQKyG7RzjUGW9d36A
X-Received: by 2002:a05:6512:3699:: with SMTP id
 d25mr4300274lfs.380.1634805353037; 
 Thu, 21 Oct 2021 01:35:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYE9Bm5GQIu/FO7vCrR5FNTs+CU74+cQPfEJRDgNydoi8lSHPDq1KNjdAw8bPjS3aYCQFlbg==
X-Received: by 2002:a05:6512:3699:: with SMTP id
 d25mr4300256lfs.380.1634805352790; 
 Thu, 21 Oct 2021 01:35:52 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id
 h6sm462794ljc.107.2021.10.21.01.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Oct 2021 01:35:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: ltp@lists.linux.it
Date: Thu, 21 Oct 2021 10:35:46 +0200
Message-Id: <20211021083547.111590-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] lib: memutils: respect minimum memory
 watermark when polluting memory
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

Parse the /proc/sys/vm/min_free_kbytes which contains the free
memory level used as minimum watermark (triggering OoM killer).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v3:
1. None

Changes since v2:
1. Use /proc/sys/vm/min_free_kbytes instead of parsing zoneinfo, thanks
   tgo Liu Xinpeng.

Changes since v1:
1. Add static and rename to count_min_pages().
---
 lib/tst_memutils.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index af132bcc6c24..df53c542d239 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -16,12 +16,18 @@
 void tst_pollute_memory(size_t maxsize, int fillchar)
 {
 	size_t i, map_count = 0, safety = 0, blocksize = BLOCKSIZE;
+	unsigned long min_free;
 	void **map_blocks;
 	struct sysinfo info;
 
+	SAFE_FILE_SCANF("/proc/sys/vm/min_free_kbytes", "%lu", &min_free);
+	min_free *= 1024;
+	/* Apply a margin because we cannot get below "min" watermark */
+	min_free += min_free / 10;
+
 	SAFE_SYSINFO(&info);
 	safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
-	safety = MAX(safety, (info.freeram / 64));
+	safety = MAX(safety, min_free);
 	safety /= info.mem_unit;
 
 	if (info.freeswap > safety)
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
