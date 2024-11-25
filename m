Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F85D59D73
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 21:33:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88DE33DAE16
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 22:33:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EBD13DADEE
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 22:32:50 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9967A1020966
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 22:32:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 35D68210FE;
 Mon, 25 Nov 2024 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732570368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bHvQNvOCzrGTcEGaU35M7idoYuKfkWo/1Vfy3P1xOY8=;
 b=RLljCvAgT26zA2C27PiiGdkI8JKjQfWF9g0TVev2y3VOFi9gX1KL3eRj/X2ZQ4YQadNVvk
 4xLeTu7Qh+gd4KDtC9Y9lpsWuCbyzq2abB6/6i9H/JELHFP/fe7flygRSc6/4afNoLJBt0
 U9eWOKnd81JnTmG3tARHTo5aeubL+Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732570368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bHvQNvOCzrGTcEGaU35M7idoYuKfkWo/1Vfy3P1xOY8=;
 b=FrbbXtUvkclVsCb+vN/3dwGgBWuKNIl3R9F8Mf1f6+ng/gdUmUu07lML5OWsfwbVprd+AR
 jOilmot0SXVuLzDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RLljCvAg;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FrbbXtUv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732570368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bHvQNvOCzrGTcEGaU35M7idoYuKfkWo/1Vfy3P1xOY8=;
 b=RLljCvAgT26zA2C27PiiGdkI8JKjQfWF9g0TVev2y3VOFi9gX1KL3eRj/X2ZQ4YQadNVvk
 4xLeTu7Qh+gd4KDtC9Y9lpsWuCbyzq2abB6/6i9H/JELHFP/fe7flygRSc6/4afNoLJBt0
 U9eWOKnd81JnTmG3tARHTo5aeubL+Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732570368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bHvQNvOCzrGTcEGaU35M7idoYuKfkWo/1Vfy3P1xOY8=;
 b=FrbbXtUvkclVsCb+vN/3dwGgBWuKNIl3R9F8Mf1f6+ng/gdUmUu07lML5OWsfwbVprd+AR
 jOilmot0SXVuLzDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1E3D13A7D;
 Mon, 25 Nov 2024 21:32:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tat1Nf/sRGeZSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 25 Nov 2024 21:32:47 +0000
Date: Mon, 25 Nov 2024 22:32:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241125213241.GA15008@pevik>
References: <20241108122139.87974-1-pvorel@suse.cz> <ZzHehDjWzY7ZMXyC@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZzHehDjWzY7ZMXyC@yuki.lan>
X-Rspamd-Queue-Id: 35D68210FE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] recvmmsg01: Workaround segfault on libc
 variant on 32 bit
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

...
> > +static void test_bad_addr(unsigned int i)
> > +{
> > +	struct time64_variants *tv = &variants[tst_variant];
> > +	void *timeout = bad_addr;
> > +	pid_t pid;
> > +	int status;
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		verify_recvmmsg(i, timeout);
> > +		_exit(!TST_PASS);

> This should be just exit(0). The child should either crash or exit with
> 0 any other result should be considered a bug.

Hm, I changed before merge it to _exit(0), instead of exit(0). As Jan explained
[1] _exit() is just for signal handlers and exit() will also flush open streams.
I guess I should fix it.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/CAASaF6yDG9VfWOzaSbzEMSGq5LXrqkNfLF7UmMcdWNvqmYywtA@mail.gmail.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
