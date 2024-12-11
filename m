Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEA5E7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 09:56:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEFDE3E7D0E
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 10:56:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A64683E7CFE
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 10:55:59 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2307C648F68
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 10:55:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 76C8321180;
 Wed, 11 Dec 2024 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733910958;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCwKEogyVeaHyyExUFKqtTg2SgY3Z5byp/j//IAqp6s=;
 b=cP6qPYDptWTm5EkokyJJxmwpvLoQULLLP5Y+WEeVg5zxlwTU2usz00j4DsZs0l4Gp22Qb3
 OPapi5geguuv1N4T2Htt0Q5506e8zCx8nQxHDONOi1aN2kr8JpBUoR1H69t0TN8CaU2eDi
 R/ZpCzN/HQ4UhpT0YnkRHfm/SH/3+lY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733910958;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCwKEogyVeaHyyExUFKqtTg2SgY3Z5byp/j//IAqp6s=;
 b=geKdaz2qAIhyP9wH2AmzQdFnlU9Mh2GdtZiqSxbBMxgp++ta9fYlEeyIGe0s11L8r/RdUq
 L6cH8FVKoipC8aBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733910957;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCwKEogyVeaHyyExUFKqtTg2SgY3Z5byp/j//IAqp6s=;
 b=blQOybqI1I5KajD/SJ7h5kPTgPhwl9WUCNRAChBjydA+fVIHjqFtum3aLZw5bFw6H3m5/I
 L8YHjA8UjKYurXJWWhgXXuk75c6H0aXrB3pUzON1lzqjSQrKC4f47blMAYZIrxqiDamclh
 Vzxn5qBmOCCvY2e+MgaGE48jVLC8/y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733910957;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCwKEogyVeaHyyExUFKqtTg2SgY3Z5byp/j//IAqp6s=;
 b=p15tUOJHKvGxunCDjezyJ/pm4MgQiqgc21Bhgq9KH1SzID+FO4xJdfPT1FYWGKpEj7Ma5T
 Y+8iCKwUrE4X45AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D95613983;
 Wed, 11 Dec 2024 09:55:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h/HrFa1hWWdCUwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Dec 2024 09:55:57 +0000
Date: Wed, 11 Dec 2024 10:55:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Message-ID: <20241211095556.GB408383@pevik>
References: <20241203-madvise_guard_install-v1-0-c0485abbfc73@suse.com>
 <20241203-madvise_guard_install-v1-2-c0485abbfc73@suse.com>
 <20241211003048.GG386508@pevik>
 <76fb3af9-0a29-4b3b-9c1f-d66bedabbd73@lucifer.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <76fb3af9-0a29-4b3b-9c1f-d66bedabbd73@lucifer.local>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add madvise12 test
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

Hi Lorenzo, Andrea,

> On Wed, Dec 11, 2024 at 01:30:48AM +0100, Petr Vorel wrote:
> > Hi Andrea,

> > [ I dared to Cc Lorenzo, the author of the kernel implementation ]

> I'm not that scary am I? :)))

> Feel free to cc- me on anything relating to this even if obviously in the
> LTP project happy to be included! :)

Thank you, we really appreciate that!

> > > Verify that MADV_GUARD_INSTALL is causing SIGSEGV when someone is
> > > trying to access memory advised with it.

> > Test LGTM, thanks for covering a new kernel feature.

> All good, looks fine to me, though might be worth expanding over time, we
> have some self tests in the kernel for this, see
> tools/testing/selftests/mm/guard-pages.c.

Great! Noted at the ticket.

> But it's nice to have a basic LTP regression test to assert the fundamental
> thing is working as it should, and also nice that you implement it from
> your perspective rather than mine, where I am obviously rather influenced
> by implementation details.

> Also note I submitted man pages for the change, you can pull it from [0]
> and view it via:

> $ man --manpath=. 2 madvise

> [0]:git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git

+1

Kind regards,
Petr

> Hopefully these will get distributed around soon!

> Thanks for doing this for my feature, much appreciated overall!

> Cheers, Lorenzo
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
