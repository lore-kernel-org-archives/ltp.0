Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1C310A88D4
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 17:05:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A8193CFFB6
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 18:05:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 941253D0E76
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 18:04:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2565920119D
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 18:04:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A4854D496;
 Thu, 26 Mar 2026 17:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774544678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxevyJbcvlMxhZEN9BbOyfEWhnGQs+QpLzeZ41s6LmU=;
 b=SjT+R6fFBkE7+YhT81vozx6pIT04c5CCW38Jwodqco7uauGBkabUQSTJDiREIz6F7u8v/5
 DTQVcfyiUZcxpJjYze5YZmov/i21n2msPlFO6AVRt6dQ1yU+7ux88IeirNQceM8ZFBm2OV
 kMZ9OnvLv7VFcz3SMx08Ceq4vvgXwko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774544678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxevyJbcvlMxhZEN9BbOyfEWhnGQs+QpLzeZ41s6LmU=;
 b=j5tK2/INM6tuzcdOqDnHlqpmxYbKv92YV+kZr1ngZwfc0Gkd4z+EPxak4er4NcUleQh8Xf
 ZB9CXA/GCSlHXiBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SjT+R6fF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="j5tK2/IN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774544678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxevyJbcvlMxhZEN9BbOyfEWhnGQs+QpLzeZ41s6LmU=;
 b=SjT+R6fFBkE7+YhT81vozx6pIT04c5CCW38Jwodqco7uauGBkabUQSTJDiREIz6F7u8v/5
 DTQVcfyiUZcxpJjYze5YZmov/i21n2msPlFO6AVRt6dQ1yU+7ux88IeirNQceM8ZFBm2OV
 kMZ9OnvLv7VFcz3SMx08Ceq4vvgXwko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774544678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxevyJbcvlMxhZEN9BbOyfEWhnGQs+QpLzeZ41s6LmU=;
 b=j5tK2/INM6tuzcdOqDnHlqpmxYbKv92YV+kZr1ngZwfc0Gkd4z+EPxak4er4NcUleQh8Xf
 ZB9CXA/GCSlHXiBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E70264A0A3;
 Thu, 26 Mar 2026 17:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0MpLNyVnxWnqTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 26 Mar 2026 17:04:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Mar 2026 18:04:35 +0100
Message-ID: <20260326170435.22566-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326170435.22566-1-pvorel@suse.cz>
References: <20260326170435.22566-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1A4854D496
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] lib: Prefer LTP_DEBUG over -D
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
Also document it.

Fixes: e434de62b4 ("lib: Extend LTP_ENABLE_DEBUG to support verbosity levels")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/users/setup_tests.rst |  2 +-
 lib/tst_test.c            | 26 ++++++++++++++------------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index a42c397feb..7e7fb9f24c 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -92,7 +92,7 @@ users.
 
    * - LTP_DEBUG
      - Enable debug info (value ``1`` (``y``) or ``2`` for more verbose level).
-       Equivalent of ``-D`` parameter.
+       Equivalent of ``-D`` parameter (but LTP_DEBUG has higher preference).
 
 Test specific environment variables
 -----------------------------------
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 6b41c6e28f..21a299f98f 100644
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
@@ -825,13 +825,15 @@ static void parse_opts(int argc, char *argv[])
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
+			if (!getenv("LTP_DEBUG")) {
+				if (optarg)
+					context->tdebug = SAFE_STRTOL(optarg, 1, 2);
+				else
+					context->tdebug = 1;
+
+				if (context->tdebug)
+					tst_res(TINFO, "Enabling debug info (level %d)", context->tdebug);
+			}
 		break;
 		case 'h':
 			print_help();
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
