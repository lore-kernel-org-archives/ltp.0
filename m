Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECFCC433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:09:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 567BB3CB1B3
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 14:09:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDF863CB191
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:08:09 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1E4D360069F
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:08:09 +0200 (CEST)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-136b5dd6655so24291652fac.3
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lX6D5NTw9Tl/Zw5lEQs2/tiJvWxUJ6H8AougPEH/Ow8=;
 b=T4UggdU22Yn04kRg8yfyWMav56eiRUXImeFGN+yiAD+6TAw2srwsvMPKaNYuMrFP+e
 zjdO2AAzttouV9vUfjZOBuNK4GEhXK6cJqZmjgHpDYRChj6XJNsDb3LNAWIfRoEj1m3m
 NfMU16An2el4U4GoAZb3YzKYP1Ei4zQa2QwlDng90PJ1yPWj2pHLIBhOCUZwzkFyV90B
 ++TB9yf0NqfhGP8FonjZyd4+F8mM38Z4bBAL5ZL/tbz80WCIFy1ZbPQxpkjOqv6U2zom
 emeoYwzR4aENHw4RIYAE23f5Lb/oWydi6QkkCF85aUrQ/1qjapt6XLTKvvOZNKlDZD2e
 As5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lX6D5NTw9Tl/Zw5lEQs2/tiJvWxUJ6H8AougPEH/Ow8=;
 b=EYRxHLp8CTnxvPrclFRaE6DyzizrpoPi512XDCqs78gcDfkmpvOGH+3q6izJ5AFaOH
 LUNnppusC8L4VwUFhY52iuRCLKBM2g3QXLZWAj6uhF1vv2XCNeMuqCbUQyLfrKrxvW4H
 rcHTXUBxva1GE/h1myFarMLDmQGUwijrNKE3X2cxZhDAns0/7UBI6TTKJuorddIqUXw7
 F8t+brxO1puGceabtiSQ9mModK0fVzILCPe9ye4DMonWb1ht1NuBEvGcRvuBoLw3YqL+
 6PLyYFqJkR/BPW63mqfutC1E3bZhU+Lf4yhXF8Yx64KQeAVIwA5G4XKKzxcL4pDSd8bk
 JHIQ==
X-Gm-Message-State: ACrzQf3U3nIZJ9jTDUmRkxCdo01+P/rHYKcnkq8dc5iVuJFiVzDZ8exe
 dlvxJJm8kTjM4/H1oDmhd5bJAE4uo9CRKYqC
X-Google-Smtp-Source: AMsMyM6nKz208xIr8Cpzjq1jABT+Y1sMnZUPU+CuxDpvnujZrsihuQvuR3XDm51I7l1c54LIlpP08g==
X-Received: by 2002:a17:90a:e387:b0:211:2d90:675 with SMTP id
 b7-20020a17090ae38700b002112d900675mr5225555pjz.66.1666267677543; 
 Thu, 20 Oct 2022 05:07:57 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 r27-20020aa79edb000000b005403b8f4bacsm13078947pfq.137.2022.10.20.05.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Oct 2022 05:07:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Oct 2022 21:07:37 +0900
Message-Id: <20221020120741.212671-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221020120741.212671-1-akihiko.odaki@daynix.com>
References: <20221020120741.212671-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/6] ftp/ftp01: Remove verbose comments
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
 testcases/network/tcp_cmds/ftp/ftp01.sh | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
index a78d8adc0..2d61377b3 100755
--- a/testcases/network/tcp_cmds/ftp/ftp01.sh
+++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
@@ -45,12 +45,6 @@ TST_SETUP=do_setup
 TST_NEEDS_CMDS='awk ftp'
 TST_NEEDS_TMPDIR=1
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_setup
-#
-#-----------------------------------------------------------------------
-
 do_setup()
 {
 
@@ -63,12 +57,6 @@ do_setup()
 
 }
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_test
-#
-#-----------------------------------------------------------------------
-
 do_test()
 {
 
@@ -115,14 +103,6 @@ do_test()
     done
 }
 
-#----------------------------------------------------------------------
-# FUNCTION: MAIN
-# PURPOSE:  To invoke the functions to perform the tasks described in
-#           the prologue.
-# INPUT:    None.
-# OUTPUT:   A testcase run log with the results of the execution of this
-#           test.
-#----------------------------------------------------------------------
 . tst_net.sh
 
 tst_run
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
