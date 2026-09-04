Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A16C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 08:08:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 369F43E937C
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:08:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CA263E15C1
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:07:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AFFFB1401206
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:07:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 039061FD02;
 Fri,  4 Sep 2026 08:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788509260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7vyhmbMdWivffR9oEuHzeB0OSpR7o1WS30CWQQXPruY=;
 b=E0f+yer9Kr3VXDIDM9PKxR12l+ZpDU5tF/VerxbJAnR3Q98c+6daNgYPU8SDhAn8xxFI8c
 Ko79R8yazG4uoZkH/PP+SegejduI4dTcdO46VWuUp3j1LcW0SrIzB7Otgrr8z7AW740ELn
 i7RRSOx2nuig02FZbaLCQPc53I+Oyhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788509260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7vyhmbMdWivffR9oEuHzeB0OSpR7o1WS30CWQQXPruY=;
 b=799lbApeW+gLpEGAWDbvdF1EaMoMHrDe9ZrBY6ZIyjkrvYnCxBpvIYzmur1hdWZgPGf22V
 Sj98hXkteEjHYkDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PVJKErxW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=C80qbZs9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788509256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7vyhmbMdWivffR9oEuHzeB0OSpR7o1WS30CWQQXPruY=;
 b=PVJKErxWltPrKbF8LyWU6h2JqeyywXrCf/BOD+M1ZEN7mhqfkgbTH40Fp2/OCe85bnREdb
 Gu47zcpKgxyw1cUygeZ0wsUI0xcTHmzZzAz4x/5BygxHL329Qp3hFA3BYwiXKdL7Hru0RZ
 e5e7ahNIlfAmlzN1Vm1zrWVIxlbNnNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788509256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7vyhmbMdWivffR9oEuHzeB0OSpR7o1WS30CWQQXPruY=;
 b=C80qbZs9MBCf8xMKVhJ896JYlakbAqNVCsDDOywVsc3srTfxdPCSWeqDuZ8z9Ed8/cFLv2
 QojpdB2NVMaAoVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8BB013678;
 Fri,  4 Sep 2026 08:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oWh9Kkd8mmpbNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 08:07:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 10:07:34 +0200
MIME-Version: 1.0
Message-Id: <20260904-min_kernel-v1-1-47b556550780@suse.com>
X-B4-Tracking: v=1; b=H4sIAEV8mmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwMT3dzMvPjs1KK81BxdIyMDM7NEo1QDE7NkJaCGgqLUtMwKsGHRsRB
 +cWlSVmpyCcgEpdpaABO7yS1uAAAA
X-Change-ID: 20260904-min_kernel-22066a2e046c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788509255; l=4230;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=XFqjZBTPpVhBpvGtTwZ9wEQTLLr9vPfAmLG1Na1KJ9M=;
 b=Y6KtghOg8K1x/WOYl8hKE65j0N0XMm+rcfkhIQRBjd/8+KpL4KSqrHQk8DuiaIJxeBEkn0b4b
 741OvvGXwg2BvsxtJDRQO9MLLfMzk2+5uO5dJIBsoy3/5WYSZTxUwku
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 039061FD02
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: Check minimal supported kernel version
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

LTP does not support kernels older than 4.4, but this requirement was
only documented in static text without automated runtime validation.

Define the minimal supported kernel version in tst_kvercmp.h so that
the documentation fetches it dynamically and the core library aborts
unsupported kernels with TCONF during test setup.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Add a variable to check minimum kernel version before running tests.
Until now, the only place we have to verify the minimum kernel is to
read the documentation.
---
 doc/conf.py                     | 15 +++++++++++++++
 doc/users/supported_systems.rst |  2 +-
 include/tst_kvercmp.h           |  7 ++++++-
 lib/tst_test.c                  | 17 +++++++++++++++++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index c28db7af1..69ea31b0c 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -21,6 +21,21 @@ ltp_repo = 'https://github.com/linux-test-project/ltp'
 ltp_repo_base_url = f"{ltp_repo}/tree/master"
 cve_url = "https://www.cve.org/CVERecord?id="
 
+def _get_min_kernel_version():
+    header_path = os.path.join(os.path.dirname(__file__), '../include/tst_kvercmp.h')
+    with open(header_path, 'r', encoding='utf-8') as f:
+        match = re.search(r'#define\s+TST_MIN_KVER\s+"([^"]+)"', f.read())
+        if match:
+            return match.group(1)
+    raise RuntimeError(f"Could not find TST_MIN_KVER in {header_path}")
+
+min_kernel_version = _get_min_kernel_version()
+
+rst_prolog = f"""
+.. |min_kernel_version| replace:: **{min_kernel_version}**
+.. |min_kernel_version_plain| replace:: {min_kernel_version}
+"""
+
 # -- General configuration ---------------------------------------------------
 # https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
 
diff --git a/doc/users/supported_systems.rst b/doc/users/supported_systems.rst
index b5d792eeb..5765214b0 100644
--- a/doc/users/supported_systems.rst
+++ b/doc/users/supported_systems.rst
@@ -14,7 +14,7 @@ branch is build tested in
 Kernel version
 --------------
 
-Minimal supported kernel version is **4.4**.
+Minimal supported kernel version is |min_kernel_version|.
 
 Oldest build tested distributions
 ---------------------------------
diff --git a/include/tst_kvercmp.h b/include/tst_kvercmp.h
index 26e8f8e3c..52267fd2b 100644
--- a/include/tst_kvercmp.h
+++ b/include/tst_kvercmp.h
@@ -1,12 +1,17 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  * Copyright (c) 2009-2016 Cyril Hrubis chrubis@suse.cz
- * Copyright (c) Linux Test Project, 2020-2025
+ * Copyright (c) Linux Test Project, 2020-2026
  */
 
 #ifndef TST_KVERCMP_H__
 #define TST_KVERCMP_H__
 
+/**
+ * TST_MIN_KVER - Minimal kernel version supported by LTP.
+ */
+#define TST_MIN_KVER "4.4"
+
 /**
  * tst_kvcmp() - Compare given kernel version with kernel in string.
  *
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 166e0f672..1bd62e24a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1087,6 +1087,21 @@ static bool check_kver(const char *min_kver, const int brk_nosupp)
 	return true;
 }
 
+static void check_supported_kver(void)
+{
+	int v1, v2, v3;
+
+	if (tst_parse_kver(TST_MIN_KVER, &v1, &v2, &v3)) {
+		tst_res(TWARN,
+			"Invalid minimal kernel version %s, expected %%d.%%d.%%d",
+			TST_MIN_KVER);
+		return;
+	}
+
+	if (tst_kvercmp(v1, v2, v3) < 0)
+		tst_brk(TCONF, "Kernel is older than minimal supported %s", TST_MIN_KVER);
+}
+
 /*
  * Checks if the struct results values are equal.
  *
@@ -1455,6 +1470,8 @@ static void do_setup(int argc, char *argv[])
 	if (context->tdebug)
 		tst_res(TINFO, "Enabling debug info (level %d)", context->tdebug);
 
+	check_supported_kver();
+
 	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
 		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
 

---
base-commit: d377d1cff1ec393459a136eec85088ffd5729430
change-id: 20260904-min_kernel-22066a2e046c

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
