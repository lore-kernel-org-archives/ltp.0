Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB7CC88E4C
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D49C93E91FD
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 11:11:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBCE23E53C2
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 11:11:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 379F3140013A
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 11:11:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A90BF1FD88;
 Fri, 11 Sep 2026 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789117891;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9lZKdWkNhyYtT7smFJGmG6Cr4u2nPJ1gD+o2QSFH2Gs=;
 b=o65XkGJnNoKQbAh+UgeSS4ewGcVBk3ycxSCUwNDZK1SQ2Lw/cQRx3BwzlzmcxD8nQBoZLE
 F6wLUQdiCBQJJO8OYJwA3c5zVqtS/9dkvuy36eo1PIjw6/o6gIe1QFYkhNqmw3NqbdbZbE
 ZTKXSxq6TSUGDq/5EOUxCGCWBTfkPrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789117891;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9lZKdWkNhyYtT7smFJGmG6Cr4u2nPJ1gD+o2QSFH2Gs=;
 b=0taiKzFzfDh1W13yfcpA5OjIpCVFJjM2tMx6qXnFliYdFpzxFpTi3wNkMag5NJIFKJAW98
 QFrrdZ8p7unhLBCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LPVR98W1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=j+X4cQA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789117887;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9lZKdWkNhyYtT7smFJGmG6Cr4u2nPJ1gD+o2QSFH2Gs=;
 b=LPVR98W1xv7fNHmWQcDOP1wOiTBRyV3aFer5/alXT2zYnCrsrMTA/JbhxNlDUrd1/KveXh
 TH1WngBTVDQvPOtwcrGROIH1D6D9CpAD7nKkhRonieckGK0N1w0AtQ97pqpycetcxrtRSV
 OV2KDLZm3NEfkQOXZwfW96tJ/iRwPG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789117887;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9lZKdWkNhyYtT7smFJGmG6Cr4u2nPJ1gD+o2QSFH2Gs=;
 b=j+X4cQA9YOekmKhX/6sXHuID0D9uqcYNtz1P15Hweyk7biRjRi5nTTb6KVVQM+2iTKN+j7
 QiB79RH97QxE1RAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B2B813715;
 Fri, 11 Sep 2026 09:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kgxFGb/Fo2rNMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 09:11:27 +0000
Date: Fri, 11 Sep 2026 11:11:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260911091110.GB1435339@pevik>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-7-43b78b15ef9f@suse.com>
 <aqO53U7noZHaIDj1@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aqO53U7noZHaIDj1@yuki.lan>
X-Rspamd-Queue-Id: A90BF1FD88
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 07/33] keyctl15: Test KEYCTL_GET_SECURITY label
 retrieval
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > +static void run(void)
> > +{
> > +	memset(buf, 0, sizeof(buf));
> > +
> > +	TEST(keyctl(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0));
> > +	if (TST_RET < 0)
> > +		tst_brk(TBROK | TTERRNO, "KEYCTL_GET_SECURITY failed");
> > +
> TST_EXP_POSITIVE()?

Well, it would not help much because Andrea wanted to use tst_brk().
I've been thinking for a while to add TST_EXP_*_BRK() variants.

Therefore it would need to check the result anyway:

TST_EXP_POSITIVE(keyctl(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0));
if (TST_PASS)
	tst_brk(TBROK | TTERRNO, "KEYCTL_GET_SECURITY failed");

(And I ignore that we don't have TST_EXP_POSITIVE_SILENT() and probably we don't
want to call TST_EXP_POSITIVE_() to make it quiet on TPASS).

Kind regards,
Petr

> > +	if (TST_RET < 1) {
> > +		tst_res(TFAIL, "returned %ld, expected at least 1", TST_RET);
> > +		return;
> > +	}
> > +	if (TST_RET == 1) {
> > +		if (buf[0] != '\0') {
> > +			tst_res(TFAIL, "empty label is not NUL terminated");
> > +			return;
> > +		}
> > +
> > +		tst_res(TPASS, "no label set, empty string returned");
> > +		return;
> > +	}

> Is the string supposed to be null terminated? Shouldn't we just check
> that the is null at the end regardless the length (we fail the test if <
> 1 either way)?

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
