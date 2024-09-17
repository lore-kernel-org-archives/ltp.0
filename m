Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE4FC35FF3
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 08:27:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0552E3C2E00
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 10:27:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10CC63C1BD4
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 10:26:56 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 145761A00706
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 10:26:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D447E2001D
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 08:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726561615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oFPXanDPLGcLTKP4jM1VK+zpuej8nZgfWZDb3PQ1mr4=;
 b=GfcgW/unNqiSf4q7ZXw0z62I/efNKKhYUFq0OzS9mE2Bk7tPJQg4SyrKDdr05JGmXx1fwi
 j0+aMuqvvTzamS1w3XIzkJGEQYp8ciodMzeCRX1gGfQkP8OPSseN8Pyj6buWySyFd959DT
 AKENg2WM2OQFuzZTnphEx3t/+QAHaLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726561615;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oFPXanDPLGcLTKP4jM1VK+zpuej8nZgfWZDb3PQ1mr4=;
 b=GxBgaKY8DPhw4+kvyLQ8HHnpa+ri8CTs4ZuAmnBuVdFX6/ZLZigsiRgkhn8xs2JKVgQGho
 0RaxddzqEIZ7RtBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726561614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oFPXanDPLGcLTKP4jM1VK+zpuej8nZgfWZDb3PQ1mr4=;
 b=SiqCV2dgO013pMEmJzm993GmTGJITpfnpFk1Vr9gaBpG/B16t/vbDCbLDqS+2ymGkDrbat
 /jG21eLoX7VveJGst8NV/DTEMXyNKYyhl+PXmNiSfN4Wl5mobfvtz5A3rMv9Ny+5PWkHJP
 3iTAr7DQNalI3p9PxaM6bQgCkWAUd+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726561614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oFPXanDPLGcLTKP4jM1VK+zpuej8nZgfWZDb3PQ1mr4=;
 b=VuRCnabHxK21jkFl2lAXJa+DooE/kRdqJz8hiCrZr68Uv5aiwNiaY9/218noYePz0kqReG
 KMj637eaIFJpamAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4CFA13AB6
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 08:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GT4dL0496WZHUAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 08:26:54 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 17 Sep 2024 10:25:43 +0200
Message-ID: <20240917082543.27125-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Disable failure hints before we actually run the test
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

This is patch based on a suggestion from Peter Vorel:

http://patchwork.ozlabs.org/project/ltp/patch/20240527202858.350200-2-pvorel@suse.cz/

Peter proposed not to print failure hints (the tags) if we fail to
acquire the device. This patch extends it for the whole test library
intialization and enables the failure hints right before we jump into
the test function.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 918bee2a1..3a71330b8 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -899,6 +899,8 @@ static void print_failure_hint(const char *tag, const char *hint,
 	}
 }
 
+static int show_failure_hints;
+
 /* update also docparse/testinfo.pl */
 static void print_failure_hints(void)
 {
@@ -919,7 +921,8 @@ static void do_exit(int ret)
 
 		if (results->failed) {
 			ret |= TFAIL;
-			print_failure_hints();
+			if (show_failure_hints)
+				print_failure_hints();
 		}
 
 		if (results->skipped && !results->passed)
@@ -930,7 +933,8 @@ static void do_exit(int ret)
 
 		if (results->broken) {
 			ret |= TBROK;
-			print_failure_hints();
+			if (show_failure_hints)
+				print_failure_hints();
 		}
 
 		fprintf(stderr, "\nSummary:\n");
@@ -1871,6 +1875,8 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	if (tst_test->test_variants)
 		test_variants = tst_test->test_variants;
 
+	show_failure_hints = 1;
+
 	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
 		if (tst_test->all_filesystems || count_fs_descs() > 1)
 			ret |= run_tcases_per_fs();
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
