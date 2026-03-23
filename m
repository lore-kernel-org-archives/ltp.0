Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E82EF483F8
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 21:08:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D0213E61D0
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 22:08:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B8A43E2B23
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 22:08:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CEE0A600AC7
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 22:08:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43F6C4D3A0;
 Mon, 23 Mar 2026 21:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774300090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GT2umCe5R2zd6Wy9Pv6+4v7nrAf/prFY5X1HWWRUK4Q=;
 b=oDe4R62Zocj0uQuWX1z2i5zGXj924TZFKuoJpMxYanye3Av/9kY1nEYYGAyTxkjPeFDcqs
 8nX1iV5gfN6ZUPntykKWuDrIuPPd/rpL6YrqRjn/BR8rMEcFrGyL0vTmlqpw0GMLCp7uzz
 3X25ADTpx3Ko4SRecprbOkpFnKrsSIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774300090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GT2umCe5R2zd6Wy9Pv6+4v7nrAf/prFY5X1HWWRUK4Q=;
 b=8FFkdLt2yfPYy4dVeVw6h55wa7oyD+Cw1n4XFX11E9Cs67qpjgRBZkHNEkDWOfJr1er+Bd
 e2LCHviPzJOGR1Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774300090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GT2umCe5R2zd6Wy9Pv6+4v7nrAf/prFY5X1HWWRUK4Q=;
 b=oDe4R62Zocj0uQuWX1z2i5zGXj924TZFKuoJpMxYanye3Av/9kY1nEYYGAyTxkjPeFDcqs
 8nX1iV5gfN6ZUPntykKWuDrIuPPd/rpL6YrqRjn/BR8rMEcFrGyL0vTmlqpw0GMLCp7uzz
 3X25ADTpx3Ko4SRecprbOkpFnKrsSIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774300090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GT2umCe5R2zd6Wy9Pv6+4v7nrAf/prFY5X1HWWRUK4Q=;
 b=8FFkdLt2yfPYy4dVeVw6h55wa7oyD+Cw1n4XFX11E9Cs67qpjgRBZkHNEkDWOfJr1er+Bd
 e2LCHviPzJOGR1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A15A43A98;
 Mon, 23 Mar 2026 21:08:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id amleBbqrwWlhPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 23 Mar 2026 21:08:10 +0000
From: Petr Vorel <pvorel@suse.cz>
To: valgrind-developers@lists.sourceforge.net
Date: Mon, 23 Mar 2026 22:08:05 +0100
Message-ID: <20260323210805.20929-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] LTP tests: Run without
 LTP_REPRODUCIBLE_OUTPUT=1
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
Cc: Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP_REPRODUCIBLE_OUTPUT=1 environment variable was added in 5894abc5f to
help valgrind to use LTP for testing. It discards the actual content of
the messages printed by the test (removes everything after printing
TINFO/TPASS/TFAIL/...  flag).

Later LTP_QUIET=1 was added which suppresses printing TCONF, TWARN,
TINFO, and TDEBUG messages. Therefore LTP_REPRODUCIBLE_OUTPUT=1 is not
needed any more.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Dan,

is it ok to remove LTP_REPRODUCIBLE_OUTPUT=1 from your tooling? Feel
free shout if it's needed/useful. If you delete it, I'd then send patch
to delete it from LTP.

Kind regards,
Petr

 auxprogs/ltp-tester.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/auxprogs/ltp-tester.sh b/auxprogs/ltp-tester.sh
index a95c603c5..077304967 100755
--- a/auxprogs/ltp-tester.sh
+++ b/auxprogs/ltp-tester.sh
@@ -20,7 +20,6 @@ PARALLEL_JOBS=${PARALLEL_JOBS:-$(nproc)}
 # Configure the LTP testsuite behavior per
 # https://lore.kernel.org/ltp/20250505195003.GB137650@pevik/T/#t
 export LTP_COLORIZE_OUTPUT=0
-export LTP_REPRODUCIBLE_OUTPUT=1
 export LTP_QUIET=1
 
 # Initialize LOGDIR for bunsen upload (https://sourceware.org/bunsen/)
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
