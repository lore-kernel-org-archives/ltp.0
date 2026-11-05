Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D739D606A326
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=J5R17G6w;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z+haQ7pj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=lAnEucT9;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9YksP3+c
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E9353CDC7B
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 11:50:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D6E73CDC7B
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 11:50:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 82BEE1400DEF
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 11:50:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DD2421F0A;
 Thu,  5 Nov 2026 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793875826;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Snn4s0IobpXdhiBMqtnNc1v1NAql5onZQAbe+sblHGg=;
 b=J5R17G6wMJ/kp+eXKx+rtUAhtP+Hff6lD8z/MN5HgNw3HQPN9hyVk5I6fgjV9Lt6zue1w1
 C78LYgp2uPSwqYLF6I0QZdbT/nUpHDe8LghQWhUQ5KiiBTv5npfA3iinfn5u90atFvjdBQ
 a+SGoUAgTUud+Oczq9r6gA0ikk6FGZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793875826;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Snn4s0IobpXdhiBMqtnNc1v1NAql5onZQAbe+sblHGg=;
 b=Z+haQ7pjSplLNKn+ol/9ddbqr55z/oBpI1BNKmDzkYsuXgtONpl2xN1NhSzO30kG3bxokI
 2oqO9V20mCcXSQCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lAnEucT9;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9YksP3+c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793875825;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Snn4s0IobpXdhiBMqtnNc1v1NAql5onZQAbe+sblHGg=;
 b=lAnEucT9b1OTCTYi7MqK8rsEBHQWN/ZVfHZbEAZisQasFBRcWHm3ftIoaJzFxZ1KozQ97w
 tLiFhI2d+fqemUBoDeaIo4+zZ6482VDS1+EvhKn0EP4tyHWG0+FX+xoGiXPKCznb5Ebxc6
 iKMfN6xO/F4REBTXk4OjhRHvLmtoNPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793875825;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Snn4s0IobpXdhiBMqtnNc1v1NAql5onZQAbe+sblHGg=;
 b=9YksP3+cvONTJc+HvgmEwfQivjjnft/r4HMUimOhShPIxRFO1zvB645VP0dZ3O6ua+porq
 MKGNAgPVvIvu52Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF630133F6;
 Thu,  5 Nov 2026 10:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8wHyI3Bf7Gr8PwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Nov 2026 10:50:24 +0000
Date: Thu, 5 Nov 2026 11:50:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20261105105023.GA459386@pevik>
References: <20261020190151.9420-1-linuxtestproject.agent@gmail.com>
 <oB4QkHztnNTcZNqTMjoGQkygrRUmUoyoYwsG@localhost.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <oB4QkHztnNTcZNqTMjoGQkygrRUmUoyoYwsG@localhost.localdomain>
X-Spamd-Result: default: False [-11.21 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,suse.cz,linux.dev,suse.com];
 RCPT_COUNT_FIVE(0.00)[6]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -11.21
X-Spam-Level: 
X-Rspamd-Queue-Id: 2DD2421F0A
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: add pwnescape reproducer
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it,
 linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, all,

I'm verifying it at least on some of SLES versions.

FYI on 4.12 and 4.4 based SLES kernels with backported 6785011f8b16 (i.e. fixed
kernels) the test fails:
pwnescape.c:213: TBROK: control datagram was not forwarded back

=> obviously test is not working on older codestreams, that would be good to get
fixed. I try to have look on it, but I'm not sure if I manage it till the end of
the month.

Otherwise LGTM, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > Hi Andrea,

> > On Tue, 20 Oct 2026, Andrea Cervesato wrote:
> > > cve: add pwnescape reproducer

> > > +	.tags = (const struct tst_tag[]) {
> > > +		{"linux-git", "6785011f8b16"},
> > > +		{}
> > > +	},

> > Add {"CVE", "2026-99999"} to .tags in testcases/cve/pwnescape.c.
> > Without it, metadata extraction assigns only the regression group, so
> > CVE-based metadata selection and the generated CVE catalog omit this test;
> > the runtest/cve entry does not populate that metadata.

> Valid, I will fix it before merge

Sure, I can add it before merge.


> > Runtime verification was blocked by unshare(CLONE_NEWUSER) returning
> > EPERM in this environment, before the forwarding behavior was exercised.

> This is the github LSM pushing out the reproducer. It's not a test bug

Sure.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
