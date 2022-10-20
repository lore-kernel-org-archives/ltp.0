Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C02C433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:08:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06AFD3CB1A6
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 14:08:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF18C3CB18F
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:08:03 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7A06E1401168
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:08:03 +0200 (CEST)
Received: by mail-pl1-x62b.google.com with SMTP id y4so1252220plb.2
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HSamzQMU691u272t9U0zFVAP6iXLXRYXU+Hewd9Tbbo=;
 b=yPpn5W4I8DrXVY14Zbeo3fkP+08/44sTaJSmm6VfOTpznVbTxu/TDRYxiOfF4l8YdL
 DQTmzutBz+w39qWhYT+dW88kdhfuoSOIKMPr+FE2JlVPG98IX6yMh1EaFVU6hH4SmUhW
 EfrsBW4jx3xVq4z4qLlxcaJqVzUxUkA3fUSc5CsGXEstCvBsDLCR4JXZBxERVypt8/wF
 pXmqfAwntv5szCeDXeMfRpAT0CUe3vfkgvPOUG0dgkW9fHyda480L9p4UDeISN5xJ3d5
 MD3tiWMyH+UgoMazNxbP9dZ9b1oe0PxgdXxduR1vPWkEcBtnpxtYQU/lBVE8GWgGxjSq
 nj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HSamzQMU691u272t9U0zFVAP6iXLXRYXU+Hewd9Tbbo=;
 b=i2rhGki6laGreP+IV9o+pl113If/aplmkGlnt1yHTOVx6i9iBlxKA2BFPxcSA9iaFP
 b9cYhcp1agCHdThQCZ88UJ7Tmd1L53w//tbhPdKMcot11x1Q6JoNWl2gqSxdDxIVNW7i
 lGgDQUGxuEtDC1QuIgAw7y/GL1MLVz/5jy8oTUl6/U3KVRSAH1dRFAV72JyN4v/9FGXA
 /EoYZ60pW2Ya8AMtixaRmrZGS4pQsF6XE8KKvQGXfLVCWeTyAMAmL2mk3IeKybi5tssJ
 JuNh+CvQ4dWpbBwasm+RQR+L2oeYT6COaVpdhCRlwI0jlJSC1ggklfHht6Z45m0GXnKK
 3uqQ==
X-Gm-Message-State: ACrzQf3KPRJipT7UWPVGke+dj6PhO0Eg2jYWu2F1SMK3GK7hYl/VtMcZ
 w7lKH5QMkX4fY1Y/rOd+RJmyV1wHnXpqWcEg
X-Google-Smtp-Source: AMsMyM5GIEqw9nPb2cJBVeVKsMS/4YRwOIVboU0447edCMi3t67bRzTM+JFlqnkZeX5QAr/tTheHVg==
X-Received: by 2002:a17:90b:4a84:b0:20a:f497:6f5d with SMTP id
 lp4-20020a17090b4a8400b0020af4976f5dmr15407582pjb.213.1666267682040; 
 Thu, 20 Oct 2022 05:08:02 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 r27-20020aa79edb000000b005403b8f4bacsm13078947pfq.137.2022.10.20.05.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Oct 2022 05:08:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Oct 2022 21:07:39 +0900
Message-Id: <20221020120741.212671-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221020120741.212671-1-akihiko.odaki@daynix.com>
References: <20221020120741.212671-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/6] ftp/ftp01: Remove sleep option
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

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 testcases/network/tcp_cmds/ftp/ftp01.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
index f8a3c98e8..10b35c384 100755
--- a/testcases/network/tcp_cmds/ftp/ftp01.sh
+++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
@@ -49,7 +49,6 @@ do_setup()
 {
 
     TC=ftp
-    SLEEPTIME=${SLEEPTIME:-0}
     ASCII_FILES=${ASCII_FILES:-"ascii.sm ascii.med ascii.lg ascii.jmb"}
     BIN_FILES=${BIN_FILES:-"bin.sm bin.med bin.lg bin.jmb"}
 
@@ -97,7 +96,6 @@ do_test()
                 fi
 
                 EXPECT_PASS "[ '$SUM1' = '$SUM2' ]"
-                sleep $SLEEPTIME
             done
         done
     done
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
