Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC05EC43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:16:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 731503E56DC
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:16:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E58C63E56B1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:15:31 +0200 (CEST)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com
 [95.215.58.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7DE516003C1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:15:30 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784024130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=37LcM7WEQ/q+l11w/QiYxV2iT+Cl3ZPSu2uqmTm3lBM=;
 b=xqjt90eNkZFKjjsr03leCkAmpR4oSyPHVQS/0rWFZFq9JxFmb8pfhzt/W7/lhLlBDlh3om
 0dRVBi/PQGOIGeKF3v9XGt6uN39g/7VjRJHL+ZTEZDYu1lipm+J28rew1aE9B/op3aNoTW
 m48oJ+e4h5WPHpm8TTTMkCGkA+xGuic=
From: Gang Yan <gang.yan@linux.dev>
To: ltp@lists.linux.it
Date: Tue, 14 Jul 2026 18:14:52 +0800
Message-ID: <20260714101454.8784-2-gang.yan@linux.dev>
In-Reply-To: <20260714101454.8784-1-gang.yan@linux.dev>
References: <20260714101454.8784-1-gang.yan@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] loongarch.in: add memfd_secret syscall
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
Cc: Gang Yan <yangang@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Gang Yan <yangang@kylinos.cn>

In 209f0c6360da('Update arch(s) syscalls files'), it only removes the
'memfd_secret' for loongarch, so that caused a error based on the old
kernel:

'''
...
accept03.c:47: TFAIL: accept() on memfd secret expected ENOTSOCK: EBADF (9)
tst_fd.c:307: TBROK: close(38) failed: EBADF(9)
'''

This patch put it back, and the output is attached below:

'''
...
tst_fd.c: 262: TCONF: Skipping memfd secret : ENOSYS(38)
'''

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 include/lapi/syscalls/loongarch64.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/lapi/syscalls/loongarch64.in b/include/lapi/syscalls/loongarch64.in
index 5407b86ea..3abc37552 100644
--- a/include/lapi/syscalls/loongarch64.in
+++ b/include/lapi/syscalls/loongarch64.in
@@ -296,6 +296,7 @@ mount_setattr 442
 quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
+memfd_secret 447
 landlock_restrict_self 446
 process_mrelease 448
 futex_waitv 449
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
