Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB89EC4167B
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 17:45:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 569743CDBD2
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 18:45:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 842593CDB24
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 18:45:35 +0100 (CET)
Received: from 66-220-144-178.mail-mxout.facebook.com
 (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CBD42603224
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 18:45:34 +0100 (CET)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
 id 6E796FF95F2B; Mon, 27 Nov 2023 09:45:19 -0800 (PST)
From: Stefan Roesch <shr@devkernel.io>
To: kernel-team@fb.com
Date: Mon, 27 Nov 2023 09:45:17 -0800
Message-Id: <20231127174517.2369593-1-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mem: disable KSM smart scan for ksm tests
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
Cc: linux-mm@kvack.org, david@redhat.com, oliver.sang@intel.com,
 ltp@lists.linux.it, shr@devkernel.io
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This disables the "smart scan" KSM feature to make sure that the volatile
count remains at 0.

Signed-off-by: Stefan Roesch <devkernel.io>

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202311161132.13d8ce5a-oliver.sang@intel.com
---
 testcases/kernel/mem/lib/mem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index fbfeef026..ef274a3ac 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -454,6 +454,9 @@ void create_same_memory(int size, int num, int unit)
 	       {'a', size*MB}, {'a', size*MB}, {'d', size*MB}, {'d', size*MB},
 	};
 
+  /* Disable smart scan for correct volatile counts. */
+  SAFE_FILE_PRINTF(PATH_KSM "smart_scan", "0");
+
 	ps = sysconf(_SC_PAGE_SIZE);
 	pages = MB / ps;
 
@@ -526,6 +529,7 @@ void create_same_memory(int size, int num, int unit)
 
 	tst_res(TINFO, "stop KSM.");
 	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
+  SAFE_FILE_PRINTF(PATH_KSM "smart_scan", "1");
 	final_group_check(0, 0, 0, 0, 0, 0, size * pages * num);
 
 	while (waitpid(-1, &status, 0) > 0)

base-commit: 8c89ef3d451087ed6e18750bd5eedd10e5ab3d2e
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
