Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799ABC46467
	for <ltp@archiver.kernel.org>; Wed, 11 Jan 2023 10:46:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 950AC3CB584
	for <ltp@archiver.kernel.org>; Wed, 11 Jan 2023 11:45:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 261FE3CB54E
 for <ltp@lists.linux.it>; Wed, 11 Jan 2023 11:45:48 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B35CA600971
 for <ltp@lists.linux.it>; Wed, 11 Jan 2023 11:45:47 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 bi26-20020a05600c3d9a00b003d3404a89faso2213851wmb.1
 for <ltp@lists.linux.it>; Wed, 11 Jan 2023 02:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hzIxFAixvTgNepkI9PJWI8sNp1ezR4FX1GHJVam0q2Y=;
 b=Oa7k0RoT3T4roe4ryoCKc2Z6PKqHMzQloYQrnEiygwSiGZFseVyKWvdTalDbb8skvI
 T0NJhrlRgOIkjggaftiXFqUvNBaQ3oS3xZ8XGOTi6/6WdrCsha2otDWlfxDLFO6p5JZN
 0klctn+FDGuzNE/GghetgF6m4D8m9jRYbbz9bFGhlKr/s5tX6OstEnWRehhQ2AwvRTpV
 n1Bk2VWZ9ANQzsEQC3RBVnIlqB+p2IUSCUxc7bcZ3BYdkKpAaCJongHvs5LSxY4F6yJr
 vyOSFpX/abxNppCq8NRxkQjIWi4VllzZEfJGZfWXNHolmnBbtTmMPdbGIh+HuAS5BxzK
 TMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hzIxFAixvTgNepkI9PJWI8sNp1ezR4FX1GHJVam0q2Y=;
 b=D+AUAVSF2zgMq1xNSEmgOCh0DyXitzlJB997FW3K00m7rOHkqv/dJKF3b1DtEIHypp
 MzRj7vKHhkJb20MhklbrSg6Sv1mcsBSRRiExn2BC2aNowM6uJVh3pe8Vkh/OydG2gEZ+
 GUM+ATSC8dOA5kz1gNpfY+KJTQqy2S4H4mBvICjwSduGAhaTD0ua5cpH1WSoiHJ1p25J
 SUKXuH5anTG+p7phi3hyqQUBqueQZFsbY8k1Jz9IgX3DGd07pgrYzTKTln38XBlORXbq
 PzEJFmg4oIi+Ds7QlBlYzXR80zcr2p0v2nWV2P7Yk4YRGplbOFb/YifEWkf9ZDcxKbKo
 5C1A==
X-Gm-Message-State: AFqh2kq5Q6PkCYB9/L4gT+dNgnpobxS9FCT861Js+5EfXNyc8Pk6CAxr
 KQpXRvzSBt2e4puKOiPyleVWuXH+ztM=
X-Google-Smtp-Source: AMrXdXvCX+tQ/+Kk+Vemuz6Ar7srBkiutTNOIiRRlWWbzQDXDorboafBx9B0/lSUH2EwoFB5RjYptQ==
X-Received: by 2002:a05:600c:34c4:b0:3d1:bf7c:391c with SMTP id
 d4-20020a05600c34c400b003d1bf7c391cmr56294968wmq.4.1673433947207; 
 Wed, 11 Jan 2023 02:45:47 -0800 (PST)
Received: from openqa-migration-qe1-1.qa.suse.de (nat1.nue.suse.com.
 [195.135.221.27]) by smtp.gmail.com with ESMTPSA id
 h10-20020a1ccc0a000000b003d237d60318sm18195483wmb.2.2023.01.11.02.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jan 2023 02:45:46 -0800 (PST)
From: coolgw <coolgw1126@gmail.com>
X-Google-Original-From: coolgw <wegao@suse.com>
To: ltp@lists.linux.it
Date: Wed, 11 Jan 2023 05:45:28 -0500
Message-ID: <20230106113126.5304-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Add PATH to tst_rhost_run.sh
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
Message-ID: <20230111104528.xdKKTplqMXw8D7nddBeGqitL_cN_IMTOX0gRaL-G3Jg@z>

When run single test case use command such as:
LTP_SHELL_API_TESTS=shell/net/tst_rhost_run.sh make test-shell
Error msg such as "ns_create: command not found" will popup, so
need update PATH before call ns_create etc..

More important:
1) LTP shell API tests depend on properly compiled LTP.
Therefore this is just a workaround to make visible that some tool is missing.

2) I wonder if there is way to properly fix this dependency in make.
I guess test-shell target should depend on (at least): ns_create ns_exec
ns_ifmove.

Signed-off-by: WEI GAO <wegao@suse.com>
---
v3 -> v4: update format base latest comments, remove unrelated change
V2 -> V3: move path to test case itself 
V1 -> V2: add tst_require_cmds for init_ltp_netspace()

 lib/newlib_tests/shell/net/tst_rhost_run.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/newlib_tests/shell/net/tst_rhost_run.sh b/lib/newlib_tests/shell/net/tst_rhost_run.sh
index 773b8dd33..951551514 100755
--- a/lib/newlib_tests/shell/net/tst_rhost_run.sh
+++ b/lib/newlib_tests/shell/net/tst_rhost_run.sh
@@ -3,7 +3,8 @@
 # Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
 
 TST_TESTFUNC=do_test
-PATH="$(dirname $0)/../../../../testcases/lib/:$PATH"
+root="$(dirname $0)/../../../../"
+PATH="$root/testcases/lib/:$root/testcases/kernel/containers/share/:$PATH"
 
 export TST_NET_RHOST_RUN_DEBUG=1
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
