Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06359C04AA5
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 21:55:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74BA33CA3CC
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 23:55:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD55B3C945D
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 23:55:04 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 276E41400520
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 23:55:03 +0200 (CEST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1667A3F45E
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 21:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1661378103;
 bh=GucX71dbC0mJ4cQOcNfbHq0BNg4FrkZ/Rjnl+Vli458=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=LibX0PuSug88Nsl5zPDJw7dCYTHvL4uMZ83IJ6Jqdp1RNG7GUUPojjjm1lifB+QC4
 zH9fOnR2CgxTdUnFS6GEv4mUPMO/0NXODkcaED1AtIS2UrRnZFJWGYyEiVh++pV8mw
 L2/0mZH+/6semcqUAiLPzJtQmLaKH7KnGN+nMty328FPFIH3rgXMEsUyuSApMQOgbT
 4bNPcp0E1II60VRCun/zsr50ATnm+xNrf4QeoTrM7Ym4eCHHCzvZWLlv6RY332jLN/
 lP2dluS9TsfluVYFtcyxhy7COOAp6B9VXC8OrFqSFbpHegh2yQm4R5COv+ulpTYWqu
 FCCPaDJfXldNg==
Received: by mail-pg1-f198.google.com with SMTP id
 r74-20020a632b4d000000b0041bc393913eso8178598pgr.10
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 14:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc;
 bh=GucX71dbC0mJ4cQOcNfbHq0BNg4FrkZ/Rjnl+Vli458=;
 b=0CCSzbICQYmjsK6f3tP7P3h1FNc2g45zCWsa7GdlF1ez6oRzOXxDl9wkd+j5i4YXZF
 ZFZ/FPRdsUMwxK8SqEf2COh3Wvw7CLMbb7Ljhc+BT/gackbwDaNCVxnzhgppxCNPVRbV
 gIAa5h6DERXX0WWnV4DWlWjASiOdkgvHSgyEaOyOaUGzTvP0sOEXfQfZmwUDRPPKLaMX
 iall0ntzimETNAbTG8cilJnWAQDv6kPoSHxlP1jPv9okLVDrsd+CF+x4nrSK1i58nzyk
 Y6ZkMuhtauUdXSZ8LsN6WfjihOWLmDdE9h0QEKMF8l9PElU/CKY9hM7jcYeAyQG+7tBE
 AHPA==
X-Gm-Message-State: ACgBeo1pe8Y3SD/pYFyuSH1N6T8P0dOnEOiXxgj5G9/OWY1GRNOjQ81n
 kGTd4tDL0ovdRJXY404PDvq6Ej88LtjXweh5OJjjXqD7WbZrxSkrHgi/4S9B9QhwOHLQJHSubnB
 kJ22t1U0ldncYaueM41xkw2hGtOao
X-Received: by 2002:a17:90a:dc15:b0:1fa:c517:7f14 with SMTP id
 i21-20020a17090adc1500b001fac5177f14mr10430514pjv.117.1661378100406; 
 Wed, 24 Aug 2022 14:55:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6a6R/AN55LAbj57uXMzI0nlV51IReHZQLqOw0loc7RpLl8gauOrP+U1qRJ7jWOeJDzjNvk6Q==
X-Received: by 2002:a17:90a:dc15:b0:1fa:c517:7f14 with SMTP id
 i21-20020a17090adc1500b001fac5177f14mr10430492pjv.117.1661378099807; 
 Wed, 24 Aug 2022 14:54:59 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 d135-20020a621d8d000000b0052d4b0d0c74sm13528879pfd.70.2022.08.24.14.54.59
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Aug 2022 14:54:59 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Wed, 24 Aug 2022 14:54:21 -0700
Message-Id: <20220824215421.90947-1-luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] API/cgroup: Add rdma controller
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

There is a test reporting "TBROK: 'rdma' controller is unknown
to LTP" so lets add the controller.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 lib/tst_cgroup.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 1cfd79243..1da3f0a5d 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -93,9 +93,10 @@ enum cgroup_ctrl_indx {
 	CTRL_BLKIO,
 	CTRL_MISC,
 	CTRL_PERFEVENT,
-	CTRL_DEBUG
+	CTRL_DEBUG,
+	CTRL_RDMA
 };
-#define CTRLS_MAX CTRL_DEBUG
+#define CTRLS_MAX CTRL_RDMA
 
 /* At most we can have one cgroup V1 tree for each controller and one
  * (empty) v2 tree.
@@ -253,6 +254,10 @@ static const struct cgroup_file debug_ctrl_files[] = {
 	{ }
 };
 
+static const struct cgroup_file rdma_ctrl_files[] = {
+	{ }
+};
+
 #define CTRL_NAME_MAX 31
 #define CGROUP_CTRL_MEMBER(x, y)[y] = { .ctrl_name = #x, .files = \
 	x ## _ctrl_files, .ctrl_indx = y, NULL, 0 }
@@ -275,6 +280,7 @@ static struct cgroup_ctrl controllers[] = {
 	CGROUP_CTRL_MEMBER(misc, CTRL_MISC),
 	CGROUP_CTRL_MEMBER(perf_event, CTRL_PERFEVENT),
 	CGROUP_CTRL_MEMBER(debug, CTRL_DEBUG),
+	CGROUP_CTRL_MEMBER(rdma, CTRL_RDMA),
 	{ }
 };
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
