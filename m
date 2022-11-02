Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16E0C433FE
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 20:40:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58FEA3CAD48
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 21:40:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D07B3CAD39
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 21:39:59 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 483442009D1
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 21:39:58 +0100 (CET)
Received: by mail-wr1-x436.google.com with SMTP id a14so26222237wru.5
 for <ltp@lists.linux.it>; Wed, 02 Nov 2022 13:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ntoy8AyCe/TRcbrwP5YL5bqphFHpz2TiQ7HZNNkJC0=;
 b=DC1vZZDhSiek0O7GCJAMr4GwxvFHlOxWZ3ycZybwT1dH80en7XsYl5YVLwcYvVezWR
 sWC8Hi4Unhprq1yA/t3QxNdiAnGeDdHUhAQm3kt/AClSz7ODumXEx6ElRDUB3DJXKfXl
 26/1qPvipWEwfCUBDT+qnzuwf5MIR3zwN9LeYsgZpWQAku9KOS8C1vzmnh2XkK8PcABg
 8kD7BhA+6U4XTI3WSGcH000HHqJRbXWx/xBhdEuTMcIEYc1JcWPZeWS7e/k1okO4eBM3
 Rsqt2t0aSUWwWQ+z+wobYaODqgY3LkXIyAKgeZOlH2eZnieQ/MwZPjvBHeKeq3PAMMOu
 A0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Ntoy8AyCe/TRcbrwP5YL5bqphFHpz2TiQ7HZNNkJC0=;
 b=CHh46xgZjhCxbsG2wQNIxfFLm1IHEFC3XpffQ4WdWX9RlFhhQEfGoUJTgF46geOAUv
 1oFjEzuLX4WHc373w6j0uMsd2saDkBKmruoqNa9X/QoErZujy4XYdRuHycsMvfNTE1il
 i5s7UbemvseytpGQ6bhdscTB3CLQj3iBlRQCBICylucaHvfqWxl2hd2hiYFy65MZ7mL1
 PSZFYgIz2+FU/t5x9CL2DWpLgld/fhLytsC2+hlZaNSXnyErxTNHX54Q17g6NUWvMqtl
 EIxOZXRpqt2Kt24LMfVO41GvNrHjnBRFj6eMehQ1Von5rA7A7CBHFS0VvDepm/SUjjiN
 RtdQ==
X-Gm-Message-State: ACrzQf3nsBG/28/2JMA5qtmwApRtybNFQatDfyIm3fTV7mRyHDwh79Lp
 bOOAKUXVXnewJGS0L/3jeoXmKSccCJ4AsA==
X-Google-Smtp-Source: AMsMyM5mWrfb21+TNzfMEXJtaAphaFMKGTIlDutLzR9XPj1/83u84PGXR6g7jKS4qAPIfC3GvYzFug==
X-Received: by 2002:a05:6000:810:b0:236:8a6d:e4e1 with SMTP id
 bt16-20020a056000081000b002368a6de4e1mr16316974wrb.661.1667421597401; 
 Wed, 02 Nov 2022 13:39:57 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 j19-20020a05600c1c1300b003a8434530bbsm3460435wms.13.2022.11.02.13.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 13:39:56 -0700 (PDT)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Wed,  2 Nov 2022 20:34:13 +0000
Message-Id: <20221102203413.547089-3-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102203413.547089-1-alessandro.carminati@gmail.com>
References: <87pme79f3d.fsf@suse.de>
 <20221102203413.547089-1-alessandro.carminati@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
