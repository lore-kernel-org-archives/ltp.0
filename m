Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CD2ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 15:43:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C9A43CA96C
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 17:43:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 575C73CA972
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:50 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 074DD600451
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:48 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 bd26-20020a05600c1f1a00b003a5e82a6474so5906301wmb.4
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 08:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=f/9FveGnOOHohBVfBdgJQhGtyUIkvHn1R0lpzbjJxtY=;
 b=aPs7uMQz0z0wA/vTW+0vwb6iLQ6ZRg1USQqUDOBt0t3Um/e6vbRsurBlO3tTtl50jY
 d2BFDCZQLiYKsMQoDTOIh1+oq/upxk7S7E+qhtNIpxcc2L/9lU5LdZaHZshyzndJR/HZ
 oEbEG3XP6X+6JpPl2DY21scktDoEpwqzMhED5MY9Y8jD96pQ4aJJIjLBBlya3mR2AoUB
 5ESDK+RUac9lA8MVk+rPMU8AXq7s4tec9VP242Cj+PF0sx8hrXBtsb0iiVxnF/dHvJMb
 TrFxEoIH0llgroXabxOwJ7U7qn4dcQCdfz4+uDON5ae8uFFWDxdGQX6jmoek2/NaC4wl
 NkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=f/9FveGnOOHohBVfBdgJQhGtyUIkvHn1R0lpzbjJxtY=;
 b=t4nx93+8DVxnZrfMyvwtC0VHoJFPRNJNJyfqHq2S2/BH2lSCQVfz3DGalTzBntdk11
 XdysYbpegVrWVzmNtHxOk3TaZU43FhUfUPQsf/l351ZZ8k+ZNu5Ax2KOu5AEiZmUT5/y
 XVHDZ/2RYphqFTvZf6UqXA/575VmaVAxC34vYN+S1pupMdYO1L6QEGI2i1dqujUnHEna
 Vn42XBH2lsPx7lRKYKNNDlEEfgnqY+Q2u8hxoTVv4Ic6yZxOn2vDAEy+swJbxI60Ebr2
 QDETWk8EmFMnGtILKdxNA0Drs+1gN/OFrdZbemKG2REH7CuSVwJx/J/tK3vhjP+Ewke+
 uVxQ==
X-Gm-Message-State: ACgBeo1DTdE1a38v9v5cGa9pcqAE+LQd6lt3sC0AUC6JZthWZbkwyfJX
 b+x4Sg86u9+ygm1Er7vfB+I=
X-Google-Smtp-Source: AA6agR4Mg3iTLKYMONwxbyGCyz89IDe1PR9a+qgtZT30TNxOCrvMUME9xn0KirOR7praBzKc+s9NAA==
X-Received: by 2002:a05:600c:418a:b0:3a5:e724:21d4 with SMTP id
 p10-20020a05600c418a00b003a5e72421d4mr11339713wmh.168.1662392568452; 
 Mon, 05 Sep 2022 08:42:48 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 e5-20020adfe7c5000000b0022862e037e3sm5790023wrn.38.2022.09.05.08.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 08:42:47 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Sep 2022 18:42:32 +0300
Message-Id: <20220905154239.2652169-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905154239.2652169-1-amir73il@gmail.com>
References: <20220905154239.2652169-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/9] syscalls/fanotify14: Require FAN_REPORT_FID
 support for entire test
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To avoid complex requirements for the new test case, we now require
FAN_REPORT_FID support for the entire test, which opts-out from testing
on FUSE filesystem.

It is not clear that there is anything to gain from running this test
on all_filsystems in the first place.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify14.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index aa4db586e..8419cea46 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -219,11 +219,8 @@ out:
 
 static void do_setup(void)
 {
-	int fd;
-
-	/* Check for kernel fanotify support */
-	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
-	SAFE_CLOSE(fd);
+	/* Require FAN_REPORT_FID support for all tests to simplify per test case requirements */
+	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, MNTPOINT);
 
 	fan_report_target_fid_unsupported =
 		fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME_TARGET, MNTPOINT);
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
