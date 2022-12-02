Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A749CC4332F
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 09:33:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7223A3CC406
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 10:33:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 366783CC3C5
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 10:33:27 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 76663101EA8A
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 10:33:26 +0100 (CET)
Received: by mail-pl1-x631.google.com with SMTP id y4so4154464plb.2
 for <ltp@lists.linux.it>; Fri, 02 Dec 2022 01:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+OmD1syjlb9z54eH5Uw5b9Clc0k+MJvUA8v3/4cYd/o=;
 b=JlNV37zOTF021N9VPdBmBQI7YVLE83kjCQVn2zyiFTejT91BScoR0JHWxE5F14x/Pv
 uY6E1pzbyN9pqS71RoHCgR7HYni2dJjI2IngoVEAv3vReruBCb9DceB4h1XgE0Miwn+R
 QIXvKrcRsIAy7hsHXCHXkCKGaLuxqu2CVnERf/PqJRrnV41kMPlygJg6+E+GMEwrcEnT
 +HkqH+NXUqX8yFB9YK46reKTpXRoHHrJuGjFImj+25JijRNYdY+7kEl5tUhandN7M3bQ
 nj583bDcRWjYhUDtUo5n+xg/uvqXSrXeG1IADK6NrQm5YLbP8vnRN/rUry0DKDBbUGZM
 58Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+OmD1syjlb9z54eH5Uw5b9Clc0k+MJvUA8v3/4cYd/o=;
 b=XcwZQAPsiTxrWTJvbY6ORolgJSAmUjSvAIOn9sFDG1FIZv0Yno1TG4JzlCpdelLmF6
 S1s8niRiO/2K9e22tzDpKWHiBKcnstx7Gj/3UH6aBhS435SYjNWn7dMQoZmh97iHOxvd
 E0NB4JvqwFkDHiiZrKcG7kTcAABa9IgsaKxBVMV4HCm0qyKWTs99EIof6dreH7cQWg+2
 tNfQi0TSFhWfPeVTebbMVCDEJ4DtT8+FvJPPq7dyOVLvVCRZO5w9bQIuG8aDbPxuxBDk
 6MKNVSMgi9jebsPWRy8fcevsDVN7y5zK55axfETtpO7mqSfKXtBBJE8FguGnpjyjPmLr
 Y3fg==
X-Gm-Message-State: ANoB5pnZBCnmGBcAZsLumtASJtfe9S7nQGZdfVF+YAaDGQRtKePWEGpH
 X2i6j9+ypvLS9FRvX9lzRs1hmtPUEW+T2ygseXU=
X-Google-Smtp-Source: AA0mqf58lLNf9kuPNByROm3CB+a1ti7Hpj/JX8G6MoK/SjHdQuQKfiTJsMH5zy6ocKX6m8/Xwbaj1g==
X-Received: by 2002:a17:902:a605:b0:189:680e:c2e5 with SMTP id
 u5-20020a170902a60500b00189680ec2e5mr35585267plq.51.1669973604654; 
 Fri, 02 Dec 2022 01:33:24 -0800 (PST)
Received: from alarm.flets-east.jp ([2400:4050:c360:8200:7b99:f7c3:d084:f1e2])
 by smtp.gmail.com with ESMTPSA id
 200-20020a6303d1000000b00477a442d450sm3734786pgd.16.2022.12.02.01.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Dec 2022 01:33:24 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Date: Fri,  2 Dec 2022 18:33:11 +0900
Message-Id: <20221202093311.98914-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ftp/ftp01.sh: Fix put command specification
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The tested command is put, not post, as the function name indicates.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 testcases/network/tcp_cmds/ftp/ftp01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
index ac57f004e..da3cdb375 100755
--- a/testcases/network/tcp_cmds/ftp/ftp01.sh
+++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
@@ -60,7 +60,7 @@ test_put()
             echo lcd $TST_NET_DATAROOT
             echo $1
             echo cd $TST_TMPDIR
-            echo post $file
+            echo put $file
             echo quit
         } | ftp -nv $RHOST
 
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
