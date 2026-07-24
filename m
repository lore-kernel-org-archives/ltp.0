Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45816C531C9
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 09:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784887081; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=QC4CXDaw6E4G17/YN2tzQtw9ZFRUPnJlOEu6fJmTBe0=;
 b=rJLRPLiepwlVbmcG3BX6R8jyryCNB5RehhPUB4nfhlQjamqGXZRMX/oTO2xb9m0AbpBf9
 O6GqUYzWEr58OJnAZbpl+VY6LsrSKDcObur1UGK8yltb2v+od/zWDzv09aickqcZlaYxfNU
 i9gGcWgRoA9JXnMC8Oob1z1lMEzk644=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3D633E557B
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 11:58:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E406D3E1F90
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 11:57:41 +0200 (CEST)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com
 [IPv6:2607:f8b0:4864:20::445])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 16C042009B6
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 11:57:41 +0200 (CEST)
Received: by mail-pf1-x445.google.com with SMTP id
 d2e1a72fcca58-84885a4fcabso346023b3a.3
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784887059; x=1785491859; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LcCIDv8uiiaNwSMqKeVpEaEqGJjZX+pBz1kyJxhhGhw=;
 b=gJNS4Xi+aqGl6qzGf8OcCX0yNJG3Ou9uN2DkkkLjyi+0bO6uG+urjNfAi8AxFdHBFz
 n7fcAdSm8ds3S8Bi3fXu/SnWhfSgYSnt+Uk13xwTsbTLKPZNLFXE9ABF3lKinGSUGVww
 lx02omFCceAGh4o2ZCs8JnJnjANrgFgYAU9+0LoOXCsWQTCF50TwCDm/0cLsmsOx45Rl
 JvfWNnTmy1ILxFKOCokX0sSGPxLSehqHTPNzKTjFJMfJnsKR3NN4n4npS6KqQkBEeGoL
 PX//K/YVH3Q2Z8tMLnasve4Uy8pVLXfbBvxOhum83CF4uHqUQUyscbPC7aMxoc+Uv+tf
 ZrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784887059; x=1785491859;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LcCIDv8uiiaNwSMqKeVpEaEqGJjZX+pBz1kyJxhhGhw=;
 b=DZmna5K0yk0TIfDTGLTq6/VTSW9yTi1NxaIKrIUtKOafJfhW2s+A9dgulOHMsILnfo
 MnSW64opKBbvKVw+ptvF2bIC0cJld7MCp6ZndaWeDTlcAR6T8U9A1ZmAG5O9BTY3GFlx
 NQGtXcPQ2LqiGEaJOL9OD1PypkwuGNkpQLlWVgJDaL4RXTqJeZR3PlFyWXMhNub3UYlT
 koySReQruOqmJQ0kZ7vxmuZTWscj5z/yyUXV/XuAkrVrsM22KdhGvMHFY3wtD+vV0XBN
 6jzvi4fc5kaSM4iJpCUjTd+XALJy2b/CV6Dik+j6jZbd4RTg9iqdcWd2eu9Tz3e1GGkB
 M36g==
X-Gm-Message-State: AOJu0YwqRS9BKitArGFu1SCYA7TJubm61i49ZN2G8d7oqoYNUpWv+tyF
 4ib0Dq05X5dO294GA5vU1BfoZ7Pm1124prJHsqz02Do1/ReEmYUXuPVYCuZyZei5CGjFlLfPc2w
 E1CIoTlkG89XfQocUerplMwtKjtaFYy2c3s1mHVnjWreCBQwOxhNKiUsQDkYtIgbNE2A3ByXkrJ
 HIVu+tVyMTLzdF5UkIEuf3sK+CmQ==
X-Received: from pfbbj14.prod.google.com
 ([2002:a05:6a00:318e:b0:849:636f:386f])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2352:b0:845:e1a3:107e
 with SMTP id d2e1a72fcca58-84e2bb85a5amr7222581b3a.52.1784887058951; Fri, 24
 Jul 2026 02:57:38 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:57:37 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260724095737.3631000-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] listmount04: Detect EBADF behavior dynamically at
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
Cc: wakel@google.com
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
 .../kernel/syscalls/listmount/listmount04.c   | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index 919f4c854..f7343608f 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -153,16 +153,35 @@ static void run(unsigned int n)
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
 		kver = AFTER_6_17_9;
-	else
+		tst_res(TINFO, "Detected kernel with EBADF behavior for invalid mnt_ns_fd");
+	} else if (TST_ERR == EINVAL) {
 		kver = BEFORE_6_17_9;
+		tst_res(TINFO, "Detected kernel with EINVAL behavior for invalid mnt_ns_fd");
+	} else if (TST_ERR == ENOSYS) {
+		tst_brk(TCONF, "listmount() syscall not supported");
+	} else {
+		tst_brk(TBROK | TTERRNO, "Unexpected error during probe");
+	}
 }
 
 static struct tst_test test = {
-- 
2.55.0.487.gaf234c4eb3-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
