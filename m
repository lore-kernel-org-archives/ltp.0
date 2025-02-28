Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87BEC282C1
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 17:25:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F6323C9E9D
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 18:25:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D34273C9E90
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 18:24:46 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1108C1425B56
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 18:24:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A284D2115A;
 Fri, 28 Feb 2025 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740763484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Va4bn1snZleqRyy5b77QALH3ZaH/cTdS6dh+AuIf21g=;
 b=K/y6XEuwjAPm4eWKhn0VCIbk1XqRSipXodfH2qOU83Thw8BlF643VpRDJparXSlD15Zcq+
 veDcnyq5tJuwt0TJe1NqOmdzUuw9iRV/Z3kI+ninnrupskkc1Fz9zd4e4q8YJUhYcafp8T
 Vm2nv77gm5aPPUnGTA9rNsg3kCk/jfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740763484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Va4bn1snZleqRyy5b77QALH3ZaH/cTdS6dh+AuIf21g=;
 b=Z6683YqGvaYo4kLNAbrrYWAsfwdO88L1B2/jBw4YD5qqPmgGp6vaiF1xdrM3LMhBNrcDF0
 PAz5o75xMQJQ8uCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740763483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Va4bn1snZleqRyy5b77QALH3ZaH/cTdS6dh+AuIf21g=;
 b=C/zF0sucD93s/GV0dt2lI2QKW35/nUxwROMTP1S5v1KaUTyibuYWnJwAEXswsNQfapgmMr
 br2v2APgWESl6zPMXoiutTYuP9rth5GMf/iBD71O7gvv9e5xxFI4wDC+xf3Y45FJ+3B377
 IVeYX4Y+ecCymr6EtZBPi/UFJj7of/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740763483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Va4bn1snZleqRyy5b77QALH3ZaH/cTdS6dh+AuIf21g=;
 b=RUp8KN5KJFvfllszJwYTM7zCJvt5BpMfVJRuN8eNVI+byG0MUCXuem7rMPLtEzxh0m7lJh
 3sksILIhWO5qiMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D20B1344A;
 Fri, 28 Feb 2025 17:24:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +KwTFVvxwWeQcQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Feb 2025 17:24:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Feb 2025 18:24:35 +0100
Message-ID: <20250228172439.3276777-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250228172439.3276777-1-pvorel@suse.cz>
References: <20250228172439.3276777-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 2/5] lib: Allow test to have positional args
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

Similar to $TST_POS_ARGS in shell API. This will be used in
testcases/lib/tst_run_shell.c.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I'm not really sure if this is a good approach.
But bounding the +1 value to .runs_script does not look to me good
either.

 doc/developers/writing_tests.rst | 2 +-
 include/tst_test.h               | 5 ++++-
 lib/tst_test.c                   | 9 +++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 9b18ec059c..f5796ddc49 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -521,7 +521,7 @@ LTP C And Shell Test API Comparison
     * - not applicable
       - TST_NEEDS_MODULE
 
-    * - not applicable
+    * - .pos_args (internal use for tst_run_shell.c)
       - TST_POS_ARGS
 
     * - not applicable
diff --git a/include/tst_test.h b/include/tst_test.h
index eb73cd593c..b249f833ab 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -292,8 +292,11 @@ struct tst_fs {
  *
  * @tcnt: A number of tests. If set the test() callback is called tcnt times
  *        and each time passed an increasing counter value.
+ *
  * @options: An NULL optstr terminated array of struct tst_option.
  *
+ * @pos_args: An number of positional parameters passed to tst_run_shell.c.
+ *
  * @min_kver: A minimal kernel version the test can run on. e.g. "3.10".
  *
  * @supported_archs: A NULL terminated array of architectures the test runs on
@@ -528,6 +531,7 @@ struct tst_fs {
 	unsigned int tcnt;
 
 	struct tst_option *options;
+	int pos_args;
 
 	const char *min_kver;
 
@@ -555,7 +559,6 @@ struct tst_fs {
 	unsigned int skip_in_secureboot:1;
 	unsigned int skip_in_compat:1;
 
-
 	int needs_abi_bits;
 
 	unsigned int needs_hugetlbfs:1;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 3823ea109e..1c2cc5e3b2 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -711,6 +711,9 @@ static void parse_opts(int argc, char *argv[])
 
 	check_option_collision();
 
+	if (tst_test->pos_args < 0)
+		tst_brk(TBROK, ".pos_args must be >= 0");
+
 	optstr[0] = 0;
 
 	for (i = 0; i < ARRAY_SIZE(options); i++)
@@ -751,8 +754,10 @@ static void parse_opts(int argc, char *argv[])
 		}
 	}
 
-	if (optind < argc)
-		tst_brk(TBROK, "Unexpected argument(s) '%s'...", argv[optind]);
+	if (optind + tst_test->pos_args < argc) {
+		tst_brk(TBROK, "Unexpected argument(s) '%s' (%d + %d < %d)",
+			argv[optind], optind, tst_test->pos_args, argc);
+	}
 }
 
 int tst_parse_int(const char *str, int *val, int min, int max)
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
