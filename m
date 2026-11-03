Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF66606A324
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F3Rltbpg
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E23A13C6571
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 08:58:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A95293C6FDF
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 08:57:34 +0100 (CET)
Received: from mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4640C6005CD
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 08:57:34 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=9yUl1ZrDcIuwhX4ig/YCY3OHa6bOD1NA8ZjxOFkKFHI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793692653; v=1; x=1794297453;
 b=F3RltbpgWmL8w/SN2nWit1MogXaAqKAzQT9L8PUr+gOXO0RTUZ/KbXLmLqIxAfJT84+2RluY
 nEqI+1trhcJ8L9Mtgn/L+YnxUuEKdWE6xQjSBdcLIKHab0yet0g5fyGSAOoYfUgIh3TDGhqq25S
 asdeM+Pt66mSpBAHq07jLwJw=
X-Envelope-To: ltp@lists.linux.it
Received: by mta12.migadu.com with ESMTPS id 6ac6f8894c0ef1e5;
 Tue, 03 Nov 2026 07:57:33 +0000
X-Mizu-Trace-ID: 6ac6f8894c0ef1e5
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Tue,  3 Nov 2026 15:57:21 +0800
Message-ID: <20261103075722.181317-4-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103075722.181317-1-li.wang@linux.dev>
References: <20261103075722.181317-1-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 3/4] tst_kconfig: add module mappings for
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
index 1b5fa104a..2193cc8f0 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -175,6 +175,8 @@ static struct config_module_map {
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
