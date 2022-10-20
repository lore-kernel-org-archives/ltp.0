Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38338C4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:08:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD79F3CB17B
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 14:08:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA7D03CB19B
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:08:02 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2893C1000466
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:08:01 +0200 (CEST)
Received: by mail-pf1-x42d.google.com with SMTP id y1so20074582pfr.3
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ae0yhJSINWSuQswycdp0xgfUq3qQ8JORRsbYicGiEA=;
 b=AU81/39XghjAuVnKffZPSyhU8od/eNabwPizN3WwxDo502zhhTPwTl2e9e8ZZ16h3G
 30DZR/DFkRFVAQewYgtGD+3jirox73EoADwgtjjzpI5q/0tneEP+NLyGriJQZaGQXvBk
 g6up2MGyA3a63lgSCCXNU7UFgrIuRDe6jAurM0fIAAd99NhM/hg7BdBZyghwNi80aYrM
 pUxIIP+8ZFN8/E3dWUnVKvTEJSxUkKwC0LKtNEN0+crssALKxM5D4c/eW8eSy4w6dCEC
 h0BnUQPwCaHBMaAn34TMr0rSoJa+obZ6DfivEZn9b1h5B8nHbO8H7OjX5Zk2Y8pcqG4S
 zPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ae0yhJSINWSuQswycdp0xgfUq3qQ8JORRsbYicGiEA=;
 b=MnD6DClmcHmKGwzPFh0ERJa47V4y408UBFZ/GGbmYA1OSd+Ognl3jgZWRoC0mUsJzm
 sazEqxD7FnPEfmiLtP9rsOiQMQ+uwp0M/sLFRBDvkstx0qq1u9YPeKy4MffheaZBuXOR
 Aq2OFfuMPCMTFDQgE8Gk4fcj1nYQbRs9pfny6slLmgjvpBMYIitvEguiFH4DEzvHgz1s
 H938K8OsuwKF5EGYt6atOdugSCbArK8gMgSRUYph6p5ErDxCc5WX04+3wNpOAJeDFXqG
 VkUEQaSZp0/MN51UhPspSb5/dMuDMCQJ3SjTLiEXciCejlwJpbYrQj2El/E7F9r/h5Rr
 9bYg==
X-Gm-Message-State: ACrzQf2jmCfiJYfE/HBXrc7joi2JUF7rAMt1Ct7w4NN9Ukl0f/KLzGZS
 kgUJwsespl3Bpb2rgn0/DCBZkpCsDEE6Gzpa
X-Google-Smtp-Source: AMsMyM5pNZ+jc/6WJrR0d8WXzgbE0uuVNaetWihygjDOGRkWonFxf/OW0EswOkYL/hFRNB4X7b+NpQ==
X-Received: by 2002:a63:e22:0:b0:458:cfe7:958 with SMTP id
 d34-20020a630e22000000b00458cfe70958mr11365363pgl.449.1666267679731; 
 Thu, 20 Oct 2022 05:07:59 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 r27-20020aa79edb000000b005403b8f4bacsm13078947pfq.137.2022.10.20.05.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Oct 2022 05:07:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Oct 2022 21:07:38 +0900
Message-Id: <20221020120741.212671-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221020120741.212671-1-akihiko.odaki@daynix.com>
References: <20221020120741.212671-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/6] ftp/ftp01: Remove old-style command substitution
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
 testcases/network/tcp_cmds/ftp/ftp01.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
index 2d61377b3..f8a3c98e8 100755
--- a/testcases/network/tcp_cmds/ftp/ftp01.sh
+++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
@@ -79,8 +79,8 @@ do_test()
                         echo $a $j
                         echo quit
                     } | ftp -nv $RHOST
-                    SUM1=`ls -l $j  | awk '{print $5}'`
-                    SUM2=`ls -l $TST_NET_DATAROOT/$j | awk '{print $5}'`
+                    SUM1="$(ls -l $j  | awk '{print $5}')"
+                    SUM2="$(ls -l $TST_NET_DATAROOT/$j | awk '{print $5}')"
                     rm -f $j
                 else
                     {
@@ -91,8 +91,8 @@ do_test()
                         echo $a $j
                         echo quit
                     } | ftp -nv $RHOST
-                    SUM1=`tst_rhost_run -c "sum $TST_TMPDIR/$j" -s | awk '{print $1}'`
-                    SUM2=`sum $TST_NET_DATAROOT/$j | awk '{print $1}'`
+                    SUM1="$(tst_rhost_run -c "sum $TST_TMPDIR/$j" -s | awk '{print $1}')"
+                    SUM2="$(sum $TST_NET_DATAROOT/$j | awk '{print $1}')"
                     tst_rhost_run -c "rm -f $TST_TMPDIR/$j"
                 fi
 
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
