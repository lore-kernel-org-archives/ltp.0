Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0530AC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:39:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBAA63CF858
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:39:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E5003CF83A
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:36 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 92EAB1A0435A
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 789085CD1D;
 Thu, 11 Apr 2024 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/TmWDLbG1VUQtU6KoSVbcpGyzNrsxBujBTLepW0dOI=;
 b=QprQ/2GSyambnhh74dtCFr0YpcNyohwtf1WMBRi08e7e9PZoM79EPn8g8K84tSRraxkrPb
 zqf1QBOV2rfuus2Awyy/HdVpxvTcCrgQSKVtJaTWjXi7+AgV7ea0RcSCBIeoAV8MnRVYcK
 hPBcMTYwTEzqlPDbtSbubniI7JafsRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/TmWDLbG1VUQtU6KoSVbcpGyzNrsxBujBTLepW0dOI=;
 b=J8KLpEyjYByEVQXN0JDWenxFWOMvd76ctvqa9FZyMsl7Md7oBkh185BIKbaJP2O97LyRFh
 NR8sHSRTSgyxL9Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/TmWDLbG1VUQtU6KoSVbcpGyzNrsxBujBTLepW0dOI=;
 b=QprQ/2GSyambnhh74dtCFr0YpcNyohwtf1WMBRi08e7e9PZoM79EPn8g8K84tSRraxkrPb
 zqf1QBOV2rfuus2Awyy/HdVpxvTcCrgQSKVtJaTWjXi7+AgV7ea0RcSCBIeoAV8MnRVYcK
 hPBcMTYwTEzqlPDbtSbubniI7JafsRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/TmWDLbG1VUQtU6KoSVbcpGyzNrsxBujBTLepW0dOI=;
 b=J8KLpEyjYByEVQXN0JDWenxFWOMvd76ctvqa9FZyMsl7Md7oBkh185BIKbaJP2O97LyRFh
 NR8sHSRTSgyxL9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18D691386E;
 Thu, 11 Apr 2024 14:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gHVHBAr0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:23 +0200
Message-ID: <20240411143025.352507-30-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 29/31] lib: Remove -C option and self_exec.c
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

It was added only for UCLINUX.

These unused functions were removed:

void maybe_run_child(void (*child)(), const char *fmt, ...);
int self_exec(const char *argv0, const char *fmt, ...);

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/old/test.h |   4 -
 lib/self_exec.c    | 225 ---------------------------------------------
 lib/tst_test.c     |  15 ---
 3 files changed, 244 deletions(-)
 delete mode 100644 lib/self_exec.c

diff --git a/include/old/test.h b/include/old/test.h
index 7394a365e..0e210e4ef 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -167,10 +167,6 @@ extern int tst_count;
 /* lib/tst_sig.c */
 void tst_sig(int fork_flag, void (*handler)(), void (*cleanup)());
 
-/* lib/self_exec.c */
-void maybe_run_child(void (*child)(), const char *fmt, ...);
-int self_exec(const char *argv0, const char *fmt, ...);
-
 /* lib/tst_mkfs.c
  *
  * @dev: path to a device
diff --git a/lib/self_exec.c b/lib/self_exec.c
deleted file mode 100644
index de7d09517..000000000
--- a/lib/self_exec.c
+++ /dev/null
@@ -1,225 +0,0 @@
-/* -*- mode: C; c-basic-offset: 4; indent-tabs-mode: t -*- */
-/*
- * self_exec.c: self_exec magic required to run child functions on uClinux
- *
- * Copyright (C) 2005 Paul J.Y. Lahaie <pjlahaie-at-steamballoon.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
- * This software was produced by Steamballoon Incorporated
- * 55 Byward Market Square, 2nd Floor North, Ottawa, ON K1N 9C3, Canada
- */
-
-#define _GNU_SOURCE		/* for asprintf */
-
-#include "config.h"
-
-#ifdef UCLINUX
-
-#include <stdarg.h>
-#include <string.h>
-#include <stdio.h>
-#include "test.h"
-#include "safe_macros.h"
-
-/* Set from parse_opts.c: */
-char *child_args;		/* Arguments to child when -C is used */
-
-static char *start_cwd;		/* Stores the starting directory for self_exec */
-
-int asprintf(char **app, const char *fmt, ...)
-{
-	va_list ptr;
-	int rv;
-	char *p;
-
-	/*
-	 * First iteration - find out size of buffer required and allocate it.
-	 */
-	va_start(ptr, fmt);
-	rv = vsnprintf(NULL, 0, fmt, ptr);
-	va_end(ptr);
-
-	p = malloc(++rv);	/* allocate the buffer */
-	*app = p;
-	if (!p) {
-		return -1;
-	}
-
-	/*
-	 * Second iteration - actually produce output.
-	 */
-	va_start(ptr, fmt);
-	rv = vsnprintf(p, rv, fmt, ptr);
-	va_end(ptr);
-
-	return rv;
-}
-
-void maybe_run_child(void (*child) (), const char *fmt, ...)
-{
-	va_list ap;
-	char *child_dir;
-	char *p, *tok;
-	int *iptr, i, j;
-	char *s;
-	char **sptr;
-	char *endptr;
-
-	/* Store the current directory for later use. */
-	start_cwd = getcwd(NULL, 0);
-
-	if (child_args) {
-		char *args = strdup(child_args);
-
-		child_dir = strtok(args, ",");
-		if (strlen(child_dir) == 0) {
-			tst_brkm(TBROK, NULL,
-				 "Could not get directory from -C option");
-			return;
-		}
-
-		va_start(ap, fmt);
-
-		for (p = fmt; *p; p++) {
-			tok = strtok(NULL, ",");
-			if (!tok || strlen(tok) == 0) {
-				tst_brkm(TBROK, NULL,
-					 "Invalid argument to -C option");
-				return;
-			}
-
-			switch (*p) {
-			case 'd':
-				iptr = va_arg(ap, int *);
-				i = strtol(tok, &endptr, 10);
-				if (*endptr != '\0') {
-					tst_brkm(TBROK, NULL,
-						 "Invalid argument to -C option");
-					return;
-				}
-				*iptr = i;
-				break;
-			case 'n':
-				j = va_arg(ap, int);
-				i = strtol(tok, &endptr, 10);
-				if (*endptr != '\0') {
-					tst_brkm(TBROK, NULL,
-						 "Invalid argument to -C option");
-					return;
-				}
-				if (j != i) {
-					va_end(ap);
-					free(args);
-					return;
-				}
-				break;
-			case 's':
-				s = va_arg(ap, char *);
-				if (!strncpy(s, tok, strlen(tok) + 1)) {
-					tst_brkm(TBROK, NULL,
-						 "Could not strncpy for -C option");
-					return;
-				}
-				break;
-			case 'S':
-				sptr = va_arg(ap, char **);
-				*sptr = strdup(tok);
-				if (!*sptr) {
-					tst_brkm(TBROK, NULL,
-						 "Could not strdup for -C option");
-					return;
-				}
-				break;
-			default:
-				tst_brkm(TBROK, NULL,
-					 "Format string option %c not implemented",
-					 *p);
-				return;
-			}
-		}
-
-		va_end(ap);
-		free(args);
-		SAFE_CHDIR(NULL, child_dir);
-
-		(*child) ();
-		tst_resm(TWARN, "Child function returned unexpectedly");
-		/* Exit here? or exit silently? */
-	}
-}
-
-int self_exec(const char *argv0, const char *fmt, ...)
-{
-	va_list ap;
-	char *p;
-	char *tmp_cwd;
-	char *arg;
-	int ival;
-	char *str;
-
-	if ((tmp_cwd = getcwd(NULL, 0)) == NULL) {
-		tst_resm(TBROK, "Could not getcwd()");
-		return -1;
-	}
-
-	arg = strdup(tmp_cwd);
-	if (arg == NULL) {
-		tst_resm(TBROK, "Could not produce self_exec string");
-		return -1;
-	}
-
-	va_start(ap, fmt);
-
-	for (p = fmt; *p; p++) {
-		switch (*p) {
-		case 'd':
-		case 'n':
-			ival = va_arg(ap, int);
-			if (asprintf(&arg, "%s,%d", arg, ival) < 0) {
-				tst_resm(TBROK,
-					 "Could not produce self_exec string");
-				return -1;
-			}
-			break;
-		case 's':
-		case 'S':
-			str = va_arg(ap, char *);
-			if (asprintf(&arg, "%s,%s", arg, str) < 0) {
-				tst_resm(TBROK,
-					 "Could not produce self_exec string");
-				return -1;
-			}
-			break;
-		default:
-			tst_resm(TBROK,
-				 "Format string option %c not implemented", *p);
-			return -1;
-			break;
-		}
-	}
-
-	va_end(ap);
-
-	if (chdir(start_cwd) < 0) {
-		tst_resm(TBROK, "Could not change to %s for self_exec",
-			 start_cwd);
-		return -1;
-	}
-
-	return execlp(argv0, argv0, "-C", arg, (char *)NULL);
-}
-
-#endif /* UCLINUX */
diff --git a/lib/tst_test.c b/lib/tst_test.c
index edb42f7f4..c5d853e22 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -520,7 +520,6 @@ static struct option {
 	{"I:", "-I x     Execute test for n seconds"},
 	{"D",  "-D       Prints debug information"},
 	{"V",  "-V       Prints LTP version"},
-	{"C:", "-C ARG   Run child process with ARG arguments (used internally)"},
 };
 
 static void print_help(void)
@@ -660,11 +659,6 @@ static void parse_topt(unsigned int topts_len, int opt, char *optarg)
 	*(toptions[i].arg) = optarg ? optarg : "";
 }
 
-/* see self_exec.c */
-#ifdef UCLINUX
-extern char *child_args;
-#endif
-
 static void parse_opts(int argc, char *argv[])
 {
 	unsigned int i, topts_len = count_options();
@@ -704,15 +698,6 @@ static void parse_opts(int argc, char *argv[])
 			else
 				duration = SAFE_STRTOF(optarg, 0.1, HUGE_VALF);
 		break;
-		case 'V':
-			fprintf(stderr, "LTP version: " LTP_VERSION "\n");
-			exit(0);
-		break;
-		case 'C':
-#ifdef UCLINUX
-			child_args = optarg;
-#endif
-		break;
 		default:
 			parse_topt(topts_len, opt, optarg);
 		}
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
