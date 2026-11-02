Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79C606A324
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hr+FDl0p
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6E063E5E70
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 03:43:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A92E3C01A0
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:43:36 +0100 (CET)
Received: from mta1.migadu.com (out-241.mta1.migadu.com
 [IPv6:2001:41d0:203:375::f1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3B9AF1A006BB
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:43:33 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=DZNYgLV+g/MWRW0hx4wodHT60M77AfRfqsr7Ebv/bYE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793587412; v=1; x=1794192212;
 b=hr+FDl0po8DUlCHtcxPDa5F+DxzG65tg+8gxyc0MoJXM06D0hlaoV7+NBeKwWCzTzD/NyOEa
 qqIfFB3R7g2frjg+dBKwLpPj6iYgzss4fBjY7WwYTNjLWtjd1WzDWNv43rGqK8qs3c483j+Y4bt
 0g8QxDYKDPLp2RT7HcVydWL4=
X-Envelope-To: ltp@lists.linux.it
Received: by mta11.migadu.com with ESMTPS id aae0da8b493fb5c5;
 Mon, 02 Nov 2026 02:43:32 +0000
X-Mizu-Trace-ID: aae0da8b493fb5c5
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Mon,  2 Nov 2026 10:43:24 +0800
Message-ID: <20261102024328.115105-1-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/4] tst_kconfig: automatic module load/unload for
 CONFIG_*=m
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

Tests that depend on a config set to =m currently load the module
themselves, and may fail with misleading errors when it is missing,
e.g. bind() returning EADDRNOTAVAIL for AF_VSOCK without vsock_loopback.

This series makes tst_kconfig record the module for every
config_module_maps[] entry seen as =m, load them once the kernel
config check passes, and unload them at cleanup time.

Changes in v6:
- Rename tst_kconfig_module_unload_all to tst_kconfig_module_unload.
- Unload modules with delete_module(O_NONBLOCK) instead of tst_modprobe(). 
- Drop the redundant modules_loaded flag.
- Reword keyctl23 root note instead of removing it.

Changes in v5:
- cve-2025-21756.c: merge drop_privileges into setup and drop cleanup.
- keyctl23.c: remove tst_modprobe() so it can run on Android.

Changes in v4:
- tst_kconfig: fold module_name_for_config() into
  kconfig_module_record()
- tst_kconfig: move the choice == 'm' gate into
  kconfig_module_record() and pass struct tst_kconfig_var * instead
  of the raw config name.

Changes in v3:
- Queue only configs that stay 'm' after kconfig_module_check(),
  so a module downgraded to 'n' does not abort an otherwise
  runnable test.
- Unload with "modprobe -r" instead of "rmmod" to also remove
  dependencies pulled in by modprobe.
- Drop the redundant geteuid() check in the unload path.
- Raise MAX_LOADED_MODULES from 16 to 32.
- cve-2025-21756: drop privileges to nobody after module loading
  and regain root in cleanup(), so the reproducer runs from a
  non-root context while the framework can still unload modules.

Changes in v2:
- Add tst_module_is_loaded() helper.
- Only load/unload modules that are not already loaded.
- Skip automatic loading when KCONFIG_SKIP_CHECK=1, keeping the
  semantics consistent with skipping the config check.
- Document the KCONFIG_SKIP_CHECK=1 behaviour for keyctl29/keyctl30
  and the vsock/vsock_loopback mapping.

Li Wang (Hieco) (4):
  lib: add module is loaded check
  tst_kconfig: load and unload kernel modules for CONFIG_*=m
  tst_kconfig: add module mappings for vsock/vsock_loopback
  testcases: drop manual tst_modprobe() now handled by tst_kconfig

 include/tst_kconfig.h                       | 21 +++++
 include/tst_module.h                        |  1 +
 lib/tst_kconfig.c                           | 86 +++++++++++++++++++++
 lib/tst_module.c                            | 39 ++++++++++
 lib/tst_test.c                              | 13 +++-
 testcases/cve/cve-2025-21756.c              | 17 ++++
 testcases/cve/cve-2026-46331.c              |  7 --
 testcases/cve/sctphantom.c                  |  3 -
 testcases/kernel/syscalls/keyctl/keyctl23.c |  6 +-
 testcases/kernel/syscalls/keyctl/keyctl29.c |  3 -
 testcases/kernel/syscalls/keyctl/keyctl30.c |  3 -
 11 files changed, 176 insertions(+), 23 deletions(-)

-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
