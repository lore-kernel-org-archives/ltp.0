Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052E6C4332F
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 15:06:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECE773CE589
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 16:06:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E645D3C2A65
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 16:06:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ED1E16005DC
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 16:06:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B85F021905;
 Mon, 13 Nov 2023 15:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699887998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EIPKfPFjqs8mlnXzwqHAJazo+mvcsfO/fUUc1mr+PYo=;
 b=zX+w/3BIgn+blM1H6FZbYmYSQNgi3TiuKF6W8mM0DunQIbb4/irJcCQUSNfKCcITOLqrRc
 W3wQ0ERJ/72HiyXE6rqC6RKFDvvn/N6lPtDRVyeqgjX+YNxKSEZFPS8fbzcawBQeviUeNF
 99CMvO2v3s3s7kXBR0FJ3JgHERj+FzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699887998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EIPKfPFjqs8mlnXzwqHAJazo+mvcsfO/fUUc1mr+PYo=;
 b=XddkJc9BNqaWnnrFfH7t8SUy8HIBH2GjomOBtZXddjCxf9z7PeAO5+HtwPLXlMZRSvYI2o
 17+mm5X7I7f8qoDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4A6313907;
 Mon, 13 Nov 2023 15:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yNpxJ347UmVHPwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 13 Nov 2023 15:06:38 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Petr Vorel <pvorel@suse.cz>,
	ltp@lists.linux.it
Date: Mon, 13 Nov 2023 16:06:32 +0100
Message-ID: <20231113150636.3476-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231113150636.3476-1-mdoucha@suse.cz>
References: <20231113150636.3476-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] keyctl02: Add delay between main loop
 iterations for RT kernels
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

Changes since v1:
- Moved KCONFIG_INIT() macro to include/tst_kconfig.h (see patch 1)
- Changed variable type to unsigned to prevent compiler warning in setup()

 testcases/kernel/syscalls/keyctl/keyctl02.c | 22 +++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index 35cc2838d..a3437d065 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -29,6 +29,7 @@
 
 #include "tst_safe_pthread.h"
 #include "tst_test.h"
+#include "tst_kconfig.h"
 #include "lapi/keyctl.h"
 
 #define LOOPS	20000
@@ -36,6 +37,7 @@
 #define PATH_KEY_COUNT_QUOTA	"/proc/sys/kernel/keys/root_maxkeys"
 
 static int orig_maxkeys;
+static int realtime_kernel;
 
 static void *do_read(void *arg)
 {
@@ -86,6 +88,15 @@ static void do_test(void)
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
@@ -126,8 +137,19 @@ static void do_test(void)
 
 static void setup(void)
 {
+	unsigned int i;
+	struct tst_kconfig_var rt_kconfigs[] = {
+		TST_KCONFIG_INIT("CONFIG_PREEMPT_RT"),
+		TST_KCONFIG_INIT("CONFIG_PREEMPT_RT_FULL")
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
