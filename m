Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CFE606A325
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=FPVsA3qM;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lD71G6mK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794309685; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=NJgeQJv0NdK5bw69b53RrtArS60MiAeiqaUDz1W5rqE=;
 b=FPVsA3qM1GYOz2fgxhosjfktvnL6RBurtlbGhTGX2i2N0aCgqdsdPR0Dhtjk7aILGMXEa
 wGmfJ5BGUhzSAN1T2Uf8+1KJhu/5e4EKRBPwZsJUt8IgV9mSvgJUUrnFKKKdBPe6cgx2X2V
 3WqmKSvNugZVIkVn8lFqt+4ArJUMx+8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F2813EA142
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 12:21:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B8003E2687
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 12:21:05 +0100 (CET)
Received: from mail-pj1-x1045.google.com (mail-pj1-x1045.google.com
 [IPv6:2607:f8b0:4864:20::1045])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 770F11400995
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 12:21:05 +0100 (CET)
Received: by mail-pj1-x1045.google.com with SMTP id
 98e67ed59e1d1-3ad91787a1aso1440987a91.1
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 03:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794309664; x=1794914464; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w2PLfnCEJ1ZMii/DTxy8eQcTK/q6mCGAhV2U6/D/brQ=;
 b=lD71G6mKp4O2rpHCxSLJ0puvhf33jbheOvHOpV6BabMHNHT2txtDqQ6txEtbq1yd2Y
 8tT8TgXpmKNdb86r9ki+ZUesfcynlFhb41Yp8n4Tyr0s0s5skIMY4Jwuusb5ArWmZ7vf
 6bbxuql8c3CwXPLlzDBqFLy+f8Mg1hmePvW7aN1LprjxHMrT5i1LQGBjxCy5YszPbizo
 EzyND6zC21VMb8+E3KoyQzkdrxIiVcaHY2CnEIEvzeB2DE1aR6pr2BgE5Gwia2/IXUvm
 rWKQWptSFyDjsgORsN6NbAFz2FUeig/p59ORS3e6l4YHpF1bZCAUvgwUakp6X/24iLqG
 tV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794309664; x=1794914464;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w2PLfnCEJ1ZMii/DTxy8eQcTK/q6mCGAhV2U6/D/brQ=;
 b=fphW2fQCj10AA+ydT3B/q0yiE4+tbg9uHJYyLGQyGYqFZIlH/6/1vqYNfggA0EUnKf
 Kr0VVeIucANZOXOHSmzKVF30jNXy5M670UEZHqHI4k7JQH1gsowV7OmraPk9aQawOKSj
 lREX8jhHTwebqy6rb+OeWKeywnEA1+TRWcnK718tAFaI5yW4uwjFC280ttQc7hLvqOb6
 8/SxIsqeTW59eQu1wvlsQOdLkxXiI/t5uGAKUyz7YQUY/Cx0Wrg2xq1LtKjSbc4gSPHj
 T/6IgqPZ3i4jKAruuvYJ2XYmqI1gRjN4llW3JQVo0KL3CisDNZ30AWNSYrEqnIByq9nv
 QghQ==
X-Gm-Message-State: APuU4Z8haX3Z72K0JKTcXOHd56onRIY+5kXORt0zSjmmeBVtAJznGJV+
 6fYr5wuyBYhAg8DwtLQi1on/V5myj5tfa+3DOiD/ZQmFbp7E+W4+q6uBFekQG/hTBAtPDd7KccS
 TpmanogWEG8GcRjl5P6nghbDqYJyEQ/QTJpxVyV+cd2o+E6mdShUyBzg5OoA8jiGvN5r/E/qRHj
 Pt/0dczEP1uPjBg/D6z8CfsAnEpg==
X-Received: from pjbbw20.prod.google.com ([2002:a17:90a:f614:b0:3b0:9569:4e9a])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:ec8c:b0:3ac:6e91:3f22
 with SMTP id 98e67ed59e1d1-3b166d273ddmr1909221a91.52.1794309663202; Tue, 10
 Nov 2026 03:21:03 -0800 (PST)
Date: Tue, 10 Nov 2026 11:21:00 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110112100.1594353-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tse_swap: Fill swapfile with zeroes on exFAT
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
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
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since commit bf1797960c20 ("exfat: add fallocate
FALLOC_FL_ALLOCATE_RANGE support") in v7.1, fallocate() succeeds on
exFAT. It only allocates clusters and leaves the valid data length
(VDL) unchanged, so tst_prealloc_size_fd() no longer falls back to
writing zeroes and the swapfile is left unwritten beyond the header
written by mkswap.

Since exFAT was converted to iomap in v7.2, swapon() maps the file via
iomap_swapfile_activate(), which queries the mapping with IOMAP_REPORT.
exFAT reports the range beyond the VDL as IOMAP_HOLE, so swapon()
rejects the file as having unallocated extents, and swapon01-03 and
swapoff01-02 fail on exFAT with:

  tse_swap.c:228: TFAIL: swapon() on exfat failed: EINVAL (22)

This matches swapon(8), which notes that files preallocated with
fallocate(1) may be interpreted as files with holes depending on the
filesystem, and that writing the file with zeroes is the most portable
way to create a swap file.

Fill the swapfile with zeroes on exFAT, as is already done for old
XFS, so that the whole file is written before mkswap and swapon().

Signed-off-by: Wake Liu <wakel@google.com>
---
 libs/swap/tse_swap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/libs/swap/tse_swap.c b/libs/swap/tse_swap.c
index ae3c19313..1e40d0d62 100644
--- a/libs/swap/tse_swap.c
+++ b/libs/swap/tse_swap.c
@@ -145,6 +145,7 @@ int make_swapfile(const char *file, const int lineno,
 	unsigned int blocks = 0;
 	size_t pg_size = sysconf(_SC_PAGESIZE);
 	char mnt_path[PATH_MAX];
+	long fs_type;
 
 	safe_statvfs(file, lineno, ".", &fs_info);
 
@@ -177,8 +178,12 @@ int make_swapfile(const char *file, const int lineno,
 	if (prealloc_contiguous_file(swapfile, blk_size, blocks) != 0)
 		tst_brk_(file, lineno, TBROK, "Failed to create swapfile");
 
-	/* Fill the file if needed (specific to old xfs filesystems) */
-	if (tst_fs_type(swapfile) == TST_XFS_MAGIC) {
+	/*
+	 * Fill the file if needed: swapon() rejects preallocated but
+	 * unwritten blocks on old XFS and on exFAT.
+	 */
+	fs_type = tst_fs_type(swapfile);
+	if (fs_type == TST_XFS_MAGIC || fs_type == TST_EXFAT_MAGIC) {
 		if (tst_fill_file(swapfile, 0, blk_size, blocks) != 0)
 			tst_brk_(file, lineno, TBROK, "Failed to fill swapfile");
 	}
-- 
2.56.0.506.g506a7eabc5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
