Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB34C79F9F
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 14:55:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EC153C2909
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 15:55:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 036A83C27C6
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 15:55:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4C40414000A9
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 15:55:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 894035BE58;
 Mon,  5 Jan 2026 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767624923;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFRDtXfXaqVhtYbWt/7Flm4eWqHmhhFbnrTTaGZ/97g=;
 b=YUijzZCA1dEMWD94hScos39OnD9CyVtMbOl12pLua8xH4rqizTYpiKhqJzdPHA11mI65nD
 fyI8ZBdVyBqQo5ijxru0H+jqcYVqtYbj+MEZ38ymuY8P824huZG1BBYtFwXkaKXgMu6bt1
 KZHx7O6Cy9U7ZhqLgQutt116M24iPSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767624923;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFRDtXfXaqVhtYbWt/7Flm4eWqHmhhFbnrTTaGZ/97g=;
 b=+vclzf1mH0yPnX1BUq4F6rc40wqD0/Ty8Nwo5ouXqVUN0fiTizeJJoNQcwykrMIDud7Xb+
 94FLTePQL3AQpVBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YUijzZCA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+vclzf1m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767624923;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFRDtXfXaqVhtYbWt/7Flm4eWqHmhhFbnrTTaGZ/97g=;
 b=YUijzZCA1dEMWD94hScos39OnD9CyVtMbOl12pLua8xH4rqizTYpiKhqJzdPHA11mI65nD
 fyI8ZBdVyBqQo5ijxru0H+jqcYVqtYbj+MEZ38ymuY8P824huZG1BBYtFwXkaKXgMu6bt1
 KZHx7O6Cy9U7ZhqLgQutt116M24iPSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767624923;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFRDtXfXaqVhtYbWt/7Flm4eWqHmhhFbnrTTaGZ/97g=;
 b=+vclzf1mH0yPnX1BUq4F6rc40wqD0/Ty8Nwo5ouXqVUN0fiTizeJJoNQcwykrMIDud7Xb+
 94FLTePQL3AQpVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6757313964;
 Mon,  5 Jan 2026 14:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cNwQGNvQW2mDDAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Jan 2026 14:55:23 +0000
Date: Mon, 5 Jan 2026 15:55:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260105145522.GI654507@pevik>
References: <20250225114418.2940134-1-pvorel@suse.cz>
 <DF1CKZZ341NH.2FBK1TT6JU5Y6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DF1CKZZ341NH.2FBK1TT6JU5Y6@suse.com>
X-Rspamd-Queue-Id: 894035BE58
X-Spamd-Result: default: False [-2.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_HAS_CURRENCY(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] tst_test: Add $LTP_SINGLE_ITERATION to
 limit variant
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!

> I was re-checking this implementation and it looks a bit different than
> what I was expecting. I probably misunderstood the first version.

> I was wondering if it's possible to select a specific variant inside
> the variants list, but this patch seems to start from the one we select
> until the end.

It's really as we discussed, only single variant is selected:

+	*last_variant = *first_variant + 1;

$ LTP_SINGLE_VARIANT=5 ./lib/newlib_tests/test_fail_variant
...
tst_test.c:1857: TINFO: Overall timeout per run is 0h 00m 30s
tst_test.c:2034: TINFO: WARNING: testing only variant 5 of 9
tst_test.c:2068: TINFO: ===== Testing tst_variant: 5 =====
test_fail_variant.c:13: TFAIL: Failing a test variant

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0

And with master is:

$ LTP_SINGLE_VARIANT=5 ./lib/newlib_tests/test_fail_variant
...
tst_test.c:1856: TINFO: Overall timeout per run is 0h 00m 30s
test_fail_variant.c:13: TFAIL: Failing a test variant
test_fail_variant.c:13: TFAIL: Failing a test variant
test_fail_variant.c:13: TFAIL: Failing a test variant
test_fail_variant.c:13: TFAIL: Failing a test variant
test_fail_variant.c:13: TFAIL: Failing a test variant
test_fail_variant.c:13: TFAIL: Failing a test variant
test_fail_variant.c:13: TFAIL: Failing a test variant
test_fail_variant.c:13: TFAIL: Failing a test variant
test_fail_variant.c:13: TFAIL: Failing a test variant
test_fail_variant.c:13: TFAIL: Failing a test variant

Summary:
passed   0
failed   10
broken   0
skipped  0
warnings 0

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
