Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39ACBC54E67
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 03:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711511449; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=5ItNnpjEk/uXvtrFWQrMudJxhC/6D4aKjc4bgJDeR+o=;
 b=bh4Qyuu29Kg1xfH49HnDPW1ZA6Hi7zJjs7URDeQpgqvAKvUZrWTsPu9ccAmMJs6TsT2yf
 pytO1wYUQGjnrkSxP6KNtuK+iwo2Q9F0DcqLqjUL78p5n8oTPA1Fyl2aHk+Er5aIynbKriB
 jS5+jwdjPS8LbSafxdKDTeC5YrehkiE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EAF63D1B9C
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 04:50:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB89A3D17FB
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 04:49:47 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1A145200C8B
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 04:49:47 +0100 (CET)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a4734ae95b3so624033766b.0
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 20:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711511386; x=1712116186; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaLN3L74Yj6IevFCFc/3pau5UGd3elc2WTM2Z9LmTJU=;
 b=N+0a1/L8VjOaZ2nTcyrelHqaPnJdJ+9Bmqxj/52TpQCyHOMmXCfB/hcPlCLU12a4MQ
 4/jAGxrwtz74FtkHBfHaxtJMyaMzcIXBIx3+6sBkeiAvMnjrjMEMLQVYE3QlJTHQ/CZu
 P3AoJUWnJNdU6EWw+G47N+Y9PVlGPcwDFAk7teowdzr9xFJwF+Gymkmd4T9t8H34nMhK
 3I2uSP+HPHBi+UCF7PghWO4xpX2Yc22gXHuoiw1X4zqWX3OD4dy4/forsG7xF4lityCN
 hj9s5x9YDck4sFvPty29M781LewcWgS8M1DoeJXoC1dIXHh45OujGsKpu4/tUPoYNssV
 1m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711511386; x=1712116186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iaLN3L74Yj6IevFCFc/3pau5UGd3elc2WTM2Z9LmTJU=;
 b=h1Obf5XA/hEwRSaODM4b5m2L1S0n2aer/xfUeDlHVV7PRCQUJhpLUGM12Jf/6FjOYM
 MCE1uyN9JqHYa7vOnrB7Xf3o00Zz+YxMC7D+duNycBIUWjKmhcyTzA9QnnFaf1OCcw6D
 BgyY52QkeKUx3M6mUt5gL9C+rniYqhUYjgBfdWtahdauju2mr8FPA/A33XjRIKClPwsQ
 Mglytx50GEbPkXADPxU0bOpVRZYRI4bu1IXap0j3gh6bP+8OSAnoazxPZ4D2SAdzzN4J
 WUGHCTyncNRrzj7XQO9hZscf+7bFb19x6rfDboKKhgRxuD1XEd0A3TK3ZYMPx+uMFlv+
 uXIA==
X-Gm-Message-State: AOJu0YzXb7iKyacwfJvqa2y/RSwrlOguNkGaYH0QuE60OaUbAioK47tL
 Gy4ihAmDkbkMW9wTAa0jTgt+vmc4hBq/Ca3JgFvXdvUQqFMpTXraizIDCzWNt6mceanmOUDbd9A
 =
X-Google-Smtp-Source: AGHT+IHD27/7FjicfEaaCBw2WdjORXN5NpK2rod73FFnWXYRGdTWT/vcOwwCtAqIgeQLxwkmVFIFCw==
X-Received: by 2002:a17:906:7109:b0:a46:b76d:dc30 with SMTP id
 x9-20020a170906710900b00a46b76ddc30mr1033147ejj.44.1711511386065; 
 Tue, 26 Mar 2024 20:49:46 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 dk5-20020a170907940500b00a4750b2e0f0sm3705766ejc.164.2024.03.26.20.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 20:49:45 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 Mar 2024 23:49:22 -0400
Message-Id: <20240327034923.30987-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240327034923.30987-1-wegao@suse.com>
References: <20240208013224.859-1-wegao@suse.com>
 <20240327034923.30987-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/3] shmat02.c: Use TST_EXP_FAIL_PTR_VOID
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

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/ipc/shmat/shmat02.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat02.c b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
index 53cb6f542..3ad1fd08e 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat02.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
@@ -44,20 +44,7 @@ static struct test_case_t {
 
 static void verify_shmat(struct test_case_t *tc)
 {
-	void *addr;
-
-	addr = shmat(*tc->shmid, *tc->shmaddr, 0);
-	if (addr != (void *)-1) {
-		tst_res(TFAIL, "shmat() succeeded unexpectedly");
-		return;
-	}
-
-	if (errno == tc->exp_err) {
-		tst_res(TPASS | TERRNO, "shmat() failed as expected");
-	} else {
-		tst_res(TFAIL | TERRNO, "shmat() failed unexpectedly, expected: %s",
-			tst_strerrno(tc->exp_err));
-	}
+	TST_EXP_FAIL_PTR_VOID(shmat(*tc->shmid, *tc->shmaddr, 0), tc->exp_err);
 }
 
 static void do_shmat(unsigned int n)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
