Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4687BC433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:08:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A52EF3CB1B2
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 14:08:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E1783CB185
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:08:06 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9663A10004AB
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:08:05 +0200 (CEST)
Received: by mail-pg1-x52b.google.com with SMTP id r18so19005636pgr.12
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I832/Ksv30ChGn1YhfdsdHZhlGeEoBtGR1Ci27xR+l0=;
 b=Msxse3TtM6u8R/qAQT+VykQl38cT5XqL8baRvSlUNZ5a1ddop9ozcXvp3rPsbeDOna
 R+w5rMBoj7gYHVrR+6aVUZcFZ23Kwe8UpngHcUR6fLz/WhJImLamW912yepcHC4pqUTr
 qW7UZsdQN6jUCuwieKS8ROoiK+7pNiPhFVdlqU3HgppmgcGLO6EAWhCYejrlFMyrFBfK
 sFYHtRkmK6QvOQ/qK9gIFpriNXH98HfwrygZkAZygEuWdktM6FR1TZEo18agDhBwnX28
 9h8KdvlK+/7ajM6KLpcRvzVtHJTpbKxMv3tHuT7j3H7GsM87nQtcdu/vB0KWqymqLN6R
 3ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I832/Ksv30ChGn1YhfdsdHZhlGeEoBtGR1Ci27xR+l0=;
 b=Rybc4Lzsr4Sdq6rZBgc8Ls/4qun5BWcaJLmoNxosLTMHbKAzgaliJvDMVYEC7kpt2U
 BE8h3k1+FgRyEUpojCdiVS58mEPwH80QRAneju6BXLS/V+BlilCFj7LJO8y/1WzS0LJ7
 /NgMaipQzIlsRT+B0hllwu1/g0utnM5FHIodlGmbTdBsxbwRE+lU1WUh6XbVhtMQYTJE
 I4qWbbMFiQoBwWlg5Oyr0PGexnz2q/+9+ln0w/28OOIG4M6jMmRjsG/LGEHC/7UAU4Cw
 tyPsqTJGCgiC3TNDtiJwFCujbnFORGEO0gev/pCy2EPJWpl1Uckqevq+ejJSVawKROxn
 SGIA==
X-Gm-Message-State: ACrzQf2LekN6sryqSaVEQeDaOwkXbrMwPP/I88ZePwKRFjdStnN4xiF+
 cPMNUpFi4ZwBPgdtobqZrvHfjw==
X-Google-Smtp-Source: AMsMyM62PR0rmdMSwT09lS/2a2CFDIKtD8FYxwZZ0ih5zJ+mbvG9uCeYAnhl+ZcFhRKoV2aOCrMX7w==
X-Received: by 2002:a63:a06:0:b0:458:2853:45e4 with SMTP id
 6-20020a630a06000000b00458285345e4mr11218127pgk.20.1666267684157; 
 Thu, 20 Oct 2022 05:08:04 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 r27-20020aa79edb000000b005403b8f4bacsm13078947pfq.137.2022.10.20.05.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Oct 2022 05:08:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Oct 2022 21:07:40 +0900
Message-Id: <20221020120741.212671-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221020120741.212671-1-akihiko.odaki@daynix.com>
References: <20221020120741.212671-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/6] ftp/ftp01: Make variables local
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
 testcases/network/tcp_cmds/ftp/ftp01.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
index 10b35c384..8c0cffdea 100755
--- a/testcases/network/tcp_cmds/ftp/ftp01.sh
+++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
@@ -58,6 +58,7 @@ do_setup()
 
 do_test()
 {
+    local sum1 sum2
 
     for i in binary ascii; do
 
@@ -78,8 +79,8 @@ do_test()
                         echo $a $j
                         echo quit
                     } | ftp -nv $RHOST
-                    SUM1="$(ls -l $j  | awk '{print $5}')"
-                    SUM2="$(ls -l $TST_NET_DATAROOT/$j | awk '{print $5}')"
+                    sum1="$(ls -l $j  | awk '{print $5}')"
+                    sum2="$(ls -l $TST_NET_DATAROOT/$j | awk '{print $5}')"
                     rm -f $j
                 else
                     {
@@ -90,12 +91,12 @@ do_test()
                         echo $a $j
                         echo quit
                     } | ftp -nv $RHOST
-                    SUM1="$(tst_rhost_run -c "sum $TST_TMPDIR/$j" -s | awk '{print $1}')"
-                    SUM2="$(sum $TST_NET_DATAROOT/$j | awk '{print $1}')"
+                    sum1="$(tst_rhost_run -c "sum $TST_TMPDIR/$j" -s | awk '{print $1}')"
+                    sum2="$(sum $TST_NET_DATAROOT/$j | awk '{print $1}')"
                     tst_rhost_run -c "rm -f $TST_TMPDIR/$j"
                 fi
 
-                EXPECT_PASS "[ '$SUM1' = '$SUM2' ]"
+                EXPECT_PASS "[ '$sum1' = '$sum2' ]"
             done
         done
     done
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
