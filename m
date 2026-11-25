Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F25E606A33C
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vXR3y9Jy
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8379F3E9F3B
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 04:06:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BEB33C8523
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 04:05:47 +0100 (CET)
Received: from mta1.migadu.com (out-250.mta1.migadu.com [95.215.58.250])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3F23B1A009A7
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 04:05:45 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=0qCGlyXCSLRrgYraygzwSKVptXNd5Z+vcnuhLF5peoc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795575944; v=1; x=1796180744;
 b=vXR3y9JyRIoPt3uzbIA+HwQsQFb/sIXTYH2KYgoq3ep3TMA5PbyVJT2rtmu+RXgRJW3lIjzg
 KnFMlD9G4VcdDsFQbGBXfcucLDyk8nVi7CLBTwNHAm67doCjKXqNYSsUv9/D2ruVKMfykor3qDc
 RxPaymmu2L6NO+DqqBxFDIB0=
X-Envelope-To: ltp@lists.linux.it
Received: by mta12.migadu.com with ESMTPS id 777b1e9e145c4cfe;
 Wed, 25 Nov 2026 03:05:35 +0000
X-Mizu-Trace-ID: 777b1e9e145c4cfe
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: chrubis@suse.cz,
	wakel@google.com
Date: Wed, 25 Nov 2026 11:05:25 +0800
Message-ID: <20261125030529.907385-1-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.1
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
Subject: [LTP] [PATCH v8 0/4] tst_kconfig: automatic module load/unload for
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Tests that depend on a config set to =m currently load the module
themselves, and may fail with misleading errors when it is missing,
e.g. bind() returning EADDRNOTAVAIL for AF_VSOCK without vsock_loopback.

This series makes tst_kconfig record the module for every
config_module_maps[] entry seen as =m, load them once the kernel
config check passes, and unload them at cleanup time.

Changes in v8:
- Enforce '_' in config_module_maps[] module names (suggested by Cyril)
- Drop the '-' -> '_' conversion and the name copy in tst_kconfig_module_unload()

Changes in v7:
- Split module_count and loaded_module_count: the former is the number
  of recorded modules, the latter the number successfully loaded.
- Add TERRNO to the TWARN message in tst_kconfig_module_unload().
- Fix the malformed reST bullet "* * Requires root" in keyctl23.c.

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
 lib/tst_kconfig.c                           | 93 +++++++++++++++++++++
 lib/tst_module.c                            | 39 +++++++++
 lib/tst_test.c                              | 13 ++-
 testcases/cve/cve-2025-21756.c              | 17 ++++
 testcases/cve/cve-2026-46331.c              |  7 --
 testcases/cve/sctphantom.c                  |  3 -
 testcases/kernel/syscalls/keyctl/keyctl23.c |  6 +-
 testcases/kernel/syscalls/keyctl/keyctl29.c |  3 -
 testcases/kernel/syscalls/keyctl/keyctl30.c |  3 -
 11 files changed, 183 insertions(+), 23 deletions(-)

-- 
2.56.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
