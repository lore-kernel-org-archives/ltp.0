Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7EECD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779784636; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=SAx7Fv1JkFoDGjvE1LZaqh37lfKIvK2z8hwWkR+JYC4=;
 b=fQkY8FdEfk7vjhhXM53/g994HAC5nRxD11+LUX+uAeNWwenLbcDp4oCWHcG3PIjL5HQvf
 HAMk1OPdeiWrrUYxYm453rQOELzse1wAJCpBWrvkiu0RbFxIW3CAdzFK1Tla/XSrqXo1AiS
 DfPBy/Sx6ZZ/pZvZdouzkf9/PJPQNZg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B05AA3E525B
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 10:37:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FEC63C5730
 for <ltp@lists.linux.it>; Tue, 26 May 2026 10:36:54 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 598B11400159
 for <ltp@lists.linux.it>; Tue, 26 May 2026 10:36:53 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4906238c62eso17231895e9.3
 for <ltp@lists.linux.it>; Tue, 26 May 2026 01:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779784613; x=1780389413; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RX7pSwbDcUhw9pbESlIku7OKuq1kKDC39mKFnqTt18I=;
 b=DhtXE9c75ytM9OMMFkQ6TKb76sTmcOU29WEHQCyNeDmmIzds4BEjyQ7+/j07xbR3v3
 HbwfZQm90yVBmXTSDd/I8A/PsBriJFj1KgEY6CdXhTmCf1w4jGlNCYTn+d+6/kiaLERu
 5WDENK2OMN0ULDYBGzBUt3BVpPv62ymTUtHeZ0EgZ0pihm+QKZrbi9Jr8rbeamwil++T
 LMTAilVGb9VWY1rfPMqjeHxkZxVY4P/rMY0NMv583N8mBKjfCIKWIyzKD+nNbT5Q7cVW
 XieNx5qKfh94ywknkwX8Pt441gEsG/3pvkfBHHk4f3wOBQHxK2eBMzJ2l2zCOHBkpdq4
 hm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779784613; x=1780389413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RX7pSwbDcUhw9pbESlIku7OKuq1kKDC39mKFnqTt18I=;
 b=fwjgNnS2WzPapfExSIXKFEi3+yyAJgsWiaLQf6kZ2vpMlrssNVIWBcbNcA0XowHYkL
 v3WKJuDLCArMLx/hTxXs6slqT+EE7aR00fj3IpZeij9YO/Ko1EO9G3bj3jTwGnPBhI6s
 1PqLTwgFj0//CVZJ5BAxZjngRFIXgGBnoREFOZQeJeQG74VoA+yAIQRhwseU7MpKt+Ge
 buL26evg0xJ6JPcSpe9A7p7bqgRrAu9iLOK5CxFO36MibSIp8roDblyrCXDluh+k+xln
 qU93yu1XrSCUEk4I+mDgPgJ/deCjJxE4NCQbFRyplvvWYakisBwWQ8CmWD4LSQ9+rstX
 6c6w==
X-Gm-Message-State: AOJu0Yw1aLkl6MfQ4kETq9jAmtym774V5mufbSc0wRGnCU38ioZNJBvN
 24/JhDdsNEktWlaQMZiJK/oLp9nxO6g5jmFhm64LLIDTJR9WGPIR4foJliiaL8gHP3UlrTJXWcf
 XdSQ=
X-Gm-Gg: Acq92OGPtArtiEMNVAkpRTgPMdH3UwM9Gh01lrLXiFOQ97cN/PjygRS1U5ljmGIrs+O
 /yhbyYJXLIU9Kt6ErVWm4ODp8bAz26V+pMZ38qu5uEt+TTX4fFl1EzObJaiOki4ek+/dK7stE4N
 PmE/6hpWwRivDOiwMCEG2jwmTKTiv5x8387597YV1+klEaqQwl5IyBV8Rei7HsDDluEmFt87gqs
 KCDG/73TAnbDkIZF2qa0580uZ84HJwH6mIBnP3Tqnf5bM6wPH8MO0eNw20MXS1Ynjft3/YY4OcR
 gwKJuhCAKhaCm0BQeTJ+mwZe3FfCvqPVAWd5TaDvgVlQX5U2FoJosf/mw4RHf+FwIK3csDUGltL
 YthxZC5FbdgdNUVaIdUUQVdzVXdscE5nqe1qXKTRPMHGRKoIWSMobsVyoq7rlzYfpYootnrvJIC
 liwGNLzDVhYAE=
X-Received: by 2002:a05:600c:4e4b:b0:489:1c32:210d with SMTP id
 5b1f17b1804b1-49069da61admr83113855e9.15.1779784612602; 
 Tue, 26 May 2026 01:36:52 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490452580dfsm160176975e9.1.2026.05.26.01.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 01:36:52 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 08:36:47 +0000
Message-ID: <20260526083650.14036-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] min_free_kbytes: Handle transient memory drops in
 check_monitor
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

High memory pressure can cause MemFree to temporarily drop below the
min_free_kbytes threshold before the kernel reclaimer can catch up.
This results in intermittent test failures, particularly observed on
openQA aarch64 machines.

Implement a 1-second grace period with exponential backoff polling
(from 1ms up to 512ms) in check_monitor() to allow the kernel time to
reclaim memory. Also the global 'end' flag is reset for multi-iteration
support (-i).

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../kernel/mem/tunable/min_free_kbytes.c      | 36 +++++++++++++------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index a62e4ae9d..59ba6a9e1 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) Linux Test Project, 2012-2025
+ * Copyright (c) Linux Test Project, 2012-2026
  * Copyright (C) 2012-2017  Red Hat, Inc.
  */
 
@@ -53,6 +53,8 @@ static void min_free_kbytes_test(void)
 	int pid, status;
 	struct sigaction sa;
 
+	end = 0;
+
 	sa.sa_handler = sighandler;
 	if (sigemptyset(&sa.sa_mask) < 0)
 		tst_brk(TBROK | TERRNO, "sigemptyset");
@@ -140,14 +142,13 @@ static void test_tune(unsigned long overcommit_policy)
 		} else {
 			if (WIFEXITED(status)) {
 				if (WEXITSTATUS(status) != 0) {
-					tst_res(TFAIL, "child unexpectedly "
-						 "failed: %d", status);
+					tst_res(TFAIL, "child unexpectedly failed: %d",
+						status);
 				}
 			} else if (!WIFSIGNALED(status) ||
 				   WTERMSIG(status) != SIGKILL) {
-				tst_res(TFAIL,
-					 "child unexpectedly failed: %d",
-					 status);
+				tst_res(TFAIL, "child unexpectedly failed: %d",
+					status);
 			}
 		}
 	}
@@ -183,18 +184,33 @@ static void check_monitor(void)
 {
 	unsigned long tune;
 	unsigned long memfree;
+	int i;
 
 	while (!end) {
 		memfree = SAFE_READ_MEMINFO("MemFree:");
 		tune = TST_SYS_CONF_LONG_GET(MIN_FREE_KBYTES);
 
 		if (memfree < tune) {
-			tst_res(TINFO, "MemFree is %lu kB, "
-				 "min_free_kbytes is %lu kB", memfree, tune);
-			tst_res(TFAIL, "MemFree < min_free_kbytes");
+			/*
+			 * Give it some time to reclaim. The kernel should keep
+			 * MemFree above min_free_kbytes, but transient drops
+			 * are possible under high pressure.
+			 */
+			for (i = 1; i < 1024; i *= 2) {
+				usleep(i * 1000);
+				memfree = SAFE_READ_MEMINFO("MemFree:");
+				if (memfree >= tune)
+					break;
+			}
+
+			if (memfree < tune) {
+				tst_res(TINFO, "MemFree is %lu kB, min_free_kbytes is %lu kB",
+					memfree, tune);
+				tst_res(TFAIL, "MemFree < min_free_kbytes");
+			}
 		}
 
-		sleep(2);
+		usleep(100000);
 	}
 }
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
