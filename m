Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D80C4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:08:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41FBA3CB19D
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 14:08:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 983423CB1A3
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:08:08 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2252D1A001B0
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:08:08 +0200 (CEST)
Received: by mail-pg1-x535.google.com with SMTP id s196so17728353pgs.3
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uaNdtCtK7RMnjrx48K6uekX5rQGql6WCa+w8jn5gHIs=;
 b=GOxXdbcPAuR5Lkqz4WULi9UIzWgkXHoMeTpmng7Q+MxAh0yhd0QyDVt0JBrVagzNZK
 UY5C/ulhmo+Yx9pBNo2qGP5m6FT8IOeX9xg1eARQM5PX22b8NxJFQFE1mzenR7ADyJPQ
 Qdy6fhnGiiZJe4f/MqWDqZ1rxvuJJZd4Y5bUJwlLi3hJeLv13lQC6dVLcGq+py6odsl8
 BVp4hR1NDLvYVbDL4jeS/zyZmyjhkZOaPB/fzg019fROmntvepB2ZwZinTYm/NaCZOsg
 Qw6ZVbkCeLiU5f1N+gadY1Gavmjw1cn9HHkwCP6uRKI+/bUQ5JsPEIxjg7ZWTRvqGSMI
 ws8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uaNdtCtK7RMnjrx48K6uekX5rQGql6WCa+w8jn5gHIs=;
 b=TT8XXGZVgib7FHlmldA2HWAIuLVW0j0aK/jtFpsiFtn80lCgVOsv1Ge9KJtTXiFxqN
 MCUO3qqRTWVyBOziASx4w4q3wzQXYOiVrCE+ioHrnG19p+ItLtCg8Gerh8nGJ4Xu1DrC
 pWsBsvgLY2U6feX6vFNSAjAb/Q6xFevYcUJUPejskZ2WalgDL+qlmuW427ncx1pa98e/
 XO7q/DYpNAp/JaCRlkIb9Wj028D2N1r7uhSFY32v+/Y+Um+g2sqMqGetE7hHwnrgnn8L
 HxbtNudTgsORHw9AW1HHTbvcYvjmcN23YcdV7EX+Y4AP0PokeOPnbKBSsp8Rl8QAH7sj
 ZDIw==
X-Gm-Message-State: ACrzQf2XDKEawnM8sIoCFNcqOcihvX2xMt2+j8+DLFkAtNhIMpDikQEz
 B03FTah8KsSEBBBtVuDG90Ai3Vd/NxOA7sjn
X-Google-Smtp-Source: AMsMyM6ShxX4abJjMabrPA7VuWMlsSR3Av/DaiB76nVwSJN9/NEZDWokuzVNWBbBCNWwfOXx8QOjbQ==
X-Received: by 2002:a05:6a00:cc4:b0:566:87c:53de with SMTP id
 b4-20020a056a000cc400b00566087c53demr13374432pfv.19.1666267686685; 
 Thu, 20 Oct 2022 05:08:06 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 r27-20020aa79edb000000b005403b8f4bacsm13078947pfq.137.2022.10.20.05.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Oct 2022 05:08:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Oct 2022 21:07:41 +0900
Message-Id: <20221020120741.212671-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221020120741.212671-1-akihiko.odaki@daynix.com>
References: <20221020120741.212671-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] ftp/ftp01: Split the test function
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
 testcases/network/tcp_cmds/ftp/ftp01.sh | 88 ++++++++++++++-----------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
index 8c0cffdea..8bb659d54 100755
--- a/testcases/network/tcp_cmds/ftp/ftp01.sh
+++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
@@ -49,56 +49,66 @@ do_setup()
 {
 
     TC=ftp
-    ASCII_FILES=${ASCII_FILES:-"ascii.sm ascii.med ascii.lg ascii.jmb"}
-    BIN_FILES=${BIN_FILES:-"bin.sm bin.med bin.lg bin.jmb"}
-
     RUSER=${RUSER:-root}
 
 }
 
 do_test()
+{
+    case $1 in
+    1) test_get binary;;
+    2) test_get ascii;;
+    3) test_put binary;;
+    4) test_put ascii;;
+    esac
+}
+
+list_files()
+{
+    case $1 in
+    binary) echo 'ascii.sm ascii.med ascii.lg ascii.jmb';;
+    ascii) echo 'bin.sm bin.med bin.lg bin.jmb';;
+    esac
+}
+
+test_get()
 {
     local sum1 sum2
 
-    for i in binary ascii; do
+    for file in $(list_files $1); do
+        {
+            echo user $RUSER $PASSWD
+            echo $1
+            echo cd $TST_NET_DATAROOT
+            echo get $file
+            echo quit
+        } | ftp -nv $RHOST
+
+        sum1="$(ls -l $file  | awk '{print $5}')"
+        sum2="$(ls -l $TST_NET_DATAROOT/$file | awk '{print $5}')"
+        rm -f $file
+        EXPECT_PASS "[ '$sum1' = '$sum2' ]"
+    done
+}
 
-        if [ $i = "binary" ]; then
-            FILES=$BIN_FILES
-        fi
-        if [ $i = "ascii" ]; then
-            FILES=$ASCII_FILES
-        fi
-        for j in $FILES; do
+test_put()
+{
+    local sum1 sum2
 
-            for a in get put; do
-                if [ $a = "get" ]; then
-                    {
-                        echo user $RUSER $PASSWD
-                        echo $i
-                        echo cd $TST_NET_DATAROOT
-                        echo $a $j
-                        echo quit
-                    } | ftp -nv $RHOST
-                    sum1="$(ls -l $j  | awk '{print $5}')"
-                    sum2="$(ls -l $TST_NET_DATAROOT/$j | awk '{print $5}')"
-                    rm -f $j
-                else
-                    {
-                        echo user $RUSER $PASSWD
-                        echo lcd $TST_NET_DATAROOT
-                        echo $i
-                        echo cd $TST_TMPDIR
-                        echo $a $j
-                        echo quit
-                    } | ftp -nv $RHOST
-                    sum1="$(tst_rhost_run -c "sum $TST_TMPDIR/$j" -s | awk '{print $1}')"
-                    sum2="$(sum $TST_NET_DATAROOT/$j | awk '{print $1}')"
-                    tst_rhost_run -c "rm -f $TST_TMPDIR/$j"
-                fi
+    for file in $(list_files $1); do
+        {
+            echo user $RUSER $PASSWD
+            echo lcd $TST_NET_DATAROOT
+            echo $1
+            echo cd $TST_TMPDIR
+            echo post $file
+            echo quit
+        } | ftp -nv $RHOST
 
-                EXPECT_PASS "[ '$sum1' = '$sum2' ]"
-            done
-        done
+        sum1="$(tst_rhost_run -c "sum $TST_TMPDIR/$file" -s | awk '{print $1}')"
+        sum2="$(sum $TST_NET_DATAROOT/$file | awk '{print $1}')"
+        tst_rhost_run -c "rm -f $TST_TMPDIR/$file"
+        EXPECT_PASS "[ '$sum1' = '$sum2' ]"
     done
 }
 
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
