Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3BCCCF9E5
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 14:36:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD3E23C5556
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 15:36:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 475863C315D
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 15:36:00 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8914060005C
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 15:35:59 +0100 (CET)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-3727280ce17so9627661fa.0
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761575759; x=1762180559; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lbXrgy4K3MQjEx+3e0ulj8NeGVuFYqKBGfzcdwNKR44=;
 b=TAMK+UTVoZ04JTdiBfTFgB3MnUDiyz0QswDFxSgeinEauxEP3d4qWpMNDzSyLtJ+Ym
 s3SNZxvDW/yvv0vEoMRWapkYN6J0rRtizOk+DuhL6QzxjxwR6TA9+3q5fAG/f2jQ4LVn
 fJ+Pud6l1DrkOVc4npWypTw+HjgFVxihax97ao4REq/ulOynDmmwGrVWLUVkjIUOX4/7
 wS4wknyhookfc85wZOfR33ddswMlX902qZHEC/dEVAyaPDhqrzHglJrWb/Si0+exvns7
 lg1zjX1iIqgdhsu0OW6gMHcyaJ91UyS5jCFFIiXZe9wef457dlUTUcOuXR8dRFShvKvM
 bakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761575759; x=1762180559;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lbXrgy4K3MQjEx+3e0ulj8NeGVuFYqKBGfzcdwNKR44=;
 b=HVTg+j9ip2fFqLb+DzSWL/mbGnPile09ZH8pwM2qTnssQ6D2BvLCC76ugZ+xxfzm1q
 mJuONr+0Hs/e6zcCvoxjIiIhWwLm0wt5HJbUyZ21Csx1TRYmyAaqWFMdVmUTwp+2Nuev
 Hj/+ANRfKWTaiCmdbnJvDlJxW8t0sOKFsKY5Szuz0vGv4VcwE6qbd3EFQKmCUhfBAFH7
 Wi6jNzusWUakRG76m/DG0xI8MNwd2OG8hVNiP4w0IXk0+6uRmTG/sEhnqJgi91TtIw60
 itOfexSaHGM3bpZ3bLK/sl8f3Cg7fFYco1m8nX+B3q59tK4x1bHufuX3xvBUL1TeZQhS
 cFFw==
X-Gm-Message-State: AOJu0Ywkajve98m+91RGl5LfIRuL593vJS4CbRRcM3iS3/CBxb0veOBs
 A1aoGbhyRxj6Ys7Uduk5PmMyZ3d/dcyFyIdcFuGLi8x+aecm2VANpUISgb4YJlMKHPLkx41WONj
 o4iB+
X-Gm-Gg: ASbGncsCrOOAPJ916JPy2B7ImOiJe/DI1mGWl5lvqXMzniz9WHI+IPiGzzMP/tXhpgM
 bCWTB6A6jJRLcgJSl89Bc6+7dk5ZaYVHQkU9ueBUpp+67HRMSlu1P9m3EZ3K/GayO191BZI5VOg
 3+SRxvfaTnnc3tTfFuoztFjYMWnjHdnsEwM8qjx1AV+H4jF5Tepx7lEG8/P79Cop0+27if+ijvv
 7gh3nJXc4vbCoeFaxXvv7Ej9mwusFv8zhPNR+PIwA6setg3frsfcGMvCS+AirrFZw9P+5rIQ611
 jhHmz+4HYr8ijjae0nBjdWbJ7ylEDWPWX/9WXeMehdla3OfRlnsPBvzlcJO0AsobLKv2UYLFaaU
 411HCz7g4vTaItcQXDjqr5nYUvAwGhQ9Ex4/xC2TbdTdv1+SyIpdBLURbKnGAFzV3lzlnLSyB9d
 o/ym7iYYkzDo30WJj80ciupWnl08MTG+vH7pCmspmzJRFcWuP5NdwvhN2V7g==
X-Google-Smtp-Source: AGHT+IFSbnuHWvX/uWysTEj7CR4l4PwWNNJI24KyJ3bvd3+cc1iHjXy9ho1O/3rMYg7h2mZVeOVUzw==
X-Received: by 2002:a05:651c:3134:b0:367:625d:efd2 with SMTP id
 38308e7fff4ca-377cadf6e62mr45609251fa.7.1761575758676; 
 Mon, 27 Oct 2025 07:35:58 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with UTF8SMTPSA id
 38308e7fff4ca-378f5f7f99fsm12990031fa.15.2025.10.27.07.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 07:35:58 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it
Date: Mon, 27 Oct 2025 15:35:44 +0100
Message-ID: <20251027143544.3634170-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCHv2] isofs: Add ISO9660 kernel config requirement
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
Cc: benjamin.copeland@linaro.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The isofs test requires ISO9660 filesystem support to test mounting and
accessing ISO images. Without CONFIG_ISO9660_FS enabled, the test fails
with "unknown filesystem type 'iso9660'" errors during mount attempts,
resulting in 140 failed test cases.

Add the CONFIG_ISO9660_FS kernel configuration requirement to ensure the
test properly skips with TCONF on systems without ISO9660 support,
either built-in or as a module.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/kernel/fs/iso9660/isofs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index 088e062d67c6..3f1426c5ee1f 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -11,6 +11,7 @@
 
 TST_NEEDS_CMDS="mount umount"
 TST_NEEDS_TMPDIR=1
+TST_NEEDS_KCONFIGS="CONFIG_ISO9660_FS"
 TST_TESTFUNC=do_test
 TST_CNT=3
 TST_SETUP="setup"
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
