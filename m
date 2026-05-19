Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46139CD4F54
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 06:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779173907; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=GsEMQPqNbxhAYQYElQNFX+heZYTJFKf7fy4vpZYb5kc=;
 b=PZRF4H8WDaGfwcv6La495PTSXqzH8ZdEkXQ8iapWfQxewcTxwCxflwIyBpdRLwNYQQXAN
 IgFNu2ZugeKqklUJDyRmHrkHJ9Ok9yRjKcbT801E/F3BKPHbhPd/Dwn0p4qNtg5c+I9KPeP
 D+3QyDQzPmIbe9r1oo0rgTUlsKh/WaM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7962F3C5E4B
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 08:58:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9ACD93C1C3B
 for <ltp@lists.linux.it>; Tue, 19 May 2026 08:58:04 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D12601400B80
 for <ltp@lists.linux.it>; Tue, 19 May 2026 08:58:03 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso1858694f8f.3
 for <ltp@lists.linux.it>; Mon, 18 May 2026 23:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779173883; x=1779778683; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=esL3BdmoZzr0LhSigYfF++WvJGkwg2ywMlz96Usdbd4=;
 b=N8lklMRvJ78ypn4/4CRW9B75elgNnFPlEyJLzEpc15gRy/VuSmSJsD35PIhIOS0rS7
 DeRccTcgW5dczofTzwYdaXl0I1/kD8T7c7RDEv06Ywire1di9JtFw0rtM9YlF2jDqEW9
 caRoIl0ZomUu5rusLTjC7TxI/r7HVCloXGe6W6m8gSPxafqqkuH5JJBHZiQ0NJ2IXq+S
 s/BPfO9HoSF747bDe8nBcIw84Unm+YIxQo1Qfsxph9WtrsVWsC1jtJZ25/co43yMOs/x
 A8kXOXRT6AotVYtuMoOge89Aex/Lzc6mHHRhxcZcE1I+aqtcmJy3x+Hdqj2wSc0fDEQs
 PyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779173883; x=1779778683;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esL3BdmoZzr0LhSigYfF++WvJGkwg2ywMlz96Usdbd4=;
 b=eBxtYIgK2ZkxiVOy8wy6yY78nlgCRq5vqV38ALan/5DW7yQzY3wKDbDobaYdrAcfBE
 ldOErWqiriI5rKWmtSUAHgPc6asiy+H3u9uj7xXRatENvHQn0Bx3dvCzVYK75AZjR929
 FCQaLz9hp6OVifOJ4hBwzqJGDPwOxpxlnVzNahI2ABM0BwisMzCLiVBKBmWn56FZ2Lea
 mrR38DF+a6enaSIqwaUo+mGQpuA9Anf67ccVK9v4pMOANYwCuhdFw2GjtBjRs+D20vNg
 uKe9U8hb/Mc+txGbvUvuHK/B9OuxEeZOqQXOyS2XlJtCOKc4r2FpSDZS69XxMwFEO/Oy
 BpCw==
X-Gm-Message-State: AOJu0YzMQ5SEmK7bV/cLz/cHyBE8UX6/vD7mI57TgLv9QqQ8Vjep3HSv
 9QWmhd+gZQT20hAXTG0WVleu9wyb4/hN9fB5e8m4tR8JTQeVXf+C/HqHzk3hpi5xvx3kKkMOfYn
 cfIo=
X-Gm-Gg: Acq92OH+40tfSDZK2QuQ5/zNaXMYmhjyvMrhsYNEy1dpqfnVEDrSAbP25JpqgVmSo/g
 REVGPQH4UnpcyZwk8MceLjfhpviiz+F5mjD+DPortefSYS4tp3Ux4mr1uLutMc1I/ZmrEynSOXw
 ayy3qOIyUqfo2OsgWYsmtke2/95ugevenMvqgyGiCrcnLgjf7PIcF1PSvNbhfieaDdG+KIvU3dA
 TjdIq2LyvNRorrWio59Us0hzi5bypYn0+VUrlfluygb9NRsVmj0O3IKCbEujvhRMcn48guvBMtM
 6fL5w6VVLZvgJ8vQPzgI23STEFbVmNk2zgW9ybGa6d0OxlmNnImTVLuBo8WxBcgJZNNImsispAe
 t0hfmlg0/KhcbJcNZZSOj+Sez049fpft+UIJzXW2RYBSFB4n+ELBCcrAzIVH+DwT9w31N1BPq+c
 niLFjP/x96obU=
X-Received: by 2002:a05:6000:2902:b0:43e:a81d:c475 with SMTP id
 ffacd0b85a97d-45e5c58fbf9mr28910754f8f.6.1779173883212; 
 Mon, 18 May 2026 23:58:03 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-45e6a135f0csm24612341f8f.27.2026.05.18.23.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 23:58:02 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 19 May 2026 06:57:55 +0000
Message-ID: <20260519065757.7693-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] af_alg08: Allow EINVAL when calling recv()
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On older kernels (e.g. 4.4), recv() on AF_ALG AEAD sockets may return
EINVAL instead of EBADMSG. Since the primary goal of this test is to
detect page cache corruption (which is verified separately), allow both
error codes.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/crypto/af_alg08.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/crypto/af_alg08.c b/testcases/kernel/crypto/af_alg08.c
index 5e04b579c..3de76b428 100644
--- a/testcases/kernel/crypto/af_alg08.c
+++ b/testcases/kernel/crypto/af_alg08.c
@@ -100,7 +100,10 @@ static void try_corrupt(void)
 	SAFE_SPLICE(pipefd[0], NULL, reqfd, NULL, OVERWRITE_SIZE, 0);
 
 	/* Expected to fail (invalid ciphertext); triggers the scratch write */
-	TST_EXP_FAIL_SILENT(recv(reqfd, recvbuf, sizeof(recvbuf), 0), EBADMSG);
+	const int exp_errs[] = {EBADMSG, EINVAL};
+
+	TST_EXP_FAIL_ARR(recv(reqfd, recvbuf, sizeof(recvbuf), 0),
+			 exp_errs, ARRAY_SIZE(exp_errs));
 
 	SAFE_CLOSE(pipefd[0]);
 	SAFE_CLOSE(pipefd[1]);
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
