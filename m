Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07F1C433F5
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 15:21:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E119961AA5
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 15:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E119961AA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 991313C8628
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 16:21:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 207EE3C0E98
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 16:20:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8EEB920034C
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 16:20:58 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E25B11FD6A;
 Mon, 15 Nov 2021 15:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1636989657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FyiWbajlnr5I0P+Rrx+zGQu1MJQRaeg/OIQBwQjpPo=;
 b=hZKEZ33lMgtRqDrSuL3U25FO/qQ9e7PiEkdGcv2+t50EcdxSOz41y0A18W5v732xFOgFPp
 lK4GslGg4wK7cRcl3RoiBUeHRARkeLEb/ytOT40LXfgm34FfloZvqcFtC9m1Wx+9IKn2so
 ZCrxsrUUMQP7lFy3EWUShG9XLFNuqKc=
Received: from g78.suse.de (unknown [10.163.24.38])
 by relay2.suse.de (Postfix) with ESMTP id A9001A3B81;
 Mon, 15 Nov 2021 15:20:57 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 15 Nov 2021 15:20:29 +0000
Message-Id: <20211115152029.22552-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115152029.22552-1-rpalethorpe@suse.com>
References: <20211115152029.22552-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] lib: Add .skip_in_compat flag
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some tests can never be run under 32-bit compatibility mode. This adds
a flag to skip them. This will show up in the meta data in addition to
causing the test to exit with TCONF if compat mode is detected at
runtime.

It's possible that support for compat mode will be added to
CAN. If this happens then we will have to probe the interface for
support when in 32-bit compat mode.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h                          |  1 +
 lib/tst_test.c                              |  4 ++++
 testcases/kernel/syscalls/ptrace/ptrace08.c | 13 +++++--------
 testcases/network/can/cve/can_bcm01.c       |  5 +++++
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 3dcb45de0..602ce3090 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -164,6 +164,7 @@ struct tst_test {
 	 */
 	int all_filesystems:1;
 	int skip_in_lockdown:1;
+	int skip_in_compat:1;
 
 	/*
 	 * The skip_filesystem is a NULL terminated list of filesystems the
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 02ae28335..c1fab3b18 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -18,6 +18,7 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_device.h"
+#include "lapi/abisize.h"
 #include "lapi/futex.h"
 #include "lapi/syscalls.h"
 #include "tst_ansi_color.h"
@@ -978,6 +979,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->skip_in_lockdown && tst_lockdown_enabled())
 		tst_brk(TCONF, "Kernel is locked down, skipping test");
 
+	if (tst_test->skip_in_compat && TST_ABI != tst_kernel_bits())
+		tst_brk(TCONF, "Running in 32-bit compat mode");
+
 	if (tst_test->needs_cmds) {
 		const char *cmd;
 		char path[PATH_MAX];
diff --git a/testcases/kernel/syscalls/ptrace/ptrace08.c b/testcases/kernel/syscalls/ptrace/ptrace08.c
index f86f69a9c..170cae64c 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace08.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace08.c
@@ -66,14 +66,6 @@ static struct tst_kern_exv kvers[] = {
 
 static void setup(void)
 {
-	/*
-	 * When running in compat mode we can't pass 64 address to ptrace so we
-	 * have to skip the test.
-	 */
-	if (tst_kernel_bits() != KERN_ADDR_BITS)
-		tst_brk(TCONF, "Cannot pass 64bit kernel address in compat mode");
-
-
 	/*
 	 * The original fix for the kernel haven't rejected the kernel address
 	 * right away when breakpoint was modified from userspace it was
@@ -164,6 +156,11 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.forks_child = 1,
+	/*
+	 * When running in compat mode we can't pass 64 address to ptrace so we
+	 * have to skip the test.
+	 */
+	.skip_in_compat = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "f67b15037a7a"},
 		{"CVE", "2018-1000199"},
diff --git a/testcases/network/can/cve/can_bcm01.c b/testcases/network/can/cve/can_bcm01.c
index 1c527da7a..d4f1e4ec4 100644
--- a/testcases/network/can/cve/can_bcm01.c
+++ b/testcases/network/can/cve/can_bcm01.c
@@ -11,6 +11,10 @@
  *  Date:   Sat Jun 19 13:18:13 2021 -0300
  *
  *  can: bcm: delay release of struct bcm_op after synchronize_rcu()
+ *
+ * The test is skipped when running in 32-bit compat mode. The kernel
+ * compatibility layer for CAN structures is not implemented at the
+ * time of writing.
  */
 
 #include "config.h"
@@ -137,6 +141,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_root = 1,
+	.skip_in_compat = 1,
 	.needs_drivers = (const char *const[]) {
 		"vcan",
 		"can-bcm",
-- 
2.33.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
