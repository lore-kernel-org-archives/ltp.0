Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE1FCA6004
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 03:37:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F173A3EAC1B
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 05:37:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFCB33EAC1B
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 05:36:49 +0200 (CEST)
Received: from mta1.migadu.com (out-84.mta1.migadu.com
 [IPv6:2001:41d0:203:375::54])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 95A851400124
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 05:36:47 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=dfKYkikJN28MEjjOTIsH1PToZraeSEL/KW7K3Y9PPUc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791603406; v=1; x=1792208206;
 b=FB1ddsE9urU9dP6jN6tXhDDPU8OXWzZTtpUthcohWBgEKoXehpKZb/6aB0sGhzgSFi64/+I1
 O1n/ch+ErihMXxoJod65mCTgiTzT6TUTqqGT02m7yJ8V5/T3MrDa168hch8qomeXOfHNTuFaRPE
 /kSMYmzuTL22Qbfc7V1TWVu8=
X-Envelope-To: ltp@lists.linux.it
Received: by mta10.migadu.com with ESMTPS id 247b69cdf5920ff7;
 Sat, 10 Oct 2026 03:36:46 +0000
X-Mizu-Trace-ID: 247b69cdf5920ff7
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Sat, 10 Oct 2026 11:36:18 +0800
Message-ID: <20261010033622.68927-1-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] tst_kconfig: automatic module load/unload for
 CONFIG_*=m
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

Tests that depend on a config set to =m currently load the module
themselves, and may fail with misleading errors when it is missing,
e.g. bind() returning EADDRNOTAVAIL for AF_VSOCK without vsock_loopback.

This series makes tst_kconfig record the module for every
config_module_maps[] entry seen as =m, load them once the kernel
config check passes, and unload them at cleanup time.

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

Li Wang (4):
  lib: add module is loaded check
  tst_kconfig: load and unload kernel modules for CONFIG_*=m
  tst_kconfig: add module mappings for vsock/vsock_loopback
  testcases: drop manual tst_modprobe() now handled by tst_kconfig

 include/tst_kconfig.h                       | 28 ++++++++
 include/tst_module.h                        |  1 +
 lib/tst_kconfig.c                           | 80 +++++++++++++++++++++
 lib/tst_module.c                            | 39 ++++++++++
 lib/tst_test.c                              | 11 ++-
 testcases/cve/cve-2025-21756.c              | 36 ++++++++++
 testcases/cve/cve-2026-46331.c              |  7 --
 testcases/cve/sctphantom.c                  |  3 -
 testcases/kernel/syscalls/keyctl/keyctl29.c |  3 -
 testcases/kernel/syscalls/keyctl/keyctl30.c |  3 -
 10 files changed, 193 insertions(+), 18 deletions(-)

-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
