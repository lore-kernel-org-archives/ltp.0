Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2E3C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787917285; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=gURUzIf0IUY/JOkVP9DKCFUYzIfKRuxglAiyoc+rQwo=;
 b=rfiLRAR5HLx1DQbEBwaGosl+h9DKVGY715yOsPsnTy5FepOIeFYFk/5KoDERghDHc6x8I
 vHtjK5ujIii3tIePZ4SIH5j9wpJj3HsH/HCWQgWtzgCmq4wjggl3AAeBWU+1vgQMWqW2Pkq
 HTkC2BcTiiGo2LprzAXofuoQjxX500Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98AE13E5DFE
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:41:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 289543C2861
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:41:04 +0200 (CEST)
Received: from mail-pg1-x545.google.com (mail-pg1-x545.google.com
 [IPv6:2607:f8b0:4864:20::545])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6771110001A7
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:41:04 +0200 (CEST)
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so1630656a12.0
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 04:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787917263; x=1788522063; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RioV8OHLcfRpu/YZZU4AMVz5kOYPND6LC1d5GDcM04I=;
 b=i0Pr5Cr3oiGV/wSTo8kceiKgeXWwjpnK9YPQC387EEotznRNcinQRYFZdXUrxenKr4
 uQCM9JATRii1Frp2vEOUfht10hUk/OJAXGIOi+Dna/bCDvbhgSmejlSlN7dGpIQ5ArtX
 Dz8nfzBcsj6GjMTTGkP7GDZqwevBtu79hWPPzH9zit+sQzMoPqomQId5NmCokdmGOY3z
 p0sRjBVlHIxUoh9sbgL2YnlvknmbqTXcwsSz7lsNZ8G/su46rEwI5ZiV1PKelex9KnI7
 wALDOYdrYTjes781kngxkuTSqCdnRkDn9fZnkjw8u0ZkSG8eCPrXX6gY+lQzGHCb2mQs
 V6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917263; x=1788522063;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RioV8OHLcfRpu/YZZU4AMVz5kOYPND6LC1d5GDcM04I=;
 b=gDGWsIQLIrk2AC9irWaBoOS9++EBqNXbkOckzv+gcSFFh4MkqHza+k95OoHd+7t5X1
 0ujrJLE1+oRemgsSo5YDu0FWjKmIiOApEr6pugfJUJLqJK75TlVGTV0hthJPfIU4q3oY
 7NZw7aF1/NRJTg1SeeVGJSybox6oNuGIryHfaNIGKP6mk8sQMQxbq2fg3QXiIoLxd1PK
 uR8lGf9l5fGLXJjNAN1yQLrzrtJ1DMhT5RRMCS9Fjzadk977iAtwPeY5mgaLJUKLeNkh
 m/BHfrB934tA42bQIlGoCvc4V2EjQKxdb62T6DNe4VgBLHg2AbIKo+fl3DTXpHWK2Gc1
 2gdQ==
X-Gm-Message-State: AFuF++k2YdQ5WxHsBMGa4n7FDj4dYCq2iCsGgvHODR4V49hAkM/SdSCq
 dMhY0h93b5LtJSdGYBYvU7+F4q08dp4aNADWBnEtcdMCK6eZoo7KKm7RghUPCyDBi2ZEfRlZbvS
 nnQ/rbtEw9g2t+Dzcvt3xiaJ4htpDRwGe8Ehi3U34WuG7wZzqS6AlDSMkarDb1iuVYnTHpCtEOL
 DX2wRfuTfNXSQYO2zMf55uZCdJbA==
X-Received: from pgam10.prod.google.com ([2002:a05:6a02:2b4a:b0:cc1:b85e:b029])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a25:b0:3d0:88f5:f806
 with SMTP id adf61e73a8af0-3d268eff056mr11415852637.15.1787917262360; Fri, 28
 Aug 2026 04:41:02 -0700 (PDT)
Date: Fri, 28 Aug 2026 11:41:00 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828114100.2356329-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] inode01: Increase dev_min_size to prevent ENOSPC on
 exfat
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The parallel scenario concurrently spawns multiple workers (default 5),
each creating 2,185 files and directories, totaling 10,925 objects.

On exfat, each file and directory occupies at least one cluster (default
32 KB for volumes > 256 MB), which requires ~350 MB of data clusters.
With filesystem metadata (FAT, allocation bitmap, upcase table),
directory growth, boundary alignment, and multi-worker concurrent
allocation fragmentation, the current 512 MB device size is easily
exhausted, leading to ENOSPC failures during write() or mkdir():

  inode01.c:61: TBROK: write(3,...) failed: ENOSPC (28)
  inode01.c:64: TBROK: mkdir(...) failed: ENOSPC (28)

Increase dev_min_size to 1024 MB to provide sufficient headroom for the
parallel scenario on exfat.

Fixes: ecf418722780 ("inode01: increase dev_min_size to fit the peak usage in parallel scenario")
Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/fs/inode/inode01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/inode/inode01.c b/testcases/kernel/fs/inode/inode01.c
index 50b5311a4..87ee07612 100644
--- a/testcases/kernel/fs/inode/inode01.c
+++ b/testcases/kernel/fs/inode/inode01.c
@@ -256,7 +256,7 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.all_filesystems = 1,
 	.needs_root = 1,
-	.dev_min_size = 512,
+	.dev_min_size = 1024,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.timeout = 300,
-- 
2.55.0.897.gb25b4bd76c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
