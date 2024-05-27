Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380F7C25B74
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 20:29:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 683973D047C
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 22:29:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A07B3C62AB
 for <ltp@lists.linux.it>; Mon, 27 May 2024 22:29:03 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 774BE14002BE
 for <ltp@lists.linux.it>; Mon, 27 May 2024 22:29:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 74A191FF2E;
 Mon, 27 May 2024 20:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716841742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bGFqP8S3YMjKhXcbOiQdOH3qRjVIAoKrzf5o6MgkXo=;
 b=I4waPwQdnnSQdMTVSs0MLbno/biMPygWZ+GaXzNvZ2JIk9Fauf57kQYkuWVi8us/jnJZ/6
 p0du6a5lhV9JuBI7k4kp7N94bgAJpBu8beqgNP1mgC5ZwUTYHp2oM5YKKjr68njs+DHzu2
 K43kZao+u4K/z2fgKYsWlhUMzb98bF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716841742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bGFqP8S3YMjKhXcbOiQdOH3qRjVIAoKrzf5o6MgkXo=;
 b=Fk1UWt+VlWilwj+tZYAE2kev9EBxtHcNz8/q1aczqmOaBQZ341c0bRN9Ms+cVUk07bNMnn
 8fBEZy/45nSwzXAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716841742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bGFqP8S3YMjKhXcbOiQdOH3qRjVIAoKrzf5o6MgkXo=;
 b=I4waPwQdnnSQdMTVSs0MLbno/biMPygWZ+GaXzNvZ2JIk9Fauf57kQYkuWVi8us/jnJZ/6
 p0du6a5lhV9JuBI7k4kp7N94bgAJpBu8beqgNP1mgC5ZwUTYHp2oM5YKKjr68njs+DHzu2
 K43kZao+u4K/z2fgKYsWlhUMzb98bF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716841742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bGFqP8S3YMjKhXcbOiQdOH3qRjVIAoKrzf5o6MgkXo=;
 b=Fk1UWt+VlWilwj+tZYAE2kev9EBxtHcNz8/q1aczqmOaBQZ341c0bRN9Ms+cVUk07bNMnn
 8fBEZy/45nSwzXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C37D13A87;
 Mon, 27 May 2024 20:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AO43DA7tVGYUZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 May 2024 20:29:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 May 2024 22:28:58 +0200
Message-ID: <20240527202858.350200-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527202858.350200-1-pvorel@suse.cz>
References: <20240527202858.350200-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.71 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-2.91)[99.64%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tst_test: Don't print hints if failed to acquire
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

It does not make much sense to print hints when it failed to acquire the
device. It can be misleading.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8c212c983..834acda0e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -88,6 +88,9 @@ int TST_ERR;
 int TST_PASS;
 long TST_RET;
 
+static struct tst_device tdev;
+struct tst_device *tst_device;
+
 static void do_cleanup(void);
 static void do_exit(int ret) __attribute__ ((noreturn));
 
@@ -883,7 +886,9 @@ static void do_exit(int ret)
 
 		if (results->broken) {
 			ret |= TBROK;
-			print_failure_hints();
+
+			if (!(tst_test->needs_device && !tdev.dev))
+				print_failure_hints();
 		}
 
 		fprintf(stderr, "\nSummary:\n");
@@ -965,9 +970,6 @@ static const char *get_tid(char *argv[])
 	return argv[0];
 }
 
-static struct tst_device tdev;
-struct tst_device *tst_device;
-
 static void assert_test_fn(void)
 {
 	int cnt = 0;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
