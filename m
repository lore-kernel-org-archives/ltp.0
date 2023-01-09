Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EC3C5479D
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 03:29:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 914FE3CDDE8
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 04:29:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DD4C3C6E7C
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 04:29:13 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E37B5100047A
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 04:29:12 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 m8-20020a05600c3b0800b003d96f801c48so8080314wms.0
 for <ltp@lists.linux.it>; Sun, 08 Jan 2023 19:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TfE0r8vbQNShwhh+v5bcv4BVqmvyTb7SYCcgSkCjuPg=;
 b=UXohZ76nBW6gL/z8hU+ALioV7XdblbgVpoY0aDCnlDA9pHVPBzbcBGqeogHKRih7G1
 COVvFPA5Y9z0T4qFdwKO2wkJFPSYoRQvE/TL+Hf0IPNoD1/wa+5MNi5sjD9VQqDQ0836
 C4e5U1fxSlQ/c6aC+WcgYCCCUE9TyhR+d9ru8cwWWg2LtmoUngqk51YmomoHfhGL2lEO
 bQwyZBWGTJcIbcVpb+FuLTmSo0Y8suGFow2TBcz4sOckp1MwYzMkxTyQesB70h2+fFYy
 NPDfTm9Qr4oHyxGesSXEgu6oyja/u0BzvN+GDtwGZIAjKQJjgDfcev3uMkiwPhz7UbhA
 z1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TfE0r8vbQNShwhh+v5bcv4BVqmvyTb7SYCcgSkCjuPg=;
 b=iuOqZ+RW/GJ7j0H4qNlCDyVs46Eyzc3OMwm0IJkz7rGMBokzp5LhdzSrdQ5ShRIqc8
 3z2BnchAuWqFu+bVsCZsVNwKkgw+tMNfR/pJ5NhgOHyfvGhjMPr3fqdDx/z1cN/Yf3p7
 rVIR8CUV2ulxCumS1twOdt8yPZ0pSime9EdUFy8UvHoY5588SLB0jVzl6YZuKFUA9WwE
 NhIUOr/4n+qyQlPWmpVxweIHBJHQCcrP2VPEm1zZO+GPEOKR0UbH3uBoGdRVIv+KBAIB
 dspOAev+3t/aNiNAqqRtH+Q4wI6YAPg67JjRva6mGL0trNav6tI/x12WY39Gm8aot0+D
 Txeg==
X-Gm-Message-State: AFqh2kp1m8jOyT6ZwD5fUi26gElX1eYUzm3IVUSCfZeZ9S/j+gLe3+St
 ccR9r/y8YsWSDTwmUxrs54WVBoIyI5nCIxKe
X-Google-Smtp-Source: AMrXdXvN+hR5PAzz6v+mQQLbO9NsPtJ4yBgohP/PiGzVCLB7/mAjGoWNWH4xJkSj/M2PInqX+ftsZA==
X-Received: by 2002:a05:600c:358a:b0:3cf:8d51:1622 with SMTP id
 p10-20020a05600c358a00b003cf8d511622mr45754621wmq.1.1673234952544; 
 Sun, 08 Jan 2023 19:29:12 -0800 (PST)
Received: from aa.suse.de ([223.72.87.185]) by smtp.gmail.com with ESMTPSA id
 s23-20020a1cf217000000b003d1e3b1624dsm14284428wmc.2.2023.01.08.19.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jan 2023 19:29:12 -0800 (PST)
From: coolgw <coolgw1126@gmail.com>
X-Google-Original-From: coolgw <wegao@suse.com>
To: wegao@suse.com,
	ltp@lists.linux.it
Date: Sun,  8 Jan 2023 22:28:50 -0500
Message-Id: <20230109032850.8227-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
