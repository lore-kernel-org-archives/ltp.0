Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1745EC43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 01:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783905986; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=euGaNOW+kDc4Ap6DkEbSW9wykT6cc7xMqV7IvVv4DDo=;
 b=eHfnvx5mypr1NE7Q61XfGgDgZxTUr0cK2TkcucgiIgWIGmeYvJsr76uX8iiHo9TFkmTDI
 V1qTQY/kKRamzGbUaMdKfirqzAuMxpgxSz8Ua6unraRJLbDO8k3SBwiHDo8/GsR4hpHrYIN
 hZoblkJYOO9J+W1w1ar9OhxrilguQKc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86CFF3E2C67
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 03:26:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D3BE3E2AAA
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 03:25:50 +0200 (CEST)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 95E79140013E
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 03:25:49 +0200 (CEST)
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2c8018f11fbso41148035ad.3
 for <ltp@lists.linux.it>; Sun, 12 Jul 2026 18:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783905948; x=1784510748; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PxGTJy50nCoFzLpfkZOY+EHnckeo3Tjwi2DpHVnspoo=;
 b=tKWtKEExb81N8jH/Tg0fzqt06Bmh8bs8JpC2FaU5DDxTWp8aBDzd3ot91uJR6Xb0KK
 cMxIR3qnMrfmPyOiydqbB2Ca4fvlUmMwN0iI0eModa5fS1qUL+cXE8dHicEAslExDVH4
 N9eCVLDKEZ+/vOIkqacwOVEKDyKV4KwXKS2Yx5i66cvI7CXvY5oR5kRneToqh/n49Q4L
 O3qDuhXQpPzscGkC64KcxkI9DCczWRu+ebzoehpK1gH1CaKWVY4rcEYmf3GpeJWBdvQi
 dN36AZ72seZA0XenQ6FB1Gi3+ytzGVpa9avBkgmUSDsvfSJPNihQII5sCpLVnqTaxtHu
 nw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783905948; x=1784510748;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PxGTJy50nCoFzLpfkZOY+EHnckeo3Tjwi2DpHVnspoo=;
 b=qmarT00nULWD/5HOGWljVCARAfygdW00CewcMv7xDQRyVez8lN+SVks5Dub9sgEvAM
 391/G1bHufJ/cp6EexJUK6mGIjwhgi+KGmzzN2/j+vV58u74v7JH+FCTD8zhteDdxLk+
 Y4skaf3kWkwXB5niR/v0j5Dzw8sM6NZ3VtwuGXD81Gi5VKOr2gRiQgNpiOlG1CXQ4+ZP
 f4Xu1lmILIBYTitgnQ6al9sfKGLeL+CLTTt6vmGNvNz/PEacfODlyKl5Ee0rLJGt/Mip
 GrFq0rESL1gNurZ129b8Dsk2S+MC4hWeExkz5a7l0AjIFbHnsX50zAVFCxxtMQNAY23M
 xXnA==
X-Gm-Message-State: AOJu0YxVnjokaBmxlQyucrNtrk96A6X4bFoLxQO3Qb8rJYRsmxvbb9zi
 fU+2lh1obWvsu0Snx+JiwWAbA2Ih6v3yJEB5MCsKHtTQHSPj6Db/6lx+1pf/aZ9kMS6TbLOeMPb
 aJpybRfW/4d18OzJv2RbomEoOW7ylw1oHhTF6yWYaGMt8sdQjgDxTIFDsJor1n2+MGBzGtr6iYN
 3jUcG12K9m3sf5FdLsKkODbn1yoQ==
X-Received: from plik8.prod.google.com ([2002:a17:903:3848:b0:2ca:e53d:2412])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc85:b0:2cc:8267:31b5
 with SMTP id d9443c01a7336-2ce9ec12126mr66903915ad.19.1783905947133; Sun, 12
 Jul 2026 18:25:47 -0700 (PDT)
Date: Mon, 13 Jul 2026 01:25:45 +0000
In-Reply-To: <20260710021502.1798161-1-wakel@google.com>
Mime-Version: 1.0
References: <20260710021502.1798161-1-wakel@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713012545.3875573-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] madvise09: Reset cgroup limits before retrying test
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

When madvise09 enters its retry loop, the cgroup limits (memory.max and
memory.swap.max) configured in the previous run remain active. If the
previous run ended due to memory pressure, the inherited limits will
cause the new child to immediately reclaim MADV_FREE pages. This
results in false-positive failures during test verification.

Reset both memory.max and memory.swap.max to "max" at the start of
child() to ensure each retry run begins in an unconstrained cgroup.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/madvise/madvise09.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 87fe096fb..9eb6e82ec 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -146,6 +146,16 @@ static void child(void)
 
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 
+	/*
+	 * Reset cgroup memory limits to default ("max") in case this is a retry run.
+	 * Otherwise, the retried child inherits the strict MEM_LIMIT from the previous
+	 * run, causing MADV_FREE pages to be dropped immediately before we touch them.
+	 */
+	if (SAFE_CG_HAS(tst_cg, "memory.max"))
+		SAFE_CG_PRINT(tst_cg, "memory.max", "max");
+	if (swap_accounting_enabled && SAFE_CG_HAS(tst_cg, "memory.swap.max"))
+		SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
+
 	ptr = SAFE_MMAP(NULL, PAGES * page_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
-- 
2.55.0.795.g602f6c329a-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
