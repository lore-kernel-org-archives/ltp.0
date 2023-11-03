Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3ECC4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 17:23:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A29063CE945
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 18:23:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D05873CC599
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 18:23:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A9C371002031
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 18:23:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CDC0C1F45F
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699032221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1TREswFvxMNEPGWEHacGHMvZqDpzLYi2rTRRvGZc5B0=;
 b=a8Nvyz3Vmw9e8jGoKU7Szc0dpkVGY9jy9nB8pGCILecGCh3qoKS18Fu47sW7C5UedXeP20
 Wkev8whFo1/lGqUtKtzz/zMHf8k7av5rPx31JzQAgNSubokk2FR838RnrkNn0qkyHIWuGh
 1x5SaDIip3K572y8J+JXdj8NlWQbB1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699032221;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1TREswFvxMNEPGWEHacGHMvZqDpzLYi2rTRRvGZc5B0=;
 b=k1T4hKxG61ny+mAdBt9rJ43pBFaDWRF4O3kTfNO5KGjJGRRkFh8FU8ec8grB97yfwgZJRO
 0kPlYTfFN69QnvAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD5621348C
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 17:23:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I85PLZ0sRWXQYAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 03 Nov 2023 17:23:41 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  3 Nov 2023 18:23:34 +0100
Message-ID: <20231103172335.23787-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] keyctl02: Add delay between main loop iterations for
 RT kernels
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

Realtime kernels have deferred thread cleanup which means that
exited and joined threads can still pile up and trigger cgroup
thread limits. Add 100us delay on RT kernels to limit the maximum
number of stale threads.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

The extra delay adds ~3 seconds to total test runtime. Tested on SLERT-12SP5,
SLERT-15SP4 and SLES-12SP5.

 testcases/kernel/syscalls/keyctl/keyctl02.c | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index 35cc2838d..2a81ce9e6 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -29,13 +29,17 @@
 
 #include "tst_safe_pthread.h"
 #include "tst_test.h"
+#include "tst_kconfig.h"
 #include "lapi/keyctl.h"
 
 #define LOOPS	20000
 #define MAX_WAIT_FOR_GC_MS 5000
 #define PATH_KEY_COUNT_QUOTA	"/proc/sys/kernel/keys/root_maxkeys"
 
+#define KCONFIG_INIT(confname) { .id = confname, .id_len = strlen(confname) }
+
 static int orig_maxkeys;
+static int realtime_kernel;
 
 static void *do_read(void *arg)
 {
@@ -86,6 +90,15 @@ static void do_test(void)
 			tst_res(TINFO, "Runtime exhausted, exiting after %d loops", i);
 			break;
 		}
+
+		/*
+		 * Realtime kernel has deferred post-join thread cleanup which
+		 * may result in exhaustion of cgroup thread limit. Add delay
+		 * to limit the maximum number of stale threads to 4000
+		 * even with CONFIG_HZ=100.
+		 */
+		if (realtime_kernel)
+			usleep(100);
 	}
 
 	/*
@@ -126,8 +139,19 @@ static void do_test(void)
 
 static void setup(void)
 {
+	int i;
+	struct tst_kconfig_var rt_kconfigs[] = {
+		KCONFIG_INIT("CONFIG_PREEMPT_RT"),
+		KCONFIG_INIT("CONFIG_PREEMPT_RT_FULL")
+	};
+
 	SAFE_FILE_SCANF(PATH_KEY_COUNT_QUOTA, "%d", &orig_maxkeys);
 	SAFE_FILE_PRINTF(PATH_KEY_COUNT_QUOTA, "%d", orig_maxkeys + LOOPS + 1);
+
+	tst_kconfig_read(rt_kconfigs, ARRAY_SIZE(rt_kconfigs));
+
+	for (i = 0; i < ARRAY_SIZE(rt_kconfigs); i++)
+		realtime_kernel |= rt_kconfigs[i].choice == 'y';
 }
 
 static void cleanup(void)
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
