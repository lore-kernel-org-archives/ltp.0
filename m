Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D540C3DA6E
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 11:00:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAC823CE4C3
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 12:00:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 652113CE486
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 12:00:31 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B156E22031A
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 12:00:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75D8821D95;
 Wed, 10 Jan 2024 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704884429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=72k69/8iJylPpvlxhltQ+h3EZfivRZRbF3ixX7+ZSM4=;
 b=jLNz4w+1s6KIM9ZLnDkvSNqsYnxdDTnbNhvHVW39i/3mxKSMv4riPsG3t2lTzjIzVnqTym
 HHmGY1+uAytsq51JGNWimej9To/u09iW4Mg2tvTU+qD7DExJCnj5T/ezyCQO2he9GdNR0Z
 E99gC36X3dsRrNGBNf5Kp2S2p9tyYyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704884429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=72k69/8iJylPpvlxhltQ+h3EZfivRZRbF3ixX7+ZSM4=;
 b=8jEhPz6HU6LNYLcVqhmloTqKehPqwHZp4aOe3arZl+4bzUTc5kvF+ncPq6gtDT28lCkq74
 QbfpJC7FWwzu3JDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704884427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=72k69/8iJylPpvlxhltQ+h3EZfivRZRbF3ixX7+ZSM4=;
 b=f1xsmRtyEVk654oOjqYfRu2HcBWy4+B9UbIxTSyDh5R2Mhvru4dRODobVpvVeS8XLOL8FM
 mS4OsC0nFGtlHGh1BIGBaCER4nHPMVnQKoPP4aLj7JWztbLbR0tnScvjIXte0cyp9aboBz
 /opVq4+6XM5owte7e7rHwi/mZ8fKE0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704884427;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=72k69/8iJylPpvlxhltQ+h3EZfivRZRbF3ixX7+ZSM4=;
 b=T0xXBxAVvMgcqs3LqZdobeIPhQ16oykon2EAtDyc431hQ5hYkCWPJUAmvHY94jNcft6yhZ
 tuxthChb4QIJtsAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 651F113786;
 Wed, 10 Jan 2024 11:00:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id spw1F8t4nmVUKwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Jan 2024 11:00:27 +0000
Date: Wed, 10 Jan 2024 12:00:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <petr.vorel@gmail.com>
Message-ID: <ZZ54308dqXEv3OBI@yuki>
References: <20231031125114.5879-1-chrubis@suse.cz>
 <20240109192444.GA1670891@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240109192444.GA1670891@pevik>
X-Spamd-Bar: ++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=f1xsmRty;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T0xXBxAV
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.99 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FREEMAIL_TO(0.00)[gmail.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.00)[12.13%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_SPAM_LONG(3.50)[1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[sched_stress.sh:url,run_sched_cliserv.sh:url]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_IN_DNSWL_HI(-1.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Queue-Id: 75D8821D95
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched: add sched sysctl sanity test
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
Cc: chrubis@suse.com, pvorel@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> It looks like the second fix 079be8fc6309 ("sched/rt: Disallow writing invalid
> values to sched_rt_period_us") is not in stable, shouldn't be there?

No idea to be honest, the second fix about rejecting invalid values is a
minor fix.

> > - Fixed a few whitespaces
> > - Added second kernel commit into metadata
> nit: metadata of the git commit looks ugly, but we would need to agree on better
> solution.

Which metadata exactly? This part is after the scisors and will be cut
when the patch is applied.

> >  runtest/sched                                 |   2 +
> >  testcases/kernel/sched/sysctl/.gitignore      |   1 +
> >  testcases/kernel/sched/sysctl/Makefile        |   7 +
> >  .../kernel/sched/sysctl/proc_sched_rt01.c     | 122 ++++++++++++++++++
> >  4 files changed, 132 insertions(+)
> >  create mode 100644 testcases/kernel/sched/sysctl/.gitignore
> >  create mode 100644 testcases/kernel/sched/sysctl/Makefile
> >  create mode 100644 testcases/kernel/sched/sysctl/proc_sched_rt01.c
> 
> > diff --git a/runtest/sched b/runtest/sched
> > index 172fe4174..3457114f4 100644
> > --- a/runtest/sched
> > +++ b/runtest/sched
> > @@ -16,3 +16,5 @@ sched_cli_serv run_sched_cliserv.sh
> >  sched_stress sched_stress.sh
> 
> >  autogroup01 autogroup01
> > +
> > +proc_sched_rt01
> 
> This should obviously be:
> proc_sched_rt01 proc_sched_rt01
> 
> And I would move it above sched_stress.sh.

Goot catch, will fix.

> The rest LGTM, thanks!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
