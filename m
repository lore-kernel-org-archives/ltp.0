Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8E1C79FA0
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 06:26:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40B583E4D57
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 08:26:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11AE63E1895
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:26:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 619141400C5E
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:26:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC7D3219F8;
 Tue,  8 Sep 2026 06:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788848797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+3GIUOTI3d/K3WqnKU3bDDCV9iDzOUwl5PsjNN9g+c=;
 b=Z2XLJpmkdDIXBnIoFi3rCQBngM+59h8loA7oHqbvYSMDydNkdeaQ0sAdxcy2xK+mrA8Os6
 jR6OYHG4sOFi896BCcwq9UTEUZBRVkkOPzKYfyudrNwnshk5aDSxP0fTxccmZltnvgWUeu
 qeyiEYuXsAlMaOzHPbwhhSV7oe4gFJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788848797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+3GIUOTI3d/K3WqnKU3bDDCV9iDzOUwl5PsjNN9g+c=;
 b=GDGz0k6QCT68nJnuRDHThgUOOHqNGg8xJYtrDmQovFY5He+s74wJn1W3gVizJXKm15Qzz6
 ZOR3ofOtXWujTGCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788848792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+3GIUOTI3d/K3WqnKU3bDDCV9iDzOUwl5PsjNN9g+c=;
 b=Jra0g2Y+9bp83W83wkwIdPZxVkUDlEDYXdxCQLG85IbeX2UrqIHoJ4fOJCZhSVEOgN67j7
 mWY/Sm1fGEYsbcbqX+8/sOxrHEvkKbSyt0SZDq+TbBl2osFFZmYQDGdrBEjwNVNTA3TjKF
 VC7cx55gMDgmOvMx20RO6Z6lOX3klms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788848792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+3GIUOTI3d/K3WqnKU3bDDCV9iDzOUwl5PsjNN9g+c=;
 b=PhspjQ5mG//9sNAHnuxtioeqw6pw6HFFuB2O9Vt9W0RnZHIdruzHS52lvi3nV6reUPBhjQ
 huv1DEuTU63ymmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D4A91368D;
 Tue,  8 Sep 2026 06:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4Le1IJiqn2orJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Sep 2026 06:26:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Sep 2026 08:26:32 +0200
MIME-Version: 1.0
Message-Id: <20260908-coredump-v8-2-591f96004543@suse.com>
References: <20260908-coredump-v8-0-591f96004543@suse.com>
In-Reply-To: <20260908-coredump-v8-0-591f96004543@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848792; l=6911;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Na67iTq5m6PoBAOpv4fnbkS+7x00xpXM0fiJCrSrSys=;
 b=j40/t/O9TinframlOum7s8pta6XuC0HIHHnVywtxTH75PuQHT8dMFl/aTOF/bKrYPzQgme9xl
 5plGqZy+s5RBHz/ju/FRS7jZXKypBL0bHXaofhcXkRM2RQ1QESclOLO
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 2/2] coredump02: Verify ELF structure and notes
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

LTP currently only tests core_pattern specifier expansion and basic
ELF magic in coredump01, leaving the internal ELF structure and notes
generated by the kernel unverified.

Add a test to verify that the kernel produces a valid ET_CORE ELF file
with the expected PT_NOTE and PT_LOAD segments, and that the
NT_PRPSINFO and NT_PRSTATUS notes contain the expected process name,
PID, and terminating signal.

Root is required to set the system-wide core_pattern into the test's
temporary directory.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/kernel_misc                    |   1 +
 testcases/kernel/coredump/.gitignore   |   1 +
 testcases/kernel/coredump/coredump02.c | 199 +++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index ecf9ee2a2..3311e1929 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -18,3 +18,4 @@ zram03 zram03
 umip_basic_test umip_basic_test
 aslr01 aslr01
 coredump01 coredump01
+coredump02 coredump02
diff --git a/testcases/kernel/coredump/.gitignore b/testcases/kernel/coredump/.gitignore
index cd0b51700..e241a112e 100644
--- a/testcases/kernel/coredump/.gitignore
+++ b/testcases/kernel/coredump/.gitignore
@@ -1,2 +1,3 @@
 /coredump01
 /coredump01_helper
+/coredump02
diff --git a/testcases/kernel/coredump/coredump02.c b/testcases/kernel/coredump/coredump02.c
new file mode 100644
index 000000000..d2bd1a352
--- /dev/null
+++ b/testcases/kernel/coredump/coredump02.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Linux Test Project
+ */
+
+/*\
+ * Verify the ELF structure and note content of a kernel-generated core
+ * dump.
+ *
+ * A core dump written by the kernel is an ELF file of type ET_CORE. It
+ * contains:
+ *
+ * - one PT_NOTE program header holding process metadata
+ * - one or more PT_LOAD program headers for the mapped memory segments
+ *
+ * The PT_NOTE segment carries a stream of notes. Two of them describe
+ * the crashed process:
+ *
+ * - NT_PRPSINFO, whose descriptor is a struct elf_prpsinfo. The pr_fname
+ *   field holds the executable name.
+ * - NT_PRSTATUS, whose descriptor is a struct elf_prstatus. The pr_pid
+ *   field holds the PID and pr_cursig holds the terminating signal.
+ *
+ * The crashed child is a fork of the test binary, so the core dump has
+ * the same ELF class as the test. ElfW() is therefore safe here.
+ *
+ * The test needs root because it rewrites the system-wide core_pattern.
+ * The original value is saved and restored by the test library on all
+ * exit paths.
+ *
+ * [Algorithm]
+ *
+ * - Point core_pattern into the test temporary directory
+ * - Fork a child which aborts itself to produce a core dump
+ * - Read the core file into memory and parse the ELF header
+ * - Walk the program headers and verify PT_NOTE and PT_LOAD are present
+ * - Walk the notes in every PT_NOTE segment
+ * - Check that NT_PRPSINFO carries the expected executable name
+ * - Check that NT_PRSTATUS carries the expected PID and signal
+ */
+
+#include <link.h>
+#include <sys/procfs.h>
+
+#include "coredump_common.h"
+
+#define NOTE_ALIGN(x) (((x) + 3) & ~3U)
+
+static char *core_buf;
+static size_t core_len;
+static int prpsinfo_seen, prstatus_seen;
+
+static void load_core(const char *path)
+{
+	struct stat st;
+	int fd;
+
+	SAFE_STAT(path, &st);
+	if (st.st_size <= 0)
+		tst_brk(TFAIL, "core file %s is empty", path);
+
+	core_len = st.st_size;
+	core_buf = SAFE_MALLOC(core_len);
+
+	fd = SAFE_OPEN(path, O_RDONLY);
+	SAFE_READ(1, fd, core_buf, core_len);
+	SAFE_CLOSE(fd);
+}
+
+static void unload_core(void)
+{
+	free(core_buf);
+	core_buf = NULL;
+	core_len = 0;
+}
+
+static const void *core_at(size_t off, size_t need)
+{
+	if (off > core_len || need > core_len - off)
+		tst_brk(TFAIL, "core file truncated at %zu (need %zu, have %zu)",
+			off, need, core_len);
+
+	return core_buf + off;
+}
+
+static void handle_note(uint32_t type, const void *desc, size_t descsz, pid_t pid)
+{
+	if (type == NT_PRPSINFO && descsz >= sizeof(struct elf_prpsinfo)) {
+		struct elf_prpsinfo info;
+		char name[sizeof(info.pr_fname) + 1] = {0};
+
+		memcpy(&info, desc, sizeof(info));
+		memcpy(name, info.pr_fname, sizeof(info.pr_fname));
+
+		TST_EXP_EQ_STR(name, "coredump02");
+
+		prpsinfo_seen = 1;
+	} else if (type == NT_PRSTATUS && descsz >= sizeof(struct elf_prstatus)) {
+		struct elf_prstatus st;
+
+		memcpy(&st, desc, sizeof(st));
+
+		TST_EXP_EQ_LI(st.pr_pid, pid);
+		TST_EXP_EQ_LI(st.pr_cursig, SIGABRT);
+
+		prstatus_seen = 1;
+	}
+}
+
+static void walk_notes(size_t off, size_t size, pid_t pid)
+{
+	size_t pos = 0;
+
+	while (pos + sizeof(ElfW(Nhdr)) <= size) {
+		const ElfW(Nhdr) *nh = core_at(off + pos, sizeof(*nh));
+		size_t np = NOTE_ALIGN(nh->n_namesz);
+		size_t dp = NOTE_ALIGN(nh->n_descsz);
+		size_t total = sizeof(*nh) + np + dp;
+
+		if (pos + total > size)
+			tst_brk(TFAIL, "note extends past PT_NOTE (pos=%zu total=%zu size=%zu)",
+				pos, total, size);
+
+		handle_note(nh->n_type,
+			    core_at(off + pos + sizeof(*nh) + np, nh->n_descsz),
+			    nh->n_descsz, pid);
+
+		pos += total;
+	}
+}
+
+static void run(void)
+{
+	char dump[PATH_MAX + 32];
+	int pt_note_cnt = 0, have_load = 0;
+	const ElfW(Ehdr) *eh;
+	const ElfW(Phdr) *ph;
+	pid_t pid;
+	size_t i;
+
+	prpsinfo_seen = prstatus_seen = 0;
+
+	set_pattern("%s/core.%%p", cwd);
+
+	pid = crash_child();
+
+	snprintf(dump, sizeof(dump), "%s/core.%d", cwd, pid);
+	load_core(dump);
+
+	eh = core_at(0, sizeof(*eh));
+
+	TST_EXP_EXPR(!memcmp(eh->e_ident, ELFMAG, SELFMAG), "core has ELF magic");
+	TST_EXP_EQ_LI(eh->e_type, ET_CORE);
+
+	if (!eh->e_phnum)
+		tst_brk(TFAIL, "core has no program headers");
+
+	ph = core_at(eh->e_phoff, (size_t)eh->e_phnum * sizeof(*ph));
+
+	for (i = 0; i < eh->e_phnum; i++) {
+		if (ph[i].p_type == PT_NOTE) {
+			pt_note_cnt++;
+			walk_notes(ph[i].p_offset, ph[i].p_filesz, pid);
+		} else if (ph[i].p_type == PT_LOAD) {
+			have_load = 1;
+			core_at(ph[i].p_offset, ph[i].p_filesz);
+		}
+	}
+
+	TST_EXP_EQ_LI(pt_note_cnt, 1);
+	TST_EXP_EQ_LI(have_load, 1);
+	TST_EXP_EQ_LI(prpsinfo_seen, 1);
+	TST_EXP_EQ_LI(prstatus_seen, 1);
+
+	SAFE_UNLINK(dump);
+	unload_core();
+}
+
+static void cleanup(void)
+{
+	unload_core();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = coredump_setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_COREDUMP=y",
+		NULL,
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{PATH_KERN_CORE_PATTERN, NULL, TST_SR_TCONF},
+		{}
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
