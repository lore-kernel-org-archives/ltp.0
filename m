Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FB2CA5FFC
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 10:58:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A91B3E9C81
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 12:58:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FF943E9C88
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 12:57:59 +0200 (CEST)
Received: from mta1.migadu.com (out-22.mta1.migadu.com
 [IPv6:2001:41d0:203:375::16])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 269AE1400C4C
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 12:57:58 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=l6PONb3IYPNrUshIo23DunvyxwbgQVBYvmqxhPznRM4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791370677; v=1; x=1791975477;
 b=rBO89SbloI/SpfcfCPF5YhNbX6/IEr3FW6gqYimcRDu8UqBDJzjvA/dB8zHxAzoeuN89InZE
 raqmji4OpjO103nZrXiwivB1P+GrdnlaDqxSesyv4h1XWYAGpo8oRY7PRHJzz0t56g7O+2wcGVG
 2nAcr/zuWRbv6jtX4jMwPdlo=
X-Envelope-To: ltp@lists.linux.it
Received: by mta10.migadu.com with ESMTPS id 25c65eb947b0e5bb;
 Wed, 07 Oct 2026 10:57:57 +0000
X-Mizu-Trace-ID: 25c65eb947b0e5bb
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Wed,  7 Oct 2026 18:57:29 +0800
Message-ID: <20261007105730.94492-3-li.wang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007105730.94492-1-li.wang@linux.dev>
References: <20261007105730.94492-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] tst_kconfig: add module mappings for
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
modules (vsock, vsock_loopback).

Signed-off-by: Li Wang <li.wang@linux.dev>
---
 lib/tst_kconfig.c              | 2 ++
 testcases/cve/cve-2025-21756.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 7e3ee1fe8..17db9cd1a 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -173,6 +173,8 @@ static struct config_module_map {
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
