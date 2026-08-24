Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E86C5DF81
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 08:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787561825; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=2R6lPc1KuRNn+7zNbfEyWEEZ+JICFbDeowhSZM35VXs=;
 b=WrAL7OlcRbDooyCcdru6zuSv1EKPxiwZ80h00mect9a755dLnOtsW7tXt53UJRj9BP1fb
 Qp9ugBrBfF2WK2TO9kr1m+FIGfJNlS86iEhp6vcGJ1ssy5WyOyU3pmhqPDPBFf6YsRDzvi1
 LirvCTEvKkhgHMhUXcC2j3TpBlu+Gig=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E7DE3D064E
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 10:57:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 119FE3CFAFA
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 10:56:45 +0200 (CEST)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com
 [IPv6:2607:f8b0:4864:20::646])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4636C14002B4
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 10:56:45 +0200 (CEST)
Received: by mail-pl1-x646.google.com with SMTP id
 d9443c01a7336-2cf7dd9fd91so34205975ad.1
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 01:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787561803; x=1788166603; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xq82idgRKsCPlLI1HjgQSyJXn989c7x4zkNeOq3szmw=;
 b=ONRqfLuz1cEAFnhMgbDayj0I7Dl2O1uHGgYEM2J1bt7SVosv4qyMVZ5GNrpvcXvyvB
 rCGTS37btjogRsso+mutFeQEoA0nMXMBGjWx9hBGsbOVm4ILfAcJrU8dReCekMa2aO4u
 u+VHowctuV5FP1svWVmXBuzhRY+HWTo9B+w8NVngwr8BQqColxuBKocj0X2EMwJTNvDI
 B3m27eJaxL+W1Sr7RsIt5obT78HG96ejhmfgZ6R28edCrT7+pwcDZNmy2BrDz8qa/dkK
 0dwXWaGNfFqSC7S0Nwuiwlkud+pkdpAjJ1Tq4ldrIA/xLNhaoKusIWnEDBtDfA9KePBe
 MmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561803; x=1788166603;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xq82idgRKsCPlLI1HjgQSyJXn989c7x4zkNeOq3szmw=;
 b=k0VPDZScyXQxvtycGZpGOQV+j52qiKMDC5WqPxCBcCTaoYAruA0NRM+qs1RHjwgg5I
 1Eu4Le+uB37rX+sPwa3NIwUuV921UyKBCpAJ5n56PSO8trsW9WwiftWJyX8BNUfILgIP
 Uz+juHXNUK04F4ccYP6e2bF5z4cZUJa/IZmeWyVRCcSPbKC4sBCDbQM/47kZhEFJTkHy
 UW4DO+EtvWreuLA1rQZDUXexwPedaGpk5jGO8Z/qqngIwSRpJHk0gPXhfeaqBEDvZ5US
 wsLcVKOG5Gc6z5JAqQ4dtwqtNPvMHRq5AV6I1RXKGNBzU25U9o4fEP21wnkpNTrD43cR
 vg3Q==
X-Gm-Message-State: AFuF++kk6YU+19jz7eOpV8RtoYS8q4OX/YEwks5XdCNr0G9PicFjYIBI
 Rra3JhL0bwiW2U7yh4/HAHh7cMR0d8hzmf5iU95Ocwj8zJusMqLs/R15kq+8s8y3TydzbbDmsbY
 bEs9eBCihaQSMzP8LN0qVvMUwAsxhsZPm+XDL3AtBWCNujd30+E5g1kTeOeftgJPPqzTnAsTUDE
 0Cql599ci3rnEyjmE8tWScvTeoRA==
X-Received: from plje1.prod.google.com ([2002:a17:902:ed81:b0:2cc:eba0:9e5a])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:354b:b0:2ca:f21a:a6c5
 with SMTP id d9443c01a7336-2d64ada70cemr446384435ad.1.1787561803050; Mon, 24
 Aug 2026 01:56:43 -0700 (PDT)
Date: Mon, 24 Aug 2026 08:56:40 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824085640.3514442-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
 testcases/kernel/fs/inode/inode01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/inode/inode01.c b/testcases/kernel/fs/inode/inode01.c
index d41ff2c62..87ee07612 100644
--- a/testcases/kernel/fs/inode/inode01.c
+++ b/testcases/kernel/fs/inode/inode01.c
@@ -68,7 +68,7 @@ static void create_tree(const struct tcase *tc, const char *parent,
 }
 
 static void record_inode(struct inode_info *inodes, unsigned int idx,
-			 const char *path, ino_t ino)
+			 const char *path, uint64_t ino)
 {
 	inodes[idx].ino = ino;
 	snprintf(inodes[idx].path, sizeof(inodes[idx].path), "%s", path);
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
2.55.0.766.g2966f0265a-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
