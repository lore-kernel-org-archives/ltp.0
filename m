Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1AAC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:32:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C39993CF832
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:32:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E3603C0333
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5081D10103AD
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 86E3D375AA;
 Thu, 11 Apr 2024 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIi9li+AzVY75zaAiQHxYNOnmyTIMHql9La2srBBxe0=;
 b=qjxNFnxUjr+sQQ464d4HySMWwR3EEOb5tOISdknS5QqzaJwF0oJMnjrZyiSs2u3Phk5euC
 QTlL3TA6IdIXu/f7Ry6Se4S9r5CQajdDvWUL78jNR0ukSbhrDjC3o+YX1vAPZopPWnAip7
 n5EHC6xYebjuzIDRyfWTLcVMZ3vty/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIi9li+AzVY75zaAiQHxYNOnmyTIMHql9La2srBBxe0=;
 b=229mOtXf85NXh4vnvwLA+wGA+d+YpugTyKREh2tJ/iQrRaSFp3McrrVzqdMK6kv8I4z5yS
 fUQIkbZ2ZZWIJkDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIi9li+AzVY75zaAiQHxYNOnmyTIMHql9La2srBBxe0=;
 b=qjxNFnxUjr+sQQ464d4HySMWwR3EEOb5tOISdknS5QqzaJwF0oJMnjrZyiSs2u3Phk5euC
 QTlL3TA6IdIXu/f7Ry6Se4S9r5CQajdDvWUL78jNR0ukSbhrDjC3o+YX1vAPZopPWnAip7
 n5EHC6xYebjuzIDRyfWTLcVMZ3vty/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIi9li+AzVY75zaAiQHxYNOnmyTIMHql9La2srBBxe0=;
 b=229mOtXf85NXh4vnvwLA+wGA+d+YpugTyKREh2tJ/iQrRaSFp3McrrVzqdMK6kv8I4z5yS
 fUQIkbZ2ZZWIJkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65DE913888;
 Thu, 11 Apr 2024 14:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gBXlFgb0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:00 +0200
Message-ID: <20240411143025.352507-7-pvorel@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 06/31] lib/parse_opts.c: Remove UCLINUX
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/parse_opts.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/lib/parse_opts.c b/lib/parse_opts.c
index a9d50589a..03e833312 100644
--- a/lib/parse_opts.c
+++ b/lib/parse_opts.c
@@ -88,11 +88,6 @@ static struct std_option_t {
 	{"h", "  -h      Show this help screen\n", NULL, NULL},
 	{"i:", "  -i n    Execute test n times\n", NULL, NULL},
 	{"I:", "  -I x    Execute test for x seconds\n", NULL, NULL},
-#ifdef UCLINUX
-	{"C:",
-	      "  -C ARG  Run the child process with arguments ARG (for internal use)\n",
-		    NULL, NULL},
-#endif
 	{NULL, NULL, NULL, NULL}
 };
 
@@ -118,11 +113,6 @@ static void usc_recressive_func();
 #define OPT_duration		04
 #define OPT_delay		010
 
-#ifdef UCLINUX
-/* Allocated and used in self_exec.c: */
-extern char *child_args;	/* Arguments to child when -C is used */
-#endif
-
 static void print_help(void (*user_help)(void))
 {
 	int i;
@@ -219,11 +209,6 @@ const char *parse_opts(int ac, char **av, const option_t * user_optarr,
 			print_help(uhf);
 			exit(0);
 			break;
-#ifdef UCLINUX
-		case 'C':	/* Run child */
-			child_args = optarg;
-			break;
-#endif
 		default:
 
 			/* Check all the user specified options */
@@ -400,7 +385,7 @@ const char *parse_opts(int ac, char **av, const option_t * user_optarr,
 				     STD_TP_sbrk);
 		}
 	}
-#if !defined(UCLINUX)
+
 	if ((ptr = getenv("USC_LP_SBRK")) != NULL) {
 		if (sscanf(ptr, "%i", &k) == 1 && k >= 0) {
 			STD_LP_sbrk = k;
@@ -410,7 +395,6 @@ const char *parse_opts(int ac, char **av, const option_t * user_optarr,
 				     STD_LP_sbrk);
 		}
 	}
-#endif /* if !defined(UCLINUX) */
 
 	if ((ptr = getenv("USC_LP_RECFUN")) != NULL) {
 		if (sscanf(ptr, "%i", &k) == 1 && k >= 0) {
@@ -453,7 +437,6 @@ const char *parse_opts(int ac, char **av, const option_t * user_optarr,
  ***********************************************************************/
 int usc_global_setup_hook(void)
 {
-#ifndef UCLINUX
 	if (STD_TP_sbrk || STD_LP_sbrk)
 		STD_start_break = sbrk(0);	/* get original sbreak size */
 
@@ -462,7 +445,6 @@ int usc_global_setup_hook(void)
 		if (Debug)
 			printf("after sbrk(%d)\n", STD_TP_sbrk);
 	}
-#endif
 	return 0;
 }
 
@@ -538,13 +520,12 @@ int usc_test_looping(int counter)
 			     STD_LP_recfun);
 		usc_recressive_func(0, STD_LP_recfun, *STD_bigstack);
 	}
-#if !defined(UCLINUX)
+
 	if (STD_LP_sbrk) {
 		if (Debug)
 			printf("about to do sbrk(%d)\n", STD_LP_sbrk);
 		sbrk(STD_LP_sbrk);
 	}
-#endif
 
 	if (keepgoing)
 		return 1;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
