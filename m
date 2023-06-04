Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C68FC7EE29
	for <ltp@archiver.kernel.org>; Sun,  4 Jun 2023 09:50:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B2543CCBB9
	for <ltp@archiver.kernel.org>; Sun,  4 Jun 2023 11:50:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB2233CCB71
 for <ltp@lists.linux.it>; Sun,  4 Jun 2023 11:49:50 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C322920015D
 for <ltp@lists.linux.it>; Sun,  4 Jun 2023 11:49:49 +0200 (CEST)
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6260e8a1424so27076366d6.2
 for <ltp@lists.linux.it>; Sun, 04 Jun 2023 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685872188; x=1688464188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1hx5cgphoFIQ7VuRG+k7cvP2m903rzFPlGhzyu//HK8=;
 b=nDTpvgMp8ncnP9JJLZlJUPTR3/BcW7av2YsdSFrkd19coHG/PZdMZ1wR/vTLf2RXB4
 IILfHjr7d7jCB0DDg77yoO1sAC4aTPMQjphFZxmDX7FHIbkL1VHCa7JUmL/doM1+Ncyd
 Ju4eel6gpyR2eR8VfymexfOL+S4y151Q8fd1/6sl9r5saSKyZvdqZggaAtOuRrUOqIyC
 K4gAps1qQXq8ADctoZUEMf8y29W+8GdU8AmJ0WyXgf7YGANbrVaDBk0CzUz6G4Jb8ivz
 O0+N2/eLTOuDscyUnlx3Zp0KpKAds+lwAy/APKcRUw9TDXxGd02EuwWhQtcA+8ZLpuOr
 9/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685872188; x=1688464188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1hx5cgphoFIQ7VuRG+k7cvP2m903rzFPlGhzyu//HK8=;
 b=HV3Pz47XPGey1st4GCBpvetNNl74sEmoehXmG7TLZPO4gbNFz2IZR7z6A4m9T5i/GC
 kOHAq3WA4u7yacZQWqNe+jYLnQAQ1Vv/qoyPOSdBwmvU0zExdnapMwttd+u26trTYTTJ
 Lw09u+aMbB/b13fXZSYvTCgQN713q2wWWXIVZAevlLKATn6Zxm5hiWnqsmbKrKl3/DQ0
 sUiq7yTZBeNKusAL1VMO5YO5gDiXAyaxbhO0yqO8qjj+vGmhmt0hNN/xAPluzhKW+9dW
 QVcyAXSUbd+vraA4p8MGJihgOiuTg7hHAu6TUHM5MtAWQ52wE41NERetXwrNvIhbYUJR
 Ej2Q==
X-Gm-Message-State: AC+VfDxSi+Cam/794+c0B5ctDLyJdCwLKFWY9ktI1A+HvJ6y1VVa4LFQ
 XEWNAAasKa+VBJ1/WK54llESB1wJsJY=
X-Google-Smtp-Source: ACHHUZ69JHXgtRHlrfG1tAJ+W772RUxx2IXaDCEKefPY9Udc/MLHQ63LUjAqvo3BEGeqaESEE+C5Dg==
X-Received: by 2002:a05:6214:d4e:b0:61b:5dd6:1f22 with SMTP id
 14-20020a0562140d4e00b0061b5dd61f22mr3952149qvr.35.1685872188314; 
 Sun, 04 Jun 2023 02:49:48 -0700 (PDT)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a0ceb89000000b0062626bd3683sm3200974qvo.59.2023.06.04.02.49.47
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 02:49:47 -0700 (PDT)
From: Murphy Zhou <jencce.kernel@gmail.com>
To: ltp@lists.linux.it
Date: Sun,  4 Jun 2023 17:49:36 +0800
Message-Id: <20230604094936.3543223-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] df01.sh: put output file to tmp dir
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

Because the output file itself will consume disk space.
This may affects the df numbers. The chance is higher
in large block size filesystems.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 testcases/commands/df/df01.sh | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 5af4f68e6..919df9818 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -12,6 +12,7 @@ TST_CNT=12
 TST_SETUP=setup
 TST_TESTFUNC=test
 TST_NEEDS_ROOT=1
+OUTPUT=$(mktemp)
 
 setup()
 {
@@ -57,15 +58,15 @@ df_test()
 
 df_verify()
 {
-	$@ >output 2>&1
+	$@ >$OUTPUT 2>&1
 	if [ $? -ne 0 ]; then
-		grep -q -E "unrecognized option | invalid option" output
+		grep -q -E "unrecognized option | invalid option" $OUTPUT
 		if [ $? -eq 0 ]; then
 			tst_res TCONF "'$@' not supported."
 			return 32
 		else
 			tst_res TFAIL "'$@' failed."
-			cat output
+			cat $OUTPUT
 			return 1
 		fi
 	fi
@@ -86,12 +87,12 @@ df_check()
 		used=$((($used * $bsize + 512) / 1024))
 	fi
 
-	grep $TST_DEVICE output | grep -q "${total}.*${used}"
+	grep $TST_DEVICE $OUTPUT | grep -q "${total}.*${used}"
 	if [ $? -ne 0 ]; then
 		echo "total: ${total}, used: ${used}"
-		echo "df saved output:"
-		cat output
-		echo "df output:"
+		echo "df saved $OUTPUT:"
+		cat $OUTPUT
+		echo "df $OUTPUT:"
 		$@
 		return 1
 	fi
@@ -175,7 +176,7 @@ test12()
 		return
 	fi
 
-	grep $TST_DEVICE output | grep -q $TST_MNTPOINT
+	grep $TST_DEVICE $OUTPUT | grep -q $TST_MNTPOINT
 	if [ $? -ne 0 ]; then
 		tst_res TPASS "'$cmd' passed."
 	else
@@ -185,3 +186,4 @@ test12()
 
 . tst_test.sh
 tst_run
+rm -f $OUTPUT
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
