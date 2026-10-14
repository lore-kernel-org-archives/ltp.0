Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972FBCC6B19
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 06:13:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBF3D3E6A1D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 08:13:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E05033E5531
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 08:12:41 +0200 (CEST)
Received: from mta1.migadu.com (out-214.mta1.migadu.com
 [IPv6:2001:41d0:203:375::d6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1BB031A00937
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 08:12:38 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=c7Tw3jc16uveOe6fIjow+2AR76tni5emmAqp/QOxUAU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791958351; v=1; x=1792563151;
 b=v8QHCIz4AcinA8fiIAVKFJoHnjr+bmm4tkev5yJv6/vXhu2DhgPYZ+eamHBWzDz5T3jNrrG6
 4UTovy9NUX8NrXFXrXfC8emVDxOljK+5n+3FTb60bZo0nTQXVhSQ0wlqaJBhQLiaEca4wChiaUq
 h+q8SHUMUqSGtnD8mF5uZQPg=
X-Envelope-To: ltp@lists.linux.it
Received: by mta10.migadu.com with ESMTPS id e4cbd318f1060bd6;
 Wed, 14 Oct 2026 06:12:31 +0000
X-Mizu-Trace-ID: e4cbd318f1060bd6
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Wed, 14 Oct 2026 14:12:02 +0800
Message-ID: <20261014061202.56362-5-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014061202.56362-1-li.wang@linux.dev>
References: <20261014061202.56362-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/4] testcases: drop manual tst_modprobe() now
 handled by tst_kconfig
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

From: "Li Wang (Hieco)" <li.wang@linux.dev>

Now that tst_kconfig loads the modules for every CONFIG_*=m entry
listed in config_module_maps[] and unloads them again at cleanup
time, tests no longer have to call tst_modprobe() from setup().

Drop the explicit tst_modprobe() calls, and the now unused
tst_module.h includes, from:

- cve-2026-46331.c: sch_ingress, cls_matchall, act_pedit
- sctphantom.c: sctp
- keyctl29.c: x509_key_parser
- keyctl30.c: pkcs8_key_parser

All four tests already declare the matching configs in
.needs_kconfigs, so tst_kconfig takes care of loading the modules
before setup() runs and unloading them once the test finishes.

BTW, with KCONFIG_SKIP_CHECK=1 the config check returns early,
so the automatic module loading is skipped as well. Users who set
that variable are expected to ensure the required modules are
loaded themselves.

Signed-off-by: Li Wang (Hieco) <li.wang@linux.dev>
---
 testcases/cve/cve-2026-46331.c              | 7 -------
 testcases/cve/sctphantom.c                  | 3 ---
 testcases/kernel/syscalls/keyctl/keyctl29.c | 3 ---
 testcases/kernel/syscalls/keyctl/keyctl30.c | 3 ---
 4 files changed, 16 deletions(-)

diff --git a/testcases/cve/cve-2026-46331.c b/testcases/cve/cve-2026-46331.c
index 3d32a1cbb..3c8db5042 100644
--- a/testcases/cve/cve-2026-46331.c
+++ b/testcases/cve/cve-2026-46331.c
@@ -44,7 +44,6 @@
 #include <linux/rtnetlink.h>
 
 #include "tst_test.h"
-#include "tst_module.h"
 #include "tst_net.h"
 #include "tst_netdevice.h"
 #include "lapi/if_ether.h"
@@ -136,12 +135,6 @@ static void setup(void)
 {
 	struct sockaddr_in addr;
 	struct passwd *pw;
-	static const char *const mods[] = {
-		"sch_ingress", "cls_matchall", "act_pedit"
-	};
-
-	for (unsigned int i = 0; i < ARRAY_SIZE(mods); i++)
-		tst_modprobe(mods[i], NULL);
 
 	/* Drop privileges so the reproducer runs as an unprivileged user */
 	pw = SAFE_GETPWNAM("nobody");
diff --git a/testcases/cve/sctphantom.c b/testcases/cve/sctphantom.c
index 83834b848..bdbe40286 100644
--- a/testcases/cve/sctphantom.c
+++ b/testcases/cve/sctphantom.c
@@ -50,7 +50,6 @@
  */
 
 #include "tst_test.h"
-#include "tst_module.h"
 #include "tst_checksum.h"
 #include "tst_safe_net.h"
 
@@ -205,8 +204,6 @@ static void setup(void)
 	};
 	const struct tst_path_val *sysctl;
 
-	tst_modprobe("sctp", NULL);
-
 	for (sysctl = sysctls; sysctl->path; sysctl++)
 		tst_sys_conf_save(sysctl);
 
diff --git a/testcases/kernel/syscalls/keyctl/keyctl29.c b/testcases/kernel/syscalls/keyctl/keyctl29.c
index afc0a093c..e66b39bcb 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl29.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl29.c
@@ -23,7 +23,6 @@
 
 #include "keyctl_common.h"
 #include "keyctl_pkey_data.h"
-#include "tst_module.h"
 
 static key_serial_t cert_key;
 static struct keyctl_pkey_query *query_buf;
@@ -32,8 +31,6 @@ static void setup(void)
 {
 	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
 
-	tst_modprobe("x509_key_parser", NULL);
-
 	cert_key = add_asymmetric_key_or_tconf("cert", rsa2048_cert,
 					       sizeof(rsa2048_cert),
 					       "CONFIG_X509_CERTIFICATE_PARSER");
diff --git a/testcases/kernel/syscalls/keyctl/keyctl30.c b/testcases/kernel/syscalls/keyctl/keyctl30.c
index ef51bba33..4f43007e0 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl30.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl30.c
@@ -20,7 +20,6 @@
 
 #include "keyctl_common.h"
 #include "keyctl_pkey_data.h"
-#include "tst_module.h"
 
 static key_serial_t priv_key;
 static struct keyctl_pkey_query *query_buf;
@@ -29,8 +28,6 @@ static void setup(void)
 {
 	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
 
-	tst_modprobe("pkcs8_key_parser", NULL);
-
 	priv_key = add_asymmetric_key_or_tconf("priv", rsa2048_pkcs8,
 					       sizeof(rsa2048_pkcs8),
 					       "CONFIG_PKCS8_PRIVATE_KEY_PARSER");
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
