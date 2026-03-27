Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB17410F2861
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 17:34:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 928C43CFFAB
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 18:34:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD8BC3DD308
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 18:33:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2CE231A010F0
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 18:33:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 732D04D1F6;
 Fri, 27 Mar 2026 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774632807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxn+3vdHASTESJ9xI3eWbrsjxneSIXMw3UOdNz0yqM8=;
 b=axgObEW2BGfig5BfLEPMMef8oF80Gcpq0y5n+DK/A+0jwAF6qIb4lO7DHkB4TMRq5QVTFT
 dOL0F3obfyl+DXHddvWhvThoyAEK2XGyDOTlX2XgVyH+ODv9WAQ3vvHYbVQoSm1WKXocE+
 rOnf7Rzf5wkbD5p9v+uz9YR4/KbJuYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774632807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxn+3vdHASTESJ9xI3eWbrsjxneSIXMw3UOdNz0yqM8=;
 b=JiT2VS7N1DwnkZRTCyVR52Zf5M90+rG1vJcpuLgiF6Z0SaBv8fAfVsholbxMRDK/HEErNH
 EWoYaKAqNsFQ6mDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774632807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxn+3vdHASTESJ9xI3eWbrsjxneSIXMw3UOdNz0yqM8=;
 b=axgObEW2BGfig5BfLEPMMef8oF80Gcpq0y5n+DK/A+0jwAF6qIb4lO7DHkB4TMRq5QVTFT
 dOL0F3obfyl+DXHddvWhvThoyAEK2XGyDOTlX2XgVyH+ODv9WAQ3vvHYbVQoSm1WKXocE+
 rOnf7Rzf5wkbD5p9v+uz9YR4/KbJuYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774632807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxn+3vdHASTESJ9xI3eWbrsjxneSIXMw3UOdNz0yqM8=;
 b=JiT2VS7N1DwnkZRTCyVR52Zf5M90+rG1vJcpuLgiF6Z0SaBv8fAfVsholbxMRDK/HEErNH
 EWoYaKAqNsFQ6mDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41D584A0B1;
 Fri, 27 Mar 2026 17:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MD8yDme/xmm0DgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Mar 2026 17:33:27 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 27 Mar 2026 18:32:51 +0100
Message-ID: <20260327173252.1112192-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327173252.1112192-1-pvorel@suse.cz>
References: <20260327173252.1112192-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] lib: Prefer LTP_DEBUG over -D
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

Environment variable has usually higher preference than getopt.
This includes disabling debugging even on -D:
LTP_DEBUG= ./test05 -D2 means debugging disabled.

Also reduce duplicity of "Enabling debug info (level %d)" message and
document that on -h and developers/debugging.rst.

Fixes: e434de62b4 ("lib: Extend LTP_ENABLE_DEBUG to support verbosity levels")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* Simplify -D code (Li)

 doc/developers/debugging.rst |  2 ++
 lib/tst_test.c               | 25 +++++++++++--------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/doc/developers/debugging.rst b/doc/developers/debugging.rst
index 36dda0d90f..4e162068b4 100644
--- a/doc/developers/debugging.rst
+++ b/doc/developers/debugging.rst
@@ -19,6 +19,8 @@ The ``-D`` parameter also supports the following verbosity levels:
 
 Suppress all debug logs if no '-D' flag passed (default behavior).
 
+``LTP_DEBUG`` has higher preference than ``-D``.
+
 Tracing and debugging syscalls
 ------------------------------
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index ea1aa5d306..61e357af3f 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -654,11 +654,11 @@ static struct option {
 	char *optstr;
 	char *help;
 } options[] = {
-	{"h",  "-h       Prints this help"},
-	{"i:", "-i n     Execute test n times"},
-	{"I:", "-I x     Execute test for n seconds"},
-	{"D::", "-D[1,2]  Prints debug information"},
-	{"V",  "-V       Prints LTP version"},
+	{"h",  "-h        Prints this help"},
+	{"i:", "-i n      Execute test n times"},
+	{"I:", "-I x      Execute test for n seconds"},
+	{"D::", "-D[1,2]  Prints debug information (can be overwriten by LTP_DEBUG"},
+	{"V",  "-V        Prints LTP version"},
 };
 
 static void print_help(void)
@@ -825,13 +825,9 @@ static void parse_opts(int argc, char *argv[])
 			tst_brk(TBROK, "Invalid option");
 		break;
 		case 'D':
-			if (optarg)
-				context->tdebug = SAFE_STRTOL(optarg, 1, 2);
-			else
-				context->tdebug = 1;
-
-			if (context->tdebug)
-				tst_res(TINFO, "Enabling debug info (level %d)", context->tdebug);
+			if (getenv("LTP_DEBUG"))
+				break;
+			context->tdebug = optarg ? SAFE_STRTOL(optarg, 1, 2) : 1;
 		break;
 		case 'h':
 			print_help();
@@ -1453,10 +1449,11 @@ static void do_setup(int argc, char *argv[])
 		else
 			tst_res(TWARN, "Invalid LTP_DEBUG value: '%s'", tdebug_env);
 
-		if (context->tdebug)
-			tst_res(TINFO, "Enabling debug info (level %d)", context->tdebug);
 	}
 
+	if (context->tdebug)
+		tst_res(TINFO, "Enabling debug info (level %d)", context->tdebug);
+
 	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
 		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
 
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
