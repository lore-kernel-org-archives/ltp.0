Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DB8CA1015
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 02:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756951214; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Bgir5+IJti/aR07/JnQPpnIHBRTbuj07I8BMDRLg0+g=;
 b=XVRxDlOGBJwhil10S3b6KWIeuhSLRWKxAYPJ7X64Tt/UNMAcP/OjxudBRt/Hnguork1iz
 yGh4j98+JBspvugFXoOT/9brjbE+8Mc/SIDYfZDBG08s7QuJTh8koKtxlfxWtAJSliIl3x9
 c6kwGsFXRZA6VmrPR2jVzqMEcDf+bpU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22C8F3CD3ED
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 04:00:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FB4E3CCF83
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 03:59:33 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1B08E14004E1
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 03:59:32 +0200 (CEST)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b0428b537e5so84838066b.3
 for <ltp@lists.linux.it>; Wed, 03 Sep 2025 18:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756951171; x=1757555971; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwJsHduv5qC5SjhNMuPlaTfPkUxLxGhE34phrohWZIQ=;
 b=eMggRGQUC/7gznxNeCIIfr+nA2kt0Vdp1+jAnlp+W+AQHYBqigQYAfETzbozIbwYd/
 T/Y3cbldSC1QtTvs343C7KQAwY7XccklQs+nPpIraCZVquAZ+BNovU1vPOUEc0GXM2zf
 6H3gToSG9wtI4PI3GcUPnBO30FOmmpaazzIxPqMOkEZ9Vl0s0fHQJdFYqDfWBy7Ct6SQ
 lKWgfx3cpiAATI5MpRAWWtRdJRZ81xbwMbIujNnn+uzQuEd6YoCpc7auzxjJ+FGrcEp5
 6+qAdIPKnQvCIc8rY0M6WKADXPlPbVitwBxNJ0cl4veXXJVmHGjld9bOIxb2BweI1USh
 ER2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756951171; x=1757555971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zwJsHduv5qC5SjhNMuPlaTfPkUxLxGhE34phrohWZIQ=;
 b=jBkToqEdsnlPWHGbywJ//jI8x+f5yEFUFnbfjzdF5GtBmEEA81c+mhOiWYI41ts59b
 CNk9lKhSYdgXIJcNrp/S5cSFCDqdP6ToUkm/lOdagcwzz+k4PuwfKJOVM0YuU8Jxu9i6
 a3nRGbB9KxMyDKU4RMc750rTcUWRnoP4Q380SUf/XDmkecGZ6K1jiqQI3X+I2jqxKeBR
 +LLlrHrgpEuLWg4yCdl3gp5WZudayia0G54eQFg0BO55sDqsxwb8pgiVuyNyiVZSwbeM
 0gGRf85cFscVZSnMbsUIKaicFa3cZfWLG81cMhhSzJhrnFfpTi2kzCZh9Uv5ZiT0pqRB
 z0bQ==
X-Gm-Message-State: AOJu0YwC8Hgm29ciN9QsbIbb24Th28Ztcj7KxbOqa2KGxpGH1GkghfBC
 Ed6cG4EsJKgQK4mirj5BHpWeGjeze9F+AIPoXregrcPN5Zivp7kdBHxSDkyFzYjH5hS/boCZSh7
 avn8=
X-Gm-Gg: ASbGncswdp3LdG1Gwo0DnlXsjqCfeeeL1r/Uw1c3m4/4LEic8zMz3VjKSv0l4oYpLLI
 Fr/cYlLczAlTB/yWUx+MpC5Kp31OxvQmMps0Cl6t/KZusm5I6gTFYHCmMZbWt3g51T0rS2NY+a4
 Qc+ZB76wOYyD9Vow+aqGkF0KuJF+B3hCvjHh995zW0GmTv0BbJHJZuj3ZH42Fo6D+EnD3fSP2MO
 wZpFKCFZCwTKPXGsga7HztbziM+ZhwzyZqzFc/bOcqJ7m8+BSJAa2MQ88ep8GMbOhOpHNoZzSLK
 Ju9DMZx6EmZbNUynacX5G5dLSP9fn3a+jAkyST0GrcqesccKyWnUnF3ArscSB59bnYDFIGdAydS
 uyfh4l9A739pHzadke2qM6/YKUit5prHwSXkHx+PuAfP2CrXJ79j7Pw==
X-Google-Smtp-Source: AGHT+IFvd1p4vNsUq45+FaOT0sYjCstHBgBJB0vyqizqnf7vBqxOhmL+fpjnIOhQ61Ba4ztUIXFpBg==
X-Received: by 2002:a17:907:7e82:b0:afe:ec09:2a23 with SMTP id
 a640c23a62f3a-b01d9769f7fmr1574246266b.43.1756951171344; 
 Wed, 03 Sep 2025 18:59:31 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-61cfc575b94sm12570911a12.53.2025.09.03.18.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 18:59:31 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  4 Sep 2025 01:58:58 +0000
Message-ID: <20250904015920.7432-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904015920.7432-1-wegao@suse.com>
References: <20250902135117.6222-1-wegao@suse.com>
 <20250904015920.7432-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] tst_test.c: Add hugepage check in
 prepare_and_mount_hugetlb_fs
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

If test case only enable .needs_hugetlbfs without .hugepages then
will trigger mount error in prepare_and_mount_hugetlb_fs. So Add
hugepage check within prepare_and_mount_hugetlb_fs.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/tst_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index b8894f782..2217595e6 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -38,6 +38,7 @@
 #include "old_device.h"
 #include "old_tmpdir.h"
 #include "ltp-version.h"
+#include "tst_hugepage.h"
 
 /*
  * Hack to get TCID defined in newlib tests
@@ -1192,6 +1193,9 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
 
 static void prepare_and_mount_hugetlb_fs(void)
 {
+	if (access(PATH_HUGEPAGES, F_OK))
+		tst_brk(TCONF, "hugetlbfs is not supported");
+
 	SAFE_MOUNT("none", tst_test->mntpoint, "hugetlbfs", 0, NULL);
 	context->mntpoint_mounted = 1;
 }
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
