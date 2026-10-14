Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B804DCC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 06:13:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4230E3E4E30
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 08:13:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAEAE3E6A1A
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 08:12:27 +0200 (CEST)
Received: from mta0.migadu.com (out-37.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::25])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 57B252009E7
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 08:12:26 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=y3qaazzVZYWE15pnDLvsPB52H6oHBeuBdgRa3j9T054=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791958346; v=1; x=1792563146;
 b=JHUGKUkMh2wwNgfQ7Pl4NuxDgZ8rfM/NlFAV/0luba9R8qNtGATpLGi5iAxZ2lKSvcgnJuAa
 MWT2uCM59E5+D+nJEkT49A3k2YhHMow8QIQcg/B+lMSUsAbDvDKqt88NIl/j/rHc0RFPGihuDpq
 Ry4gUW+KgLERdQVzG3Y/z3D8=
X-Envelope-To: ltp@lists.linux.it
Received: by mta10.migadu.com with ESMTPS id 33f8bd4d30c4dd8b;
 Wed, 14 Oct 2026 06:12:25 +0000
X-Mizu-Trace-ID: 33f8bd4d30c4dd8b
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Wed, 14 Oct 2026 14:12:01 +0800
Message-ID: <20261014061202.56362-4-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014061202.56362-1-li.wang@linux.dev>
References: <20261014061202.56362-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/4] tst_kconfig: add module mappings for
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
after the modules are loaded, and regain root in cleanup() so the
modules can be unloaded again.

Signed-off-by: Li Wang (Hieco) <li.wang@linux.dev>
---
 lib/tst_kconfig.c              |  2 ++
 testcases/cve/cve-2025-21756.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

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
index 4245a4c95..70dddabb7 100644
--- a/testcases/cve/cve-2025-21756.c
+++ b/testcases/cve/cve-2025-21756.c
@@ -13,12 +13,38 @@
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
+	drop_privileges();
+}
+
+static void cleanup(void)
+{
+	restore_privileges();
+}
+
 static int vsock_bind(unsigned int cid, unsigned int port, int type)
 {
 	int sock;
@@ -85,8 +111,16 @@ static void run(void)
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
