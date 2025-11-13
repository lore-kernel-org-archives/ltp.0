Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D42CD4F37
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 01:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762998857; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=iO2imNpDkGUkjkMnBtADjI2PxyJ4y3LOP9uyQVFQub0=;
 b=MHI7Ys4bsc88uv796Vuk5VtmFBVvv/nZ0YBMbE5wYAbO2luN8rtTGiyhOotHZNtRCLYRY
 Po/bLuT4IPmL1lqjQ8Rh2B1telQLEw2ZHD6Ga230vNiDDU5brcyQIxosnwqLrZ3Zzx81+tU
 g6ZJolcaQRKk3wpDJTfxZtuXrZ+SXUI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95E1F3CF7D2
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 02:54:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED22B3CF7B7
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 02:52:53 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8171D20009B
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 02:52:53 +0100 (CET)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b734fcbf1e3so35390066b.3
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 17:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762998773; x=1763603573; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEL0NQTfTkCmE8lWnRqiw2jKKU0sjZ7ShasqoDCgQDk=;
 b=PVfsHir0k/5jD3KPBI1VCWYylBDgE8SgyKJb9ZcFn3i2CgdIEvYTw3oLy0Aom+17ng
 +3vBMqZsu42vh633iwJhL9/POimDgoBr+qpterkTUmIi5H6GD+aaefa8XjnZCVrduxQ1
 I2mWtRuXOBt05c8QEGeqGglWql1d6IcP8UaTaYRWflQmh3RkuCiRYiRNuPWAAwhNd0sQ
 ZeleMPXBSdGDhoNNvLpKPd5sFYl4smDojScM82rH2/knQLe+3yTi+2Rk63Igz+0uc92b
 Gw0+GLKNn/moD3yHRz0QbT+1pOC1/swdMFqEoyjbhzAgjBrtcYLMyyh48UYrmL+Ws/GF
 52hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762998773; x=1763603573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EEL0NQTfTkCmE8lWnRqiw2jKKU0sjZ7ShasqoDCgQDk=;
 b=DyGI/wMxGp3Bn1F06V86ctiRmUVjE/vRyeb1JRU/P/3vUrBPD/MVtjWhKGbZDrGhVr
 FAuJqcoNKIDQza14ILPArAfds0bbdv50n9EYkV+Qi7E7W/k6V79NVBbHKVqAoeat7Rro
 N7wOLIRDKDLpBy+bTgSnHp7EOOf6B9H7xSyhKGuxHVlaNSPX1h3GQ0tF4oJfM9RDacyi
 ebsc/0WHi0FedB2Tu9nD6PRwLa1xQ7lfqmBDCLwJippxV9zeUr2RN5kDhxL8b4iOQaxZ
 zd6wYGyhrFFGVOcaBelY3HxCbMuzCMg7P1mmXJJIuDFjGEh3bXYUVsB5PxMVgehXTocJ
 uo7w==
X-Gm-Message-State: AOJu0Yw76tdbnSJwZpy+r+cxXke5wv8x5bwSw4AfVy83OqEEbcBbyMc5
 ZPaSfcRfJFruFnQ/5Uufg7ksh62q8xjud0ejsp5L+U+FLUMGKuzu69zcJYl3GT9RAD92KzvqZ1B
 0fdw=
X-Gm-Gg: ASbGncuL2h8C2ecWS/yB5MXk0sn+4lykRTSH8h41KymKJTFujebPxf2DXyJqGCt4M7B
 oBmk+9rh/z2fC0aU1xJLwZvpDRJ7U7G6VtHGxNpNAg2W8BZe7Zfehds+ga382sPBSRqykap/jnX
 sVbND5IL4IqtZR7JGfvb5xG+uZLw0wTA7J+ebOMvywDfn5rt1iTiObGHFMfCaTna57xTmGt7+fI
 q8Ct3KDwURceHnBF/CszRtQkNPy85RG8I4ZUQWUn7/M8no8VQvwbNzE/kt4ih9h7fCKRuVbR3Ls
 lkEq+4/s8mlaWdQDlcIvzRp/Gkne0yyYXufaFpJ139PeHy++ukPnaS5E80Q4hJdPvE3P2ey6MXv
 9he+fsIFAMRrds5vLYE53gEqXpHEWBvGEZHbjSnaGS17lQriymGb9+a+WS6jifRa2
X-Google-Smtp-Source: AGHT+IFJAH2Rj4ho0lR5K27JzNL3XFM2OkCnOQmrJwrCpv3pKdzmJkhHNllvprsrv5p+8DzEhCOp0Q==
X-Received: by 2002:a17:906:3c0c:b0:b73:403d:613d with SMTP id
 a640c23a62f3a-b73403d7aa4mr214182766b.41.1762998772747; 
 Wed, 12 Nov 2025 17:52:52 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fad48dcsm52080766b.25.2025.11.12.17.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 17:52:52 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 13 Nov 2025 01:52:32 +0000
Message-ID: <20251113015242.799-4-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113015242.799-1-wegao@suse.com>
References: <20251101012320.24972-1-wegao@suse.com>
 <20251113015242.799-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/3] ci: Add e2fsprogs package for CI test
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

We should add e2fsprogs to ci env otherwise test cases
which need tune2fs/dumpe2fs in ci will be skipped.

For example following message:
2025-09-24T09:00:56.9304198Z tst_cmd.c:268: TCONF: Couldn't find 'tune2fs' in $PATH

Signed-off-by: Wei Gao <wegao@suse.com>
---
 ci/alpine.sh     | 1 +
 ci/debian.sh     | 1 +
 ci/fedora.sh     | 1 +
 ci/tumbleweed.sh | 1 +
 4 files changed, 4 insertions(+)

diff --git a/ci/alpine.sh b/ci/alpine.sh
index 254f4aaec..f3a1bf528 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -25,6 +25,7 @@ apk add \
 	musl-dev \
 	numactl-dev \
 	openssl-dev \
+	e2fsprogs-extra \
 	pkgconfig
 
 cat /etc/os-release
diff --git a/ci/debian.sh b/ci/debian.sh
index 0445c92ec..767c9b985 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -33,6 +33,7 @@ pkg_minimal="
 	linux-libc-dev
 	lsb-release
 	pkg-config
+	e2fsprogs
 "
 
 pkg_nonessential="
diff --git a/ci/fedora.sh b/ci/fedora.sh
index f57806ebf..f4482a1da 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -26,6 +26,7 @@ $yum \
 	libtirpc \
 	libtirpc-devel \
 	pkg-config \
+	e2fsprogs \
 	redhat-lsb-core
 
 # CentOS 8 fixes
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index 8a30b02c2..8f23229df 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -30,6 +30,7 @@ while [ $i != 0 ]; do
 		libtirpc-devel \
 		linux-glibc-devel \
 		lsb-release \
+		e2fsprogs \
 		pkg-config
 
 	ret=$?
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
