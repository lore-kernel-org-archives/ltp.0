Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812E6C4332F
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 09:34:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CDBC3CC3DB
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 10:33:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D606C3CC3C5
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 10:33:49 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6981011F35DB
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 10:33:49 +0100 (CET)
Received: by mail-pj1-x1032.google.com with SMTP id q15so3362214pja.0
 for <ltp@lists.linux.it>; Fri, 02 Dec 2022 01:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6iVmaxthzk74fG4zje1Q2ufmLBFzeDjymnW4S9m7Suw=;
 b=ifXvSbQS7C6xM5AwOw9gB55bwIF9MRW75chfk0ETk67eblZN3kTjbqGsAb7YVDHMpU
 WTvv5kuHrX+3lglq6lTXzbNDop8OSmEkSO21QTcOXgqDuqv0IW+8XXtLBV9bOu5k7l5H
 jRBm9p/Acx/zptttDMm2GtZUbDX7bzSTq+oYOl4dXLq43yIxsxnpEQ4Z+i/+TIwxQIPg
 scE88IRqa6B58sSJ0G5hy7M3x6Y1qw9UOxpWOrvnTUDmVtzn3FUWh9AgiOq/40hx7z+U
 EES3Guq0AdFyvs0Y7xUCKEBf3VnKKSAx/JgMIyKtOCb4i/4wgHQL+R/X7X51imCJCGYZ
 rbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6iVmaxthzk74fG4zje1Q2ufmLBFzeDjymnW4S9m7Suw=;
 b=7Q5u5fwvhZyO3JW3aqpZtZ6Dd+okSS1sz3+f+iZBmxd18hkBiapau2fjvSDvXGH67n
 g4eEOqm3M08H63g1/alLjSxSLIM8t2KGymxTql1tKnVxE1/E8S+6NyRdbfScg+BvvJxr
 bOizNbd2pI6eoh1jDoMMAC+jhttUY3m+BYW78G2J8teso0lES2n1PaaRH8866n1jkTOK
 wbMBGVV3ZjxB7KZ+aYi3Hw3h6fltMxDs21eyCQXZbS5fKDKHaKrz8t0GIYmAPUBnpJ/b
 mQ4z7Po68ITvMV4l2R5fEx3AFFrh5G9Hz+0d9fO0CrGEZxGNpg0G7tmiCc57V0RzsHKA
 7inw==
X-Gm-Message-State: ANoB5pmFhOITfSfsBou1gdxbkkrIbR5zSaN5CG/FQOSB1RLYOaPsG/J/
 wuEpbyilY4K5qSfq1fHHQrCBSS1KEc+GAZhZrrc=
X-Google-Smtp-Source: AA0mqf7bmuukwSJuimFBrTzZS+AVILcCjoZ0NVN2jS4w8R1oah/hMXNDRIM/MRIqoomfjAgVyDobwQ==
X-Received: by 2002:a17:90b:30c6:b0:219:11ae:265f with SMTP id
 hi6-20020a17090b30c600b0021911ae265fmr35927781pjb.194.1669973627710; 
 Fri, 02 Dec 2022 01:33:47 -0800 (PST)
Received: from alarm.flets-east.jp ([2400:4050:c360:8200:7b99:f7c3:d084:f1e2])
 by smtp.gmail.com with ESMTPSA id
 b18-20020aa79512000000b005765df21e68sm1023718pfp.94.2022.12.02.01.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Dec 2022 01:33:47 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Date: Fri,  2 Dec 2022 18:33:42 +0900
Message-Id: <20221202093342.104600-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ftp/ftp01.sh: Fix list_files
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

The arguments and the returned values were swapped.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 testcases/network/tcp_cmds/ftp/ftp01.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
index da3cdb375..53d1eec53 100755
--- a/testcases/network/tcp_cmds/ftp/ftp01.sh
+++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
@@ -25,8 +25,8 @@ do_test()
 list_files()
 {
     case $1 in
-    binary) echo 'ascii.sm ascii.med ascii.lg ascii.jmb';;
-    ascii) echo 'bin.sm bin.med bin.lg bin.jmb';;
+    ascii) echo 'ascii.sm ascii.med ascii.lg ascii.jmb';;
+    binary) echo 'bin.sm bin.med bin.lg bin.jmb';;
     esac
 }
 
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
