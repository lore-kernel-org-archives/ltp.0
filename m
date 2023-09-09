Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39492EEB58A
	for <ltp@archiver.kernel.org>; Sat,  9 Sep 2023 11:30:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 180F73CC235
	for <ltp@archiver.kernel.org>; Sat,  9 Sep 2023 13:30:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD2183CB4B9
 for <ltp@lists.linux.it>; Sat,  9 Sep 2023 13:30:09 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9FF3E200BDE
 for <ltp@lists.linux.it>; Sat,  9 Sep 2023 13:30:08 +0200 (CEST)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso22158045ad.2
 for <ltp@lists.linux.it>; Sat, 09 Sep 2023 04:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694259007; x=1694863807; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xosiTtYrnbxETl8XhYP+jc4qa8jqf2/CH1H6KoTmahI=;
 b=cWd7De+nja9AuzxsBMJvgBZF15OCJVdc2wI/QQ8GAs09qM5kP/8aRI/3bmDOSIVtU0
 clIOnAsKYtVUTX8p2Ue5Wmc6MGDjFURYEkA1s4J5bA6fNmf2tiYMSEKd9O4b5kuYc0RZ
 sAvDA/4F/bySGWlT9Pk8+oCM6wvaAMUgNFw7ce/CLRuNfr2Rl6S2dBCMTYOq5WYFVla2
 BsjIHTxjfOVsnDMycxJR0EXF5LWelrv5klrM629uVl9zqk2KHkpTrHZjHctRa9cAM0yR
 FYnMJcwuEljJy8Y2CRGP2Hkw7tVPp7ffa9IUzNLlPtCwJkvhdYiyjxwlO1YayTu65ioE
 0pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694259007; x=1694863807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xosiTtYrnbxETl8XhYP+jc4qa8jqf2/CH1H6KoTmahI=;
 b=ga97HC2z6RAeL0zcoVToj6I9j9wAAbk9Jgp4ZkMvpyuntORU+AGWaLCi1iCdQHErH1
 nZBBv1pLRnPl4VqzdgRlQODP+eTPjuGthvscJIHO9kf1ZtpcWeVU4481KhH072o4ngX7
 B1gYv02HqmGh9diJ7n1spAJk/qvuf0tCpjMTozvGgflAxNjXZYKDMiUGurksO1HciWre
 Iqy3aCKNPLZMWE77uXfN/xORzVI7qKbrPIKX04ZCUX4xW/xZ2M3klMPru3XxFEdi5nVL
 /rd+aVfa8JvSdjVI8f85pPH8DRm0OYRfJBZck1peVDahb3vhF6Poj5JiM56TaRnc7aY5
 XEtA==
X-Gm-Message-State: AOJu0YyunAi6toQhidxunoxmF03dVqv38Px7MVj8RTIct8wNg74h3tMm
 6q+b2JnkQ8qc1dkJ1xYgQrOclpgVz7I=
X-Google-Smtp-Source: AGHT+IF9157Ab5G/MpuYEahiSfMwwFAnIMlLYZFCoiXVkDYgOFCGTO2HCrWi81Mn2QsGx6Vfbqko6g==
X-Received: by 2002:a17:902:ecc4:b0:1c0:d8e8:38cd with SMTP id
 a4-20020a170902ecc400b001c0d8e838cdmr5457889plh.9.1694259006923; 
 Sat, 09 Sep 2023 04:30:06 -0700 (PDT)
Received: from localhost.localdomain
 ([2405:6583:30c0:2d00:2ef0:5dff:fe9e:61e8])
 by smtp.gmail.com with ESMTPSA id
 jk6-20020a170903330600b001ab39cd875csm3106453plb.133.2023.09.09.04.30.06
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 04:30:06 -0700 (PDT)
From: Takuya Wakazono <pastalian46@gmail.com>
To: ltp@lists.linux.it
Date: Sat,  9 Sep 2023 20:30:04 +0900
Message-ID: <20230909113004.21766-1-pastalian46@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] recvmsg01: Skip unsupported test
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

Since it's already stated that MSQ_ERRQUEUE + SOCK_STREAM is not
supported on kernels < 3.17, let's actually skip this test.

Fixes: 7d365d72ba71 ("recvmsg01: Refactor using new LTP API")
Signed-off-by: Takuya Wakazono <pastalian46@gmail.com>
---
 testcases/kernel/syscalls/recvmsg/recvmsg01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index 2576e1572..80c1b3aa9 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -220,14 +220,14 @@ static void run(unsigned int n)
 	struct tcase *tc = &tcases[n];
 	int ret = tc->exp_errno ? -1 : 0;
 
-	setup_all();
-
 	if ((tst_kvercmp(3, 17, 0) < 0)
 			&& (tc->flags & MSG_ERRQUEUE)
 			&& (tc->type & SOCK_STREAM)) {
 		tst_res(TCONF, "MSG_ERRQUEUE requires kernel >= 3.17");
+		return;
 	}
 
+	setup_all();
 	tc->setup(n);
 
 	iov[0].iov_base = tc->recv_buf;
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
