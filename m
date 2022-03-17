Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9688BC433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 09:01:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 597103C9431
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 10:01:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 129E43C9364
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 10:00:51 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C1DF210286A4
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 10:00:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1647507649; i=@fujitsu.com;
 bh=OrlOEc6/LXARNuluUrDmww7hQSXqu7jH+cpk87xCEww=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=QbW7c0+FqGEbAsg5MJG3oGzFI9pNhsaAM4Ad+PGb0PO7MoaLp6CJAs/oadZyobkt3
 +AfZUr5/4LT7LCUScOWHzz1EmuGFvQ+xcvqGKQfOLAYzSwvNvriQf41e2X0I80QAq1
 u9Atxly2N7MuKyyDs1pHIxUvvl4G7jBJK6+ntaF6663LOOflozi+ETapbKcKlLU+eG
 hb91Bzt+Wq6my61E1kaKW5JY0qJfSmmZX5YOVcyJ379HzGhl0mCsb1G5Bk+Caw/e1Y
 LKcRBwxYvYNTFxGtz3dPQsds5/xT0szWINpoCK46Cwu1xozxnlUz1x3oPaguGa3QtS
 NAJKM6JluNNfA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRWlGSWpSXmKPExsViZ8MxRffgD6M
 kg57N0hYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8b5s4fYC6bwVHy5N4O5gXEDZxcjF4eQQBOT
 xKSDO5khnP2MEnsPvgdyODnYBDQkrj1uB7NFBOQl9k5oBrOZBWwk9l2dAGYLC+hKbJr1ngXEZ
 hFQlbj19hVjFyMHB6+Aq8SBX5IgYQkBBYkpDyFGcgpoS9y/shKsREhAS+LYG1eQMK+AoMTJmU
 9YIKZLSBx88YIZolVRYv/ejYwQdoXEjBnb2CYw8s9C0jILScsCRqZVjJZJRZnpGSW5iZk5uoY
 GBrqGhqa6xroWZnqJVbqJeqmluuWpxSW6hnqJ5cV6qcXFesWVuck5KXp5qSWbGIHhmFLMHLaD
 8U/vT71DjJIcTEqivGu/GiUJ8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuDd/B0oJ1iUmp5akZaZA
 4wNmLQEB4+SCK/xR6A0b3FBYm5xZjpE6hSjopQ477v3QAkBkERGaR5cGyweLzHKSgnzMjIwMA
 jxFKQW5WaWoMq/YhTnYFQS5r0Gsp0nM68EbvoroMVMQIsbBcAWlyQipKQamEqNyvgmxq04f2i
 p1411e1Pe8LT+qn275k6SodoXv1jvxVIbn7W/vqRRd5xth8w2PhOeB/NbtngJeTyeqx5vvDVI
 SWpmbjXbA4ezKgabM+Ve/q76L7HB6sLRFI4EyTppce4LRY+5Z67x/lK670s7y8SuSxN1jUVO2
 Tx5k6KVNeux9oO+vG2z36lx+XwPaXOc82mBztQb60OdrmVMM2Li/H+dfR/fgfrNUdM4mW/8Wx
 B2++kkho11STIvw+9LGeTrfjpwwkHboWnegY03z3La6Aq05rTFfPi3yL6803X5j7cqU3KcG6K
 7MrTFq3sMGU8H3C8x8K+rZJKNYOefrtH0OL1sS1Imw4nncopsjhPclFiKMxINtZiLihMBH2Up
 DEIDAAA=
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-8.tower-591.messagelabs.com!1647507649!4729!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.10; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27015 invoked from network); 17 Mar 2022 09:00:49 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-8.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 17 Mar 2022 09:00:49 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 22H90gl2016121
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 09:00:49 GMT
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 17 Mar 2022 09:00:40 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <xuyang2018.jy@fujitsu.com>
Date: Thu, 17 Mar 2022 17:00:11 -0400
Message-ID: <1647550813-1958-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <622EE434.4000400@fujitsu.com>
References: <622EE434.4000400@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] Add SAFE_ACCESS macro
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 include/tst_safe_macros.h |  5 +++++
 lib/tst_safe_macros.c     | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 9a543e4..81c4b08 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -24,6 +24,11 @@
 #include "safe_macros_fn.h"
 #include "tst_cmd.h"
 
+int safe_access(const char *filename, const int lineno, const char *pathname,
+		   int mode);
+#define SAFE_ACCESS(path, mode) \
+	safe_access(__FILE__, __LINE__, (path), (mode))
+
 #define SAFE_BASENAME(path) \
 	safe_basename(__FILE__, __LINE__, NULL, (path))
 
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index a9f6aeb..24aad0d 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -20,6 +20,25 @@
 #include "lapi/personality.h"
 #include "lapi/pidfd.h"
 
+int safe_access(const char *file, const int lineno,
+           const char *pathname, int mode)
+{
+        int rval;
+
+        rval = access(pathname, mode);
+
+        if (rval == -1) {
+                tst_brk_(file, lineno, TBROK | TERRNO,
+                        "access(%s,%d) failed", pathname, mode);
+        } else if (rval) {
+                tst_brk_(file, lineno, TBROK | TERRNO,
+                        "Invalid access(%s,%d) return value %d", pathname,
+                        mode, rval);
+        }
+
+        return rval;
+}
+
 int safe_setpgid(const char *file, const int lineno, pid_t pid, pid_t pgid)
 {
 	int rval;
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
