Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD3BCC6B34
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 07:59:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDD683E69F0
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 09:59:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31DDB3E69F4
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 09:58:57 +0200 (CEST)
Received: from mta0.migadu.com (out-13.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6BC2360223E
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 09:58:55 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=X8j5RSiKdsuM71iPv6u1xGLnVp5fLjfF/cKQ7ZLdu+A=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792051135; v=1; x=1792655935;
 b=k0QTNQAXyHU7S3vXx2AnvPtbrSO/+I9+rdeMYfOQPzfRIABZkX7nDEk7KyfhlrTz632Y/3rN
 bxtTaT7AXZImG71YABLcAEISIQf5y1h2rmj5FGF6zjGYJjpEyu3Q+rzJzwC0OhoEbRwQiQaioXJ
 hTsLa6dS62f6ZiyOhwOeyPVk=
X-Envelope-To: ltp@lists.linux.it
Received: by mta12.migadu.com with ESMTPS id 256b4bfe0e84d93e;
 Thu, 15 Oct 2026 07:58:54 +0000
X-Mizu-Trace-ID: 256b4bfe0e84d93e
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Thu, 15 Oct 2026 15:58:11 +0800
Message-ID: <20261015075812.184811-4-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015075812.184811-1-li.wang@linux.dev>
References: <20261015075812.184811-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/4] tst_kconfig: add module mappings for
 vsock/vsock_loopback
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
Cc: wakel@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: "Li Wang (Hieco)" <li.wang@linux.dev>

Map CONFIG_VSOCKETS to "vsock" and CONFIG_VSOCKETS_LOOPBACK to
"vsock_loopback" so tst_kconfig can load them on demand.

cve-2025-21756 binds to VMADDR_CID_LOCAL and therefore needs
vsock_loopback. Without the module loaded, bind() fails with
EADDRNOTAVAIL and the test aborts with TBROK. Declare both configs in
needs_kconfigs so the modules are loaded first.

The test needs root only to load the modules; the reproducer runs as
an ordinary non-root process in the initial namespace, where it can
use loopback VSOCK on non-privileged ports. Drop privileges to nobody
in setup() after the modules are loaded; the framework unloads the
modules from its still-root context, so no restore is needed in
cleanup().

Signed-off-by: Li Wang (Hieco) <li.wang@linux.dev>
---
 lib/tst_kconfig.c              |  2 ++
 testcases/cve/cve-2025-21756.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 421852ba5..dc025c9f0 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -174,6 +174,8 @@ static struct config_module_map {
 	{"CONFIG_NET_ACT_PEDIT", "act_pedit"},
 	{"CONFIG_PKCS8_PRIVATE_KEY_PARSER", "pkcs8_key_parser"},
 	{"CONFIG_X509_CERTIFICATE_PARSER", "x509_key_parser"},
+	{"CONFIG_VSOCKETS", "vsock"},
+	{"CONFIG_VSOCKETS_LOOPBACK", "vsock_loopback"},
 	{}
 };
 
diff --git a/testcases/cve/cve-2025-21756.c b/testcases/cve/cve-2025-21756.c
index 4245a4c95..b49950045 100644
--- a/testcases/cve/cve-2025-21756.c
+++ b/testcases/cve/cve-2025-21756.c
@@ -13,12 +13,22 @@
  * Beware, this test will crash the system.
  */
 
+#include <pwd.h>
+
 #include "tst_test.h"
 #include "lapi/vm_sockets.h"
 
 #define MAX_PORT_RETRIES	24
 #define VMADDR_CID_NONEXISTING	42
 
+static void setup(void)
+{
+	struct passwd *pw = SAFE_GETPWNAM("nobody");
+
+	SAFE_SETEGID(pw->pw_gid);
+	SAFE_SETEUID(pw->pw_uid);
+}
+
 static int vsock_bind(unsigned int cid, unsigned int port, int type)
 {
 	int sock;
@@ -85,8 +95,15 @@ static void run(void)
 }
 
 static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
 	.test_all = run,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.needs_kconfigs = (const char *const[]) {
+		"CONFIG_VSOCKETS",
+		"CONFIG_VSOCKETS_LOOPBACK",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "fcdd2242c0231032fc84e1404315c245ae56322a"},
 		{"CVE", "2025-21756"},
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
