Return-Path: <SRS0=3a48=N4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5669FC433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 08:35:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D164960F45
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 08:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D164960F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9477B3C269B
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 10:35:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55D1E3C267F
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 10:34:59 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5E8181400BCA
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 10:34:58 +0200 (CEST)
Received: by mail-pg1-x531.google.com with SMTP id k24so6064661pgh.8
 for <ltp@lists.linux.it>; Mon, 06 Sep 2021 01:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ayItHc1twcC6jjTfSnDA1kM/89ii3w3BrnsWq+c1iDA=;
 b=l0MFUchltVOZRh4/thmkmXursfuhhwJ1aY7/4SSZ7bBkh8Fy7JUaQeHnBMJet0vG2l
 g2GbI9xgUeReGx9vZifdcvQRpStSN5xmWmdmobf8xGnrn7R6EZ3iy7VFKvKMsNcR3m0c
 3RuXABrh3dm4TbCbNM5WXaEcb+ffMYPdX4Yw9w//LOA1VbRT2D5RHr/iGIIrWIn6o78I
 Ti9xK3oYdEcE5T0X7MudCmg/XdtW8v+HTiz4nz4jjh5TxKKupLdUE/prZsrFlviY7ly1
 P0PKXBIs4/YEYK+G+lx+y6jcdvAcU9Z1JiJ/knbCDQgQzR/NXQ2kg6mwNcXSudosi+36
 4eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ayItHc1twcC6jjTfSnDA1kM/89ii3w3BrnsWq+c1iDA=;
 b=Hvmno8GH71L0FDwkdkbu27sX2E25PNg5J1dDK4J0XFHqBfEOOi7rSzfN6Wu1vSrN8I
 0Dna/tOXacxB9M2abd/FWMQ10LgNYcIQXzeveEGQ6v2Nox3YsVF64Ev1PQSwA2le+bwh
 8PqfPc5a4+i2UQMmNDG3QQYTHm2ICQT0FEFE+ZsaDq0s5ezZNmNEZdvOzT4HJEypwVsq
 jh89PIUTfXrSOqIpiWxvdrIm49hpzGK1OM/whqrGXG5kWnsKvJNklrMrGZ3U1j+BhKWQ
 p2ZrORs0B35GVPt2k5IHvozoDC1L2IkqjPHpLoDZW24XeCTqYU+W3wrX1KN3bc4dt5Da
 cMPg==
X-Gm-Message-State: AOAM5322qf61IyYx2KGB8HoEOmRdXzsKDREam+nnTbS2SyfUE1dQ+sLg
 UOxnhmnlBvdLeIj2KxRzf2UBOhFYB9pk3g==
X-Google-Smtp-Source: ABdhPJyZ/hFxOpKdHTeY4dgrFa1hglx9vaOfEI67L4bsVp9bAU0n4rjVEhOpn2qyr2Sc1Hr5jjd7yQ==
X-Received: by 2002:a62:3301:0:b0:3eb:2fee:87cc with SMTP id
 z1-20020a623301000000b003eb2fee87ccmr10943161pfz.62.1630917296259; 
 Mon, 06 Sep 2021 01:34:56 -0700 (PDT)
Received: from localhost.localdomain ([124.123.174.194])
 by smtp.gmail.com with ESMTPSA id u15sm6979090pfl.14.2021.09.06.01.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Sep 2021 01:34:55 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: ltp@lists.linux.it
Date: Mon,  6 Sep 2021 14:04:44 +0530
Message-ID: <20210906083444.82394-2-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906083444.82394-1-naresh.kamboju@linaro.org>
References: <20210906083444.82394-1-naresh.kamboju@linaro.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] runtest/smoketest: Adding ping01 and ping02 test
 cases
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
Message-ID: <20210906083444.4QVXoaMx-Ygkk5W_5zqcM64QUavN03HvwBMvsLEt9QE@z>

Adding two ping test case to smoketest
ping01 ping01.sh
ping02 ping02.sh

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 runtest/smoketest | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/runtest/smoketest b/runtest/smoketest
index dd689bd6f..361f1db29 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -13,3 +13,5 @@ utime01A symlink01 -T utime01
 rename01A symlink01 -T rename01
 splice02 splice02 -s 20
 shell_test01 echo "SUCCESS" | shell_pipe01.sh
+ping01 ping01.sh
+ping02 ping02.sh
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
