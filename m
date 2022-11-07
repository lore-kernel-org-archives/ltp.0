Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B15C4332F
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 16:46:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 294A53CDA41
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 17:45:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80BFC3CDA47
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 17:45:34 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 00E426008A1
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 17:45:32 +0100 (CET)
Received: by mail-ej1-x630.google.com with SMTP id sc25so31633806ejc.12
 for <ltp@lists.linux.it>; Mon, 07 Nov 2022 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ntoy8AyCe/TRcbrwP5YL5bqphFHpz2TiQ7HZNNkJC0=;
 b=J9U8xVh6yPUOa7f/S7pjuLqWDvMXwS7rvFT5KiV4M5jK8NopCnOgLTMI9ib3x7x4fQ
 Oju6dngUp9ypUUljhYHFi0UAUaJC76dFDYBZzhGxBBH+xmQtPhC4WTWylsOKsI/L8doC
 UfysIpDD+WZdl5M5/ucgJEb05zq67/XXukUBBjOEKMzrG5uucSV+pcPSvxEujONQeoYP
 aBWoFTPFjhEAfgdzH9sjYEGGy1s//LYdjmaGg0nPAYnRYPhKJzMMRgVKr/ghXjngi8wQ
 OEzr1p5WNg417LImL7Za/x5XKdq3m6RnMVXWqVVt7MOvrlotZG86S/i/jUKVKG1IwfTh
 10Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Ntoy8AyCe/TRcbrwP5YL5bqphFHpz2TiQ7HZNNkJC0=;
 b=PaRvCLVu8A/Sxo3BNAinZ7D8Z5lLb2oe1QAwqfM95Xk4Fsm+g5zAdz7GYaKjxbYiL9
 /teMrXUhyRaAQZ526Oi90FFE6cIisXKcRu/S3Deq4b6Pf1z4ZfuExzlDBAx/HBU54zox
 Y6XJQkkkLh/i+E8iKfaJrn8xF9K1WzIVeZhx4RV0x7dt+uaAUU+vIzl5s9Fh/cuFbMLr
 FuE3VJ/BhzhDMu9FCet+wd3kFT7Fp2/QOPcFoBJXrdU1YDabp2y8xKCjZTcUGMTLI8t2
 YTSl244EAZ8LSORaBpxGQpYRe9NcJ/7JOa5sqUrdm08oqHJx+vyWt3TWjYH7KoLOJIID
 Q8MA==
X-Gm-Message-State: ANoB5pmmJK3DURfuoW3vDBJ1bP2xQur9cMKXZN+YcIU7RvoMNqLy7PNY
 QCrIzGPLUwQl+K+56pcU8a+cLCcvqO2IIA==
X-Google-Smtp-Source: AA0mqf6EbfDctgh94mwHst5PRxgJivpcVDbFRb92vm9eB0SS++x75xw0yeXkN3qKPqcQleTsz1Nxtw==
X-Received: by 2002:a17:907:971e:b0:78d:e7ed:7585 with SMTP id
 jg30-20020a170907971e00b0078de7ed7585mr593710ejc.258.1667839531832; 
 Mon, 07 Nov 2022 08:45:31 -0800 (PST)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 17-20020a170906219100b007add1c4dadbsm3645684eju.153.2022.11.07.08.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Nov 2022 08:45:31 -0800 (PST)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Mon,  7 Nov 2022 16:39:57 +0000
Message-Id: <20221107163957.721315-3-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107163957.721315-1-alessandro.carminati@gmail.com>
References: <87h6zbxgc9.fsf@suse.de>
 <20221107163957.721315-1-alessandro.carminati@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] c-test-api: Documentation updated
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, rpalethorpe@suse.com,
 acarmina@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since the tst_find_backing_dev logic is changed, the doc is updated
accordingly.

Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
---
 doc/c-test-api.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 64ee3397f..a7888c242 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -1071,8 +1071,11 @@ voud tst_find_backing_dev(const char *path, char *dev);
 -------------------------------------------------------------------------------
 
 This function finds the block dev that this path belongs to, it uses stat function
-to get the major/minor number of the path. Then scan them in '/proc/self/mountinfo'
-and list 2th column value after ' - ' string as its block dev if match succeeds.
+to get the major/minor number of the path. 
+This function finds the block dev that this path belongs to, it uses the unevent 
+file in sysfs to find the device name. It needs to discriminate between btrfs
+and not btrfs. For non btrfs filesystems it uses the minor, major numbers. For
+btrfs it uses the fs uuid.
 
 [source,c]
 -------------------------------------------------------------------------------
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
