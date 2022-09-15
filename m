Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA9BC6FA89
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 16:03:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 239CB3CAC66
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 18:03:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18E913CABA9
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 18:03:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5BACB1401349
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 18:03:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3391E1F936
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 16:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663257824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OC7Vtt+zUih/P6fDdUi1K2W0dgZEnbwEGJ/+NVkCXHg=;
 b=nmyXniPU4/KyNsaTFcCBTjbfpkGWl6KgAZm0ygxRMhRgVwtj8a0VTsvIKkZkEeV3sTvajx
 W+tZEYml7cYR68cQTd04Amb+AZonma422t/lmDJI8sk98CAadmVIkqbjMO4rDZd1xxzgdN
 6ayL6ynNrBnrh5p/F0d3d2eoeCLFqXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663257824;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OC7Vtt+zUih/P6fDdUi1K2W0dgZEnbwEGJ/+NVkCXHg=;
 b=C+9lYXs2WdnnuYz291TfEOOrZCtdqYcWS9lisWFtRlgiKOuq+AlvuNcWhp+W/ej7drtUNj
 DWU/a3LSMYceohCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A61613A49
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 16:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oSqdBOBMI2NZIwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 16:03:44 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 15 Sep 2022 18:03:43 +0200
Message-Id: <20220915160343.21773-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ksm: Add max_runtime to tests
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

ksm02, ksm04 and ksm05 take 10+ seconds to finish. Set max_runtime to avoid
random timeout issues.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Increased max_runtime from 20s to 32s
- Added dynamic runtime calculation for non-default memsize

After some experiments it turns out that the total amount of RAM doesn't
matter, ksmd will scan only pages marked with MADV_MERGEABLE. So unless
another process interferes with the test, we can calculate max_runtime
from the memory size parameter.

The create_same_memory() function will run 4 ksm scan on each call which
takes about 2 seconds with the default memory size. Both ksm02 and ksm04
call it twice which means 16 seconds of runtime by default. Let's raise it
to 32 for some safety margin on slower systems.

 testcases/kernel/mem/ksm/ksm02.c      | 4 ++++
 testcases/kernel/mem/ksm/ksm04.c      | 4 ++++
 testcases/kernel/mem/ksm/ksm_common.h | 4 +++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 1cb7d8e73..4183108d5 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -85,6 +85,9 @@ static void verify_ksm(void)
 static void setup(void)
 {
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
+
+	if (opt_sizestr && size > DEFAULT_MEMSIZE)
+		tst_set_max_runtime(32 * (size / DEFAULT_MEMSIZE));
 }
 
 static struct tst_test test = {
@@ -110,6 +113,7 @@ static struct tst_test test = {
 	},
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
+	.max_runtime = 32,
 	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
 };
 
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 39c741876..9fe9d6dd5 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -87,6 +87,9 @@ static void setup(void)
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
+
+	if (opt_sizestr && size > DEFAULT_MEMSIZE)
+		tst_set_max_runtime(32 * (size / DEFAULT_MEMSIZE));
 }
 
 static struct tst_test test = {
@@ -112,6 +115,7 @@ static struct tst_test test = {
 	},
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
+	.max_runtime = 32,
 	.needs_cgroup_ctrls = (const char *const []){
 		"memory", "cpuset", NULL
 	},
diff --git a/testcases/kernel/mem/ksm/ksm_common.h b/testcases/kernel/mem/ksm/ksm_common.h
index 56faf01e4..a582891c6 100644
--- a/testcases/kernel/mem/ksm/ksm_common.h
+++ b/testcases/kernel/mem/ksm/ksm_common.h
@@ -9,7 +9,9 @@
 
 #include "tst_test.h"
 
-int size = 128, num = 3, unit = 1;
+#define DEFAULT_MEMSIZE 128
+
+int size = DEFAULT_MEMSIZE, num = 3, unit = 1;
 char *opt_sizestr, *opt_numstr, *opt_unitstr;
 
 static inline void parse_ksm_options(char *str_size, int *size,
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
