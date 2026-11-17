Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4E606A330
	for <ltp@archiver.kernel.org>; Tue, 17 Nov 2026 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=ZSdg8fQK;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bECF/Po2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794920246; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=k6oPOQlqH6eLTb2krt+56+xNSXawwtbDzeKHWp8UskY=;
 b=ZSdg8fQKjgkkj6fZsk4gbz4MzizAjeCzCQa7Senz+HD9Tc04LFzJxlCn9QAeuunI/OBtp
 QEaASsoVugankycdQtUiCyYsrWGtR2qMcECvuZEvU5pNuL8c1sdr4k9Vqu8b6ADau8vtPkQ
 RlLSknps7xACcK4XPI/UiN02ezKeL/0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 748283EB407
	for <ltp@archiver.kernel.org>; Tue, 17 Nov 2026 13:57:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC8BB3EB3FC
 for <ltp@lists.linux.it>; Tue, 17 Nov 2026 13:57:03 +0100 (CET)
Received: from mail-pj1-x1046.google.com (mail-pj1-x1046.google.com
 [IPv6:2607:f8b0:4864:20::1046])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5DFBC1400187
 for <ltp@lists.linux.it>; Tue, 17 Nov 2026 13:57:03 +0100 (CET)
Received: by mail-pj1-x1046.google.com with SMTP id
 98e67ed59e1d1-3b3b74351a4so630457a91.2
 for <ltp@lists.linux.it>; Tue, 17 Nov 2026 04:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794920221; x=1795525021; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wQE6Csu0jolakXIEYbIEhQ31w7U3TRhd0ls2JueNpOA=;
 b=bECF/Po2ZZNkgYzPo5y6Z+Uy9tvjYx1qcLV+YVtQLv2N3xn/blcnuNvv2D4ZtqTcER
 JQwEAv1KrRxcgLdQQseU7On+SL5ONppk76rHzBtLPKv9rP94OeG4RnTwdOCTFLmBLM/O
 AauzLRkziUZpr6coQJ2+mOnVkBXChg/RuLkh7SzCC84GRapJd0oM0/oZ1dsDkHT8jvrU
 HPewaJaPkKA3X+csi/qkbFj1Ke+vcpkXdFjR4p14SRWdw16QhoHvjtgezjkJ4fwE3Rf+
 NfRVyZO1U0utMam+/CfNyJhw+9ThY1cR8stmc6gKmW9RG9faDqOHOnURgVW8Qozy3E+x
 mGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794920221; x=1795525021;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wQE6Csu0jolakXIEYbIEhQ31w7U3TRhd0ls2JueNpOA=;
 b=L/pZ7e9N9oedz0GkqPII1S/n43/iBdmH1mf2rgvfzXBiQt8Au1v8lSmu8YIrqIQe0k
 y7eC5vnz1dPdeKux7H3273wzWNTJRH6oFHCS89cy5gTwxPQTfj2HrKLorsBno1Iq67fj
 ojcp0bsEbbHAIgPIZ5zHAvWHwGnfepr7C3e7mIBBWTw6oX/gghya99mREy3RvjKIh1wG
 LDhrftQZxltaSfd0H5xLHFbzUkpgT1/5kl60ChY6HkMnvWbrpEvEBFVM4e1Xs0PUm+JJ
 fNcjtExdYNfoEfUsFUF1OweUmacRB6+qBfjZpjhQc87Y/sjVD8DwYlU33xzCSrMYRY3Q
 Mfjg==
X-Gm-Message-State: APuU4Z+B761nKnKtiPDQLY5M4LJKCRw1vz4fMJKaiiepDNDL2JUZTQcu
 +D+YHv30KzWaGttgk71LD9LYo0IyEE/yn/n20mbjE2UeNxtaK2XDRG7xDp5HKgyMvG+67+64gR1
 mFeYgeDLtSQfhoNuKr3x2Mk9TORQi0IYIAldTcJJLCZxrTLK5EfgF4fpiw9zywLNtmqa/yIGbmC
 mSS7U3kJzmr1fRWPGABjA0kViWIA==
X-Received: from pjrz15.prod.google.com ([2002:a17:90a:bd8f:b0:3b1:adbc:2757])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4f82:b0:3a4:f8da:2478
 with SMTP id 98e67ed59e1d1-3b1b09fd889mr14347265a91.29.1794920221110; Tue, 17
 Nov 2026 04:57:01 -0800 (PST)
Date: Tue, 17 Nov 2026 12:56:58 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117125658.1743505-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] inode01: Drop redundant 512MB dev_min_size requirement
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

Commit ecf418722780 ("inode01: increase dev_min_size to fit the peak
usage in parallel scenario") raised dev_min_size from the default 300MB
to 512MB because mkfs.exfat defaulted to a 32KB cluster size on volumes
larger than 256MB, providing only ~9,600 clusters on a 300MB device for
the ~10,925 objects created across the 5 parallel workers.

Subsequently, commit 4bf4da8c6fda ("inode01: Configure 4KB cluster size
on exfat to prevent ENOSPC") explicitly configured mkfs.exfat with a 4KB
cluster size (-c 4K). With 4KB clusters, the 10,925 objects consume
under 50MB at peak, and the default 300MB loop device provides ~76,800
clusters on exfat, which is more than sufficient for all supported
filesystems.

Drop the redundant .dev_min_size = 512 setting so inode01 uses the
default 300MB device size and avoids unnecessary ENOSPC failures when
allocating the loop backing file on storage-constrained systems.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/fs/inode/inode01.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/fs/inode/inode01.c b/testcases/kernel/fs/inode/inode01.c
index e7190fc99..09e0e9da0 100644
--- a/testcases/kernel/fs/inode/inode01.c
+++ b/testcases/kernel/fs/inode/inode01.c
@@ -260,7 +260,6 @@ static struct tst_test test = {
 		{}
 	},
 	.needs_root = 1,
-	.dev_min_size = 512,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.timeout = 300,
-- 
2.56.0.679.gc527c65306-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
