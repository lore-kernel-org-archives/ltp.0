Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F2BCA6017
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 03:37:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 917303EB1C2
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 05:37:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 692033EB1C4
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 05:36:59 +0200 (CEST)
Received: from mta0.migadu.com (out-151.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::97])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DF91D60193C
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 05:36:58 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=AS9FRZerIDXcoyM0v7qS+yJRT10d9lTmm6kYtZpG1qU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791603417; v=1; x=1792208217;
 b=cdlQtoYP0rGDBvAP4507lpxpDF4JJFfdyfOUfMNrCa14VRPmI8dJxZAKbpTKYnclPou4ZLlR
 6YOTgfurfgChxm+RaShzvnJN/SYCWb1ekgJ8l6UvZp3qQpuhhpGZSP8cU92a6UIHo1wd72cCO1e
 a/UVLPj3hLAIV7V/IpYxUCs0=
X-Envelope-To: ltp@lists.linux.it
Received: by mta10.migadu.com with ESMTPS id 905328b9c6565e13;
 Sat, 10 Oct 2026 03:36:57 +0000
X-Mizu-Trace-ID: 905328b9c6565e13
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Sat, 10 Oct 2026 11:36:21 +0800
Message-ID: <20261010033622.68927-4-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010033622.68927-1-li.wang@linux.dev>
References: <20261010033622.68927-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] tst_kconfig: add module mappings for
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Map CONFIG_VSOCKETS to "vsock" and CONFIG_VSOCKETS_LOOPBACK to
"vsock_loopback" so tst_kconfig can load them on demand.

cve-2025-21756 binds to VMADDR_CID_LOCAL and therefore needs
vsock_loopback. Without the module loaded, bind() fails with
EADDRNOTAVAIL and the test aborts with TBROK. Declare both configs in
needs_kconfigs so the modules are loaded first.

The test needs root only to load the modules; the reproducer runs as
an ordinary nonroot process in the initial namespace, which can use
loopback VSOCK on nonprivileged ports. Drop privileges to nobody after
module loading and regain root in cleanup() so the modules can be
unloaded.

Signed-off-by: Li Wang <li.wang@linux.dev>
---
 lib/tst_kconfig.c              |  2 ++
 testcases/cve/cve-2025-21756.c | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index e2f3061c0..d239f39df 100644
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
index 4245a4c95..a57abeef8 100644
--- a/testcases/cve/cve-2025-21756.c
+++ b/testcases/cve/cve-2025-21756.c
@@ -13,12 +13,40 @@
  * Beware, this test will crash the system.
  */
 
+#include <pwd.h>
+
 #include "tst_test.h"
 #include "lapi/vm_sockets.h"
 
 #define MAX_PORT_RETRIES	24
 #define VMADDR_CID_NONEXISTING	42
 
+static void drop_privileges(void)
+{
+	struct passwd *pw = SAFE_GETPWNAM("nobody");
+
+	SAFE_SETEGID(pw->pw_gid);
+	SAFE_SETEUID(pw->pw_uid);
+}
+
+static void restore_privileges(void)
+{
+	SAFE_SETEGID(0);
+	SAFE_SETEUID(0);
+}
+
+static void setup(void)
+{
+	/* This exercises the vulnerability from a non-root context. */
+	drop_privileges();
+}
+
+static void cleanup(void)
+{
+	/* Regain root so that the module can be unloaded. */
+	restore_privileges();
+}
+
 static int vsock_bind(unsigned int cid, unsigned int port, int type)
 {
 	int sock;
@@ -85,8 +113,16 @@ static void run(void)
 }
 
 static struct tst_test test = {
+	.needs_root = 1,
 	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
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
