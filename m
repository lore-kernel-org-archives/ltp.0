Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76CEC25B78
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 09:38:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24B513D0530
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 11:38:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C17E3CFE14
 for <ltp@lists.linux.it>; Tue, 28 May 2024 11:38:01 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8DF5D100034D
 for <ltp@lists.linux.it>; Tue, 28 May 2024 11:38:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4FBB5201FB;
 Tue, 28 May 2024 09:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716889078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5P+xCuf+QeNaU0n+RSvhotUahJyjua8UY25Hs0CTy8=;
 b=R/wwXdr2xsyc+Q7QxBAgcc9MVCqOwwkfWpG3Hf3f7zQThqBLhmZwKywC47mW8pXZ9V59W2
 UzmDce1HhsF/GO4nKq7hR7VOrgoaSu8V4MOB5vxhtapAcR7HPzA5jarVh6hCB2tdx9LaJT
 F4QRzLz8hBUZlX4ASl23DtxUY+2KOCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716889078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5P+xCuf+QeNaU0n+RSvhotUahJyjua8UY25Hs0CTy8=;
 b=RUEjXb7raEdFmPiEWA8CLdqH1RhPcGsOSRBD6bGHjBbS6Zjeud1JjWbpcOu+0yE9GZDW/J
 MePo2e2KxHM16xCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716889078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5P+xCuf+QeNaU0n+RSvhotUahJyjua8UY25Hs0CTy8=;
 b=R/wwXdr2xsyc+Q7QxBAgcc9MVCqOwwkfWpG3Hf3f7zQThqBLhmZwKywC47mW8pXZ9V59W2
 UzmDce1HhsF/GO4nKq7hR7VOrgoaSu8V4MOB5vxhtapAcR7HPzA5jarVh6hCB2tdx9LaJT
 F4QRzLz8hBUZlX4ASl23DtxUY+2KOCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716889078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5P+xCuf+QeNaU0n+RSvhotUahJyjua8UY25Hs0CTy8=;
 b=RUEjXb7raEdFmPiEWA8CLdqH1RhPcGsOSRBD6bGHjBbS6Zjeud1JjWbpcOu+0yE9GZDW/J
 MePo2e2KxHM16xCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1988713A5D;
 Tue, 28 May 2024 09:37:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aFEXBPalVWb4YwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 May 2024 09:37:58 +0000
Date: Tue, 28 May 2024 11:37:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240528093752.GA408250@pevik>
References: <20240527135718.29451-1-mdoucha@suse.cz>
 <20240527223551.GA374567@pevik>
 <8774370a-d6c7-42f6-a135-57fdf23032d9@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8774370a-d6c7-42f6-a135-57fdf23032d9@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
Subject: Re: [LTP] [PATCH] kvm_pagefault01: Do not write into tdp_mmu sysfile
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

> On 28. 05. 24 0:35, Petr Vorel wrote:
> > > +
> > > +	if (read_bool_sys_param(TDP_MMU_SYSFILE) > 0)
> > > +		tst_res(TINFO, "tdp_mmu is enabled, beware of false negatives");

> > Wouldn't it be better to add "WARNING:" to make it more visible?
> > 		tst_res(TINFO, "WARNING: tdp_mmu is enabled, beware of false negatives");

> > (if you agree, I can change it before merge)

> I thought about it for a while and I see good reasons for both TINFO and
> TWARN. It shouldn't matter for our tests because tdp_mmu defaults to off on
> SLE-15SP4 and SLE-15SP5. If other reviewers agree, feel free to change it to
> TWARN.

I slightly prefer tst_res(TINFO, "WARNING: ...", than TWARN. Although false
negative is serious, still failing the test based on suspicion of false
positives is not good.

@Li, @Jan, @Metan: any opinion on it?

Also, I send a patch to add TINFO_WARN flag (yeah, ugly name) to print TINFO
but slightly more visible due the color.

https://patchwork.ozlabs.org/project/ltp/list/?series=408394&state=*

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
