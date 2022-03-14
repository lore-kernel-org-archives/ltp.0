Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691AFC433EF
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 04:29:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F19E03C91DE
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 05:29:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2196C3C0211
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 05:29:12 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B80831A006AE
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 05:29:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1647232150; i=@fujitsu.com;
 bh=MScL3CcBQSkN+XC6ZJ04PFcb2WeGolBTC1cBD8m+F0o=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=yohhgJqdefnbuzzJTNj0GaBmy0ThPOwjKAxuzYWwvZQv6utfitDqzD/QXsdsN5Vhn
 7mfnOdk36wK9CsB71CQHgW3OOqclNtvLgMIM2VHK6GPP0WaGYkwve4Ac33UfOvJKLR
 Q/UYK3YjVfZBVsIwhEkdR8iQiaN1Zl+XjH2CC2nMjVXcOgDyWBI26QsL6cFAf9EKV8
 6HK7ydSxQe6rysRH22KC7ZYFgKOW8v6KpuhSPeznpg3OzectlVh0OMkCFSjuyGUmQX
 UR7Krp1S6a7xeUPE9BG3VQH33urG73ti9oXHlO2gzSZ9DqiwBHb3NqsjkfTp3CRY4Z
 ZIRLpJJvWoozA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRWlGSWpSXmKPExsViZ8MRojvtiF6
 SwZRfLBYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aC9klsBduFKtZ19TA3MN7i72Lk5BASaGKS
 uPG+CsLezyhx/oMAiM0moCFx7XE7M4gtIiAh0dHwlh3EZhZQk9h99RgbiC0soCVxY94/FhCbR
 UBVonNGA1ANBwevgJvEqZ+SIGEJAQWJKQ/fg43hFRCUODnzCQvEGAmJgy9eMEPUKErs37uREc
 KukJgxYxvbBEbeWUhaZiFpWcDItIrRMqkoMz2jJDcxM0fX0MBA19DQVNdQ19RSL7FKN1EvtVS
 3PLW4RNdQL7G8WC+1uFivuDI3OSdFLy+1ZBMjMLhSihmtdzB29P3UO8QoycGkJMp7cLNukhBf
 Un5KZUZicUZ8UWlOavEhRhkODiUJ3omH9ZKEBItS01Mr0jJzgIEOk5bg4FES4X25DyjNW1yQm
 FucmQ6ROsWoy/Fg4d69zEIsefl5qVLivOEgMwRAijJK8+BGwKLuEqOslDAvIwMDgxBPQWpRbm
 YJqvwrRnEORiVh3m6QKTyZeSVwm14BHcEEdMQ8abAjShIRUlINTBsCJ2zaxqLoHP2QKa/i4rx
 Vuq6T3ieJKszcHMd78rRWz8r5inHm1W/5zXQSP8jxX6gJ9Ns7j1d9/r24vc4nMvgfz5PITpVf
 7Tstb96pvNqN5tKXpzu9ua36JeWguOmn6ecP8504+04g6tYqL2lXxliWtR1rqiu7jmjNtWL52
 apSfrJKuLb70DHWjzK3RS8fbpz7nnWe5Ix9p9krtx+W2HIuWnNOTeQ+uW8/5+nNfhqm5v1v6e
 nsI5/1VGe93Hu75BnzsmX737F4bFvk0jfNXFJ/jfyx1Z4fp+id99dex325dfUe0YrYnKTt6Y6
 PdF4vDV9wa06F0XvbLX+lXq5dKPa1bW7Zmskc1zyWz+l57m+gxFKckWioxVxUnAgAFQ60pzUD
 AAA=
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-12.tower-591.messagelabs.com!1647232149!7768!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17691 invoked from network); 14 Mar 2022 04:29:10 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
 by server-12.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 14 Mar 2022 04:29:10 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 22E4T32M019011
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 04:29:09 GMT
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Mon, 14 Mar 2022 04:29:02 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 14 Mar 2022 13:28:18 -0400
Message-ID: <1647278899-29461-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Add SAFE_ACCESS macro
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

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 include/old/safe_macros.h |  3 +++
 include/safe_macros_fn.h  |  3 +++
 include/tst_safe_macros.h |  3 +++
 lib/safe_macros.c         | 20 ++++++++++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/include/old/safe_macros.h b/include/old/safe_macros.h
index fb1d7a1..1d5de49 100644
--- a/include/old/safe_macros.h
+++ b/include/old/safe_macros.h
@@ -20,6 +20,9 @@
 #include "old_safe_stdio.h"
 #include "old_safe_net.h"
 
+#define SAFE_ACCESS(cleanup_fn, pathname, mode)	\
+	safe_access(__FILE__, __LINE__, cleanup_fn, (pathname), (mode))
+
 #define SAFE_BASENAME(cleanup_fn, path)	\
 	safe_basename(__FILE__, __LINE__, (cleanup_fn), (path))
 
diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index 3df9528..2c8eb50 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -24,6 +24,9 @@
 #include <unistd.h>
 #include <dirent.h>
 
+int safe_access(const char *file, const int lineno,
+		void (*cleanup_fn)(void), const char *pathname, int mode);
+
 char* safe_basename(const char *file, const int lineno,
                     void (*cleanup_fn)(void), char *path);
 
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 9a543e4..d8e56f5 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -24,6 +24,9 @@
 #include "safe_macros_fn.h"
 #include "tst_cmd.h"
 
+#define SAFE_ACCESS(pathname, mode) \
+	safe_access(__FILE__, __LINE__, NULL, (pathname), (mode))
+
 #define SAFE_BASENAME(path) \
 	safe_basename(__FILE__, __LINE__, NULL, (path))
 
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index a5b6bc5..006e583 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -24,6 +24,26 @@
 #include "test.h"
 #include "safe_macros.h"
 
+int
+safe_access(const char *file, const int lineno, void (*cleanup_fn) (void),
+	   const char *pathname, int mode)
+{
+	int rval;
+
+	rval = access(pathname, mode);
+
+	if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"access(%s,%d) failed", pathname, mode);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid access(%s,%d) return value %d", pathname,
+			mode, rval);
+	}
+
+	return rval;
+}
+
 char *safe_basename(const char *file, const int lineno,
 		    void (*cleanup_fn) (void), char *path)
 {
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
