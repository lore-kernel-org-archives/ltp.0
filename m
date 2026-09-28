Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BC1CA5FA3
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 21:28:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB1023CF865
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 23:28:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 854003D00A7
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 23:27:37 +0200 (CEST)
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 218EF6001B0
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 23:27:36 +0200 (CEST)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaf2ab41bbso458990a12.2
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 14:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790630855; x=1791235655; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OM2/EfpnK48cf1wYmHD3/+HhuirU3WRHts+ZKher0bA=;
 b=M3qu2zWIcRWkoda1QHi4awB4abYuo96LxVtliA6mkJUsXcmAj4Rig1SZkOUpIkjrEs
 nUJmq+NbEsTuKlWoXSx0rT5GacRo2+c/jdrOi/62lIRumdkwU7XlOKPLWJw55CewCuNJ
 6k2N/wLKP7Uporhh/6sPMJ41zGplQ2JHDbVHnBDjQ3q3pUevWsy2leOhgtzcCTW8AORg
 9PnIi7ZIUCBnVzSDXwM4Cq2e6OM/uehbcByQC6DJBe+2nxC0CJWaZRfy7ZMCr71cpPWC
 Ekz53deyCc8JPJcAD1eeN/8iePDlCkt8o9buxglM5Pc0BGMlgNwZDMaFRsZFptUzGgYD
 CKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790630855; x=1791235655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OM2/EfpnK48cf1wYmHD3/+HhuirU3WRHts+ZKher0bA=;
 b=uHObgHaR6smGGhWkPqx2g8uXgL/myOIt5OCUdrCgJa0SiP5xyCyp/FwEXs3tziPf79
 CzkxcZfN0Dynka/VzrFPvUNuyYZhE2BPDrw+QNANDYJ6IUvh/eJ1sqC/mDS0fPF0MdbI
 CPO1Lixhtb7iYyt9hbfqq9C+MAUgv6vJKvFZv0ICd1Pz2zi55TB2ygAzyjfOt5STa9oS
 Czr+zSeA0vobUgLf7S6g/G78CbO5EsHv5OWWdPAYiXcTywywQRiCVrIIi0+awW6/1ZiV
 +B+9tZjJhnGhcKuOP6K9DfolaxJuKxCUk4jjXuyYa2oW3Wssxpc1BNxEUd2GlJ3CMXYp
 R/xA==
X-Gm-Message-State: AFuF++mfSwI8PFW/v5knFW4XoUKg9wfHs1jOsjhFM9Q95e35SdKViwZ0
 xjGnUDwg2Mj2KgNF3dMbBE8l/6maG+nf4KDRLTLe3W5ukVyOEBoIbrR6EIf07s8EjTvtxrH8mzf
 6TT/g
X-Gm-Gg: AYBFou3gnH0SISly3XMjalaXJEPtTMDObtUF0YuVyD29wrL2ydAD9ssVlHRllKbHxgG
 IqCnjz7VvrDr5DXEi0VMJ56IBJsyHeyUxRLh+TLe1NGHPeaxBaszMKWXILOmsdiEZ2yzsfVVS9A
 /vOdHbREpDHf5yOAcK6h/JAKY+8cQywIrNNIzbEZ5WWkJKQDkHczzQ3998k5U7NJU6p5PuAfSLl
 oB7ijzSjWi9STRHFRnBAGTFqFArrSVZ2Ve/kVuMZ2iqk5+kBhCRbnfwdvHlbk52FHuWBCWxizTx
 lOSlXxR/Nnt+XEWwZd0QM9Yyd1zIYIxp4kFjvW0ELqEefuTsbuulagfQ9FeGNkXsB8JpquphNrZ
 O9gSbPP3uqUpFCl0p9A9UPnZHNQq+wc8r3Do2IVgmnXx5JiCqOfp/UtOyZ6BBOuwWBxpAVWNzXN
 V/COAiHck6RCbiS9LyKSt61frtIzOvYphB4NOdIjYHEz0NHU3NG40Xn8in0ElimZoO90WAkHGX5
 LGMuRT0D7Ch4lBB6gmxifwh/0GQGgiyeg==
X-Received: by 2002:a17:907:72cb:b0:c16:1290:11a7 with SMTP id
 a640c23a62f3a-c2adb93a40emr945942266b.1.1790630855355; 
 Mon, 28 Sep 2026 14:27:35 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dbd3bcab8sm339476366b.75.2026.09.28.14.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 14:27:35 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it
Date: Mon, 28 Sep 2026 23:27:33 +0200
Message-ID: <20260928212733.2835408-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] accept02: Join the multicast group on lo
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

The test joins the multicast group with interface 0. Then the kernel
needs a route to 224.0.0.0 to find a device. When we only have lo,
like in a QEMU guest with no network, there is no such route and the
test breaks:

  accept02.c:52: TBROK: setsockopt(3, 0, 42, ...) failed: ENODEV (19)

All traffic in the test goes over 127.0.0.1, so join the group on lo.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/kernel/syscalls/accept/accept02.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
index 17056625e933..09a1c35e2591 100644
--- a/testcases/kernel/syscalls/accept/accept02.c
+++ b/testcases/kernel/syscalls/accept/accept02.c
@@ -22,6 +22,7 @@
 #include <errno.h>
 #include <sys/socket.h>
 #include "tst_test.h"
+#include "tst_netdevice.h"
 #include "tst_safe_net.h"
 #include "tst_safe_pthread.h"
 
@@ -112,7 +113,7 @@ static void setup(void)
 	client_addr = tst_alloc(sizeof(*client_addr));
 	mc_group = tst_alloc(sizeof(*mc_group));
 
-	mc_group->gr_interface = 0;
+	mc_group->gr_interface = NETDEV_INDEX_BY_NAME("lo");
 	mc_group_addr = (struct sockaddr_in *) &mc_group->gr_group;
 	mc_group_addr->sin_family = AF_INET;
 	inet_aton(MULTICASTIP, &mc_group_addr->sin_addr);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
