Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDF4CDB47C
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:21:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 863533E61F5
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:21:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4DCC3E533C
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7003F2005FE
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB5F576128
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGUUHAvMqclw3oP/1j66Awfrc+uQjYU8Sr4iLGkjfRQ=;
 b=WI80SWfkcqhGMtL36Sft8Gjc2qYTSow0ns/fshTM6sQs5FTzNG/oRzmzBHEW3U8VDZ4yIb
 wETH3OJDL/FU2dmp3FFcT+y98V0jk81N3CwOS2aPpevbJB+kmjvUgobB82rdVROClmXtmd
 Da4MitLFRvq57qtESrNW1ZigBE+GT1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGUUHAvMqclw3oP/1j66Awfrc+uQjYU8Sr4iLGkjfRQ=;
 b=ifkYphcjGiCPqAw8rs3GH65BL86c8TK/bn4Q9YbqBAnYhPLhMJEvWGbEJ8u7iWMeRIGYwA
 7GtAL5k+Erj92gDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGUUHAvMqclw3oP/1j66Awfrc+uQjYU8Sr4iLGkjfRQ=;
 b=P8TZEW5AmEFtP7Red9ZFctd6e9AJ/aTPU0XBd86E/JWJ9jj3obG9RbsyKTlW19+NMRvEXC
 1BHpStqr+R1CGeg6f33OnQD1rbKEHJE8v2+DBmgxDq+gS6CO6W/LV5+rfetTsjXnG5VPlm
 BVBfJqyVqOnaBUSj0PlZsMRNAKU3QX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGUUHAvMqclw3oP/1j66Awfrc+uQjYU8Sr4iLGkjfRQ=;
 b=ZLeSyHtaB5VrB5J44YPWbKTiiD0/VitBRec1cBiZiv1HWFYySyDmmCpEirtjxVsNfjNce+
 j5nZK+ZHr8rq9OCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFC17779B2
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QxZdNQehO2pXAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:03 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:18:55 +0200
Message-ID: <20260624091900.4107041-9-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624091900.4107041-1-chrubis@suse.cz>
References: <20260624091900.4107041-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 08/13] lib: tst_test: Move the iterations to struct
 tst_test
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

This allows us to set the default number of iterations in the tst_test
structure.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h | 4 ++++
 lib/tst_test.c     | 8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 4afe4cbe0..6befb7787 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -478,6 +478,9 @@ struct tst_fs {
  *           probabilistic or fuzzy synchronization tests).
  *           If not set, a default minimum of 1 second is enforced.
  *
+ * @iterations: The default value for the number of test iterations, i.e. the
+ *               -i command line parameter.
+ *
  * @setup: Setup callback is called once at the start of the test in order to
  *         prepare the test environment.
  *
@@ -608,6 +611,7 @@ struct tst_fs {
 	int timeout;
 	int runtime;
 	int min_runtime;
+	unsigned int iterations;
 
 	void (*setup)(void);
 	void (*cleanup)(void);
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 5c3607016..e1166c0c6 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -64,7 +64,6 @@ const char *TCID __attribute__((weak));
 struct tst_test *tst_test;
 
 static const char *tcid;
-static int iterations = 1;
 static float duration = -1;
 static float timeout_mul = -1;
 static int reproducible_output;
@@ -834,7 +833,7 @@ static void parse_opts(int argc, char *argv[])
 			print_test_tags();
 			exit(0);
 		case 'i':
-			iterations = SAFE_STRTOL(optarg, 0, INT_MAX);
+			tst_test->iterations = SAFE_STRTOL(optarg, 0, UINT_MAX);
 		break;
 		case 'I':
 			if (tst_test->runtime > 0)
@@ -1484,6 +1483,9 @@ static void do_setup(int argc, char *argv[])
 		}
 	}
 
+	if (tst_test->iterations == 0)
+		tst_test->iterations = 1;
+
 	if (tst_test->mount_device)
 		tst_test->format_device = 1;
 
@@ -1770,7 +1772,7 @@ static void testrun(void)
 	for (;;) {
 		cont = 0;
 
-		if (i < (unsigned int)iterations) {
+		if (i < tst_test->iterations) {
 			i++;
 			cont = 1;
 		}
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
