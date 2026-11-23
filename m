Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC4606A335
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HsZFynUJ;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XqDIww6c;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HsZFynUJ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XqDIww6c
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC1743EAF9C
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 17:24:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB8483EAF92
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 17:23:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 07E761400BC0
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 17:23:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 77FA12204B
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795451007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4PA0A08Cb7xpC9XnHXmU/wESmG0+b42VF8gI90J5Io=;
 b=HsZFynUJAG6uWKDxA18JALXaVeVfG3X9OC0QIscHHi1g9IQGWlYUKvqcAzdpfaivJecX4r
 UvtioA0EDpYk5/bV1gdRtewFbR7mqqYjvSX8NVR2NeeMiffau60Wnzx8rQCiNCipQk2+6l
 RfsKgUvXCrQFq9OvHX8M2MTHlIL2BbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795451007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4PA0A08Cb7xpC9XnHXmU/wESmG0+b42VF8gI90J5Io=;
 b=XqDIww6cq7JeW89v6bokKHMAZRdPl6VZ027KhGZrZvKG2A7eAh+C0hQZnjMjXxZZfEF+Kd
 6EreUFTh/+NR3KAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HsZFynUJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XqDIww6c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795451007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4PA0A08Cb7xpC9XnHXmU/wESmG0+b42VF8gI90J5Io=;
 b=HsZFynUJAG6uWKDxA18JALXaVeVfG3X9OC0QIscHHi1g9IQGWlYUKvqcAzdpfaivJecX4r
 UvtioA0EDpYk5/bV1gdRtewFbR7mqqYjvSX8NVR2NeeMiffau60Wnzx8rQCiNCipQk2+6l
 RfsKgUvXCrQFq9OvHX8M2MTHlIL2BbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795451007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4PA0A08Cb7xpC9XnHXmU/wESmG0+b42VF8gI90J5Io=;
 b=XqDIww6cq7JeW89v6bokKHMAZRdPl6VZ027KhGZrZvKG2A7eAh+C0hQZnjMjXxZZfEF+Kd
 6EreUFTh/+NR3KAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B3AD13505
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 16:23:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JRd8Cn9oBGvYUQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 16:23:27 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 23 Nov 2026 17:23:56 +0100
Message-ID: <20261123162357.256048-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123162357.256048-1-chrubis@suse.cz>
References: <20261123162357.256048-1-chrubis@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 77FA12204B
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.01
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] tools/apicmds: Remove tst_fs_has_free
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The tst_fs_has_free shell command has no users left in the tree, remove
it from the apicmds binary along with its documentation and entry point.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/old/Shell-Test-API.asciidoc | 22 ---------------
 tools/apicmds/.gitignore        |  1 -
 tools/apicmds/Makefile          |  3 +-
 tools/apicmds/ltpapicmd.c       | 50 +--------------------------------
 4 files changed, 2 insertions(+), 74 deletions(-)

diff --git a/doc/old/Shell-Test-API.asciidoc b/doc/old/Shell-Test-API.asciidoc
index c38fb0698..2b1ad4c19 100644
--- a/doc/old/Shell-Test-API.asciidoc
+++ b/doc/old/Shell-Test-API.asciidoc
@@ -686,28 +686,6 @@ https://github.com/linux-test-project/ltp/wiki/C-Test-API#16-runtime-kernel-vers
 NOTE: See also LTP
       https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions#13-minimal-supported-kernel-version[minimal supported kernel version].
 
-tst_fs_has_free
-+++++++++++++++
-
-[source,sh]
--------------------------------------------------------------------------------
-#!/bin/sh
-
-...
-
-# whether current directory has 100MB free space at least.
-if ! tst_fs_has_free . 100MB; then
-	tst_brkm TCONF "Not enough free space"
-fi
-
-...
--------------------------------------------------------------------------------
-
-The 'tst_fs_has_free' shell interface returns 0 if the specified free space is
-satisfied, 1 if not, and 2 on error.
-
-The second argument supports suffixes kB, MB and GB, the default unit is Byte.
-
 tst_retry
 +++++++++
 
diff --git a/tools/apicmds/.gitignore b/tools/apicmds/.gitignore
index 54a1d664d..375e7e9b8 100644
--- a/tools/apicmds/.gitignore
+++ b/tools/apicmds/.gitignore
@@ -6,4 +6,3 @@ tst_ncpus_conf
 tst_ncpus_max
 tst_res
 tst_resm
-tst_fs_has_free
diff --git a/tools/apicmds/Makefile b/tools/apicmds/Makefile
index 4b2a60495..b240a8958 100644
--- a/tools/apicmds/Makefile
+++ b/tools/apicmds/Makefile
@@ -27,8 +27,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 CPPFLAGS		+= -D_GNU_SOURCE
 
 MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit \
-			     res resm ncpus ncpus_conf ncpus_max \
-			     fs_has_free)
+			     res resm ncpus ncpus_conf ncpus_max)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index 40018b3ed..9725d2e41 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -193,42 +193,6 @@ struct param_pair {
 	int value;
 };
 
-int apicmd_fs_has_free(int argc, char *argv[])
-{
-	if (argc != 3) {
-		fprintf(stderr, "Usage: tst_fs_has_free path required_bytes\n"
-			"path: the pathname of the mounted filesystem\n"
-			"required_bytes: the required free space"
-			" (supports kB, MB and GB suffixes)\n");
-		exit(2);
-	}
-
-	char *endptr;
-	unsigned int required_kib = strtoull(argv[1], &endptr, 0);
-	unsigned int mul = TST_BYTES;
-
-	if (*argv[1] == '\0')
-		goto fs_has_free_err;
-
-	if (*endptr != '\0') {
-		if (!strcasecmp(endptr, "kB")) {
-			mul = TST_KB;
-		} else if (!strcasecmp(endptr, "MB")) {
-			mul = TST_MB;
-		} else if (!strcasecmp(endptr, "GB")) {
-			mul = TST_GB;
-		} else {
-			goto fs_has_free_err;
-		}
-	}
-
-	exit(!tst_fs_has_free(NULL, argv[0], required_kib, mul));
-
-fs_has_free_err:
-	fprintf(stderr, "%s is not a valid size\n", argv[1]);
-	exit(2);
-}
-
 /*
  * Function:    main - entry point of this program
  *
@@ -261,17 +225,7 @@ int main(int argc, char *argv[])
 	TCID = getenv("TCID");
 	tst_total = getenv("TST_TOTAL");
 	tst_cntstr = getenv("TST_COUNT");
-	if (TCID == NULL || tst_total == NULL || tst_cntstr == NULL) {
-		 if(!strcmp(cmd_name, "tst_fs_has_free")) {
-			fprintf(stderr,
-				"\nSet variables TCID, TST_TOTAL, and TST_COUNT before each test:\n"
-				"export TCID=<test name>\n"
-				"export TST_TOTAL=<Total Number of Tests >\n"
-				"export TST_COUNT=<Test case number>\n\n");
-			/* Make sure the user knows there's an error. */
-			abort();
-		}
-	} else {
+	if (TCID && tst_total && tst_cntstr) {
 		TST_TOTAL = atoi(tst_total);
 		tst_count = atoi(tst_cntstr);
 		if (tst_count > 0)
@@ -306,8 +260,6 @@ int main(int argc, char *argv[])
 		printf("%li\n", tst_ncpus_conf());
 	} else if (strcmp(cmd_name, "tst_ncpus_max") == 0) {
 		printf("%li\n", tst_ncpus_max());
-	} else if (strcmp(cmd_name, "tst_fs_has_free") == 0) {
-		apicmd_fs_has_free(argc, argv);
 	}
 
 	exit(0);
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
