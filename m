Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE7DCCF9E0
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 12:57:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B93A3CF2D4
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 14:57:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 733893C7040
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 14:56:53 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 336BA600829
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 14:56:53 +0200 (CEST)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-592fff52913so32776e87.1
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 05:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761310612; x=1761915412; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xKEkVtmeNqDm7r0LKTAK2a3f4mZUKhIaEkKkh8kcbiQ=;
 b=wh9PK+v/cEQPcwcQQKcXBvdVGO8TtmI4xUeiuYigG8sQY4GLBhPollkYPlrUDQCz5b
 z4rRyJHP1dXy7sCStgomb+CAlBN9drIYVfebWD7AgRp6NT0otjnFJeE/KhOWNy4itLRB
 xj5bvnLsKGic0gWh0wGK7fkJmq7Ct8w5+paB+VuG6XYFTTvL0iTSK4yHgru0h/FmZqRP
 0nKYbqdJnldhj1Ks2z2TRaMzJwwM0e12uhHxlvLOq+d/wGnzEP6q7II+TG7+nav5hLTa
 7540HRpAluyhoNx7F/XwTylyi+yCPyXFbV1RMrdhb4Pkqg6aGAhexcgzEo66awRsDuvs
 sTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761310612; x=1761915412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xKEkVtmeNqDm7r0LKTAK2a3f4mZUKhIaEkKkh8kcbiQ=;
 b=KIxR2mKXrDDU8swSb6Nk+w8KxsveDUX7AYbksmQJs0R2MbkZtsrhRlyQs2NvdZhJ6V
 N3V3XdSyHfm7QMxl2TceRFo3KBrxlGDqL4ua5aIRhhB5of7GCjVCHH1Wjpzo2A+6hXr1
 QMdhUq6fAO+sws2goCTNQeTiGwXIQZT4jKKtjEgutazGTttbu+Trr1W7AOr3/gIMWnz2
 Ko9OrJ5dJLGQOdpzan9ToLxG1t9DjRx2l3d3f6LeOMj6WwdiH4w21shCNzVROL9I/w3x
 3+U2Y69/OD+N0UISL3CfnRLX3NrgtE3gO8EUSPNjJ2VXEJ9eBcd1LADDzQ6HI2IOJaRX
 M5RA==
X-Gm-Message-State: AOJu0YwzUC31BGE9lmIhy49lDKXhVAyCqAL18+hygIBR5/CZBCbbSX5W
 QBfClSVt0FhanInZhXTip1MfOkuhgSH74yd50S3wgPFXf13CX7tiIkQJ2aoOYfwKyxAcSO8L72u
 zTxEg
X-Gm-Gg: ASbGncv1qpbmfZzD+uhi5lemSnGhL+lTolD/6kYpfJRwZF3I60SZgHNO7j4Y6ZAOd8j
 F9UWpebq9BGQOa83tpX1flPLSVPpBp3wN1cr/f1ZFsvYACV0ic9XLkpUCqza2g8Xpms4PMndT9k
 9HciwGypdvBnpECSmJRoXaowg2VCp7N5ywL2AT2o9/gG/9vCo+eSKyEOIMHjznks6DrxAlM+aOk
 TV8brzWKszcYDGvwvq4paEJ4qTeI1t5/swu0LP/O4UTFLpITAWiw3CPQ06tmExljxG9Z44wbznZ
 0KFGmEFIzK+d5Iic5osGGAnSZQGPUhkQQtmDmRMIV1+DkxiOEtKgmfJOtu+xPURxWgzReJj8LJm
 xIvHyS5nWNTtMKkQ1F5Yw46YnEG1K/LLcAnxeNmMjJDH0RWWdXmKFT1i1mkEB4QwqVSG7NaU6lH
 psww4ks09GRoy5Hbviy0hsXvOkdTPj7Z3qui7TQPsm6xiwkQnhbbfkyqh9cw==
X-Google-Smtp-Source: AGHT+IGUQVDs9fiTvbxvCdhc/lhdGOGE4+sTsRXGp4Hp9lJQIFXWgD1SNcy4HP2a2NVbX30ERk4fng==
X-Received: by 2002:a05:6512:3b8b:b0:57d:9bd4:58d5 with SMTP id
 2adb3069b0e04-591ea31581dmr3638083e87.5.1761310612361; 
 Fri, 24 Oct 2025 05:56:52 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with UTF8SMTPSA id
 2adb3069b0e04-592f4d2c2desm1627999e87.91.2025.10.24.05.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 05:56:51 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it
Date: Fri, 24 Oct 2025 14:56:49 +0200
Message-ID: <20251024125649.2343520-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] isofs: Add ISO9660 kernel config requirement
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
index 088e062d67c6..c66a284cebf1 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -11,6 +11,7 @@
 
 TST_NEEDS_CMDS="mount umount"
 TST_NEEDS_TMPDIR=1
+TST_NEEDS_KCONFIGS="CONFIG_ISO9660_FS=y | CONFIG_ISO9660_FS=m"
 TST_TESTFUNC=do_test
 TST_CNT=3
 TST_SETUP="setup"
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
