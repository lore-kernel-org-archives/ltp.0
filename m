Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B241FC88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:08:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 132073E8C54
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:08:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D616B3E7D54
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D6F17600953
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B1C3421DC3;
 Wed, 16 Sep 2026 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vyVAItora3zqBp7wxj6OxN1rL4Hag0m4BHFD3vGCQsw=;
 b=qiydv1M6FcUYitQz6z4gKQhRxN1o6q3fmIr3otEkzKCSppPuRT8mO6GOa+b1lrLX6bzDZm
 JXGwIYVFGgdrm+p5AxL9drDlkn0X2x2/mtFCcyNH0AEmwXfs32Svf1RVkWN+hHr5CdX5UH
 yarJxpLH5lQnNkjiFxldDM65BFXp7Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vyVAItora3zqBp7wxj6OxN1rL4Hag0m4BHFD3vGCQsw=;
 b=pQmpZKqB8YQgeuNw1xY3Z15KBHmkrOM7hu3PsYaFA/REn7FszhK63ny1zIj5lxVofac2bP
 w+P6nBTRGbMLNbCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vyVAItora3zqBp7wxj6OxN1rL4Hag0m4BHFD3vGCQsw=;
 b=m82h7MvDoXw6zLX3CUfjhHJ8oMhquI8R8g10iJ2rpALAXe7WAtWJi84GqzsVoZl9M6CslZ
 bPKQmNFb1bJ2zFM795XrKt9NyJX6VrxZBFOdB4hTJAi866QYuy/ZUOR6sqlQzvUfLKkg2I
 uU9NlbjhJHCDguuf9ZFJCI4YiJqYxJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vyVAItora3zqBp7wxj6OxN1rL4Hag0m4BHFD3vGCQsw=;
 b=6/VQfr1Em8PnQK2c/f8czOlS7iusg8t9KTiAFNI5i6h4wRd1K3GHfq1+LaKanwEK9zJrqe
 trc7OZ3cWZ9mF8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DFF2139AF;
 Wed, 16 Sep 2026 14:04:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T18
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:43 +0200
Message-ID: <20260916140402.1797325-18-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.994];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 17/36] lib: tst_test: Move the iterations to struct
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

From: Cyril Hrubis <chrubis@suse.cz>

This allows us to set the default number of iterations in the tst_test
structure.

Link: https://lore.kernel.org/ltp/20260624091900.4107041-9-chrubis@suse.cz/
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_test.h | 4 ++++
 lib/tst_test.c     | 8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 53f58180f6..80b46f9b1e 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -479,6 +479,9 @@ struct tst_fs {
  *           probabilistic or fuzzy synchronization tests).
  *           If not set, a default minimum of 1 second is enforced.
  *
+ * @iterations: The default value for the number of test iterations, i.e. the
+ *              -i command line parameter.
+ *
  * @setup: Setup callback is called once at the start of the test in order to
  *         prepare the test environment.
  *
@@ -609,6 +612,7 @@ struct tst_fs {
 	int timeout;
 	int runtime;
 	int min_runtime;
+	unsigned int iterations;
 
 	void (*setup)(void);
 	void (*cleanup)(void);
diff --git a/lib/tst_test.c b/lib/tst_test.c
index f3f72141b0..2b38d0063d 100644
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
@@ -1502,6 +1501,9 @@ static void do_setup(int argc, char *argv[])
 		}
 	}
 
+	if (tst_test->iterations == 0)
+		tst_test->iterations = 1;
+
 	if (tst_test->mount_device)
 		tst_test->format_device = 1;
 
@@ -1788,7 +1790,7 @@ static void testrun(void)
 	for (;;) {
 		cont = 0;
 
-		if (i < (unsigned int)iterations) {
+		if (i < tst_test->iterations) {
 			i++;
 			cont = 1;
 		}
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
