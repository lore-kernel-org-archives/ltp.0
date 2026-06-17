Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75F7CD98F0
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 20:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781726611; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=5nEpa5ep7PlGQElzbJoEYaakBp2nCqqum40cZp5NNFo=;
 b=hx05cx4bij44N072Xbd6/U7mavUQ/8Q4JjCvTAO1gYeuVPqsk5lNG651xlTGyJ6G4RNeU
 VVoiOITFC604JTwJmJaR/vlovNSuO7i1mxNp0ww7Sfnoj6MhgSFRTcEwOKEmBPvOAG9wBI3
 rMyFHBF0BiqzlbVc7YDmbl3vLY5+6Ak=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA6723E6BF1
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 22:03:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95BAB3D06C3
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 22:03:12 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C76BB1A00484
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 22:03:11 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490ac10e337so633515e9.3
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781726591; x=1782331391; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mWVWGlyZwBZ6Vw/jBY2ulYY8jmFkbICcp1k1Wqp8LfQ=;
 b=XpCfGoyW9409j0QnFc9KhdRAu4vA3LZDf6/ZBe0LFdn1/k4QZCQVTZaIjrHMjsVbqB
 GR6dskBr8S7jk4umtk24BueCiqEHE2PN5eL/gRXMVHqOOaIbAMLr3xLH+Dqd8AztKyQ7
 Ot0FyFFYEVahuY2d81oepwLf8f2Le/PxtBHR/gHjfPno3X8h+7/79WUG6jG17q+mJhm0
 I+iBqVWpMQLBAqL7cTJdKyieJtC3rQA/N4Z9JzmZiohd5zVqOkKfYOsJNt+z2dc79WAB
 S27M1dm5jA3hYjk1ZH9zQ8aBGoKCH/TTGqfvl4vAuzqNbNABvGVbqo2Uh7Pw/eduZWaa
 rnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781726591; x=1782331391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWVWGlyZwBZ6Vw/jBY2ulYY8jmFkbICcp1k1Wqp8LfQ=;
 b=V5Ti8px1+4Ae/Sfn5Xt/1KY/SodXl/kkirJSMQi3hRo8zcEjg9NO/V8/lSDCa7/NgO
 mDG307RsIQKDN7s5WzwSWd7BnFP0XAd5nmNqlfM5/ctuwdFGl+QTiPu8UEBpyKYRy95D
 6FgOqIaQyoBDsCaL2L5BvDkr2JkXVkLeAGCXYYZU6izZepapwS4DQynEKX5Mveg4m+4b
 ELFNBKMmg9V6qVYzjyXJahH/oaQ+EQc1eQJYbSFxkeHa5AJvARfEgy9CmNWEcD0w8t1R
 5wwl1rj2wVGkNK7/HionPTNMNTaJCUFtLm5U22Yj29fjNw2XAkNuZSjBTSiw1buD0fkR
 fI5w==
X-Gm-Message-State: AOJu0YwhcweDE2b7xkTJLV0hp2O6Rkx07WOGLJa6ADKpaniRZ/kBVTDM
 UWcfrI6nemTlw6SzOPeqDWosDojt1tc7nNwCX861tAiDlcY6eSdTZOuE64G8g7aBC3GspHRkaVf
 NgxNjyOY=
X-Gm-Gg: Acq92OHV3n9jBP5mo+3PcNW7c3awjiI7m9BzpQM1edGBKizzXHBNVUB+t7MEIAVDdVX
 uSAlLXyMl0p7BkaKVtQyk2kJmtwkHfUTp9jKyf1Dy+IWSfd00KIMhrT8MXeSJ2IU/B3fLyd1LDz
 tcApEeoBhfrZjlwzrzkXhj0Am3eZT+xnSAlGJonia0M4TyKVqd5hNeu7SrKUxej0JTmRLb0sjiI
 Z9twEjR8jcEEFinp1IAg2cBHftis0M3gXEaefVFQcmBZPIo5TJKkF/KQQckGrP+wmYqn1OzjU7O
 5t9XZXwGWUnA6k36J4Xy2/JoCZrc/6NOLYGZ2Yx9R3edrWoefcsKNPnQv0ODyc/4t3LAr+WFzY9
 e/8cHGUhNaqpbNYRW2T7r943SPIfH/tBSuidtsBRDctn3TK9yFdLbIzQMNUKCFTOp9TU+H00lWs
 p4M78JIEhN0w==
X-Received: by 2002:a05:600c:6385:b0:490:b1b8:95f5 with SMTP id
 5b1f17b1804b1-492381ec7d6mr13228625e9.15.1781726591239; 
 Wed, 17 Jun 2026 13:03:11 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa47ce3sm211980435e9.6.2026.06.17.13.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 13:03:10 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 17 Jun 2026 22:03:06 +0200
Message-ID: <20260617200309.176925-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fw_load0[12]: Skip on Lockdown and Secure Boot
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

looks like these checks were lost in the recent commit converting
these tests to new API.

tst_module.c:139: TINFO: module signature enforcement: off
insmod: ERROR: could not insert module ltp_fw_load.ko: Key was rejected by service

Fixes: fd2c4d2c25d3 ("fw_load: rewrite test using new LTP API")
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/firmware/fw_load/fw_load01.c | 3 +++
 testcases/kernel/firmware/fw_load/fw_load02.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/testcases/kernel/firmware/fw_load/fw_load01.c b/testcases/kernel/firmware/fw_load/fw_load01.c
index 4b30a3b40..c3d0c8c28 100644
--- a/testcases/kernel/firmware/fw_load/fw_load01.c
+++ b/testcases/kernel/firmware/fw_load/fw_load01.c
@@ -57,6 +57,9 @@ static void setup(void)
 		tst_brk(TCONF, "Skipping test due to read-only %s",
 			LIB_PATH);
 
+	if (tst_lockdown_enabled() > 0 || tst_secureboot_enabled() > 0)
+			tst_brk(TCONF, "Cannot load unsigned modules in Lockdown/Secure Boot");
+
 	tst_requires_module_signature_disabled();
 
 	snprintf(fw_size_param, sizeof(fw_size_param), "fw_size=%d", FW_SIZE);
diff --git a/testcases/kernel/firmware/fw_load/fw_load02.c b/testcases/kernel/firmware/fw_load/fw_load02.c
index 8d2063772..0a3a614d0 100644
--- a/testcases/kernel/firmware/fw_load/fw_load02.c
+++ b/testcases/kernel/firmware/fw_load/fw_load02.c
@@ -54,6 +54,9 @@ static void setup(void)
 	char fw_size_param[32];
 	char *tmpdir = tst_tmpdir_path();
 
+	if (tst_lockdown_enabled() > 0 || tst_secureboot_enabled() > 0)
+			tst_brk(TCONF, "Cannot load unsigned modules in Lockdown/Secure Boot");
+
 	tst_requires_module_signature_disabled();
 
 	SAFE_FILE_PRINTF(FW_PATH, "%s", tmpdir);
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
