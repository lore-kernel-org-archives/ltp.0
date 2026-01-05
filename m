Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FC8C79F89
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 13:04:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C00023C2465
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 14:04:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 585B33C21FC
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 14:04:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5AE9B600188
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 14:04:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BD94C5BE37;
 Mon,  5 Jan 2026 13:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767618243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7lgKe6LVqx23RQ81mzgCl4rOqSte2/Ey6EEGHuqA+KA=;
 b=JIgWjqaWMCaeD+8SJEuSoUL1TlfAkV2PTo8mRzXIjlH5QckyQ+uamFX6UCI48xyrOQgiBN
 orxHINHPVI8rPtXqMtUYaXSgBt3q36rJqwunKcsqwO9gbcEU/pugBpapv9aw/84Fu10CzT
 9eB6ignXMF2nHrfE6lvD2SbeltDd4Ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767618243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7lgKe6LVqx23RQ81mzgCl4rOqSte2/Ey6EEGHuqA+KA=;
 b=Y/KnCubniKcQ8MqWLL/SZKZJ4keyts8uW5JI3M+M+Rf9EH7Qp1TyfRuz8EhA4uCBQM+YHl
 3vabM3/jpF49CwAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767618242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7lgKe6LVqx23RQ81mzgCl4rOqSte2/Ey6EEGHuqA+KA=;
 b=GVnQcUpxFc4OO0AJZrsVtso/DDPAUuzL8kbIp/sltFN2EbNaTiZgI6gN1TaBne6Mh1C5f+
 S0Rj7Z1aYYwoP3xv0MGVMjXG3r1RjlkUT43yvydZiBC0f1/+cHU6cTrkcRwb+9an1BTPP2
 JJcXh68T+pFSG3ivIFgQkfQd7ZiCusY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767618242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7lgKe6LVqx23RQ81mzgCl4rOqSte2/Ey6EEGHuqA+KA=;
 b=yB4yqniF3tjmRH6rndj5qqz121pAMjOojxvVMcFHkkZtmFtM7J+YKSTa839UhOpG3XtCE+
 JE46Pfayw5eGTMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54A1D3EA63;
 Mon,  5 Jan 2026 13:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CHgRE8K2W2k7cwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Jan 2026 13:04:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  5 Jan 2026 14:03:58 +0100
Message-ID: <20260105130359.647879-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.992];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,linux.it:email,suse.cz:email,suse.cz:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] make check: b3: Use --strict when run
 checkpatch.pl
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

The main motivation is to show typos on 'make check' which require --strict:

* TYPO_SPELLING
tst_cgroup.h:127: CHECK: 'libary' may be misspelled - perhaps 'library'?

Other checks included:

* LINE_SPACING
tst_test.h:174: CHECK: Please don't use multiple blank lines

* MACRO_ARG_REUSE:
tst_test.h:69: CHECK: Macro argument reuse 'ttype' - possible side-effects?
    #define tst_res(ttype, arg_fmt, ...) \
	({									\
		TST_RES_SUPPORTS_TCONF_TDEBUG_TFAIL_TINFO_TPASS_TWARN(\
			!((TTYPE_RESULT(ttype) ?: TCONF) & \
	...

* LONG_LINE:
tst_test.h:73: CHECK: line length of 105 exceeds 100 columns
=> enforced by --strict because we miss kernel fix from v6.11:
d6bb39519aafe ("checkpatch: really skip LONG_LINE_* when LONG_LINE is ignored")
(will be fixed by checkpatch.pl update in next commit).

Whitelist all other checks added by --strict.
Update also b4 config.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: here are checked whitelisted. Do we want to add some of these?

Kind regards,
Petr

* LONG_LINE:
tst_test.h:73: CHECK: line length of 105 exceeds 100 columns

* SPACING
tst_test.c:1239: CHECK: spaces preferred around that '|' (ctx:VxV)

* MULTIPLE_ASSIGNMENTS
tst_test.c:1419: CHECK: multiple assignments should be avoided
TCID = tcid = get_tcid(argv);

* UNNECESSARY_PARENTHESES
tst_test.c:802: CHECK: Unnecessary parentheses around toptions[i].arg
*(toptions[i].arg) = optarg ? optarg : "";

* PARENTHESIS_ALIGNMENT
tst_test.c:1300: CHECK: Alignment should match open parenthesis
	mnt_data = limit_tmpfs_mount_size(fs->mnt_data,
					buf, sizeof(buf), tdev.fs_type);

* BRACES
tst_test.c:2069: CHECK: Blank lines aren't necessary before a close brace '}'
tst_test.c:1560: CHECK: Blank lines aren't necessary after an open brace '{'
	if (!tst_test->all_filesystems && count_fs_descs() <= 1) {

			if (!tst_fs_is_supported(tdev.fs_type))

* CONCATENATED_STRING
tst_test.c:200: CHECK: Concatenated strings should use spaces between elements
	tst_brk(TBROK, IPC_ENV_VAR" is not defined");

* PREFER_KERNEL_TYPES
tst_test.c:74: CHECK: Prefer kernel type 's32' over 'int32_t'
=> obviously kernel related

 .b4-config             | 4 ++--
 include/mk/env_post.mk | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.b4-config b/.b4-config
index 36aa15c38f..5ff045b55b 100644
--- a/.b4-config
+++ b/.b4-config
@@ -4,6 +4,6 @@
     send-series-to = Linux Test Project <ltp@lists.linux.it>
     pw-url = https://patchwork.ozlabs.org/
     pw-project = ltp
-    prep-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --showfile --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES
-    am-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES
+    prep-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --showfile --no-tree --strict --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES,PREFER_KERNEL_TYPES,LONG_LINE,MACRO_ARG_REUSE,SPACING,MULTIPLE_ASSIGNMENTS,UNNECESSARY_PARENTHESES,PARENTHESIS_ALIGNMENT,BRACES,CONCATENATED_STRING
+    am-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --no-tree --strict --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES,PREFER_KERNEL_TYPES,LONG_LINE,MACRO_ARG_REUSE,SPACING,MULTIPLE_ASSIGNMENTS,UNNECESSARY_PARENTHESES,PARENTHESIS_ALIGNMENT,BRACES,CONCATENATED_STRING
 
diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index ab31da73af..947151457b 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -73,7 +73,7 @@ CHECK_TARGETS			?= $(addprefix check-,$(notdir $(patsubst %.c,%,$(sort $(wildcar
 CHECK_TARGETS			:= $(filter-out $(addprefix check-, $(FILTER_OUT_MAKE_TARGETS)), $(CHECK_TARGETS))
 CHECK_HEADER_TARGETS		?= $(addprefix check-,$(notdir $(sort $(wildcard $(abs_srcdir)/*.h))))
 CHECK				?= $(abs_top_srcdir)/tools/sparse/sparse-ltp
-CHECK_NOFLAGS			?= $(abs_top_srcdir)/scripts/checkpatch.pl -f --no-tree --terse --no-summary --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES
+CHECK_NOFLAGS			?= $(abs_top_srcdir)/scripts/checkpatch.pl -f --no-tree --terse --no-summary --strict --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES,PREFER_KERNEL_TYPES,LONG_LINE,MACRO_ARG_REUSE,SPACING,MULTIPLE_ASSIGNMENTS,UNNECESSARY_PARENTHESES,PARENTHESIS_ALIGNMENT,BRACES,CONCATENATED_STRING
 SHELL_CHECK			?= $(abs_top_srcdir)/scripts/checkbashisms.pl --force --extra
 SHELL_CHECK_TARGETS		?= $(addprefix check-,$(notdir $(sort $(wildcard $(abs_srcdir)/*.sh))))
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
