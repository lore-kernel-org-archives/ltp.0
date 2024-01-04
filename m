Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15A1C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 12:23:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CB413CE6EF
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 13:23:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADECA3CE6DE
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:23:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 21BCB6008A3
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:23:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A18C1F806;
 Thu,  4 Jan 2024 12:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704370994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edUJ8ioNT61j38ZpfNzDVgPr1gBmH/mjbmDAhNxPf6M=;
 b=3FlclmYR0CBdkdB3w6qu+6hOA3L1pr+vHd0ZluzZ1FAqJM0TRXyJeBIHHwFs/UCcjLZM+G
 JH5vkGYLvy7s9dl6y2SJ726XEEd/bm6RMBwX26PIF7GErRAS8C7VI7pJV4sI3s5Bl/pFMG
 cr4kBYT6tnpsWAZIf0xJ8C1sT5aC7mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704370994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edUJ8ioNT61j38ZpfNzDVgPr1gBmH/mjbmDAhNxPf6M=;
 b=bK20Gj+Fc7cKH7TMvBib+qsvyZg7lT7Q9PsybbJf7RFOdiyj2l9PDZ62znhUYURltDXX82
 SrRL2IY0FCzfXLBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704370994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edUJ8ioNT61j38ZpfNzDVgPr1gBmH/mjbmDAhNxPf6M=;
 b=3FlclmYR0CBdkdB3w6qu+6hOA3L1pr+vHd0ZluzZ1FAqJM0TRXyJeBIHHwFs/UCcjLZM+G
 JH5vkGYLvy7s9dl6y2SJ726XEEd/bm6RMBwX26PIF7GErRAS8C7VI7pJV4sI3s5Bl/pFMG
 cr4kBYT6tnpsWAZIf0xJ8C1sT5aC7mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704370994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edUJ8ioNT61j38ZpfNzDVgPr1gBmH/mjbmDAhNxPf6M=;
 b=bK20Gj+Fc7cKH7TMvBib+qsvyZg7lT7Q9PsybbJf7RFOdiyj2l9PDZ62znhUYURltDXX82
 SrRL2IY0FCzfXLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8D6F13C96;
 Thu,  4 Jan 2024 12:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UH2SNjGjlmUVFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 12:23:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 13:23:06 +0100
Message-ID: <20240104122308.1158487-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104122308.1158487-1-pvorel@suse.cz>
References: <20240104122308.1158487-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lib: Use LTP_ prefix for LTP_ENABLE_DEBUG variable
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

Variables which are supposed to be user defined should use LTP_ prefix
instead of TST_ prefix.

Fixes: 018f555a4 ("lib: Add support for TDEBUG tst_res() flag")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/C-Test-API.asciidoc          | 2 +-
 doc/User-Guidelines.asciidoc     | 2 +-
 lib/newlib_tests/tst_res_flags.c | 2 +-
 lib/tst_test.c                   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
index 979ec5ccf..db16be36e 100644
--- a/doc/C-Test-API.asciidoc
+++ b/doc/C-Test-API.asciidoc
@@ -227,7 +227,7 @@ Printf-like function to report test result, it's mostly used with ttype:
 | 'TPASS'  | Test has passed.
 | 'TFAIL'  | Test has failed.
 | 'TINFO'  | General message.
-| 'TDEBUG' | Debug message (new C API only, printed with '-D' or via 'TST_ENABLE_DEBUG=1' or 'y'
+| 'TDEBUG' | Debug message (new C API only, printed with '-D' or via 'LTP_ENABLE_DEBUG=1' or 'y'
              environment variable), only for messages which would be too verbose for normal run.
 | 'TWARN'  | Something went wrong but we decided to continue. Mostly used in cleanup functions.
 |==============================
diff --git a/doc/User-Guidelines.asciidoc b/doc/User-Guidelines.asciidoc
index 9c6cb2fe7..cff2e83c8 100644
--- a/doc/User-Guidelines.asciidoc
+++ b/doc/User-Guidelines.asciidoc
@@ -41,7 +41,7 @@ For running LTP network tests see `testcases/network/README.md`.
                           and others, which imply it, shell: 'TST_NEEDS_TMPDIR=1').
                           Must be an absolute path (default: '/tmp').
 | 'TST_NO_CLEANUP'      | Disable running test cleanup (defined in 'TST_CLEANUP').
-| 'TST_ENABLE_DEBUG'    | Enable debug info (value '1' or 'y').
+| 'LTP_ENABLE_DEBUG'    | Enable debug info (value '1' or 'y').
 |==============================================================================
 
 
diff --git a/lib/newlib_tests/tst_res_flags.c b/lib/newlib_tests/tst_res_flags.c
index b104808d7..a14f0df2c 100644
--- a/lib/newlib_tests/tst_res_flags.c
+++ b/lib/newlib_tests/tst_res_flags.c
@@ -21,7 +21,7 @@ static struct tcase {
 	{FLAG(TCONF)},
 	{FLAG(TWARN)},
 	{FLAG(TINFO)},
-	{FLAG(TDEBUG), " (printed only with -D or TST_ENABLE_DEBUG=1)"},
+	{FLAG(TDEBUG), " (printed only with -D or LTP_ENABLE_DEBUG=1)"},
 };
 
 static void do_cleanup(void)
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 629610781..bcf2c4555 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1149,7 +1149,7 @@ static void do_cgroup_requires(void)
 
 static void do_setup(int argc, char *argv[])
 {
-	char *tdebug_env = getenv("TST_ENABLE_DEBUG");
+	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
 
 	if (!tst_test)
 		tst_brk(TBROK, "No tests to run");
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
