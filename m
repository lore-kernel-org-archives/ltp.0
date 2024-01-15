Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C7CC3DA79
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 16:00:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F17583CFD0A
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 17:00:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9EE93CCB4A
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 16:59:52 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5DB5A600BC9
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 16:59:52 +0100 (CET)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d3ec3db764so33454645ad.2
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 07:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705334390; x=1705939190; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1d24Wsn5+Xjgi/7URex0zjrTgjAUVZgXb/uGxbE6Hs=;
 b=m2rC99WXHZyMLmRQaR0CugP6Qgu+QR2ePh8rlPmEFwN86vtR/RLxmEd7JFZonRBNj7
 68XCa+xNnTmvXsm2sUWNXKyxevP+3QiY/U9kf4JeIIvVcaQ3GFS3jwGsOsXaQQzm8uhX
 uUnUj0YPAiRAovpzLgavBhYqL6bnvorN6wsYbUFtUO+Lre6D8KE3hjp9FJ6SeYjeMrYn
 uKVwd9j453o8ATqc5FJ3UAQVEMjLpdJmLjSVQc7FqU/RpQ2wAwZ5SElzsHKv/ToH5Flq
 17Nn9/TDrmsXI43+LLI0+81b+WLd/u/Mvj6SWFb1jipf97oEklus4lqv9DOanWBlpkYe
 LS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705334390; x=1705939190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z1d24Wsn5+Xjgi/7URex0zjrTgjAUVZgXb/uGxbE6Hs=;
 b=eDIX35JTVNxNCdO/q6Q6xFNyuVIuu59sUme3/yhH8y3DT8fkyi8VJKayLYEePzF3rk
 3m8y5riCg9rVLcigs6HQegsx7k+2Zaa9+OjUqM9WZYx5FHBDYdKB1PPN9jVOYt5/jQjD
 WtAW8rjeXeS6tas5UwRYGcpvBhBX2yqSM/gn3qSuy3TkTmxltWJFD0T+1mqj0AYBQLl4
 tvFPZxHT9kbE9EY/pj723sw8yHerM6Irvjpb1x7ltgns7aDn/gPG6BO9PSFwWT4mjoMF
 8x9+riPLBekmRXW2Nu5WyXO6lven7mPyVgoRuQQ3Hi/oIl9ylvoCt0ADFF3Wm8Ieer2q
 ayyw==
X-Gm-Message-State: AOJu0Yw6dE//97E+lz+DyanODjABZBO5PlqkVT7tpxKi2xActoEJ6YjO
 L1yOQZcb7V2oCBek6fc/prIhIJKb59o=
X-Google-Smtp-Source: AGHT+IGdNqhvM/WsariRy/2jFAdtAe3cQk/eGx5mOC5FQeMiT85MWG4dkqYtun30m6conP/o66Cm/A==
X-Received: by 2002:a17:903:328b:b0:1d4:e1d6:10cc with SMTP id
 jh11-20020a170903328b00b001d4e1d610ccmr2963421plb.73.1705334390622; 
 Mon, 15 Jan 2024 07:59:50 -0800 (PST)
Received: from localhost.localdomain ([106.51.187.155])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a1709026b0700b001d5383ae01csm7680482plk.121.2024.01.15.07.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 07:59:50 -0800 (PST)
From: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
To: ltp@lists.linux.it
Date: Mon, 15 Jan 2024 10:59:36 -0500
Message-Id: <20240115155936.3235-1-subramanya.swamy.linux@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] isofs.sh:Use genisoimage/xorrisofs instead of
 mkisofs
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
Cc: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Debain uses genisoimage/xorrisofs and Centos uses xorrisofs
both genisoimage & xorrisofs have symlinks to mkisofs
xorrisofs doesn't support -hfs option & supports only -hfsplus option
genisoimage supports both -hfs & -hfsplus options

Signed-off-by: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
---
 testcases/kernel/fs/iso9660/isofs.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index dfa4ac73d..392e1a764 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -19,12 +19,14 @@ MAX_DIRS=4
 
 setup()
 {
-	if tst_cmd_available mkisofs; then
-		MKISOFS_CMD="mkisofs"
+	if tst_cmd_available xorrisofs; then
+		MKISOFS_CMD="xorrisofs"
+		HFSOPT="-hfsplus -D"
 	elif tst_cmd_available genisoimage; then
 		MKISOFS_CMD="genisoimage"
+		HFSOPT="-hfsplus -D -hfs -D"
 	else
-		tst_brk TCONF "please install mkisofs or genisoimage"
+		tst_brk TCONF "please install xorrisofs or genisoimage"
 	fi
 }
 
@@ -62,7 +64,7 @@ do_test()
 	for mkisofs_opt in \
 		" " \
 		"-J" \
-		"-hfs -D" \
+                $HFSOPT \
 		" -R " \
 		"-R -J" \
 		"-f -l -D -J -allow-leading-dots -R" \
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
