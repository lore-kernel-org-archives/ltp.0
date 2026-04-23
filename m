Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A84F99351
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 08:42:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9D683E4ACB
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 10:42:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3D283E4B3E
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:41:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E017B2009E4
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:41:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22F9F6A7DE;
 Thu, 23 Apr 2026 08:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776933695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dm4xu19sSoPPPCSwQdP935QPhEiL+/V28fiY8V9aCuU=;
 b=1Wog4xQvFvAdqhPeUI/mov+gEdLt0o3P6v+EmrJ9NDOHDKWZbi5UQ9kR/pqqfI3L18ZBbe
 k60Hqed1+FMCMc897DAutdqW0/+tXSIpkyn0YOfv0aZdZSLIW1KFPR+zm0elSOz5SYJIB+
 7DfVmT1bz2T5KuIWUd0vxakDPcz5+F0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776933695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dm4xu19sSoPPPCSwQdP935QPhEiL+/V28fiY8V9aCuU=;
 b=QsMfiEANXaO+paAJu8UdozeFoUSMYCtNaAkWtf0f0cQFtQct8Jl8IQzYCxswfJ06XNm3Cl
 FCBrSWL5ZyB346BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1Wog4xQv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QsMfiEAN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776933695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dm4xu19sSoPPPCSwQdP935QPhEiL+/V28fiY8V9aCuU=;
 b=1Wog4xQvFvAdqhPeUI/mov+gEdLt0o3P6v+EmrJ9NDOHDKWZbi5UQ9kR/pqqfI3L18ZBbe
 k60Hqed1+FMCMc897DAutdqW0/+tXSIpkyn0YOfv0aZdZSLIW1KFPR+zm0elSOz5SYJIB+
 7DfVmT1bz2T5KuIWUd0vxakDPcz5+F0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776933695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dm4xu19sSoPPPCSwQdP935QPhEiL+/V28fiY8V9aCuU=;
 b=QsMfiEANXaO+paAJu8UdozeFoUSMYCtNaAkWtf0f0cQFtQct8Jl8IQzYCxswfJ06XNm3Cl
 FCBrSWL5ZyB346BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBD32593B0;
 Thu, 23 Apr 2026 08:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UF47ND7b6Wl6fgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Apr 2026 08:41:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 10:41:19 +0200
Message-ID: <20260423084123.657690-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423084123.657690-1-pvorel@suse.cz>
References: <20260423084123.657690-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,suse.com,redhat.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 22F9F6A7DE
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/6] lib: Prefer LTP_DEBUG over -D
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
Cc: Martin Cermak <mcermak@redhat.com>
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
Reviewed-by: Li Wang <wangli.ahau@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
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
index c79cabcd7a..12f7489d4e 100644
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
+	{"D::", "-D[1,2]  Prints debug information (can be overwritten by LTP_DEBUG)"},
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
