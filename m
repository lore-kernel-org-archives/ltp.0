Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13763CDB47C
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:20:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CF4D3E5345
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:20:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD7F93E5353
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C06E6200ACD
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E35AA76129
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MiOHMOOfT0RGA1oDoSFu+Qq6o8Qf1Sa6avFv+kOYfg=;
 b=lEcEluCD5rUXP1ojlSKsX9nDq/m2XvvzAXbVhxqFfE41Zpskx1uuVnKVc546/XK/NDvfZ9
 Y54zPzxfxP5aKimw9DIBFwgklwuoUojUMJ6Ckvplo/6KVQat+lML4KvjxlVGtdjEVqRlwF
 +PMls36Vrp5NtyosYwlZ31lMNvxI+b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MiOHMOOfT0RGA1oDoSFu+Qq6o8Qf1Sa6avFv+kOYfg=;
 b=G+TFTEW8zrEXvDp8LKgVxQ08BnR/FUs49vkcDg9UVvDcF0Il+9lVsbDVQK5Y36l0d9JQlG
 HYlUaGIOENrPJAAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MiOHMOOfT0RGA1oDoSFu+Qq6o8Qf1Sa6avFv+kOYfg=;
 b=lEcEluCD5rUXP1ojlSKsX9nDq/m2XvvzAXbVhxqFfE41Zpskx1uuVnKVc546/XK/NDvfZ9
 Y54zPzxfxP5aKimw9DIBFwgklwuoUojUMJ6Ckvplo/6KVQat+lML4KvjxlVGtdjEVqRlwF
 +PMls36Vrp5NtyosYwlZ31lMNvxI+b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MiOHMOOfT0RGA1oDoSFu+Qq6o8Qf1Sa6avFv+kOYfg=;
 b=G+TFTEW8zrEXvDp8LKgVxQ08BnR/FUs49vkcDg9UVvDcF0Il+9lVsbDVQK5Y36l0d9JQlG
 HYlUaGIOENrPJAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E9E2779B3
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xe1tEQihO2pZAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:04 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:18:56 +0200
Message-ID: <20260624091900.4107041-10-chrubis@suse.cz>
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
Subject: [LTP] [PATCH 09/13] syscalls/setsockopt08: Add .iterations = 100
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

This moves the number of iterations from the cve runtest file to the
actual test. This unifies the test default settings across different
runtest files since the number of iterations is now encoded in the test
rather than in the runtest file.

The reason I moved the iterations into the test is that if we need 100
iterations to reproducibly trigger the bug it does not make much sense
to run only single iteration in the syscalls runtest file.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/cve                                         | 2 +-
 testcases/kernel/syscalls/setsockopt/setsockopt08.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/runtest/cve b/runtest/cve
index ca9994868..5f29d1686 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -77,7 +77,7 @@ cve-2021-4034 execve06
 cve-2021-4197_1 cgroup_core01
 cve-2021-4197_2 cgroup_core02
 cve-2021-4204 bpf_prog06
-cve-2021-22555 setsockopt08 -i 100
+cve-2021-22555 setsockopt08
 cve-2021-26708 vsock01
 cve-2021-22600 setsockopt09
 cve-2021-38604 mq_notify03
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index 2578638df..5b324cb46 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -146,6 +146,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.forks_child = 1,
+	.iterations = 100,
 	.bufs = (struct tst_buffers []) {
 		{&buffer, .size = 2048},
 		{},
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
