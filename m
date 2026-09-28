Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12404CA5FA3
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 21:27:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E83553CD0B3
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 23:27:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 854CC3CC64A
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 23:27:19 +0200 (CEST)
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ECF53200A00
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 23:27:17 +0200 (CEST)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ab02dc629dso456291a12.0
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790630837; x=1791235637; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZMzfP2NuCrrw8ZDftZtyhRMy82/ezyRJm06DuzoWmVQ=;
 b=W0pwVdbXlmiIvzgPERlgngIfWeT2ukT2fRE/60Lw9AcTGCleO00C3TpSLCIivKzn7X
 e2FQYlXaGP5/WnvfPFvUhNM59Jj2SLEQIiPDIlDgGAuguR6wuyqUag0mMMvwWELFolxU
 ut8pwGZ+uShr8mIGHTMAE69hItznEuYSqPBwbFNqEltR+HwK5kq6dLNaNTxykxQKRgfd
 9khIg3oajv0AoufD1W7Kgnzii14QdOOZVnQBw6WZTF1v9gBKyb4eyxf6lc56yNra+954
 +92sw4wudsEkLrRqaVvZyKGehFpZPOQ94tVkouV4ht1u78BRUV8nsUWvrmLNp4J8u1TP
 LSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790630837; x=1791235637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZMzfP2NuCrrw8ZDftZtyhRMy82/ezyRJm06DuzoWmVQ=;
 b=VXBmve/dBS/bOj78gMwHrsA1POXVwhMEpPSIuLyik/HMAqEs0pyeQn2cE7W3COhhaB
 LRWD7VeuFH4jG/tf1nUf+ZoVhVf8XZGYZVVYP6XSkiYznSstKtkKGSB3olrP1a7Htm8U
 +WJQ07xn3vBsz9A8qQdvgMLuqNX8j74RPLFooCourl9DWNnAJrPcTPImMQBsWXwojHnc
 nNM+6rbH8HXmfrt1xZOvCw21wGYH3b7VE1RKjSsKbmMd5mDlaZ6wntHwB2jYynQeq6uQ
 eba9VcyHAmK6HN3PcnhJO2YKeEcH1Vv96VrCR3+fLKinBmEKlsHVFV7D5a3OzLiDmuUA
 GOyA==
X-Gm-Message-State: AFq9FYLF17oor5H279x3MMAk8has7AK3yPBOn4NwK+JNh8bFEg8+dDx3
 PGhrPeka6utZcWNUIzjYAS0DxCfWWFmPgG1lfIf39/vDhsdCo7ZTM1evrH8tanzJaX1tTUoFldB
 TiYCN
X-Gm-Gg: AYBFou0g8MOqrf93GbWLjaUVSIlFcfPP64RpCmK2talSCeRDiMkQ8dk3CMYIqJ0tFxm
 uSAbv9cZIaYWeFCb0lQHcrlU468b6M+2mYNg6B5Z3LpGjr7gleEv4MhKLmNZqy0+L88+WUJQMOe
 cafCFDWJKX9rTYPMk7jnnLs4H0rq+Z6a2f3KaJ7s1EqqA4heNz/1ggdcvW1FlAjO7zamcWd3OTS
 kTVM8Mdai3WIKZ5fF8jNAeRyTG7eBynYrUh/ZyBc7Qy8V2Yn4Z11TLG3h3Xw2UD28CuPLaFSO2r
 Q3tQEFRDT7xWeOjyn8mFJKLdPeNOe0bMageKLFmzr+yokNjL11CfnnOldosmPKukhn4cUSUjjY9
 byIBYdwU7Hru3xxixM1Px85jPRvaUlyqwWWa4coCgPljZLe3i+dihWWSC84Z+BJDWamJFaI7Kbq
 QBizmC2iqIcBZhEZ+SxX/iRTQMH9fKxx3PCy82SbiqfCOMDWDYSrvJ8cwTWOuQpGqwtbhHYuWV7
 Ifv7euE8HJuyHMc83s94kZrEciDGBtylg==
X-Received: by 2002:a05:6402:50c6:b0:6aa:f240:241 with SMTP id
 4fb4d7f45d1cf-6aaf24004c5mr8116509a12.0.1790630837024; 
 Mon, 28 Sep 2026 14:27:17 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aae5cb98dfsm4557698a12.6.2026.09.28.14.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 14:27:16 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it
Date: Mon, 28 Sep 2026 23:27:13 +0200
Message-ID: <20260928212713.2832800-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_clone: Fix child detection on sparc
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On sparc the clone syscall does not return 0 in the child. It returns
the parent pid, so the child thinks it is the parent.

Save the pid before the clone and compare it after.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/tst_clone.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/tst_clone.c b/lib/tst_clone.c
index 296cd40ac0a0..2fdd9e163717 100644
--- a/lib/tst_clone.c
+++ b/lib/tst_clone.c
@@ -20,6 +20,9 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
 	};
 	int flags;
 	pid_t pid = -1;
+#ifdef __sparc__
+	pid_t parent_pid = getpid();
+#endif
 
 	tst_flush();
 
@@ -31,7 +34,7 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
 		return -1;
 
 	if (pid != -1)
-		return pid;
+		goto out;
 
 	flags = args.exit_signal | args.flags;
 
@@ -44,5 +47,11 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
 	if (pid == -1)
 		return -2;
 
+out:
+#ifdef __sparc__
+	if (getpid() != parent_pid)
+		pid = 0;
+#endif
+
 	return pid;
 }
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
