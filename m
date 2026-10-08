Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5AECA6002
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 05:23:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23C7E3E2BA3
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 07:23:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 993CB3E2BD8
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 07:22:13 +0200 (CEST)
Received: from mta1.migadu.com (out-222.mta1.migadu.com
 [IPv6:2001:41d0:203:375::de])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 30DFA20009A
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 07:22:12 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=OitUSc9HFKVw6tb1cqUxyzhCA0pjENwBlceFe69ph3Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791436932; v=1; x=1792041732;
 b=o7cMzmhjTwDjbyg6sTbbs8ynlc73CCAgJFRw1VqhoXhkTdY0i5suJ9W3sT9vO582UCkXGT5o
 QDgmKBNTx3vz2uIG46Diqq1oU+nqv9vfgJtaWi/mzYabwr63utR9Msb8WIW+E7ogyYckqATGWKE
 0Z2hQVuww8rqvLx57VlveGfs=
X-Envelope-To: ltp@lists.linux.it
Received: by mta11.migadu.com with ESMTPS id c58ae7e89e7e2cbe;
 Thu, 08 Oct 2026 05:22:12 +0000
X-Mizu-Trace-ID: c58ae7e89e7e2cbe
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Thu,  8 Oct 2026 13:21:40 +0800
Message-ID: <20261008052141.129763-4-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008052141.129763-1-li.wang@linux.dev>
References: <20261008052141.129763-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [Patch v2 3/4] tst_kconfig: add module mappings for
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

Map CONFIG_VSOCKETS and CONFIG_VSOCKETS_LOOPBACK to their kernel
modules (vsock, vsock_loopback), so that tst_kconfig can load them
automatically when the test declares the matching configs.

cve-2025-21756 binds to VMADDR_CID_LOCAL, which requires the
vsock_loopback module. When the module is present but not loaded,
bind() fails with EADDRNOTAVAIL and the test aborts with TBROK
instead of exercising the CVE, so declare both configs in the test's
needs_kconfigs.

The test also needs root to load the modules and to run as the
vsock_loopback transport is not available from an unprivileged user
namespace.

Signed-off-by: Li Wang <li.wang@linux.dev>
---
 lib/tst_kconfig.c              | 2 ++
 testcases/cve/cve-2025-21756.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index fc03966ba..b267c5f30 100644
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
index 4245a4c95..1df8545c9 100644
--- a/testcases/cve/cve-2025-21756.c
+++ b/testcases/cve/cve-2025-21756.c
@@ -85,8 +85,14 @@ static void run(void)
 }
 
 static struct tst_test test = {
+	.needs_root = 1,
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
