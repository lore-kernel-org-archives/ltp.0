Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9A5C64EC4
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 07:53:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6D4B3CB982
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 08:53:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE6273CB976
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 08:53:08 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CAF2D1400432
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 08:53:07 +0100 (CET)
Received: by mail-pl1-x62b.google.com with SMTP id i3so1881042plg.6
 for <ltp@lists.linux.it>; Thu, 02 Mar 2023 23:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1677829986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zeYY0bCTDbWZ7+Uc0eJI0jQ4PNmcE36qUsvpgFfLR/Q=;
 b=hQ0snW0DFu4sGEDK9Y52DZ1KCOOFVZ9KrnF2bqO7IvMZTeXWWeirbo852OfdWM7B32
 +BRCWI18V+Qih16HqaRFaLo+mcbsRVd5UboB/TZ6yj/RMiZLqyfAFKX0TJOG2jzm3CTu
 LwYKLXQB2RiK6DMKBm//3LpqOh/DQUnhxF4rPWQAtxeF42bmjwfAWHjpt9IBi2NcIXS+
 OhehZSF1delvJ9vFGNHNVHKoIq8ovcR8U0Vm4QfS24qXPgsnDak10uWFYK9WI+zX/I6T
 rY4Gp4vaF4/dUh/SK1gq1WIRj/e9qHNs78hVqv0TqgEI/jJ4UFVGPNYLx/fveBYYrfd7
 8SXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677829986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zeYY0bCTDbWZ7+Uc0eJI0jQ4PNmcE36qUsvpgFfLR/Q=;
 b=rzZsxMx/Zebt5eoTlmFh94AW+EjS+8C/WxLMRPCfhja/C4GYT1c9lLrhEnPzaug3db
 0L8kk+htDzY/fs94s+UQotyiJdImKUed9oSREsAYd6KuWSqNCoV4UAoNbczRd0PPENch
 YNRB0Y6dguEmwZys/DvNYCSDH20dI3viEJUHZKg9v+SS8l8W7q6PyCbkcJbJKni7yo72
 Ge4b/624q4dE+gqcjGPUEuW2SSySZzMZAKyaezLFKMMAMoJc9rV0yWDoAl5kPE51rE8f
 o0TTy2bzOBlKOFvi/ryZB7ralFAKwTPM3YUtzuQZiUtbvDll7cd87L12Gmoa0muLcLS2
 3pBg==
X-Gm-Message-State: AO0yUKXbc74Xed3yWJk0nAI74skQHvXqNwq4QDCErGFPCr+UDhGIRmQ5
 HJs3VxLjhGM4jA11Z6UkdcgbnSC2ESPFaFsqvd8=
X-Google-Smtp-Source: AK7set+pJ8WMSRB59Q9cqtJwaAKfTaSJsECY+THp2tYZW9kxd6W5gKaRu4RS6v2r5O2nzwJTFdvSzg==
X-Received: by 2002:a17:902:e80f:b0:19e:747e:813e with SMTP id
 u15-20020a170902e80f00b0019e747e813emr1331141plg.23.1677829985794; 
 Thu, 02 Mar 2023 23:53:05 -0800 (PST)
Received: from C02G876QMD6R.bytedance.net ([139.177.225.250])
 by smtp.gmail.com with ESMTPSA id
 ko16-20020a17090307d000b0019472226769sm857728plb.251.2023.03.02.23.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 23:53:05 -0800 (PST)
From: Zhao Gongyi <zhaogongyi@bytedance.com>
To: ltp@lists.linux.it
Date: Fri,  3 Mar 2023 15:52:58 +0800
Message-Id: <20230303075258.1066-1-zhaogongyi@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ltp-pan: Send SIGKILL instead of SIGALRM to kill the
 child process
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

From: zhaogongyi <zhaogongyi@bytedance.com>

When PAN stop Alarm was received, and the testcase blocked the signal SIGALRM,
PAN will be hung up until the testcase exit. So it is necessary to send SIGKILL
instead of SIGALRM to kill the running process.

Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
 pan/ltp-pan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 0bdb51477..b07a7ec50 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -685,7 +685,7 @@ propagate_signal(struct tag_pgrp *running, int keep_active,

 	if (rec_signal == SIGALRM) {
 		printf("PAN stop Alarm was received\n");
-		rec_signal = SIGTERM;
+		send_signal = SIGKILL;
 	}

 	for (i = 0; i < keep_active; ++i) {
--
2.37.1 (Apple Git-137.1)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
