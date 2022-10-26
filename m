Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316F6C433FE
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 14:10:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0353D3CA55F
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 16:10:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEFDF3CA7E1
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 16:10:13 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 15FD4100047A
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 16:10:13 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id n12so16215414eja.11
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cqe9Qa8vaEwEDFgZrndu1D/jpfVK1M1LtWR1Zo0pEtU=;
 b=QLEZhAJgIJFtyf5czIhmtSRn0CHlP1j1GH8a5GHghWIjAMxb7hP0kPC4lYHLdxTyMT
 uks87TFCCMbO86o7kxoXixyIA9lbxgj8mz+nGoRPa1wfz+XfyLbDZlV52IwFHBvFAY5L
 5KU0AppcoX2I8loCSfqoCHVgYouhc6U3pPAIyb6zD6iSc6ur4YQFQ901NO8QjVcaPXT3
 xOuGOfbroo4TIL5K9WOUOUbDv7o9asgA7GzNgZTxtbdCH+jprl+wg+dGzXWNrfX2pShn
 rRXhPZHcMQ6ZP8nIWzoJeGzUcFB7fjpZOC2xQJufHokAKsl7NmHgPK8sflB18h6PMdc7
 /yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cqe9Qa8vaEwEDFgZrndu1D/jpfVK1M1LtWR1Zo0pEtU=;
 b=egqusxH1Lta213+NJlk3PlcZQ0CSMLRZN8fKs14QJvVzWB0CWZgkXe/3NFAlQB4s77
 hOgQsXES05tRzYy4/CN2OSAO/HrSkqTf7YtswPcjm0ket23ASYdOhscnIk7FtrOuNby0
 tlmCIbXc0g7mhPUuLWAwOwDEELU2QkgEhUiZJbPWe0mTgA5tODCitbn4bn49g+jz0VyZ
 vS0JIfgaemmjDpK51kS//r1ENYk9zm5B9WWOnCjfJRj2+IXYgiKKXzs0di/sSAbNWbP+
 /C/MxWzbdd0KM54wnFs/E3NdpgDr4bdS3DLot0EIkUkzRA7tPtgNoRmxCpVep6s3KD9E
 FMOQ==
X-Gm-Message-State: ACrzQf0bFPAW87bpM39z38FzOPuyq9SygV4+Gs0tgJ5dbTKW/d6Q4XOH
 jIC6RT4sTpeQWRCGYzVHX5bY1OOl9UpTLQ==
X-Google-Smtp-Source: AMsMyM7tcnxbaPXvqTiSMe8oN2GCJPPjOkgqFG5mFRcv26kZIg0MyCDUvABgc5sowzNDS23vGPpmQw==
X-Received: by 2002:a17:906:8a48:b0:7a5:a8f5:b870 with SMTP id
 gx8-20020a1709068a4800b007a5a8f5b870mr16221020ejc.458.1666793411906; 
 Wed, 26 Oct 2022 07:10:11 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 ka3-20020a170907990300b0073cd7cc2c81sm3022156ejc.181.2022.10.26.07.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Oct 2022 07:10:11 -0700 (PDT)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 26 Oct 2022 14:04:08 +0000
Message-Id: <20221026140408.471609-3-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026140408.471609-1-alessandro.carminati@gmail.com>
References: <[LTP] [PATCH] Fix tst_find_backing_dev when no initramfs>
 <20221026140408.471609-1-alessandro.carminati@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
 doc/c-test-api.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 64ee3397f..b579e85ee 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -1067,12 +1067,11 @@ is created for that intention.
 -------------------------------------------------------------------------------
 #include "tst_test.h"
 
-voud tst_find_backing_dev(const char *path, char *dev);
+void tst_find_backing_dev(const char *path, char *dev);
 -------------------------------------------------------------------------------
 
-This function finds the block dev that this path belongs to, it uses stat function
-to get the major/minor number of the path. Then scan them in '/proc/self/mountinfo'
-and list 2th column value after ' - ' string as its block dev if match succeeds.
+This function finds the block dev that this path belongs to, it uses the unevent 
+file in sysfs to find the device name from the major and minor numbers. 
 
 [source,c]
 -------------------------------------------------------------------------------
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
