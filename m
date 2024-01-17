Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99D7C47258
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 17:30:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D57B23CE31A
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 18:30:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 088733C1D32
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 18:30:09 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0C88D1182E7E
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 18:30:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E93EC1FCDB
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705512608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LaYT5QJXfpEZ54svj9FFQq2eluyiNyFCtMw3HJJUXw=;
 b=Hwy16YZj+yGGWxudlSFCwedQmvs3PCdOu0p0lIlPp/fwdnhkxN7lxVpKE2zY7GgXy1jUrT
 vk9MHE03Zzkw5uLzjtmklwOTw8nSOK3b3vdAUHHIQWMmrAYpXVqPbD2gaJkS8xfp9twNDz
 KAdTegtQL6XfZlEWM92EinDb67ciRRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705512608;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LaYT5QJXfpEZ54svj9FFQq2eluyiNyFCtMw3HJJUXw=;
 b=CfVldhT+Qv7bCsAWZ2ySHCMN2pVnsD2xbe6jfO0jgmMbWutE4RGWuangAJRAq1xEW5jxYq
 05HlHr1CEn0QnDDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705512607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LaYT5QJXfpEZ54svj9FFQq2eluyiNyFCtMw3HJJUXw=;
 b=TpPhdIGImH+R3cDZv2ZwtPo0803NaSd3x6MJoVKE3x7NW0uQY969wZkU1FYb6nf+6Am1V6
 U/Ya36uJRAOO2OAjHDDAJBwgdwkcVkc6hcCEliLr6bxJLrOvTWst72uB6zi6MM+yHZ5JZz
 dsOd73mzg8EGQkAn5YJGSjLSmzRHac4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705512607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LaYT5QJXfpEZ54svj9FFQq2eluyiNyFCtMw3HJJUXw=;
 b=O1HpdSvJNUkZyGaKaWnKvD13uc5iTsCIJFp7kc+xvNgZ5O+mNMJ3zeCODwMmhgq8Ov+ZDd
 jJpyOm3QNsmyM6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D50B813808
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 17:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uEKkM58OqGVTQAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 17:30:07 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 17 Jan 2024 18:30:04 +0100
Message-ID: <20240117173006.31521-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240117173006.31521-1-mdoucha@suse.cz>
References: <20240117173006.31521-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TpPhdIGI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O1HpdSvJ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: E93EC1FCDB
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Add test for ASLRn't bug
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

On some kernels and some filesystems, shared libraries with sufficiently
large filesize will be mmapped to a hugepage, which causes base address
alignment to higher power of 2 (e.g. 21 bits on x86 instead of the usual
12) and loss of ASLR randomness.

The test has two modes: default and strict. In default mode, it checks
that library base addresses have at least 8 random bits (configurable
using the -b option). In strict mode, it checks that the number
of random bits matches kernel configuration and library base addresses
are aligned to normal pagesize, not hugepage.

Successful reproduction of the issue requires hugepage support and
the test being linked against a library larger than hugepage size.
However, the test may be useful even without either condition being
satisfied so it'll just print suggestions and run anyway.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

The test is currently intended to run primarily in 32bit compat mode.
The 64bit variant of the test in default mode will always pass even
on affected kernels. On the other hand, the strict mode is intended
to fail even with full mitigation. Only a proper fix that prevents
hugepage base address alignment will pass strict mode.

 runtest/kernel_misc                       |   1 +
 testcases/kernel/security/aslr/.gitignore |   1 +
 testcases/kernel/security/aslr/Makefile   |  10 +
 testcases/kernel/security/aslr/aslr01.c   | 287 ++++++++++++++++++++++
 4 files changed, 299 insertions(+)
 create mode 100644 testcases/kernel/security/aslr/.gitignore
 create mode 100644 testcases/kernel/security/aslr/Makefile
 create mode 100644 testcases/kernel/security/aslr/aslr01.c

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index 02b0ddd1a..78f00d305 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -15,3 +15,4 @@ zram01 zram01.sh
 zram02 zram02.sh
 zram03 zram03
 umip_basic_test umip_basic_test
+aslr01 aslr01
diff --git a/testcases/kernel/security/aslr/.gitignore b/testcases/kernel/security/aslr/.gitignore
new file mode 100644
index 000000000..a15f88c39
--- /dev/null
+++ b/testcases/kernel/security/aslr/.gitignore
@@ -0,0 +1 @@
+aslr01
diff --git a/testcases/kernel/security/aslr/Makefile b/testcases/kernel/security/aslr/Makefile
new file mode 100644
index 000000000..1457667c5
--- /dev/null
+++ b/testcases/kernel/security/aslr/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2024 Linux Test Project
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS			+= -D_GNU_SOURCE
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/aslr/aslr01.c b/testcases/kernel/security/aslr/aslr01.c
new file mode 100644
index 000000000..ba1030369
--- /dev/null
+++ b/testcases/kernel/security/aslr/aslr01.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test that address space layout randomization (ASLR) is sufficiently random.
+ * A bug in dynamic library mmapping may reduce ASLR randomness if the library
+ * file is larger than hugepage size. In 32bit compat mode, this may
+ * completely disable ASLR and force large dynamic libraries to be loaded
+ * at fixed addresses.
+ *
+ * The issue may not be reproducible if hugepage support is missing or no
+ * sufficiently large library is loaded into the test program. If libc is not
+ * large enough, you may use `export LD_PRELOAD=...` to load another
+ * sufficiently large library. The export keyword is required because
+ * the checks are done on a subprocess.
+ *
+ * In normal mode, the test checks that library base address has a minimum
+ * number of random bits (configurable using the -b option). In strict mode,
+ * the test checks that library base address is aligned to regular pagesize
+ * (not hugepage) and the number of random bits is at least
+ * CONFIG_ARCH_MMAP_RND_BITS_MIN or the compat equivalent. The -b option is
+ * ignored.
+ */
+
+#include <unistd.h>
+#include <string.h>
+#include <stdio.h>
+#include <inttypes.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "tst_kernel.h"
+#include "tst_kconfig.h"
+#include "tst_safe_stdio.h"
+
+/* Indices for aslr_kconfigs[] below */
+#define ASLR_HAVE_COMPAT 0
+#define ASLR_MINBITS 1
+#define ASLR_COMPAT_MINBITS 2
+
+static int pagebits, minbits = 8;
+static char *minbits_str, *strict_check;
+static char lib_path[PATH_MAX];
+static FILE *ldd;
+
+static struct tst_kconfig_var aslr_kconfigs[] = {
+	TST_KCONFIG_INIT("CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS"),
+	TST_KCONFIG_INIT("CONFIG_ARCH_MMAP_RND_BITS_MIN"),
+	TST_KCONFIG_INIT("CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN"),
+};
+
+static int count_align_bits(size_t val)
+{
+	int ret = 0;
+
+	for (; val && !(val & 0x1); val >>= 1, ret++)
+		;
+
+	return ret;
+}
+
+static int count_bits(size_t val)
+{
+	int ret = 0;
+
+	for (; val; val >>= 1) {
+		if (val & 1)
+			ret++;
+	}
+
+	return ret;
+}
+
+/* Extract library path and base address from a line of ldd output. */
+static int parse_mapping(const char *line, char *path, uint64_t *addr)
+{
+	int ret;
+
+	line = strchr(line, '/');
+
+	if (!line)
+		return 0;
+
+	ret = sscanf(line, "%s (0x%" PRIx64 ")", path, addr);
+	return ret >= 2;
+}
+
+/*
+ * Run ldd on the test executable and pass each library/address to callback.
+ * If the callback returns non-zero, the reader loop will immediately exit.
+ */
+static void read_shared_libraries(int (*callback)(void*, const char*, uint64_t),
+	void *arg)
+{
+	char line[PATH_MAX], path[PATH_MAX];
+	uint64_t addr;
+	int ret;
+
+	sprintf(path, "ldd /proc/%d/exe", getpid());
+	ldd = SAFE_POPEN(path, "r");
+
+	while (fgets(line, PATH_MAX, ldd)) {
+		if (*line && !feof(ldd) && line[strlen(line) - 1] != '\n')
+			tst_brk(TBROK, "Dynamic library entry too long");
+
+		if (!parse_mapping(line, path, &addr))
+			continue;
+
+		if (callback(arg, path, addr))
+			break;
+	}
+
+	while (fgets(line, PATH_MAX, ldd))
+		;
+
+	ret = pclose(ldd);
+	ldd = NULL;
+
+	if (!WIFEXITED(ret) || WEXITSTATUS(ret))
+		tst_brk(TBROK, "Reading dynamic libraries failed");
+}
+
+static int find_large_lib_callback(void *arg, const char *path,
+	uint64_t addr LTP_ATTRIBUTE_UNUSED)
+{
+	size_t *libsize = arg;
+	struct stat statbuf;
+
+	SAFE_STAT(path, &statbuf);
+
+	if (*libsize < (size_t)statbuf.st_size) {
+		strcpy(lib_path, path);
+		*libsize = statbuf.st_size;
+	}
+
+	return 0;
+}
+
+static void find_large_lib(void)
+{
+	size_t hpsize, libsize = 0;
+
+	read_shared_libraries(find_large_lib_callback, &libsize);
+
+	if (!libsize) {
+		tst_brk(TCONF,
+			"No dynamic libraries loaded, please use LD_PRELOAD");
+	}
+
+	hpsize = tst_get_hugepage_size();
+	tst_res(TINFO, "Largest loaded library: %s (%zu bytes)", lib_path,
+		libsize);
+
+	if (!hpsize) {
+		tst_res(TCONF, "Hugepage support appears to be missing");
+	} else if (libsize < hpsize) {
+		tst_res(TCONF, "The largest dynamic library is smaller than "
+			"hugepage size");
+		tst_res(TCONF, "Please use LD_PRELOAD to add larger library");
+	}
+}
+
+static int get_lib_address_callback(void *arg, const char *path, uint64_t addr)
+{
+	uint64_t *out_addr = arg;
+
+	if (!strcmp(path, lib_path)) {
+		*out_addr = addr;
+		return 1;
+	}
+
+	return 0;
+}
+
+static void setup(void)
+{
+	int compat = tst_is_compat_mode();
+	const char *kconf_minbits, *minbits_path;
+
+	pagebits = count_align_bits(getpagesize());
+	tst_kconfig_read(aslr_kconfigs, ARRAY_SIZE(aslr_kconfigs));
+
+	if (compat && aslr_kconfigs[ASLR_HAVE_COMPAT].choice != 'y')
+		tst_brk(TCONF, "ASLR not supported in compat mode");
+
+	if (!strict_check && tst_parse_int(minbits_str, &minbits, 1, 64))
+		tst_brk(TBROK, "Invalid bit count argument '%s'", minbits_str);
+
+	if (strict_check) {
+		if (compat) {
+			kconf_minbits = aslr_kconfigs[ASLR_COMPAT_MINBITS].val;
+			minbits_path = "/proc/sys/vm/mmap_rnd_compat_bits";
+		} else {
+			kconf_minbits = aslr_kconfigs[ASLR_MINBITS].val;
+			minbits_path = "/proc/sys/vm/mmap_rnd_bits";
+		}
+
+		/*
+		 * Reading mmap_rnd_bits usually requires root privileges.
+		 * Fall back to kernel config values if unprivileged.
+		 */
+		if (!access(minbits_path, R_OK))
+			SAFE_FILE_SCANF(minbits_path, "%d", &minbits);
+		else if (!kconf_minbits)
+			tst_brk(TBROK, "Cannot determine kernel ASLR min bits");
+		else if (tst_parse_int(kconf_minbits, &minbits, 1, 64))
+			tst_brk(TBROK, "Invalid kernel ASLR min bits value");
+	}
+
+	find_large_lib();
+}
+
+static void run(void)
+{
+	uint64_t rndbits = 0, fixbits, addr;
+	int rndcount, aligncount, i;
+
+	fixbits = ~rndbits;
+
+	for (i = 0; i < 512; i++) {
+		addr = 0;
+		read_shared_libraries(get_lib_address_callback, &addr);
+
+		if (!addr) {
+			tst_res(TWARN, "Library %s not found?!", lib_path);
+			continue;
+		}
+
+		rndbits |= addr;
+		fixbits &= addr;
+	}
+
+	rndcount = count_bits(rndbits & ~fixbits);
+	aligncount = count_align_bits(rndbits);
+
+	if (rndcount < minbits) {
+		tst_res(TFAIL,
+			"Large lib base address has less than %d random bits",
+			minbits);
+		return;
+	}
+
+	tst_res(TPASS, "Library address has %d random bits", rndcount);
+	tst_res(TINFO, "Library base address alignment: %d bits", aligncount);
+
+	if (aligncount > pagebits) {
+		tst_res(strict_check ? TFAIL : TINFO,
+			"Base address alignment is higher than expected (%d)",
+			pagebits);
+	}
+}
+
+static void cleanup(void)
+{
+	if (ldd) {
+		char buf[PATH_MAX];
+
+		while (fgets(buf, PATH_MAX, ldd))
+			;
+
+		pclose(ldd);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.options = (struct tst_option []) {
+		{"b:", &minbits_str, "Minimum ASLR random bits (default: 8)"},
+		{"s", &strict_check, "Run in strict mode"},
+		{}
+	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_HAVE_ARCH_MMAP_RND_BITS=y",
+		NULL
+	},
+	.needs_cmds = (const char *[]) {
+		"ldd",
+		NULL
+	},
+};
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
