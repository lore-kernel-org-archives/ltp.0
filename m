Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EF7C5ACB3
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 06:34:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 174FE3CE182
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 07:34:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C99CC3CC2E3
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 07:34:04 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A8A152009F0
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 07:34:03 +0100 (CET)
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-779fb118fe4so338009485a.2
 for <ltp@lists.linux.it>; Mon, 20 Nov 2023 22:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700548442; x=1701153242; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=D7BaN0LVNXVe+13hU3JXqSMKR4o95iF3vge9XFzFJO0=;
 b=j9IPrhAOqAgYynfhEaiOTm7AQC5LqGjuaKxMNexg6TbSXyWlPDvHIoDPBkYeEUtHUJ
 gUX3ad7wAQRikfvxxw6oVeZTkA2/z81tHZ0kidmdy7z0sYeFep6g9C+2/JeU0vHTwVMa
 WT/gaY7AuFTjbloYdfGHVkqtmmC1kL58pLCpttd93xqzxXhlY/xD1r/NjlfPBT1tMIt+
 /k4JkxpYiPOT7w0rZ87bzAIJNZ3DUhnAZbGKt6rPRY2AeToD8wfcTbYwd1TAwpqBCQYN
 7EbAMtwUxIT6Q2M2KGxO1nulm/P9duXqiJXiz+ZanGZOzyKkG084ltTcOzHMJzgXe9DS
 L3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700548442; x=1701153242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D7BaN0LVNXVe+13hU3JXqSMKR4o95iF3vge9XFzFJO0=;
 b=xNAzetwceSmsqgyVZuJ6tI2Arv33MAFARLaJpH6kKuBiee3ZKexUFrl1TrAeKZs/EY
 mj9LATt5/g7saJKraNcg5IQZQvXAL5/dPXeQgMSCmypKvgvwhI0PHuLt2UVCN8WGJelT
 HLRJuQSkt1Yh7gujkV9pnzQNA10HX1XXvEl6f5nYvvpCtXEm13TugQ7QhmR2f3Yw6iyI
 kc61tJisYhLjy87Hoa7zR6FGwgL0KUBamo47zLQx2RgE6Z6aDWbtlG8YnAd2C98mYJHd
 I8N0bsXqDGR0Kku92ODEOHC3HIWAWZRq6bJBRHM4ldXFeF1wVGWntgKvuxcqIkMYLKCs
 E/ag==
X-Gm-Message-State: AOJu0YyrKbjJ7nlqWfA/2BCkDwrwvDIzfqpkpngpG5MbTkmfS+V3Xpgw
 40JrjOMNWx60+XHVloFpkpRTvRhIWO4=
X-Google-Smtp-Source: AGHT+IF63gwPAZpcyn2XPeioda9I/grzK7v1yVhKtaW2HGBcemFG/ls6XJo/tzTGaDEefQt6sqgI9A==
X-Received: by 2002:a05:622a:1393:b0:412:395c:e794 with SMTP id
 o19-20020a05622a139300b00412395ce794mr14935002qtk.50.1700548442176; 
 Mon, 20 Nov 2023 22:34:02 -0800 (PST)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
 by smtp.gmail.com with ESMTPSA id
 g21-20020ac84815000000b00405502aaf76sm3376662qtq.57.2023.11.20.22.34.01
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 22:34:01 -0800 (PST)
From: Murphy Zhou <jencce.kernel@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 21 Nov 2023 14:33:58 +0800
Message-Id: <20231121063358.2996193-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/sched_setparam03: fix typo
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

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 testcases/kernel/syscalls/sched_setparam/sched_setparam03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
index 759b790b6..ffa92a3bf 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
@@ -49,7 +49,7 @@ void setup(void)
 	tst_res(TINFO, "Testing %s variant", tv->desc);
 
 	if (tv->sched_setscheduler(0, SCHED_FIFO, &p))
-		tst_brk(TBROK | TERRNO, "sched_setcheduler(0, SCHED_FIFO, 1)");
+		tst_brk(TBROK | TERRNO, "sched_setscheduler(0, SCHED_FIFO, 1)");
 }
 
 static struct tst_test test = {
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
