Return-Path: <SRS0=xZdR=PI=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6F7C433EF
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 09:14:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E5760FD8
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 09:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4E5760FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7E063C4E23
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 11:14:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46D393C1B10
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 11:14:00 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 604D42010BD
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 11:13:59 +0200 (CEST)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 896D8402E6
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1634721237;
 bh=BJTdenav3Bov4zq0cYMhge373QA1b5vgdBWwQxrtgXM=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=M7eZpP6nJRLtNdZOpC9/empbLKiDhjYzCajHTJKOfxEJDvJzt70WFhsizl799a3Mo
 Ot+qATLv1t01DilYsc/VmELNrQ8IYzkFfqM77x2GpBNawueYM1TF17aMxyC+mSbX7A
 BvSIAQ4QcH0OP3UmgbJ8vhb0I+QloWKh3AxI864MBBucX2V+mvCuYty3f2kTOLjV8M
 3n5GWgKgQd9bGMu4LJo7n5TMT3BfdjXcQQCVtlolRA5YkTeGvFcd3AlaquJkOKOGyb
 vz/Uqw3ksWrccpLYRq4MpZirb6JFEUOx5IJZgTWwUYx4YAe5KQdaOOugY1mx/2X6d+
 hO/sH2S+86xrQ==
Received: by mail-lf1-f72.google.com with SMTP id
 i6-20020a056512318600b003fd8c8c2677so2855863lfe.1
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 02:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BJTdenav3Bov4zq0cYMhge373QA1b5vgdBWwQxrtgXM=;
 b=JWqVVD6y+ePUhsWUGxh5g0huGQSW0X8G3Lmd07VVqIDhMV/PvpdM/cSkS0vByXWgPO
 7Y1v826OsKQvYQQ8yqbQlTPy6RFtRWO+y+4yxx5BrAysSgWRAZyuEK10N5jEVZy8pMXd
 uecckw2a48A/xbEEoVVrxjn/Gv6V+plOIo7rHuhMXnd9POpBEQSYBQvz5T0KWpG1pXJI
 PvRJGoPnGvd95VNbvXtOStEtOaaVtB+FiqQfJ4GImRRyK8oz86NLRIzPMEgwuKPjBhFx
 PrxAI+kRWJZAHjbhw01Y9rr/Qu0Yc6SAHHz6B4p7m/WDQCC9Tp91cSZTq5/yo958q6N0
 Azvg==
X-Gm-Message-State: AOAM5314/eoySNjbYRsCmZGQj+kAtNQf8sOt0DRpCOp5hoAmIFugrEzm
 CSpGSB2M9xbl9F/wGK1fE1CDNSTJx0q2xgLdKUf2KBBJoLsKMtEkJ3shosUhJ5SzmyQmKXIU6AS
 m9fhA4e3AZFUCxjF4NHC7M7/h4UwR
X-Received: by 2002:a05:6512:3401:: with SMTP id
 i1mr11382777lfr.336.1634721236371; 
 Wed, 20 Oct 2021 02:13:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOtd1bT/N5geiuvPiX4m9WTzAEgSYTUdpDC6cLv6908vmVY5u/gQekJmUh5Qb29uL9tQDPxA==
X-Received: by 2002:a05:6512:3401:: with SMTP id
 i1mr11382757lfr.336.1634721236104; 
 Wed, 20 Oct 2021 02:13:56 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id
 m20sm144282lfg.176.2021.10.20.02.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Oct 2021 02:13:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: ltp@lists.linux.it
Date: Wed, 20 Oct 2021 11:13:53 +0200
Message-Id: <20211020091353.90731-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] lib: memutils: respect minimum memory watermark
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

Parse the /proc/sys/vm/min_free_kbytes which contains the free
memory level used as minimum watermark (triggering OoM killer).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

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
