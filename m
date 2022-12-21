Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E104CC4332F
	for <ltp@archiver.kernel.org>; Wed, 21 Dec 2022 07:58:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85A743CA4DD
	for <ltp@archiver.kernel.org>; Wed, 21 Dec 2022 08:58:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E0D13C62B6
 for <ltp@lists.linux.it>; Wed, 21 Dec 2022 08:58:36 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E1FEA1A0093C
 for <ltp@lists.linux.it>; Wed, 21 Dec 2022 08:58:35 +0100 (CET)
Received: by mail-qt1-x835.google.com with SMTP id bq12so2941709qtb.3
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 23:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cCCxZn1BRvD3Rk+itK0u5Tmr94z7thi6Spl1qiZlQ3A=;
 b=e3oCjWSAlJKw/P72fueqnAR5xSRBJHnh2G5Ng2x9Ailie9vqTvCfcbiGlDYo79c4Di
 GIECZfFyPl+BAj7OnT51sfKTsPO058722aAljVmXW6cuTtQ2IkGWn0QkwntmD6/G93GD
 2fOK6tSOr6Y0c4R/d6Wph+kmiR5ndIPaG5YR69Qichja/t6c0f2peb11JYpb3siz3U2N
 BXPuuiEgGgUR/HVynmzLAN2p8jjLA2mK5kxlJd1T1SJzKxToQQSKVmbwhKP1TWwM/k3y
 MoAaqNDZpTmOBYdR0Xis1BJUdc2KHlulVgvTD5nPSEcjCYMhMUwHjDw4JmDhsw17tdzG
 6WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cCCxZn1BRvD3Rk+itK0u5Tmr94z7thi6Spl1qiZlQ3A=;
 b=L8I5VPVwUNPkinZ2nRBzU/rCtXTE+oOhS45Fta+UqlMzf0gDBqb3BQ5fzrXb3a4RIe
 U3/UQqqB8/yoGkrwfrFA7BRdVO1uWV6fdrFfnQiv9eWcvR2vuZAA8yowJtRAECc8r1yv
 b8U/nL6qtpWWqvP8GwSX/LmnphqiCoSjX+HxTEi3qQbCEfeoxVrmtOCV2Wj/9WKWveeK
 T4llQxCfsOv4yIAfZHA/LbFqT5SdLoQoxsd0GA1c/F+XqA7f7R1BBtOSOirwvsKm5FkU
 iu77QDLLGUK5lmXJoYuJeo0kbMbpDW9bQ7BP4myew0KwIHJdBlRYXwWp9N6W0QUk7Xai
 Bs/Q==
X-Gm-Message-State: AFqh2koOxgOvpHGer0RXv4UhZn1VAMLDhYboWMnmJxptbNU5HlwF4B40
 zpMgd/MNsKyNpgRvHTWYg2uXfVoZWMo=
X-Google-Smtp-Source: AMrXdXue5s+kAL6n7LVbefY1HjLk6x0LQ4LorftvvnKVCGNWc/HiGLZqNTQHGYyKYCglYs6tlHLwhg==
X-Received: by 2002:a05:622a:4c08:b0:3a7:f599:9c6c with SMTP id
 ey8-20020a05622a4c0800b003a7f5999c6cmr890847qtb.26.1671609514548; 
 Tue, 20 Dec 2022 23:58:34 -0800 (PST)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
 by smtp.gmail.com with ESMTPSA id
 ci27-20020a05622a261b00b003a580cd979asm8974475qtb.58.2022.12.20.23.58.34
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 23:58:34 -0800 (PST)
From: Murphy Zhou <jencce.kernel@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 21 Dec 2022 15:58:21 +0800
Message-Id: <20221221075821.3786392-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] statx07: umount before un-export
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

We need to umount first, or there will be an umounted mountpoint
left behind.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 testcases/kernel/syscalls/statx/statx07.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index e1ae36a35..8cb3e9b6d 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -149,6 +149,9 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	if (mounted)
+		SAFE_UMOUNT(CLI_PATH);
+
 	if (!exported)
 		return;
 	snprintf(cmd, sizeof(cmd),
@@ -156,9 +159,6 @@ static void cleanup(void)
 
 	if (tst_system(cmd) == -1)
 		tst_res(TWARN | TST_ERR, "failed to clear exportfs");
-
-	if (mounted)
-		SAFE_UMOUNT(CLI_PATH);
 }
 
 static struct tst_test test = {
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
