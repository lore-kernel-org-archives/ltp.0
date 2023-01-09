Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0E0C61DB3
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 05:06:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E622B3CDDF5
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 06:06:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49F7E3CB7C3
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 06:06:36 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D1B4F20006A
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 06:06:35 +0100 (CET)
Received: by mail-wr1-x432.google.com with SMTP id az7so6999374wrb.5
 for <ltp@lists.linux.it>; Sun, 08 Jan 2023 21:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TfE0r8vbQNShwhh+v5bcv4BVqmvyTb7SYCcgSkCjuPg=;
 b=Ah02iXQrafmATGyVDItw/KZxEIw3h2ZpinLcjFcpner4ITYy3kfL4JwrpvcnDeB0JJ
 rUKaVY3TDB9/ho+ryCxRRgzeEoIeqJieiSnM9MWxDc5Q6MEaHsRKUdZ8Mu63gTxbHopR
 57PVX15AeKw9HVOdoXyvVFns21JU1Ps88bbZq9JToGdpuU8jf3y2iO2qPv9Zi7MjwPfS
 GPYN51Gvy3gfxqULeuxx1uH1HVK/leViiyMmqzLf6EnxhfY8FVQnJ5CgcOfjCKXw1G5i
 Qa6z7dToq8rAjeAOI16uI2b6FMJlc1OU5c3iGMwYBC+s4xKH+Em3kwASUiZd697lSbJA
 0RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TfE0r8vbQNShwhh+v5bcv4BVqmvyTb7SYCcgSkCjuPg=;
 b=dS2WwudP/cg/6MCm6PgQYg0bigObyP5mP584AcyMrSXCi7xDyLFh5tB0hPqQXFuhoW
 1GZsR7EMA8LgkLcSauGqkF4qqBIcV3Y9YbNr9S0B3It+GUV9dvoEsmpQY8XyZaNentkX
 L59UtHIMm4CFcrHIbfYUu0WIhPGGNK3XPaaH/26uYDs1ktlHSIIseaACbHNrOIXUTqK4
 F7iJaGBQb5ui0SZa+t1iniNKJN8sOQibBB9Kp/ZOP241psv6ojdZS7DB3sryzZG4UlUG
 dhAd8O6nERg5ouj6Tk3XNzySyrnTDdABjRmDMRYGi5J9OxH3eJ8YS+TSXSxl3DmQ3Wr0
 qvKA==
X-Gm-Message-State: AFqh2kryO3/tcBF+PfrByXLQ+0+gnbUOdZ/CDOm4bQvt/FUBIdQ3sQ7o
 e5YQGJeWeD2viWQAY+rGl6k=
X-Google-Smtp-Source: AMrXdXsmraOI1y+mj9h/uzR4ZmaStJY/8x4qNzliuZaZIvEMJ3d0dnjqFyZQeIfB0sYjU6nyP6kQWQ==
X-Received: by 2002:adf:de0e:0:b0:242:63e5:2449 with SMTP id
 b14-20020adfde0e000000b0024263e52449mr41497361wrm.69.1673240795272; 
 Sun, 08 Jan 2023 21:06:35 -0800 (PST)
Received: from openqa-migration-qe1-1.qa.suse.de (nat1.nue.suse.com.
 [195.135.221.27]) by smtp.gmail.com with ESMTPSA id
 f8-20020a0560001b0800b002423edd7e50sm7427060wrz.32.2023.01.08.21.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jan 2023 21:06:34 -0800 (PST)
From: coolgw <coolgw1126@gmail.com>
X-Google-Original-From: coolgw <wegao@suse.com>
To: wegao@suse.com,
	ltp@lists.linux.it
Date: Mon,  9 Jan 2023 00:06:32 -0500
Message-Id: <20230109050632.30153-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
