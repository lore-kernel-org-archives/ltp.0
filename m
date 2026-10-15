Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE48FCC6B34
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 07:59:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DF6A3E2D1D
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 09:58:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EDB23C9EF6
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 09:58:42 +0200 (CEST)
Received: from mta1.migadu.com (out-135.mta1.migadu.com [95.215.58.135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 249B310000C8
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 09:58:40 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=D2un5He+IAk/XCyt6NVUWk/ReEA3L1Cj3FwlqDK4AlM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792051119; v=1; x=1792655919;
 b=PAjAgw0MqWjIpudpAIxX4AFLrFKrkG23E4ZrXzvd0cokQA2sXgEcs3SFDkgOKe9JkO6JLw/R
 68rvN3UwAZKhZjrAnxkTnq6yUpVn2wOTOt+2qkWuAl/UvA6+RIftanaORLqxA7bm3MmUjaXUSxJ
 B6CO8cPqBg+RFi3bAbIpQULU=
X-Envelope-To: ltp@lists.linux.it
Received: by mta12.migadu.com with ESMTPS id b07712ed32f286e7;
 Thu, 15 Oct 2026 07:58:39 +0000
X-Mizu-Trace-ID: b07712ed32f286e7
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Thu, 15 Oct 2026 15:58:08 +0800
Message-ID: <20261015075812.184811-1-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/4] tst_kconfig: automatic module load/unload for
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
Cc: wakel@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: "Li Wang (Hieco)" <li.wang@linux.dev>

Tests that depend on a config set to =m currently load the module
themselves, and may fail with misleading errors when it is missing,
e.g. bind() returning EADDRNOTAVAIL for AF_VSOCK without vsock_loopback.

This series makes tst_kconfig record the module for every
config_module_maps[] entry seen as =m, load them once the kernel
config check passes, and unload them at cleanup time.

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

 include/tst_kconfig.h                       | 28 ++++++++
 include/tst_module.h                        |  1 +
 lib/tst_kconfig.c                           | 77 +++++++++++++++++++++
 lib/tst_module.c                            | 39 +++++++++++
 lib/tst_test.c                              | 11 ++-
 testcases/cve/cve-2025-21756.c              | 17 +++++
 testcases/cve/cve-2026-46331.c              |  7 --
 testcases/cve/sctphantom.c                  |  3 -
 testcases/kernel/syscalls/keyctl/keyctl23.c |  5 --
 testcases/kernel/syscalls/keyctl/keyctl29.c |  3 -
 testcases/kernel/syscalls/keyctl/keyctl30.c |  3 -
 11 files changed, 171 insertions(+), 23 deletions(-)

-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
