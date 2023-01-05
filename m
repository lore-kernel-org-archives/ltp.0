Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521A5C5479D
	for <ltp@archiver.kernel.org>; Fri,  6 Jan 2023 09:05:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73DFB3CB61D
	for <ltp@archiver.kernel.org>; Fri,  6 Jan 2023 10:05:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CFD83C84F2
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 11:37:21 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 11E8C600796
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 11:37:21 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 bi26-20020a05600c3d9a00b003d3404a89faso2017216wmb.1
 for <ltp@lists.linux.it>; Thu, 05 Jan 2023 02:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i4PzIdY4rNagGqvjDkNcZWpPb3Qq2be79AhmDWAu19U=;
 b=qnvcdUR/pGz4J9v+o0ltXjF/RvYGNJZkREhERFWuVQrkOTTyNQvTxqL+ZxAzJls7D7
 P0iSs9W5FNdhcdJJsDnNEKNdUlAnwzVXkyUt2niqoKknvyP3bj19w6Dn77ilH/JIOlV/
 UX8hMofY/QOIxGUovQnW5KGEqgyRfP5gAvdOYpERmq6cV/fl6RKtjkGnlq56QaKGY5+T
 6226Moxea4CoIqHS9WexzJZvVBEoiWebYWcBjGlTY9RXF6tQNTVuRLNmGZJycXsW9OkH
 RtEHgz6T755Xocj6Vxdrktm3bsJc3utaIHFABqnM9UQeI/T7R3ljJi2y01Mz/g9xIfEr
 YTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i4PzIdY4rNagGqvjDkNcZWpPb3Qq2be79AhmDWAu19U=;
 b=qXbm+wCsrHuiSIMgd4fW0xVAKk4IL7Vtu1ghDxnqxuDhVr2bX7BiCdJn1A7sHfH4tO
 JUORhc79PzLPzsyquCLSzE9QK35ktzXTURcoEtJIezlhA76GgK+v8TfiRPqZNUzmsrBC
 4s3SH84B1dSXKixbix6ShWJn89qR+giJvoYJj5ByEyIGLZs5shNtQp3WGI3h5BFdurbD
 Qad6pXsPjA81m4dmvtJMBWpcbdJUnO8xFCSgPV9mbYRNyjmN9H+vDMpLhOJfgbVjcOnx
 vDhyH6uIzGAzGk5uYV/6PQhjbXdil4qv0VP0roUwgqKSRp3BlTSLDRW1mmt+BoV13kF/
 I+9A==
X-Gm-Message-State: AFqh2kr/7N+3O3cJ/e01znkCtHAwhLB1Kafw0ddZKVZJfHeIVlTseSIT
 HaWu/boQotOv8OSqvihZh9kZG/Q9qb9RKJVG
X-Google-Smtp-Source: AMrXdXsRD5db0F7Np8p2CzBUGE+hOlGNKgjKe6pMQp4pD9xy2HdcUkDchbK4xRx3KSChpc0mWci5zg==
X-Received: by 2002:a05:600c:4e51:b0:3cf:7b8b:6521 with SMTP id
 e17-20020a05600c4e5100b003cf7b8b6521mr35263684wmq.32.1672915040629; 
 Thu, 05 Jan 2023 02:37:20 -0800 (PST)
Received: from aa.suse.de ([223.72.84.126]) by smtp.gmail.com with ESMTPSA id
 d13-20020a05600c34cd00b003d9c97d82f2sm2002455wmq.8.2023.01.05.02.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jan 2023 02:37:20 -0800 (PST)
From: coolgw <coolgw1126@gmail.com>
X-Google-Original-From: coolgw <wegao@suse.com>
To: ltp@lists.linux.it
Date: Thu,  5 Jan 2023 05:37:11 -0500
Message-Id: <20230105103711.7343-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 06 Jan 2023 10:05:41 +0100
Subject: [LTP] [PATCH v1] Add containers/share to PATH when call
 init_ltp_netspace
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

When run single test case use command such as:
LTP_SHELL_API_TESTS=shell/net/tst_rhost_run.sh make test-shell
Error msg such as "ns_create: command not found" will popup, so
need update PATH before call ns_create etc..
---
 testcases/lib/tst_net.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index ceb45c98d..54c6dd1cc 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -128,6 +128,9 @@ tst_net_require_ipv6()
 
 init_ltp_netspace()
 {
+	PATH="$PWD/../../testcases/kernel/containers/share/:$PATH"
+	tst_res TINFO "PATH='$PATH'"
+
 	local pid
 
 	if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
