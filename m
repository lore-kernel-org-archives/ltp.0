Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB224C43217
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 05:59:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67A603CAEE5
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 07:59:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 649493CAEEF
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 07:59:31 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9F1461A0110F
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 07:59:30 +0200 (CEST)
Received: by mail-qv1-xf2e.google.com with SMTP id o67so664972qvo.13
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 22:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=19Fj/8eIHs/a7WhE19acLT4vvCBbZJAz7iijelipC8k=;
 b=uLtxq87Ioh/UIkVW3B/M5vEGVEtJnIxzuILgkqWrexQqd2FcPlp8vLIHIIND4CpF0e
 xvazUS/x768/ZYNXD6uCDoMm4nE1CF4QKNGlHFR1rhEC31VCxBbbML2iLhiRan+aDq27
 qa9HYrXYmLdxkGM/RrONRZH+P41GZQ7wUTYESyKNI6l685th+IreHp/G60zWOT7pIjUj
 NTgHn+QnaMHUD4PhjvWQu36NuU7Cgogdmj2MG3fU+OpqQoH38JUpITO08vV5+/zEVMwt
 MY7K25p2XH+XWlGjuP+yLC8yD6HlamVJ/7DOLiw6NoK26zS7aRuNLnX8zeZWO3pksCt8
 93ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=19Fj/8eIHs/a7WhE19acLT4vvCBbZJAz7iijelipC8k=;
 b=ItWvB3Y7Rv+k1xGSRmozDOGCssDK2ScAvwTU3qcITWAIBK4cJ3hV/h/cTK9D4C9QNr
 2yPCy9wS5E/bNSQLzoNOZh7WCOp9inrqVxZd76BO3FEuyR+qbRPGntDZky4wskW6izWO
 tL2qGEvl5AOikm/hnexon36GC3NDoxdLrH7O4BSD8o7E7k+dmRe9Fiowh5MScPT1wFLz
 REW+Z7r6t/Zw8NRlzG0cXw6KpJqSL/GdW/ctFPqn2dm02q/MvSxndmQ69lcWDJ7BxM71
 Z3mM/pC13msD8XDW0ga+GZVRjv2eOSBgRyBYHCuBqsb6rG2+2H39kiIwXdI+BdZzRfOM
 euCQ==
X-Gm-Message-State: ACrzQf1uso3Op3Rse53fY39OHRQHDhFOL8PTG/uDDSlkvPU9NpgSGgQB
 Vs2ZoObWZMW2BtAIJAxmrjrD9lm9e8CTCw==
X-Google-Smtp-Source: AMsMyM5UcNcAtFOojxCX+F2u6ySBKEd/1IunjqOyJ3zma4Flk/K4GtFN4supvcksP0xMPrzHKgCOBA==
X-Received: by 2002:a17:902:ccc2:b0:178:29e1:899e with SMTP id
 z2-20020a170902ccc200b0017829e1899emr33116901ple.114.1665640758318; 
 Wed, 12 Oct 2022 22:59:18 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 y17-20020aa793d1000000b0053e6d352ae4sm953767pff.24.2022.10.12.22.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Oct 2022 22:59:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: ltp@lists.linux.it
Date: Thu, 13 Oct 2022 14:59:13 +0900
Message-Id: <20221013055913.29058-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc: Correct git send-email spelling
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
 Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 doc/c-test-tutorial-simple.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/c-test-tutorial-simple.txt b/doc/c-test-tutorial-simple.txt
index 867c26532..9321d537d 100644
--- a/doc/c-test-tutorial-simple.txt
+++ b/doc/c-test-tutorial-simple.txt
@@ -271,7 +271,7 @@ the below
 --------------------------------------------------------------------------------
 
 Obviously you need to at least change your name and e-mail. The SMTP server is
-useful for +git send-mail+, which we will discuss later. The editor value is
+useful for +git send-email+, which we will discuss later. The editor value is
 used for things like writing commits (without the +-m+ option).
 
 [source,shell]
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
