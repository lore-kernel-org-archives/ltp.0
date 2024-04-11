Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD02CD128A
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 10:43:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20DC63CF7E1
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 12:43:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63C373C0F54
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 12:43:11 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AAE5C1009BEC
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 12:43:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 80FAA22BDF;
 Thu, 11 Apr 2024 10:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712832189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDJmwU+S5ezoiEhcVBHWZRTLmH2xeZCqup48pceSj1w=;
 b=e/DYP+l8sqeWHg/hLFIvOwFslJ7/W2brZ7KN3L+i/EHL1gxZ4AAzU2cy1uWVZvWPwuWQck
 EYuUgm19ymAxB27faWIFOATZ4Gr7p+nFQfJiuTt58fTPkrXMtSUqaX77bBi/QlZjMpRhHC
 H7gVlX4yx8D4V1KJQksiLCUCbuYz9BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712832189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDJmwU+S5ezoiEhcVBHWZRTLmH2xeZCqup48pceSj1w=;
 b=aIURlf4CdqaaN+AbK30qCvM0A/KrF/kDMhNwvu257g+Ds6UZml++vepw4PDOOE0VCSi5di
 jZRi4moOJLI7ebDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712832189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDJmwU+S5ezoiEhcVBHWZRTLmH2xeZCqup48pceSj1w=;
 b=e/DYP+l8sqeWHg/hLFIvOwFslJ7/W2brZ7KN3L+i/EHL1gxZ4AAzU2cy1uWVZvWPwuWQck
 EYuUgm19ymAxB27faWIFOATZ4Gr7p+nFQfJiuTt58fTPkrXMtSUqaX77bBi/QlZjMpRhHC
 H7gVlX4yx8D4V1KJQksiLCUCbuYz9BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712832189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDJmwU+S5ezoiEhcVBHWZRTLmH2xeZCqup48pceSj1w=;
 b=aIURlf4CdqaaN+AbK30qCvM0A/KrF/kDMhNwvu257g+Ds6UZml++vepw4PDOOE0VCSi5di
 jZRi4moOJLI7ebDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69D1013685;
 Thu, 11 Apr 2024 10:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XCZqGL2+F2YFdwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 11 Apr 2024 10:43:09 +0000
Date: Thu, 11 Apr 2024 12:42:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zhe-hlpYX2lDOd0U@yuki>
References: <20240320095927.19973-1-chrubis@suse.cz>
 <20240320095927.19973-2-chrubis@suse.cz>
 <20240321092922.GA548078@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240321092922.GA548078@pevik>
X-Spamd-Result: default: False [-2.54 / 50.00]; BAYES_HAM(-1.74)[93.44%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls: Add test for splicing from
 /dev/zero and /dev/full
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +{
> > +	int pipefd[2];
> > +	char buf[bytes];
> > +	size_t i;
> > +	int fail = 0;
> > +
> > +	memset(buf, 0xff, sizeof(buf));
> > +
> > +	SAFE_PIPE(pipefd);
> > +
> > +	TST_EXP_POSITIVE(splice(dev_fd, NULL, pipefd[1], NULL, sizeof(buf), 0));
> > +
> > +	if (!TST_PASS)
> > +		goto ret;
> > +
> > +	SAFE_READ(1, pipefd[0], buf, sizeof(buf));
> > +
> > +	for (i = 0; i < sizeof(buf); i++) {
> > +		if (buf[i])
> > +			fail++;
> > +	}
> > +
> > +	if (fail)
> > +		tst_res(TFAIL, "Non-zero bytes spliced from /dev/zero");
> Maybe write how many fail we have?
> 
> I also agree with Jan's comment about missing TST_RET, which is in splice09.

Will fix both.

> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> > +	else
> > +		tst_res(TPASS, "All bytes spliced from /dev/zero are zeroed");
> > +
> > +ret:
> > +	SAFE_CLOSE(pipefd[0]);
> > +	SAFE_CLOSE(pipefd[1]);
> > +}
> > +
> > +static void verify_splice(unsigned int n)
> > +{
> > +	unsigned int bytes = 1009 * n;
> 
> Out of curiosity, why 1009 and not 1000?

Because people tend to use buffers that are either power of two or
multiples of 100 or 1000. The 1009 is a prime number which means that
multiples of it will have "unexpected" sizes.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
