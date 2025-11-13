Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6DBCD4F37
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 01:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762998835; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Nsz20qCpZQjmmyr6wfF3ejNBG8+gOfvQeHNfTtqrxRE=;
 b=ejs8dCk56rMmkdeur23Z/3KDdvcf7cWJ0kioD/+V9kJOXNQlZwG5EV7R/jghoZljxUORM
 rgg8WLEOlCvFNQNA1v/5+NPjVaMyG+5/4aJ6mb46W5C5LZVfffV0MPKM1EWpDNRHkbOfmkG
 Rns6JDHuOyrcfLZzDaX6Db6lvfAeHC4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 094963CF7BB
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 02:53:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6B343CF7A0
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 02:52:52 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 47B28600964
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 02:52:52 +0100 (CET)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b727f452fffso219203366b.1
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 17:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762998771; x=1763603571; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ml5Y5VOet49S41aSk2N+8oSGIIBpATsoelk1nFmg0Dw=;
 b=BfsMQF/3OYcT6d/dAhNeLb9qp+QVKu+wem2WNTRTBtb9fyNLrzF3rhyl2tNTqConXl
 63vqJ7IfzCvhz4iayRlUW1lqFD5XRESvQY1qr4tBfA3Nw9GhiwsO2wplmePtBOLCrHvK
 Gxo7p+ig76a/oB6G/U4ho45agU5ihSrVuaXhpDf+bQvZal2xEFJ8irIkJo4j3sqdzbU3
 HAbWlyhv/g07KnW28RSvefLAMuafr4tzoubJqj52xGQnaJZa2+txFbT/RVcjuDAjnZwt
 UbHIK217P77IgzbvFmod8DAoomllzoYEEDY6udqrn0eePmK7TgT/2sWZ2zIoOqCluSJt
 NilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762998771; x=1763603571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ml5Y5VOet49S41aSk2N+8oSGIIBpATsoelk1nFmg0Dw=;
 b=tnaPtufjK6Ao5DcsK7PW6tZnnx5l77KAcrUx5uVX2n73jQL2xyGG0SfsneEZVNHwFv
 KNrAn3TRC0Rbq6FrsusWNQcisrVkW/BtGs7cjXEFXGJ0HExXt+hbQsfig0IEzjOJP1lg
 q/eBG5cOUVEMGKm7ouxdwnQjK22b+kiW4dGP5XEERXteiy8UKNTqf5N47DbT8D7sEbOa
 hK9kVmfGJxfW/YcFjvXbXuMsuwoSBUYQ+8oWiqropF8guIK8CfcB6dGF/hRFOQbZhsQ/
 z8ooSHnEGli36YwmtxMt6dX6Ko2YjqCku6O/b7Th4daJmTwgTY09//8vZNBOtdYylvCO
 TREA==
X-Gm-Message-State: AOJu0YzD58cdK/t+xBGUooQU9xjghUbCtkiHNsz85++L5p/fVlfVKsRx
 bgOM53dEOff0aUqa3OAEAF5XKZ45YPJP5lhjC89Rot0kliYpa9j4EOimBKRyfn1jc6RNpav0TCX
 tvhc=
X-Gm-Gg: ASbGnctV48ogmDDbcGSLUwW/DdIlXfNySPoJqy5hpjbPngnUybH4khk1qYEcH2nRmG0
 V4yOe6WtBhkwZZd9i91yDX5abhJZ48B2Pxo+Z2t+x32dg0+OHkiAHaSQZLaeHrBZSLkug8Ze/uG
 N90qvQvb8Ow4YBfJ4PS7gs8NiGv+4oEQwcjHh6i45raCIAqikdcUtG1g31AAE6c7OMEwPTm09k+
 bMhmJ/UK1LZVlQj6oFDy5mSqbKF/EfrnLeYGDHmGvim2KgtCVdVUvAEX5MFJNiGHSK5V3Tym7T2
 +uZ4VnKBr5kJRgluriRS4TlYnufys3QgKfaB7Hmz+vy5+HfoN6GCMPO5WG12rom5fhNkrN7cFJ2
 FWXzCiL9ITIai5lJV8396XQwDEsAGlIvJfFQZSTulbmkCwWlvIT/4ounTLml4b9WW
X-Google-Smtp-Source: AGHT+IGhHTkq9gNw2CWc/sivY18AcbtuOvtnTrzHtnOuRcqDfULhblei9iI3FGzMndfXIjIt4JTcTg==
X-Received: by 2002:a17:907:9445:b0:b6d:5dbb:a1e1 with SMTP id
 a640c23a62f3a-b7348056643mr156203666b.5.1762998771474; 
 Wed, 12 Nov 2025 17:52:51 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fad41e5sm52199966b.19.2025.11.12.17.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 17:52:51 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 13 Nov 2025 01:52:31 +0000
Message-ID: <20251113015242.799-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113015242.799-1-wegao@suse.com>
References: <20251101012320.24972-1-wegao@suse.com>
 <20251113015242.799-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/3] ci: Add mount operation for busybox
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Busybox df implementation require mounting (unlike coreutils
implementation). Following error can be found during alpine ci:

runtest TINFO: * shell/tst_format_device.sh
tst_format_device 1 TINFO: Running: tst_format_device.sh
tst_format_device 1 TINFO: Tested kernel: Linux 0ba9f024d6b7 6.11.0-1018-azure #18~24.04.1-Ubuntu SMP Sat Jun 28 04:46:03 UTC 2025 x86_64 Linux
tst_format_device 1 TINFO: Using /tmp/LTP_tst_format_device.XXXXOajpgN as tmpdir (UNKNOWN filesystem)
tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
tst_format_device 1 TINFO: Formatting ext2 with opts='-b 1024 /dev/loop0 5m'
tst_format_device 1 TINFO: timeout per run is 0h 5m 0s
tst_format_device 1 TPASS: device formatted
df: /dev/loop0: can't find mount point
tst_format_device 2 TFAIL: df /dev/loop0 | grep -q /dev failed unexpectedly
tst_format_device 3 TINFO: AppArmor enabled, this may affect test results
tst_format_device 3 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
tst_format_device 3 TINFO: loaded AppArmor profiles: none

Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/newlib_tests/shell/tst_format_device.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/newlib_tests/shell/tst_format_device.sh b/lib/newlib_tests/shell/tst_format_device.sh
index dbe4ea9e7..b7366517e 100755
--- a/lib/newlib_tests/shell/tst_format_device.sh
+++ b/lib/newlib_tests/shell/tst_format_device.sh
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
 
-TST_FORMAT_DEVICE=1
+TST_MOUNT_DEVICE=1
 TST_NEEDS_ROOT=1
 TST_TESTFUNC=test
 TST_CNT=2
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
