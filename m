Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A7BC54EBD
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 05:13:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74A9E3CDDEC
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 06:13:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 670D93CB7C3
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 06:13:03 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 17201778504
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 06:13:03 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 m8-20020a05600c3b0800b003d96f801c48so8167521wms.0
 for <ltp@lists.linux.it>; Sun, 08 Jan 2023 21:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TfE0r8vbQNShwhh+v5bcv4BVqmvyTb7SYCcgSkCjuPg=;
 b=TeLj2PEjQWdUZ8xHwP9OrG38wauPhie9Fg2nOhk9oHambbcRxZyt2B7vsBhlErQmDH
 0rJz3EV/IvO04IVj5fe/gDPucbDwzKRFSXADBDCCv+OyFxiv6sc4Fusf/dz9FXxB7Gih
 lT7vN4gwI8K6fC12Xc6WTP688hNDK5jTOXBx11wNUYgOPiJaCt7s8M5EupLumacgUvB9
 u5XIQF2xFYoBXD2WOAfezO0QHHKDOMtRkIISoK4Qcqa1u5LQL4j4uZbdEmd/2Vv3DzxR
 X0lgmwgylfsinwaIc4fW7w/Yff6N8d162+Yqq2ldmNBL5ZZxSMXHOQadX8okebZzSIzJ
 xohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TfE0r8vbQNShwhh+v5bcv4BVqmvyTb7SYCcgSkCjuPg=;
 b=L0hDp09trLZLD4sxMG+BoThsXrgvHKKmxORU5CqcwBY2INywItpDF9fzYVNqK6539T
 Qb/7eE3WO2hOjuN+/3CiRiS86Wn2mYaPPH9fTW3SjudhkIQsIPRlmN6yly8u/DSN9bvE
 vvHEj7SykEWyEXjLfwyQ2wrmgMtEMLVwLiIlOpmfpZqm9ODMXc0fYj7H3kPzVQ7EvJUZ
 dwLM8b2XHUBthbqrKci9x96hC0f64d7rW80h/OY5QifIa+U4qwjsz99enhl3KVSZq5/y
 wEYkzPiiyJdgYUiuo48GeBd0fITHvFOmQJ/0fwBME46xOPU4cbA3Q4LeWRmQ4bkRt4h7
 AbFQ==
X-Gm-Message-State: AFqh2kofOwaC7xIPmg3sJemxYc3msTzgYPb1Bvy0u1x7ngnngbO2aY1L
 Bj5y92P/GJ/ivMfOr9ABDc3ZLak/h62YFQ==
X-Google-Smtp-Source: AMrXdXsThVTarUPEkOs5hXKc4mpmX29JCyGh0TxCuAIUNZZNyNF1ZWkPXDyWCHcqYGBDo/XCFXHR4w==
X-Received: by 2002:a05:600c:3d10:b0:3c6:e63e:89c6 with SMTP id
 bh16-20020a05600c3d1000b003c6e63e89c6mr11045466wmb.34.1673241182634; 
 Sun, 08 Jan 2023 21:13:02 -0800 (PST)
Received: from openqa-migration-qe1-1.qa.suse.de (nat1.nue.suse.com.
 [195.135.221.27]) by smtp.gmail.com with ESMTPSA id
 v12-20020a5d6b0c000000b002366553eca7sm7466508wrw.83.2023.01.08.21.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jan 2023 21:13:02 -0800 (PST)
From: coolgw <coolgw1126@gmail.com>
X-Google-Original-From: coolgw <wegao@suse.com>
To: ltp@lists.linux.it
Date: Mon,  9 Jan 2023 00:12:59 -0500
Message-Id: <20230109051259.30263-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] readahead02.c fixes: use tst_parse_filesize() so
 that we can pass sizes with units e.g. -s 128M
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

Signed-off-by: WEI GAO <wegao@suse.com>
---
 testcases/kernel/syscalls/readahead/readahead02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 3ed88c005..c282b4d68 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -367,8 +367,8 @@ static void setup_readahead_length(void)
 
 static void setup(void)
 {
-	if (opt_fsizestr) {
-		testfile_size = SAFE_STRTOL(opt_fsizestr, 1, INT_MAX);
+        if (tst_parse_filesize(opt_fsizestr, &testfile_size, 1, INT_MAX)) {
+		tst_brk(TBROK, "invalid initial filesize '%s'", opt_fsizestr);
 		tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
 	}
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
