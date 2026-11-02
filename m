Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8F606A324
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 02:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mcGHa11y
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 985CB3CFDC9
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 03:44:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 750273E5D51
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:43:45 +0100 (CET)
Received: from mta0.migadu.com (out-113.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::71])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9FDDA60065E
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:43:44 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=j8YW+HV4jnGIZkvbSMRfG5G6piFWMCNHJ4o7M3gxXnk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793587423; v=1; x=1794192223;
 b=mcGHa11yzMCyWaeGiayjB5uQ99M0pfsYs44SH6AvKial2BlOSkYOChy5BEc1GLDjkxImNc+i
 G5gMeV7hl86Q+zx5IszMi1HqWEl3UVmI1hhE7dZOtxEREBlS4A2O7KmAzjjPv+cqkEyhpzKm7M8
 ycNkr/q/FNZvVgk/+pRE1Yvo=
X-Envelope-To: ltp@lists.linux.it
Received: by mta11.migadu.com with ESMTPS id b16eab0ceb14e79a;
 Mon, 02 Nov 2026 02:43:43 +0000
X-Mizu-Trace-ID: b16eab0ceb14e79a
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Mon,  2 Nov 2026 10:43:27 +0800
Message-ID: <20261102024328.115105-4-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102024328.115105-1-li.wang@linux.dev>
References: <20261102024328.115105-1-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/4] tst_kconfig: add module mappings for
 vsock/vsock_loopback
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: wakel@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

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
index a0985912c..dca7daec8 100644
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
