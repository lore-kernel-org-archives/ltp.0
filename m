Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED3FCA5FC1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 20:14:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14ED73CC708
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 22:14:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 447B13C6EBE
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 22:14:34 +0200 (CEST)
Received: from mail-ej2-x0d.google.com (mail-ej2-x0d.google.com
 [IPv6:2a00:1450:4864:34::d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B8B9910007AE
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 22:14:33 +0200 (CEST)
Received: by mail-ej2-x0d.google.com with SMTP id
 a640c23a62f3a-c2e027a995eso20746166b.1
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790799273; x=1791404073; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=elP+fgfdelzxa0Qk5KLTzSQ8EZPG8ijhVIrUDE/8HzI=;
 b=I4pdlYy/FQlVRmra7ZC3mBoIdaHZNbRnrCmMkkT/eMA63WllTq/seX9cZyPQBt3hJ6
 8IakPVPdpwkVx9HpaUEMBKUJqwY9O+NGyisCfRmkhaCWLKE/iZN516VxaOXKRunNop7h
 BP6XrdnbWRVT3tp8dWN2uWAzqljOUckPxoT6ts2npYOCzVwljfXB0RzAqHeAVBscAWiH
 5BURA2AqUvEsnAaKfs3ozWxe0O9Qncy7Xb2OZxhuDE1hfo0Al02hl/tGAjxGGCLJV+Lo
 2+vFpkJfQ0E6I6BAlySre9gPhcv9HUbCvPyH9wjTTapnU0MckQsv6ihEkKmSF7m/sXSV
 HfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790799273; x=1791404073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=elP+fgfdelzxa0Qk5KLTzSQ8EZPG8ijhVIrUDE/8HzI=;
 b=ifc452yVxodvmumhN8kNj5g0aEtixRy4j0dg8f2R5d+XgE8ZNUwvijehGL7olr1QKd
 A0IbaGIfVhpsaAOt3wgD/Nz2qoDyV802iDWQHXJS31kvSSnE9Xpw7TF6aKHpdaZOpZuL
 ZZqkS80i0SOE8788li+O+O88HTKfLWBN9xnbUz6VGlNzMMtpinKmrSVG/1N2mO47zs8P
 8WcECzSHXvFkgJttgDk3C0uEuAuAmWmXu3Fjho4P0+3VKe1wyh2zrBaS/a8gUTfTgmZh
 aPBp1oZZ182TOEf29AI5nYWDGy18qJlNvOcfnezchwxYNLbMpoffTWopYxSn9T+EStMA
 t6rA==
X-Gm-Message-State: AFuF++nWLrG7/R+nDREEztq90cwRjPaIIQ1T4eoZ0UtQ3Sr4veUkZE5h
 T6GwLwNpXpEv7lKah9tsEEK9UdCzVdPLUOZ2NyFoid9LhPdbWqS/sX+XR+X7aDuvbdq3F5eB+Vh
 nIqAh
X-Gm-Gg: AYBFou3VuretV5hLw/bAyB6Sm9a+SynynOTEqNJ4QNNRlx6guIPmBeSl6okA+fXnr/B
 +laZJ+TApQ86ANCsSGq01hA4E3AHGqbe9hHUnHJ6Xj06kczn+30hsOOi35uRfhSI8OW3BhGgNmA
 3jE5GJ0JwXdYmyGEE0SO0YfzGin8Pd3BXewDiD6Eje3nCBU/pJRbST4VQw1cYBH/8hbJ8tu1rGB
 ZZkwr8k9EU0Zof8oBumUozIrdhIVrCZJeSJO3t3Q/PVrTwzGHA1jN/IMC/JP7Fq3MVCqiSGOCiO
 dd2kgeCmZ3ZCNEwJDGPGChLUr77FmClfcH1iuYDirFPGNYw3OTOwQspBRqVckZu2vo66G5yj+Y9
 MzqzEgo7axyzH9sI0vFqDSYUpOqzqT1PqibAWNLP8zxlMaLun7O2aD0ucGsTB9z/petKbW/NXK/
 AfMUJJCEYPDrPg1ECAokAqsYxnaRr3WdllL1m7M0jBBL35dIqosC6j/50IiRrSgpSwBT/g0w74l
 3PwDXEKYzQUb6GS1ErSuUIrAXHP7ANoRw==
X-Received: by 2002:a17:907:9703:b0:c25:2fb5:e57c with SMTP id
 a640c23a62f3a-c2e23d7d89bmr230659166b.3.1790799273073; 
 Wed, 30 Sep 2026 13:14:33 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e31ce6499sm52319266b.33.2026.09.30.13.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 13:14:32 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Wed, 30 Sep 2026 22:14:30 +0200
Message-ID: <20260930201430.1924463-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] tst_clone: Fix child detection on sparc
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

On sparc the clone syscall returns the caller's thread id in the child,
not 0. So the child thinks it is the parent.

Compare with tst_gettid() in the clone fallback. clone3 returns 0, but
sparc only has it since v7.0.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
v2 -> v3: use tst_gettid(), the kernel returns the caller's thread id
to the child. And only get it in the clone fallback, as the AI review
suggested.

v1 -> v2: fixed the AI review comments, use tst_getpid() since glibc
before 2.25 caches getpid(), and only check after clone, so the goto
is gone.

 lib/tst_clone.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/tst_clone.c b/lib/tst_clone.c
index 296cd40ac0a0..a04c4042653b 100644
--- a/lib/tst_clone.c
+++ b/lib/tst_clone.c
@@ -35,6 +35,10 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
 
 	flags = args.exit_signal | args.flags;
 
+#ifdef __sparc__
+	pid_t tid = tst_gettid();
+#endif
+
 #ifdef __s390x__
 	pid = syscall(__NR_clone, NULL, flags, args.pidfd, NULL, NULL);
 #else
@@ -44,5 +48,10 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
 	if (pid == -1)
 		return -2;
 
+#ifdef __sparc__
+	if (pid == tid)
+		pid = 0;
+#endif
+
 	return pid;
 }
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
