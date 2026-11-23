Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B40606A321
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=qAkpTFkf;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KIIz7smQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795437438; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=F75Is5mYhtqveJh8qKfIBNFxt1hoAK8HlSWwgMJf4sI=;
 b=qAkpTFkf6yH3nWml/H9H3IIFd0Ywmq3wr1Oyh5gFFnqe09YY5T9/Gi9i9knNuHLQuRvNt
 HTF9Opz3bzNL4I8ayS7rQZHqlEVsYCQNRln5CKdRpSHeFWnOKyaHIusrQNzL+9wy3DB0M4J
 8O+HLJfDXCUDz+NbBl0qOEylYMJcIYU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7461E3E99C0
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 13:37:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FBCE3C5493
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 13:36:59 +0100 (CET)
Received: from mail-pf1-x448.google.com (mail-pf1-x448.google.com
 [IPv6:2607:f8b0:4864:20::448])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 262C61A0089B
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 13:36:59 +0100 (CET)
Received: by mail-pf1-x448.google.com with SMTP id
 d2e1a72fcca58-8b60129a46eso3710367b3a.1
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 04:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795437417; x=1796042217; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GTzAQFPDO5//LobpE6q1+Gh4Ip78uzBSokIOFAKLzIk=;
 b=KIIz7smQ/Csf43F4lBh3Fa/l0dN5MkEhBRjJ3KBWjF23Sd/EbYyUK/yFFLe/76Sy9X
 lThPOIYCyfk5iKtU3xJVzwSFxUAVZ31boFswBg94iI0yppG0ow570a1GkUwUjpkFOShf
 s/oz2vDrGPWWGx5qktNenPebtWMq/iiPyIV9tjJaRKdyFpoMxPQvfn1SRR1aJFO+3F2Q
 VSBWgqq8c2SwTiPAeZxgfGNs08mLRYzOdkBM31OexFg8iB4hCfCp4FzPQ/i+UvNZbU3Z
 Iq3iWmNWmLN2HDbo0ccJ1UUfg9wMCLD8qVrfosEgUFXTlvxhcVv0jQVC7MVNRDRuOP1D
 fGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795437417; x=1796042217;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GTzAQFPDO5//LobpE6q1+Gh4Ip78uzBSokIOFAKLzIk=;
 b=tL9MKGg8Ipt5WxRNVk6+Oyt0D4KfB6D9p1s+aCvYpa4xKM8qblDut2QVLSxX6O5PWM
 c/kSkly063JtvHfLcwj6z701aK5aDwR2Oap0lbafUSxyNUTHojPWhbsxX5xXU9mixZsU
 zfvyjELnJ8+bR6OeANPa0h+wQ86Zk5f1eMFDyHA+M6n0jAeguByEExIQPh21Dbk9Oh2H
 URh7RfKZojZodMFyikDG909Lql9b6g2Y4uiQS4SASGBNVaJR2xbsQpHAh54iOy9gWpMQ
 j30VkU3ZS1oy63q9XoMKO7laAt2lBh9SDcm/U4kDR1ZRtRLT0LTtEoiBMGa7bZXgP96c
 tRMg==
X-Gm-Message-State: APuU4Z+v0eo2mJ+mwwjSZ1VBmigZJ8pY+9TbxKg8Wlrpa2loGXXxM/q0
 gtwMkPsA2qh8xH9/wuvbBpOjaxdduxs4OOy2LXpJBwF5NGDnMVaRCjGwLC/9xtu9l8uReYnTcdN
 ConbhRlqurAQc5Ec0I3bFBfGbMTiPbBl1dDO5qdNalQwauBOS41hq506v0YnNwhZeA5HZ0QpSxC
 K4M0RbqFrYwLdGmuBfKZMuJrsNnw==
X-Received: from pfbdw24.prod.google.com
 ([2002:a05:6a00:3698:b0:8b5:e240:867f])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:94e3:b0:89f:e64f:c34a
 with SMTP id d2e1a72fcca58-8c87ce33aecmr10373597b3a.46.1795437390511; Mon, 23
 Nov 2026 04:36:30 -0800 (PST)
Date: Mon, 23 Nov 2026 12:36:25 +0000
In-Reply-To: <20261123123626.1499705-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261123123626.1499705-1-wakel@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123123626.1499705-2-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tse_swap: Stat target directory instead of "." in
 make_swapfile()
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

make_swapfile() calls safe_statvfs() on "." (the LTP temporary
directory) before resolving the directory where the swapfile will be
created. When the temporary directory resides on a filesystem with a
larger block size than the mounted loop filesystem on mntpoint (for
example, 16KB f2fs tmpdir vs 4KB ext4 loop filesystem), blk_size is
taken from "." instead of the target filesystem. With SWAPFILE_BY_BLKS,
this inflates the requested swapfile size (e.g. 4x on 16KB vs 4KB) and
can falsely trigger TCONF in tst_fs_has_free().

In addition, extracting mnt_path via sscanf("%[^/]") fails for absolute
paths, truncates nested relative paths at the first slash, and returns
the non-existent swapfile name when no slash is present.

Resolve the parent directory of swapfile upfront with safe_dirname() on
a path copy and pass it to both safe_statvfs() and tst_fs_has_free().
Also widen byte-size multiplications to uint64_t to avoid 32-bit
overflow with large block sizes or swapfile sizes.

Fixes: 0f5d8c520d4e ("libswap.c: Check free space with correct mnt path")
Signed-off-by: Wake Liu <wakel@google.com>
---
 libs/swap/tse_swap.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/libs/swap/tse_swap.c b/libs/swap/tse_swap.c
index ae3c19313..21dce8a64 100644
--- a/libs/swap/tse_swap.c
+++ b/libs/swap/tse_swap.c
@@ -144,15 +144,20 @@ int make_swapfile(const char *file, const int lineno,
 	unsigned long blk_size;
 	unsigned int blocks = 0;
 	size_t pg_size = sysconf(_SC_PAGESIZE);
-	char mnt_path[PATH_MAX];
+	char cpy[PATH_MAX];
+	char *mnt_path;
 
-	safe_statvfs(file, lineno, ".", &fs_info);
+	if (snprintf(cpy, sizeof(cpy), "%s", swapfile) >= (int)sizeof(cpy))
+		tst_brk_(file, lineno, TBROK, "Path too long: %s", swapfile);
+
+	mnt_path = safe_dirname(file, lineno, NULL, cpy);
+	safe_statvfs(file, lineno, mnt_path, &fs_info);
 
 	blk_size = fs_info.f_bsize;
 
 	if (method == SWAPFILE_BY_SIZE) {
 		tst_res_(file, lineno, TINFO, "create a swapfile size of %u megabytes (MB)", num);
-		blocks = num * 1024 * 1024 / blk_size;
+		blocks = (uint64_t)num * TST_MB / blk_size;
 	} else if (method == SWAPFILE_BY_BLKS) {
 		blocks = num;
 		tst_res_(file, lineno, TINFO, "create a swapfile with %u block numbers", blocks);
@@ -161,16 +166,14 @@ int make_swapfile(const char *file, const int lineno,
 	}
 
 	/* To guarantee at least one page can be swapped out */
-	if (blk_size * blocks < pg_size) {
+	if ((uint64_t)blk_size * blocks < pg_size) {
 		tst_res_(file, lineno, TWARN, "Swapfile size is less than the system page size. "
 			"Using page size (%lu bytes) instead of block size (%lu bytes).",
 			(unsigned long)pg_size, blk_size);
 		blk_size = pg_size;
 	}
 
-	safe_sscanf(file, lineno, swapfile, "%[^/]", mnt_path);
-
-	if (!tst_fs_has_free(mnt_path, blk_size * blocks, TST_BYTES))
+	if (!tst_fs_has_free(mnt_path, (uint64_t)blk_size * blocks, TST_BYTES))
 		tst_brk_(file, lineno, TCONF, "Insufficient disk space to create swap file");
 
 	/* create file */
-- 
2.56.1.750.gf70dc682cf-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
