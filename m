Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD22EC4332F
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:12:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E71B3CAEDD
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:12:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 586603CB56D
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:23 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD97E200130
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 05:47:38 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id p16so2357301wmc.3
 for <ltp@lists.linux.it>; Thu, 03 Nov 2022 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ntoy8AyCe/TRcbrwP5YL5bqphFHpz2TiQ7HZNNkJC0=;
 b=CG3I2dQMGt1hZt325Q2j3xkACzq8H1fOhELRFe8LTnyYfI5hxlcY+oOwo/KT0iddzQ
 TvAuOS9AzxsfF5/c2eqW0OKXZgguxjG4nNjnsDsKXcON4bXVwDJVCYmXxxyp3JDUjq70
 cpfrmoDoCQLhdY5D9HoMoGSNCpzQn8MIHg7IxVTeV2OT7Lud4f0kFNboZOSvc9Q2pc5O
 jb3VSjBSzHrQ/fP1oS2XGrCZSm2Y8UC+FSP36DPsbl7Y0DjeihJQm1s0s/sE3iO53b7Q
 kL6lkf/H/CkkUhWtEsgntDjuNPrYrQnaqEBaxpT/XfGH//FKybQlVefK6+vqocLjPUkf
 soxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Ntoy8AyCe/TRcbrwP5YL5bqphFHpz2TiQ7HZNNkJC0=;
 b=avRiJ0IjMq8jja6M9xl4nIJC5m2xPp8rSmC+EWFhuClYV05wOGsY6cKjJE1jL8xl3Y
 O0NekaXfaRKGLiVpQejEL0J7otKDZxia8DkLsszn+dLFaek/JaBl+9Ap3vSR2pq+bXZW
 D4vNDlLXTrfK1vyZVA1e2nHhymgc0ZGGvyO96Cd+MbMHx1LXc18GKFfa6QbhuJWAtvOZ
 sv0na+4SwJAOAeRPkb5fLB0bsKUUmXHYktaDxqFgK12RU1j6bM730xPyx6pNj007bckf
 lyOrV4JVR54Ag4IA8udi7ZqT/AOHnPAedVS2YJgLQzlaLJb5+KwZRXc26zMvRdWYgRZY
 Wp4w==
X-Gm-Message-State: ACrzQf02tWSATa3oq+nPxhU8Hx5YqLP/d6RfYNhgopID+XRuHKW8EIry
 BBEUM38EwnhlZtr3GDqmOIRF9Hb1Zx4OPw==
X-Google-Smtp-Source: AMsMyM4yhQOInLjclwdpFi1XSQ86p+szw5fqtIdbkdTPNmMEYZdvAaLOUMYCqsceOeYlSo8PiQJAPA==
X-Received: by 2002:a05:600c:3b88:b0:3c6:cef8:8465 with SMTP id
 n8-20020a05600c3b8800b003c6cef88465mr31817038wms.64.1667537258190; 
 Thu, 03 Nov 2022 21:47:38 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 h19-20020a05600c351300b003b4ff30e566sm9583599wmq.3.2022.11.03.21.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Nov 2022 21:47:37 -0700 (PDT)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Fri,  4 Nov 2022 04:41:49 +0000
Message-Id: <20221104044149.655317-3-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104044149.655317-1-alessandro.carminati@gmail.com>
References: <8735b0jos5.fsf@suse.de>
 <20221104044149.655317-1-alessandro.carminati@gmail.com>
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
