Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE918606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 03:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=TKyLNzEy;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fNfHB1it
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793330035; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=B1Pf2qkd2UbHrqJVIqtXalmM03OMT1BwKUrcEPgvY20=;
 b=TKyLNzEyOYXHDs1nwg3m5IZdBHYEqKGE6FCEUvLXEvMVEJLjc5J8eagCggYOnoDsYXWyG
 3EaDzff+MzF65kL4eVOzaqFLkbTypnrFJp7OyPMLqCBgHD6evzKyVXSShtgff+7YF38mNMH
 j6g4XioGXy/FCeQww/gRwukVLI+6E+o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 501873EA3C7
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 04:13:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11DB23D23FD
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 04:13:33 +0100 (CET)
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com
 [IPv6:2607:f8b0:4864:20::547])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6999360096F
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 04:13:33 +0100 (CET)
Received: by mail-pg1-x547.google.com with SMTP id
 41be03b00d2f7-cdac99e77d0so116025a12.0
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 20:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793330012; x=1793934812; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cdMKojXyht4Ccg9qxcYXTLfVv/KoP0cM2ra+II/k58c=;
 b=fNfHB1it9GWuoBQXxo1vbDEco26Tfzsc7b1QY8kZmz9BiAzxy1+unFcCe3zjuSsRDz
 PP262K2yoyw+HcweFtCABRBc2Ky+E+QvvvBVNkoOoKKSrPv+eu8boccC3lPZGf/hJKXj
 Wys0IhSYR3ecAIiz7oKdokKVWpuFlIRK/gM6bwYvNceMxTluV02jNhukVHaVuMYKORP2
 c+8f3OlYZIAzRH9PdXyKXVQJNlu3xjN3+XeDnfKt0aAsNzZDsKRM+NMJiTJuv0phwQbH
 1fEht2quxCPYLkYDYQxIXzWdPf4eNzVle3uxZAfMhN3jrfMMisCY99J06V9JWLN9ajz7
 NYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793330012; x=1793934812;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cdMKojXyht4Ccg9qxcYXTLfVv/KoP0cM2ra+II/k58c=;
 b=E1+GjLplNwe61hXyNkeKjeX8p2XwjClwzIqEvQ8jlN5RS2xJl+GkU+KfWom7MULNYA
 VH/xr+mG9sBn+ykOwEaWMLXoVfAMwK2dnr2qAaVXqkLJ24lyOMK2ECXgYc3cwV9f0/O5
 /wyhszDU2Yf8zB3v4Vjv/hUN6S6oFnjy/mtY0VedeEPKoTC+F6vDWHVe9c4zwNjsPhZ2
 p/MuPaEh/swCSeFCdAKMOeFxtXLAYF5uqkEc1/U0ezyLn8ccyro3hDPggANTXKAtQsBy
 xS5aAhI8ZMi3G8D6fTjQHjF1yEzJSsLOStu0/6kEW6tWCgm8HmZzTsi1psTrfqPIrFw2
 Faxg==
X-Gm-Message-State: AFq9FYJTd38jk51EPPbXyVl8Ou6yvHOLL4j28OHV5bwNRjSub++GAFk6
 PVrUzR0GpbEJ9txfrMRCpMqpnyeRUX4YBL/v/PKabc9E7OB0kkelJZ7x5B3jStnoEVDyzVZVa2c
 B/DivOHAHCAAeOvnSAklORuvw9hGzwB1GV4iT38NQY3MC83WRbCyQnfK6Ux5Nc1ltSo2FVUquzr
 fWNw9KiqI062pGdPxOeGkjDrjyNw==
X-Received: from pfoo8.prod.google.com ([2002:a05:6a00:1a08:b0:890:4d0b:32b0])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6906:b0:3e1:a57c:ab8e
 with SMTP id adf61e73a8af0-3e928d92fbamr1069933637.46.1793330011184; Thu, 29
 Oct 2026 20:13:31 -0700 (PDT)
Date: Fri, 30 Oct 2026 03:13:28 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030031329.354771-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] splice08: Keep calling splice() until all bytes are
 spliced
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

splice() may transfer fewer bytes than requested, but the test fails
as soon as a single call does not splice the whole buffer.

/dev/zero and /dev/full use copy_splice_read(), which limits the
transfer to the number of pages it gets from alloc_pages_bulk(). Since
kernel commit 187ad460b841 ("mm/page_alloc: avoid page allocator
recursion with pagesets.lock held"), the bulk allocator allocates only
one page per call when page_owner is enabled. On kernels booted with
page_owner=on, every request larger than a page is therefore cut to
PAGE_SIZE bytes and the test fails:

  TPASS: splice(...) returned 4096
  TFAIL: Only part 4096 bytes of 5045 were spliced

A short count is valid splice() behavior, not a kernel bug, so keep
calling splice() until the whole buffer is in the pipe and fail only
if it stops making progress before that.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/splice/splice08.c | 27 ++++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/splice/splice08.c b/testcases/kernel/syscalls/splice/splice08.c
index bd635ee7e..2af1c88b6 100644
--- a/testcases/kernel/syscalls/splice/splice08.c
+++ b/testcases/kernel/syscalls/splice/splice08.c
@@ -23,21 +23,30 @@ static void test_splice(unsigned int bytes, int dev_fd)
 {
 	int pipefd[2];
 	char buf[bytes];
-	size_t i;
+	size_t i, spliced = 0;
 	int fail = 0;
 
 	memset(buf, 0xff, sizeof(buf));
 
 	SAFE_PIPE(pipefd);
 
-	TST_EXP_POSITIVE(splice(dev_fd, NULL, pipefd[1], NULL, sizeof(buf), 0));
-
-	if (!TST_PASS)
-		goto ret;
-
-	if ((size_t)TST_RET != sizeof(buf)) {
-		tst_res(TFAIL, "Only part %lu bytes of %u were spliced",
-			TST_RET, bytes);
+	/*
+	 * splice() may transfer less than requested, e.g. with page_owner=on
+	 * copy_splice_read() gets only a single page per call, so keep
+	 * splicing until all bytes are in the pipe.
+	 */
+	do {
+		TST_EXP_POSITIVE(splice(dev_fd, NULL, pipefd[1], NULL,
+					sizeof(buf) - spliced, 0));
+		if (!TST_PASS)
+			goto ret;
+
+		spliced += TST_RET;
+	} while (TST_RET && spliced < sizeof(buf));
+
+	if (spliced != sizeof(buf)) {
+		tst_res(TFAIL, "Only part %zu bytes of %u were spliced",
+			spliced, bytes);
 		goto ret;
 	}
 
-- 
2.56.0.307.g5fe7bd680c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
