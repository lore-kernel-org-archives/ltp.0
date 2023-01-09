Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44FEC61DB3
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 03:27:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9FC23CDDEC
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 04:27:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E5C53C6E7C
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 04:27:10 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 812D810001D2
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 04:27:10 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 k22-20020a05600c1c9600b003d1ee3a6289so5627196wms.2
 for <ltp@lists.linux.it>; Sun, 08 Jan 2023 19:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TfE0r8vbQNShwhh+v5bcv4BVqmvyTb7SYCcgSkCjuPg=;
 b=Tx4lJ5VmzYXNlPqI3SqgpEggzMeWEEVBjbD/K5qfQHKOIF/VA6PHT25RxPft/zbB69
 EdtW/oc9uA0uL3Mwr1sVep1Ipkkdk2FLpUqwdJE5TFZ3mKInnb4s0eoT6fx5QWs2ShLE
 LmRMBIILBTNLdXAWlJOgDvFXwZz2L5jG8ckmmZotkGWUGSNW5KW8cFtHF0OB/secIBge
 mFlA7b9+hI+J4sWP4tQRjKLc3vrpC+/t0PyVXLlHggGc/oKNhQ4nUuiBQrDZR1G7W7Bz
 5dIZ9fzwmcOUU/1GF+QYwlyv44lD7XGWVPeX9ZrtAqqM1gu14AO6Rvhm/ZW4pnXT4MHe
 LIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TfE0r8vbQNShwhh+v5bcv4BVqmvyTb7SYCcgSkCjuPg=;
 b=ChVU0oWIn8XmkpVfhQfg8SHm/R0f5QUWvscxhE8dokiixJGLQ9yLUT1R0GA/E5UOx0
 46cDMXAbV9glkR0uX/x/t8Hp/FMOqTI7XLSKX1MgngraexIC+1eqTjUoi+Wi55vT6v6K
 5VUswANo2no+WXGmE5sbglZ2iqJnTCtVCsaqVl+QaeCV/0nBoqrJrI686TEwjorYrt60
 KaooRD+w1sDnQEWALEj/Ll/9HkORcI4p+0N88sZLRfYDj29GsuFCRmXUug9R4pygvaXv
 D8DFRN13ZSartnrM9JbUtS9+FSscadIr1Pc8jIr+yMMLmri6kzyi0JkXJDUNDSIyEXo3
 QDQw==
X-Gm-Message-State: AFqh2krpaa3oklKRuj3PqGSbw46e3J3YYnm1c/yJz6aVrhQf6QrCVBEQ
 Jx+6mgdh2CSM4SXYESLAgOE=
X-Google-Smtp-Source: AMrXdXsAsDdoMejEHONq9DA9+5s10fXpbgg/I+NOq60z23VrcUEvq+aBmklvDXs40RDOF4ULaLKE1g==
X-Received: by 2002:a05:600c:34ca:b0:3d6:80b5:f948 with SMTP id
 d10-20020a05600c34ca00b003d680b5f948mr45528745wmq.39.1673234830037; 
 Sun, 08 Jan 2023 19:27:10 -0800 (PST)
Received: from aa.suse.de ([223.72.87.185]) by smtp.gmail.com with ESMTPSA id
 q22-20020a05600c331600b003d9dd62deedsm9170908wmp.30.2023.01.08.19.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jan 2023 19:27:09 -0800 (PST)
From: coolgw <coolgw1126@gmail.com>
X-Google-Original-From: coolgw <wegao@suse.com>
To: wegao@suse.com,
	ltp@lists.linux.it
Date: Sun,  8 Jan 2023 22:27:00 -0500
Message-Id: <20230109032700.7959-1-wegao@suse.com>
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
