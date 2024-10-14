Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3411D1812A
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 16:03:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 587423C6654
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 18:03:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D6C33C1CC0
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 18:02:30 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8FB4920B0D5
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 18:02:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 54BFC1FE62
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728921748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPIqzKCnWmIpJUKsTbMl09MzHKY6JUff8dtjxSoAuas=;
 b=zHHBPjAcDqg9l0jnRwan4hlZ96KdRW2l6ryQ8hOK6iOpQ6q5kfWNz2e7d8GeJwe5WzEjg9
 q2nqA3OXyKTAsAbGiN0Z6GWrkOBh216+O7Bus/nyBl6PnCoZiESn+N2+eapWv4gaUZZf1I
 /RM99fZYngryWiiMaFimJ3yAn6nhU0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728921748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPIqzKCnWmIpJUKsTbMl09MzHKY6JUff8dtjxSoAuas=;
 b=A7fHngvgHGZXb1sP3YSGYYho9NGfa/miS+SYpK6LTNDM0SP+dXyj+fGjppyUHmSxveYhtU
 hqkP2hLEO9rrIKBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728921748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPIqzKCnWmIpJUKsTbMl09MzHKY6JUff8dtjxSoAuas=;
 b=zHHBPjAcDqg9l0jnRwan4hlZ96KdRW2l6ryQ8hOK6iOpQ6q5kfWNz2e7d8GeJwe5WzEjg9
 q2nqA3OXyKTAsAbGiN0Z6GWrkOBh216+O7Bus/nyBl6PnCoZiESn+N2+eapWv4gaUZZf1I
 /RM99fZYngryWiiMaFimJ3yAn6nhU0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728921748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPIqzKCnWmIpJUKsTbMl09MzHKY6JUff8dtjxSoAuas=;
 b=A7fHngvgHGZXb1sP3YSGYYho9NGfa/miS+SYpK6LTNDM0SP+dXyj+fGjppyUHmSxveYhtU
 hqkP2hLEO9rrIKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4642C13A79
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 16:02:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kDnLEJRADWc5BgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 16:02:28 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 14 Oct 2024 18:02:13 +0200
Message-ID: <20241014160217.28824-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241014160217.28824-1-mdoucha@suse.cz>
References: <20241014160217.28824-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] cve-2015-3290: Exit after 1000 failures
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

On some kernels, the new error messages may produce millions of lines
of test output. Limit the maximum number of failures to avoid huge test
logs.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/cve/cve-2015-3290.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index 4185c22a7..3bdc0f8f0 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -178,8 +178,10 @@ static greg_t *csptr(ucontext_t *ctx)
 #endif
 
 #define LDT_SS 0x7
+#define MAX_FAILS 1000
 
 static volatile long expected_rsp;
+static volatile int fail_count;
 static int running = 1;
 
 static void set_ldt(void)
@@ -320,11 +322,13 @@ static void try_corrupt_stack(unsigned short *orig_ss)
 
 	if (!(flags & (1 << 9))) {
 		tst_res(TFAIL, "Interrupt flag is disabled (0x%lx)", flags);
+		fail_count++;
 	}
 
 	if (new_ss != LDT_SS) {
 		tst_res(TFAIL, "Wrong stack selector 0x%lx, expected 0x%x",
 			new_ss, LDT_SS);
+		fail_count++;
 	}
 }
 
@@ -417,6 +421,11 @@ static void *child_thread(void *arg)
 		 * the system.
 		 */
 		syscall(0x3fffffff);
+
+		if (fail_count >= MAX_FAILS) {
+			tst_res(TINFO, "Too many failures, exiting");
+			break;
+		}
 	}
 
 	for (i = 0; i < ARRAY_SIZE(perf_events); i++)
@@ -456,6 +465,9 @@ static void do_child(void)
 	free(orig_ss);
 	free(threads);
 
+	if (fail_count)
+		exit(1);
+
 	tst_res(TPASS, "can't corrupt nested NMI state after %ld iterations",
 		total_iter);
 }
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
