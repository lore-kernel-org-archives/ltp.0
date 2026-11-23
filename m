Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFDA606A31A
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=G4Bf7Pg8;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=POlpuOhb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795437257; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/uaTOflpJYwYVHEqnZF3jvYvTDFR4RaORXd5n7gPeCE=;
 b=G4Bf7Pg8dmpBex+li/bity9Z9cexyuhZf+8jZK5dHjg5u8OJmaSf15Wy8zzcjqGv0Sv+/
 juYTvZOc2Lm/NpIr2Zfx3gDKtSgvPwyc6Xv9RYUQeQ+Ir/46suyQA/GcRx2V+akyKTd0Egu
 rpI0uQ50twT6sloVCwDUL43XGfcRSvM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFC1B3C4D7F
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 13:34:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BE173C02AD
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 13:33:57 +0100 (CET)
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com
 [IPv6:2607:f8b0:4864:20::647])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7F6A514001F6
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 13:33:56 +0100 (CET)
Received: by mail-pl1-x647.google.com with SMTP id
 d9443c01a7336-2efa9aea3c0so42139995ad.1
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 04:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795437235; x=1796042035; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zxz1lGgeSFd1ZKfbFKlxYyWg8I06TLGh+0M8htewsa4=;
 b=POlpuOhbmN+Om2X34a0nfY4nGlXxYbenCN3UlaPaO/weX3D81mneiyx7k5xPXJBHC2
 Qfi0PHSmk3C0STnjAziGaJ2ZtPWlwtOANsYCi/gpAgJjimU3JvecvBW0726zGw6blcSq
 9kzqDHbk4O9hgikkjruY6J+QzZ2LDd4fBlU7sK90b12oUksiOPd9DxT7pw25FfRwm5vV
 wa6r488eA8lO1f9XwvQIsqIshgN4+IgjDVw3dwLOoWVyplHWcGqqCNOIWSTM4PHLe3fz
 exykr2iPHWMeocp291ghzqmF+3B/XZgBY2dfSnIvYOUUyeXbC5i/i/1UU2aoaql9Hlti
 KHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795437235; x=1796042035;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zxz1lGgeSFd1ZKfbFKlxYyWg8I06TLGh+0M8htewsa4=;
 b=qzqiFonSHGgse0EYodg/suxsewPjsJDUsjEEYtlu7QyEFweFas7vSBXj0B5EbWhjsQ
 +RZgBEGPnOWta7DETI5C9cw98uZt9tM5oo6+IUm1lua5UFtB+ax6f2+RWqcMOgDJbDZl
 NNbscB78uOj8aX7pMmRG1vXqQyryg/mzRwrOhRlXuQ3+0DBEKKmiVosrpQWyjK+mnA3Y
 e2TJbnWugCaKU0bflAuPrcJpA1rKUYVzBv2ucZgC5Khvrg6XTwFgeUkqyoFfPvS2azWU
 U5MjUaFSnVJwSuZVGn9mAmD7E3mdzHnYRTUNLfLy9zulh0VV8EQm4iv6AhFl8FPIDyrN
 3fGg==
X-Gm-Message-State: APuU4Z+PHtRnLuf5G9OUeJqlZ5sI44QpsK9HcuAhhTuu8Fqtja8DaTf+
 SaoLpjHq+xdjHa02LSWwMCbXwAaw6Xk+ndttEQ+DczE66WKPFrD7PHsI4RstFE2l4RIzzfsy30I
 tyFpF2ExG5TX48rBtgHQGxh/EPlW06bx+giJ7BqpGPecD26u6pON5QCvZKGGlRuKCqGLSwng+tN
 bnaatreiHP0CcjoBDTQoWKCQnTSw==
X-Received: from pgre8.prod.google.com ([2002:a65:6788:0:b0:cdb:5eea:8c6c])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e49:b0:3b4:625:3d2f
 with SMTP id 98e67ed59e1d1-3b41cb212bfmr10037056a91.55.1795437234451; Mon, 23
 Nov 2026 04:33:54 -0800 (PST)
Date: Mon, 23 Nov 2026 12:33:51 +0000
In-Reply-To: <20261119134825.294248-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261119134825.294248-1-wakel@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123123351.1496233-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/tst_test.c: Scale default tmpfs size with
 filesystem block size
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
Cc: Wake Liu <wakel@google.com>, Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When .dev_min_size is not set, limit_tmpfs_mount_size() mounts tmpfs
with a fixed 32MB size limit. Because tmpfs allocates space in whole
filesystem blocks (kernel PAGE_SIZE), 32MB provides 8192 blocks with
4KB pages, but only 2048 blocks with 16KB pages and 512 blocks with
64KB pages.

After commit 3c212bef5d11 ("inode01: Drop redundant 512MB dev_min_size
requirement"), inode01 creates 5460 non-empty files in parallel across
5 workers and fails with ENOSPC on tmpfs when the kernel uses 16KB or
64KB pages.

Query the actual tmpfs block size via memfd_create() and fstatvfs()
(falling back to getpagesize() when unavailable) rather than deriving
it from getpagesize(), as the kernel page size can also differ from the
page size reported to userspace. Scale the default 32MB limit by
MAX(block_size / 4096, 1) to keep a consistent 8192-block budget across
all page configurations.

Fixes: 21c8759f445f ("lib: adjust the tmpfs size according to .dev_min_size and MemAvailable")
Fixes: 3c212bef5d11 ("inode01: Drop redundant 512MB dev_min_size requirement")
Suggested-by: Avinesh Kumar <avinesh.kumar@suse.com>
Signed-off-by: Wake Liu <wakel@google.com>
---
Context: https://lore.kernel.org/ltp/20261117125658.1743505-1-wakel@google.com/

 lib/tst_test.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 10ff73397..957635e02 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1257,6 +1257,31 @@ int tst_creat_unlinked(const char *path, int flags, mode_t mode)
 	return fd;
 }
 
+/*
+ * tmpfs allocates space in filesystem blocks (kernel PAGE_SIZE), which may
+ * exceed 4KB or differ from the page size reported to userspace. Query the
+ * actual tmpfs block size via memfd_create() + fstatvfs() so the default
+ * mount size keeps an 8192-block budget across all page configurations.
+ */
+static unsigned long get_tmpfs_block_size(void)
+{
+	struct statvfs st;
+	int fd = -1;
+
+	if (__NR_memfd_create != __LTP__NR_INVALID_SYSCALL)
+		fd = syscall(__NR_memfd_create, "ltp_tmpfs", 0);
+
+	if (fd >= 0) {
+		int ret = fstatvfs(fd, &st);
+
+		SAFE_CLOSE(fd);
+		if (!ret && st.f_bsize > 0)
+			return st.f_bsize;
+	}
+
+	return getpagesize();
+}
+
 static const char *limit_tmpfs_mount_size(const char *mnt_data,
 		char *buf, size_t buf_size, const char *fs_type)
 {
@@ -1266,7 +1291,7 @@ static const char *limit_tmpfs_mount_size(const char *mnt_data,
 		return mnt_data;
 
 	if (!tst_test->dev_min_size)
-		tmpfs_size = 32;
+		tmpfs_size = 32 * MAX(get_tmpfs_block_size() / 4096, 1UL);
 	else
 		tmpfs_size = tdev.size;
 
-- 
2.56.1.750.gf70dc682cf-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
