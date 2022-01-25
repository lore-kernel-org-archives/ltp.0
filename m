Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327BBC433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 02:48:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E84DE3C93CE
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 03:48:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D5033C03AE
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 03:47:52 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 29C5060081D
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 03:47:52 +0100 (CET)
Received: by mail-pl1-x629.google.com with SMTP id z5so3897004plg.8
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 18:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:subject:message-id:mime-version:content-disposition;
 bh=9siN7kfgz73JNRwlgS58CJN8bS3ncTtS+V9abIcPpF8=;
 b=KippUnJLmvIBvR20wMJsLG6lUZFTT3/7nwV5H4gDm0+RVHndVtWRUCuLoHp4C6W0qs
 1RY12+KY28tIvBH0jRvkdhi6Ew1yG+WZjopt5J1ZxfTCXJv9CHEufJadL2Xl8ioQpghG
 TE+lgzJl9QNVWEMxjVVgS+F73ESy0hYHMUkV27XYFiwu9TrRmi/vPYsSuekpkQboje1c
 ObKrWnYCsptmwXegpjwEVPGKMlJtaLkvgG6xHBK1quaPzudbbJFMNkG2DGlFlXNlQBDF
 JrF8jWrU+BHaWZKSaF7158IlhwxOoDMlU3fQCapA7WtAEdAqgP42zgkBkSN2/D4VEdSw
 4j/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=9siN7kfgz73JNRwlgS58CJN8bS3ncTtS+V9abIcPpF8=;
 b=mmAiW9ugA9A2WbdJHRnE2gagw624U30JQkdIwKrDNJ5he30vCmg2t0gV7SPk/fhi/U
 ZiWcH1o7dyk8ZuOKpUs+xILYIy1XbwONb6sV/h/jxTTQAR2qO4c8hhwYQ7vP4sV+L8VJ
 tBRWVS0L7MLmIG/54kzAGZbV5iX5qKBBBTwDuxmyi9z91lTAbEUx4RkIXAkkZomd5bji
 Z2ckyo1kf91IWtY7KLFVeDwSx4uLgMHHhag1DeVLGOizWYfW/ACfTVFplYa5x3iPlkge
 LGJNbOrLC6+Cft0Yjw2DP55EK9ij9d9Wg2NtatnSi+BAFx1CrwJNUhu1J21TAPr2OMFM
 k7xQ==
X-Gm-Message-State: AOAM532Wo9CEKEuTygpa3s2YpcgA+OQCFKoh61t57YA8k9StHo03mOMV
 w6twiGNWb//2xRjmNW2A4Sxyom01iok=
X-Google-Smtp-Source: ABdhPJx62YKng23cuaOWeio/8V5qMDATilJ5wJ9cLv1x6pRWQMcLCgggpehCi//IRDy8wV4rlzw0yQ==
X-Received: by 2002:a17:90b:3a8b:: with SMTP id
 om11mr1302167pjb.184.1643078870310; 
 Mon, 24 Jan 2022 18:47:50 -0800 (PST)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id rm12sm637421pjb.13.2022.01.24.18.47.48
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 18:47:49 -0800 (PST)
Date: Tue, 25 Jan 2022 10:47:46 +0800
From: Murphy Zhou <jencce.kernel@gmail.com>
To: ltp@lists.linux.it
Message-ID: <20220125024746.gukme7rfwe6l3bix@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] runtest/fs: add fsnotiy-stress
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
 runtest/fs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/runtest/fs b/runtest/fs
index 1d753e0dd..3390e000f 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -87,3 +87,5 @@ binfmt_misc01 binfmt_misc01.sh
 binfmt_misc02 binfmt_misc02.sh
 
 squashfs01 squashfs01
+
+fsnotify-stresss.sh fsnotify-stress.sh
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
