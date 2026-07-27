Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9031C53219
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 12:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785154315; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fcgrxkicK9MD2qMVEa2cbPj+IHHTKHMdS2d8MhOaBlc=;
 b=N4cFuh462LSMBqyxkSUEA5cs6EOqC3mTvhuWr7kxn4JDFh7jZiOybY+vUJaygrT7eqBfC
 tCm6GOciFlZxLe0+0At6nqjZlmwK2NruklkIhdQqofP9Gv3RLJlGufH+qVBQHWbQnwE4PPA
 Y/+fFhrjHOYl5hVaCcKY7XA3c6gEQNM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9465C3E5433
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 14:11:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 077AE3E5278
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 14:11:34 +0200 (CEST)
Received: from mail-pj1-x1046.google.com (mail-pj1-x1046.google.com
 [IPv6:2607:f8b0:4864:20::1046])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 699BC100076A
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 14:11:34 +0200 (CEST)
Received: by mail-pj1-x1046.google.com with SMTP id
 98e67ed59e1d1-38e11baa66eso2883679a91.2
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785154293; x=1785759093; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hWVhJZHE2vQuDXxVWEAl8WGZbbU5PzzVNKxeNfkPoQs=;
 b=aSGhg5w0cPsnUCvCtFxLgvdtWFJjlOSUCN4Fy/V6QG1eBlL/bG6FJXZJs1YsaQmpP/
 wbTDwyhHo6mBclLbOU41JAI/TIe9iFuTPoZsViRgeVTX+qIGvZokyPkq16LtaBuBnGBQ
 c7vm8WWYEB7xvgZ26iOiB+bi5HV4DUtZW+ZBm0dPGH1m4PHhc305Hm2plt+yo4IDQhk0
 tV/b0npHSlwchU+DCPQwpcLXJuv8Ui6GNEbewbqWEsu9fXgoi1zbpUJfdsoXj+gilYkb
 DIfNgvu7xoQO7CLSonsK3UJ97tBRyBxw1/9PZhFQvXGdjEXVev2yzJGgBpPGUQL7P35P
 mq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785154293; x=1785759093;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hWVhJZHE2vQuDXxVWEAl8WGZbbU5PzzVNKxeNfkPoQs=;
 b=B0fb5bgzUUEX/SudECQSwPrMRmczbRJuZ3neKusfgAfMt1lgvOzxFOrIRAs7611cEM
 B4DHVF7YPRvrNlq8BP6ejRZQxrGxVxfC9ITkpx8bGTBQfDc6vIvUXM7AGvZn90PuYiFA
 S0Cg1XsZMUPvlrYSjkeXQXWJmgoSbdnzC/XfoxsRvp4mFebL9indAmVokFGpUyO9m+c8
 q1HyMotwCXccAuSyqyvLs/8SjR09GzCp0SsEIraqTEazJCv0uE5er6k6WWJPV8mYMMuQ
 Sou2GTzs05eBFQc3gqfga6TOQxHMHGl9qP0b9jlJmhQTlJjumhTecrblyWawALn4E5Tl
 o4Vw==
X-Gm-Message-State: AOJu0YzEXnNvv8HzbB7kM3Coca5ap0MlD8cfThj4ZIg6eySIsHQsfTlq
 XjXWphLXu8oQjh0EKTzZYPOAWuxsnoxZa4cHG3kpW6v00XO3rgyfeeKBE5mURMC08cR6+uHFRWK
 Y4w==
X-Received: from pjbne14.prod.google.com ([2002:a17:90b:374e:b0:381:8e2:3f55])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b8e:b0:38e:2a4:cffc
 with SMTP id 98e67ed59e1d1-38f2961561dmr8359084a91.25.1785154292552; Mon, 27
 Jul 2026 05:11:32 -0700 (PDT)
Date: Mon, 27 Jul 2026 12:11:30 +0000
In-Reply-To: <20260724121114.GB983347@pevik>
Mime-Version: 1.0
References: <20260724121114.GB983347@pevik>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260727121130.1294997-1-wakel@google.com>
To: pvorel@suse.cz
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] listmount04: Detect EBADF behavior dynamically at
 runtime
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
Cc: wakel@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Upstream commit 78f0e33cd6c9 ("fs/namespace: correctly handle errors
returned by grab_requested_mnt_ns") changed the errno from EINVAL to
EBADF when an invalid mount namespace file descriptor is passed to
listmount(). This change has been backported to various stable kernels
(e.g., 6.12.59 LTS).

Instead of hardcoding version checks for every stable backport, probe
the behavior dynamically in setup() by calling listmount() with an
invalid fd (-1) and checking the returned errno.

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../kernel/syscalls/listmount/listmount04.c   | 40 ++++++++++++++-----
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index 919f4c854..561386cb4 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -23,10 +23,11 @@
 #define MNT_SIZE 32
 /*
  * For commit 78f0e33cd6c9 ("fs/namespace: correctly handle errors returned
- * by grab_requested_mnt_ns") from v6.18-rc7 backported to v6.17.9.
+ * by grab_requested_mnt_ns") from v6.18-rc7. Note that this change was
+ * backported to stable kernels (e.g. v6.17.9, v6.12.59).
  */
-#define BEFORE_6_17_9 1
-#define AFTER_6_17_9 2
+#define BEFORE_6_18 1
+#define AFTER_6_18 2
 
 static mnt_id_req *request;
 static uint64_t mnt_ids[MNT_SIZE];
@@ -89,7 +90,7 @@ static struct tcase {
 		.nr_mnt_ids = MNT_SIZE,
 		.exp_errno = EINVAL,
 		.msg = "invalid mnt_id_req.spare",
-		.kver = BEFORE_6_17_9,
+		.kver = BEFORE_6_18,
 	},
 	{
 		.req_usage = 1,
@@ -100,7 +101,7 @@ static struct tcase {
 		.nr_mnt_ids = MNT_SIZE,
 		.exp_errno = EBADF,
 		.msg = "invalid mnt_id_req.mnt_ns_fd",
-		.kver = AFTER_6_17_9,
+		.kver = AFTER_6_18,
 	},
 	{
 		.req_usage = 1,
@@ -153,16 +154,33 @@ static void run(unsigned int n)
 	}
 
 	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
-		tc->nr_mnt_ids, tc->flags), tc->exp_errno,
-		"%s", tc->msg);
+				 tc->nr_mnt_ids, tc->flags),
+		     tc->exp_errno,
+		     "%s", tc->msg);
 }
 
 static void setup(void)
 {
-	if (tst_kvercmp(6, 17, 9) >= 0)
-		kver = AFTER_6_17_9;
-	else
-		kver = BEFORE_6_17_9;
+	mnt_id_req req = {
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = LSMT_ROOT,
+		.mnt_ns_fd = -1,
+	};
+	uint64_t ids[MNT_SIZE];
+
+	TEST(tst_syscall(__NR_listmount, &req, ids, MNT_SIZE, 0));
+	if (TST_RET >= 0)
+		tst_brk(TBROK, "listmount() succeeded unexpectedly with invalid fd");
+
+	if (TST_ERR == EBADF) {
+		kver = AFTER_6_18;
+		tst_res(TINFO, "Detected kernel with EBADF behavior for invalid mnt_ns_fd");
+	} else if (TST_ERR == EINVAL) {
+		kver = BEFORE_6_18;
+		tst_res(TINFO, "Detected kernel with EINVAL behavior for invalid mnt_ns_fd");
+	} else {
+		tst_brk(TBROK | TTERRNO, "Unexpected error during probe");
+	}
 }
 
 static struct tst_test test = {
-- 
2.55.0.487.gaf234c4eb3-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
