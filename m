Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DFCC83F33
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 07:45:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DAF63CB8DF
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 09:45:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 521CC3CB66E
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 09:44:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3D8C51000A2F
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 09:44:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C6BF1F88D;
 Mon,  4 Sep 2023 07:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693813486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bWcua07BU9hecMg1TkvXD8xALydx6160V1aTNv7sp2E=;
 b=hDMEBvCX6+Z+fpL/+lJNaXMvbbpBGBLdtmWrjFTOCWayIced6XFNOY3nqzTOHlIGMbLHhI
 G8pibi/E0iL4LCzRzvO+dMzDODcA8UEP7Q2UaBi+ppC7Ct+WdxjXkAAD55CsOrXUDqZai3
 exg0zAFMawUzmJXm8GFHWbm82RA/LjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693813486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bWcua07BU9hecMg1TkvXD8xALydx6160V1aTNv7sp2E=;
 b=ZuOQdYhyio3AnNor22Y/rOviKTk9Iibpi1z/sfS7X3ZynYa+PoH0+pZCTFM1QqLzkhougW
 N/tl/DWhQe5ycJDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F4C313425;
 Mon,  4 Sep 2023 07:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4mjfGu2K9WTQRAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Sep 2023 07:44:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon,  4 Sep 2023 09:44:43 +0200
Message-Id: <20230904074443.24701-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] lib: add .min_swap_avail in tst_test struct
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

This new field is mainly to set the minimum size of SwapFree for
LTP testcase. If system available free swap memory is less than
.min_swap_avail, test will be exit with TCONF.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_memutils.h | 5 +++++
 include/tst_test.h     | 3 +++
 lib/tst_memutils.c     | 9 +++++++++
 lib/tst_test.c         | 3 +++
 4 files changed, 20 insertions(+)

diff --git a/include/tst_memutils.h b/include/tst_memutils.h
index 45dec55bc..19b593430 100644
--- a/include/tst_memutils.h
+++ b/include/tst_memutils.h
@@ -25,6 +25,11 @@ void tst_pollute_memory(size_t maxsize, int fillchar);
  */
 long long tst_available_mem(void);
 
+/*
+ * Read the value of SwapFree from /proc/meminfo.
+ */
+long long tst_available_swap(void);
+
 /*
  * Enable OOM protection to prevent process($PID) being killed by OOM Killer.
  *   echo -1000 >/proc/$PID/oom_score_adj
diff --git a/include/tst_test.h b/include/tst_test.h
index 0ac492a80..75c2109b9 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -210,6 +210,9 @@ struct tst_test {
 	/* Minimum size(MB) of MemAvailable required by the test */
 	unsigned long min_mem_avail;
 
+	/* Minimum size(MB) of SwapFree required by the test */
+	unsigned long min_swap_avail;
+
 	/*
 	 * Two policies for reserving hugepage:
 	 *
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index 6fc9f6a93..c5382ff10 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -95,6 +95,15 @@ long long tst_available_mem(void)
 	return mem_available;
 }
 
+long long tst_available_swap(void)
+{
+	unsigned long long swap_available = 0;
+
+	FILE_LINES_SCANF("/proc/meminfo", "SwapFree: %llu", &swap_available);
+
+	return swap_available;
+}
+
 static int has_caps(void)
 {
 	struct tst_cap_user_header hdr = {
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 0efabe467..3cc4aee0a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1198,6 +1198,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->min_mem_avail > (unsigned long)(tst_available_mem() / 1024))
 		tst_brk(TCONF, "Test needs at least %luMB MemAvailable", tst_test->min_mem_avail);
 
+	if (tst_test->min_swap_avail > (unsigned long)(tst_available_swap() / 1024))
+		tst_brk(TCONF, "Test needs at least %luMB SwapFree", tst_test->min_swap_avail);
+
 	if (tst_test->hugepages.number)
 		tst_reserve_hugepages(&tst_test->hugepages);
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
