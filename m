Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A87606A330
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=a4zKhPgp;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oKq8zZp8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=a4zKhPgp;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oKq8zZp8
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 565BF3CCA23
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 19:28:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C4D33C0565
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 19:28:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 462331A00278
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 19:28:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 031991F385;
 Wed,  4 Nov 2026 18:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793816892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NP/4ajVTDXD9DAEOmT+tu5kREXqedZjj7sAB1bo0S7k=;
 b=a4zKhPgpQA9ZJT+sQFfbzbii/zbSnUYT34M3iIjw32ij88wHTyCRIAlzh/MzaUuR3dZC1g
 row+zs9Ztzzn8Z7j7HEnbEnHlTFpx88/HUH09zs2G4EoRL35UW2U35WPYwA0VuN4CPeOFb
 nTfy9LZxJNo2m1YTTaC758VjJ8497fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793816892;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NP/4ajVTDXD9DAEOmT+tu5kREXqedZjj7sAB1bo0S7k=;
 b=oKq8zZp8N0U84jByfAjefLGh1XuB2LN9jRnc4J+4go5d2ePlB9pi3nbjCPG5Ft/6TcVrpP
 ctRgW5YA5ln2BuDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a4zKhPgp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oKq8zZp8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793816892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NP/4ajVTDXD9DAEOmT+tu5kREXqedZjj7sAB1bo0S7k=;
 b=a4zKhPgpQA9ZJT+sQFfbzbii/zbSnUYT34M3iIjw32ij88wHTyCRIAlzh/MzaUuR3dZC1g
 row+zs9Ztzzn8Z7j7HEnbEnHlTFpx88/HUH09zs2G4EoRL35UW2U35WPYwA0VuN4CPeOFb
 nTfy9LZxJNo2m1YTTaC758VjJ8497fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793816892;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NP/4ajVTDXD9DAEOmT+tu5kREXqedZjj7sAB1bo0S7k=;
 b=oKq8zZp8N0U84jByfAjefLGh1XuB2LN9jRnc4J+4go5d2ePlB9pi3nbjCPG5Ft/6TcVrpP
 ctRgW5YA5ln2BuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9286B134F0;
 Wed,  4 Nov 2026 18:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Lx0qGjt562qSZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Nov 2026 18:28:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Nov 2026 19:28:00 +0100
Message-ID: <20261104182800.421758-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 031991F385
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -12.01
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] sparse: LTP-006: Detect files created in the
 current directory
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Extend LTP-006 from TST_FD_FOREACH() to any file, directory, FIFO or
link created with a relative path. A test without a tmpdir runs in a
shared working directory, so parallel runs race on the same paths and
files may be left behind.

Covered are SAFE_*() macros, LTP helpers (tst_fill_file(),
tst_prealloc_file(), tst_fd_next()) and libc functions, including the
glibc _FORTIFY_SOURCE variants. A call is reported only when the path is
a string literal not starting with '/', open() flags are constant and
contain O_CREAT (fopen() mode starts with 'w' or 'a') and for *at()
functions dirfd is AT_FDCWD. Paths built at runtime are not detected.

Also treat .format_device, .mount_device and .all_filesystems as
creating a tmpdir, as they imply .needs_device in the library.

Assisted-by: LLM
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

this is based on Stephen's report [1]. I consider the patch small enough
and useful, but we'd have to remember to update LTP sparse code if ever
change related functionality in the library.

Example of output (affected only these 4 tst_fd related files Stephen reported):

accept03.c:52:9: warning: LTP-006: tst_fd_next() creates files in the current directory, but struct tst_test doesn't set .needs_tmpdir = 1
epoll_pwait06.c:31:9: warning: LTP-006: tst_fd_next() creates files in the current directory, but struct tst_test doesn't set .needs_tmpdir = 1
ioctl_pidfd01.c:38:9: warning: LTP-006: tst_fd_next() creates files in the current directory, but struct tst_test doesn't set .needs_tmpdir = 1
splice07.c:63:9: warning: LTP-006: tst_fd_next() creates files in the current directory, but struct tst_test doesn't set .needs_tmpdir = 1

This report is not valid, it's just an example of non-tst_fd (I removed
.needs_tmpdir = 1 from the test):
open15.c:36:9: warning: LTP-006: safe_touch() creates 'myfile.txt' in cwd, but struct tst_test doesn't set .needs_tmpdir = 1

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20261104164638.407069-1-sbertram@redhat.com/

 doc/developers/writing_tests.rst |  13 ++
 tools/sparse/sparse-ltp.c        | 273 +++++++++++++++++++++++++++++++
 2 files changed, 286 insertions(+)

diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 9a56c02659..f8ecdbacd7 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -141,6 +141,19 @@ The following linting code can be found when we run ``make check``:
       - When defining arrays in the :c:struct:`tst_test` structure, we need to
         end the array items with a sentinel ``NULL`` value.
 
+    * - LTP-006
+      - Tests which create files in the current directory must have a tmpdir
+      - Tests which create files, directories, FIFOs or links using a
+        relative path, or use library functions which do so (e.g.
+        :c:macro:`TST_FD_FOREACH`), must set ``.needs_tmpdir = 1`` (or another
+        :c:struct:`tst_test` field which creates a temporary directory, e.g.
+        ``.needs_device``, ``.mntpoint``). Otherwise parallel runs race on
+        the same paths and files may be left behind.
+
+        The check covers ``SAFE_*()`` macros, LTP library helpers and libc
+        functions called with a string literal path and constant flags.
+        Paths built at runtime are not detected.
+
 Shell coding style
 ------------------
 
diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
index d649ee7b74..7f038aa726 100644
--- a/tools/sparse/sparse-ltp.c
+++ b/tools/sparse/sparse-ltp.c
@@ -60,6 +60,209 @@ static void check_lib_sets_TEST_vars(const struct instruction *insn)
 		"LTP-002: Library should not write to TST_RET or TST_ERR");
 }
 
+/* State for LTP-006, collected per translation unit */
+static struct {
+	/* First call which creates a file in the current directory */
+	const char *tmpdir_func;
+	const char *tmpdir_path;
+	struct position tmpdir_func_pos;
+	/* struct tst_test test was found */
+	bool test_struct;
+	/* struct tst_test sets a field which creates a tmpdir */
+	bool test_creates_tmpdir;
+} tmpdir_state;
+
+enum creat_kind {
+	/* Always creates a file (path is optional) */
+	CREAT_ALWAYS,
+	/* Creates a file if open() flags contain O_CREAT */
+	CREAT_OFLAGS,
+	/* Creates a file if fopen() mode starts with 'w' or 'a' */
+	CREAT_FMODE,
+};
+
+/*
+ * Functions which create files. Argument indexes are 0-based, -1 means
+ * none. Calls with a relative string literal path (or no path at all for
+ * library functions like tst_fd_next()) are reported. Paths which are
+ * not string literals are ignored, as are *at() calls whose dirfd is not
+ * AT_FDCWD.
+ */
+static const struct creat_func {
+	const char *name;
+	/* Name shown in the warning, if different (_FORTIFY_SOURCE) */
+	const char *alias;
+	enum creat_kind kind;
+	int path_arg;
+	int flags_arg;
+	int dirfd_arg;
+} creat_funcs[] = {
+	/* LTP library, file, lineno and cleanup_fn come first */
+	{"safe_open", NULL, CREAT_OFLAGS, 3, 4, -1},
+	{"safe_openat", NULL, CREAT_OFLAGS, 3, 4, 2},
+	{"safe_creat", NULL, CREAT_ALWAYS, 3, -1, -1},
+	{"safe_mkdir", NULL, CREAT_ALWAYS, 3, -1, -1},
+	{"safe_mkfifo", NULL, CREAT_ALWAYS, 3, -1, -1},
+	{"safe_mknod", NULL, CREAT_ALWAYS, 2, -1, -1},
+	{"safe_link", NULL, CREAT_ALWAYS, 4, -1, -1},
+	{"safe_symlink", NULL, CREAT_ALWAYS, 4, -1, -1},
+	{"safe_rename", NULL, CREAT_ALWAYS, 4, -1, -1},
+	{"safe_touch", NULL, CREAT_ALWAYS, 3, -1, -1},
+	{"safe_file_printf", NULL, CREAT_ALWAYS, 3, -1, -1},
+	{"file_printf", NULL, CREAT_ALWAYS, 2, -1, -1},
+	{"safe_fopen", NULL, CREAT_FMODE, 3, 4, -1},
+	{"tst_fill_file", NULL, CREAT_ALWAYS, 0, -1, -1},
+	{"tst_prealloc_file", NULL, CREAT_ALWAYS, 0, -1, -1},
+	/* TST_FD_FOREACH() */
+	{"tst_fd_next", NULL, CREAT_ALWAYS, -1, -1, -1},
+
+	/* libc, including glibc _FORTIFY_SOURCE variants */
+	{"open", NULL, CREAT_OFLAGS, 0, 1, -1},
+	{"open64", NULL, CREAT_OFLAGS, 0, 1, -1},
+	{"__open_2", "open", CREAT_OFLAGS, 0, 1, -1},
+	{"__open64_2", "open64", CREAT_OFLAGS, 0, 1, -1},
+	{"__open_alias", "open", CREAT_OFLAGS, 0, 1, -1},
+	{"__open64_alias", "open64", CREAT_OFLAGS, 0, 1, -1},
+	{"openat", NULL, CREAT_OFLAGS, 1, 2, 0},
+	{"openat64", NULL, CREAT_OFLAGS, 1, 2, 0},
+	{"__openat_2", "openat", CREAT_OFLAGS, 1, 2, 0},
+	{"__openat64_2", "openat64", CREAT_OFLAGS, 1, 2, 0},
+	{"__openat_alias", "openat", CREAT_OFLAGS, 1, 2, 0},
+	{"__openat64_alias", "openat64", CREAT_OFLAGS, 1, 2, 0},
+	{"creat", NULL, CREAT_ALWAYS, 0, -1, -1},
+	{"creat64", NULL, CREAT_ALWAYS, 0, -1, -1},
+	{"mkdir", NULL, CREAT_ALWAYS, 0, -1, -1},
+	{"mkdirat", NULL, CREAT_ALWAYS, 1, -1, 0},
+	{"mkfifo", NULL, CREAT_ALWAYS, 0, -1, -1},
+	{"mkfifoat", NULL, CREAT_ALWAYS, 1, -1, 0},
+	{"mknod", NULL, CREAT_ALWAYS, 0, -1, -1},
+	{"mknodat", NULL, CREAT_ALWAYS, 1, -1, 0},
+	{"link", NULL, CREAT_ALWAYS, 1, -1, -1},
+	{"symlink", NULL, CREAT_ALWAYS, 1, -1, -1},
+	{"rename", NULL, CREAT_ALWAYS, 1, -1, -1},
+	{"fopen", NULL, CREAT_FMODE, 0, 1, -1},
+	{"fopen64", NULL, CREAT_FMODE, 0, 1, -1},
+	{}
+};
+
+static pseudo_t call_arg(const struct instruction *insn, int n)
+{
+	return ptr_list_nth_entry((struct ptr_list *)insn->arguments, n);
+}
+
+/* Returns string literal passed as a call argument or NULL */
+static const char *pseudo_string(pseudo_t p)
+{
+	const struct expression *expr = NULL;
+	const struct instruction *def;
+
+	if (!p)
+		return NULL;
+
+	if (p->type == PSEUDO_SYM) {
+		expr = p->sym->initializer;
+	} else if (p->type == PSEUDO_REG) {
+		def = p->def;
+
+		if (def->opcode == OP_SETVAL)
+			expr = def->val;
+		else if (def->opcode == OP_SYMADDR &&
+			 def->src->type == PSEUDO_SYM)
+			expr = def->src->sym->initializer;
+	}
+
+	if (!expr || expr->type != EXPR_STRING)
+		return NULL;
+
+	return expr->string->data;
+}
+
+static bool pseudo_value(pseudo_t p, long long *val)
+{
+	if (!p || p->type != PSEUDO_VAL)
+		return false;
+
+	*val = p->value;
+	return true;
+}
+
+/* Part of check for LTP-006
+ *
+ * Does the call create a file in the current directory? Unknown
+ * (non-constant) arguments are treated as "no", to avoid false
+ * positives.
+ */
+static bool call_creates_file(const struct instruction *insn,
+			      const struct creat_func *f, const char **path)
+{
+	const char *mode;
+	long long val;
+
+	*path = NULL;
+
+	if (f->dirfd_arg >= 0) {
+		/* The value may be zero-extended, compare as int */
+		if (!pseudo_value(call_arg(insn, f->dirfd_arg), &val) ||
+		    (int)val != AT_FDCWD)
+			return false;
+	}
+
+	if (f->path_arg >= 0) {
+		*path = pseudo_string(call_arg(insn, f->path_arg));
+		if (!*path || !**path || **path == '/')
+			return false;
+	}
+
+	switch (f->kind) {
+	case CREAT_ALWAYS:
+		return true;
+	case CREAT_OFLAGS:
+		return pseudo_value(call_arg(insn, f->flags_arg), &val) &&
+		       (val & O_CREAT);
+	case CREAT_FMODE:
+		mode = pseudo_string(call_arg(insn, f->flags_arg));
+		return mode && (*mode == 'w' || *mode == 'a');
+	}
+
+	return false;
+}
+
+/* Part of check for LTP-006
+ *
+ * Remember the first call which creates a file in the current
+ * directory.
+ */
+static void check_call_needs_tmpdir(const struct instruction *insn)
+{
+	const struct creat_func *f;
+	const struct ident *id;
+	const char *path;
+
+	if (tmpdir_state.tmpdir_func)
+		return;
+	if (insn->opcode != OP_CALL)
+		return;
+	if (insn->func->type != PSEUDO_SYM)
+		return;
+
+	id = insn->func->sym->ident;
+	if (!id)
+		return;
+
+	for (f = creat_funcs; f->name; f++) {
+		if (strcmp(f->name, show_ident(id)))
+			continue;
+
+		if (!call_creates_file(insn, f, &path))
+			return;
+
+		tmpdir_state.tmpdir_func = f->alias ? f->alias : f->name;
+		tmpdir_state.tmpdir_path = path;
+		tmpdir_state.tmpdir_func_pos = insn->pos;
+		return;
+	}
+}
+
 static void do_basicblock_checks(struct basic_block *bb)
 {
 	struct instruction *insn;
@@ -70,6 +273,8 @@ static void do_basicblock_checks(struct basic_block *bb)
 
 		if (tu_kind == LTP_LIB)
 			check_lib_sets_TEST_vars(insn);
+		else
+			check_call_needs_tmpdir(insn);
 	} END_FOR_EACH_PTR(insn);
 }
 
@@ -199,6 +404,42 @@ static void check_struct_array_initializer(const struct symbol *const sym)
 		"LTP-005: Struct array doesn't appear to be null-terminated; did you forget to add '{}' as the final entry?");
 }
 
+/* Part of check for LTP-006
+ *
+ * Does a struct tst_test initializer entry create a tmpdir? Keep in sync
+ * with needs_tmpdir() in lib/tst_test.c and with the fields which imply
+ * needs_device in do_setup().
+ */
+static bool entry_creates_tmpdir(struct expression *const entry)
+{
+	static const char *const fields[] = {
+		"needs_tmpdir",
+		"needs_device",
+		"format_device",
+		"mount_device",
+		"all_filesystems",
+		"mntpoint",
+		"resource_files",
+		"needs_checkpoints",
+		NULL
+	};
+	int i;
+
+	if (!entry->ctype || !entry->ctype->ident)
+		return false;
+
+	/* .needs_tmpdir = 0 (folds implicit casts) */
+	if (entry->init_expr && is_zero_constant(entry->init_expr))
+		return false;
+
+	for (i = 0; fields[i]; i++) {
+		if (!strcmp(fields[i], show_ident(entry->ctype->ident)))
+			return true;
+	}
+
+	return false;
+}
+
 /* Find struct tst_test test = { ... } and perform tests on its initializer */
 static void check_test_struct(const struct symbol *const sym)
 {
@@ -226,6 +467,13 @@ static void check_test_struct(const struct symbol *const sym)
 	if (ctype_name != tst_test)
 		return;
 
+	tmpdir_state.test_struct = true;
+
+	FOR_EACH_PTR(init->expr_list, entry) {
+		if (entry_creates_tmpdir(entry))
+			tmpdir_state.test_creates_tmpdir = true;
+	} END_FOR_EACH_PTR(entry);
+
 	FOR_EACH_PTR(init->expr_list, entry) {
 		if (entry->init_expr->type != EXPR_SYMBOL)
 			continue;
@@ -279,6 +527,30 @@ static void process_symbols(struct symbol_list *list)
 	} END_FOR_EACH_PTR(sym);
 }
 
+/* Check for LTP-006
+ *
+ * Run after the whole translation unit was processed, because struct
+ * tst_test is usually defined after the functions which use the
+ * library.
+ */
+static void check_tmpdir_needed(void)
+{
+	if (tmpdir_state.tmpdir_func && tmpdir_state.test_struct &&
+	    !tmpdir_state.test_creates_tmpdir) {
+		if (tmpdir_state.tmpdir_path) {
+			warning(tmpdir_state.tmpdir_func_pos,
+				"LTP-006: %s() creates '%s' in cwd, but struct tst_test doesn't set .needs_tmpdir = 1",
+				tmpdir_state.tmpdir_func, tmpdir_state.tmpdir_path);
+		} else {
+			warning(tmpdir_state.tmpdir_func_pos,
+				"LTP-006: %s() creates files in cwd, but struct tst_test doesn't set .needs_tmpdir = 1",
+				tmpdir_state.tmpdir_func);
+		}
+	}
+
+	memset(&tmpdir_state, 0, sizeof(tmpdir_state));
+}
+
 static void collect_info_from_args(const int argc, char *const *const argv)
 {
 	int i;
@@ -317,6 +589,7 @@ int main(int argc, char **argv)
 	process_symbols(sparse_initialize(argc, argv, &filelist));
 	FOR_EACH_PTR(filelist, file) {
 		process_symbols(sparse(file));
+		check_tmpdir_needed();
 	} END_FOR_EACH_PTR(file);
 
 	report_stats();
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
