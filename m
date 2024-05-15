Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54873C25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 12:23:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C251F3CF864
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 14:23:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EAC93CF2AD
 for <ltp@lists.linux.it>; Wed, 15 May 2024 14:22:56 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA4C36067D5
 for <ltp@lists.linux.it>; Wed, 15 May 2024 14:22:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CCF3C20652;
 Wed, 15 May 2024 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715775771;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33wevqcjDYbRSglV3qE6J0Z+wpzkkfqOzU/r//wNah0=;
 b=wvFptulV9rp02vlz/zgn6pt0yIqkq5+dwJtPWmCjb1yCIGDYmBxXC6dcfx91EXTN30PVm2
 VC6k2fhGTb50ZZHnf4bTThH+PGMi5W5eKlkjRSCEUdHrlP9hCA4YR/DI8s7FMKEajgsIF1
 FE18j//VMkL2s115gFJGKQHDwep01aA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715775771;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33wevqcjDYbRSglV3qE6J0Z+wpzkkfqOzU/r//wNah0=;
 b=YWwW+h38AwEufbzwvWp2e/uSFSttP8axKyrS9YIdUPkLIeOi/BSXlAIkmR3QVM99wWRZze
 LmeIthSig6eaedAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715775771;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33wevqcjDYbRSglV3qE6J0Z+wpzkkfqOzU/r//wNah0=;
 b=wvFptulV9rp02vlz/zgn6pt0yIqkq5+dwJtPWmCjb1yCIGDYmBxXC6dcfx91EXTN30PVm2
 VC6k2fhGTb50ZZHnf4bTThH+PGMi5W5eKlkjRSCEUdHrlP9hCA4YR/DI8s7FMKEajgsIF1
 FE18j//VMkL2s115gFJGKQHDwep01aA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715775771;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33wevqcjDYbRSglV3qE6J0Z+wpzkkfqOzU/r//wNah0=;
 b=YWwW+h38AwEufbzwvWp2e/uSFSttP8axKyrS9YIdUPkLIeOi/BSXlAIkmR3QVM99wWRZze
 LmeIthSig6eaedAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A6DF139B3;
 Wed, 15 May 2024 12:22:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3v0WHBupRGaCWAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 May 2024 12:22:51 +0000
Date: Wed, 15 May 2024 14:22:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240515122245.GA220651@pevik>
References: <20240515094753.1072-1-mdoucha@suse.cz>
 <20240515101511.GA211618@pevik> <ZkSUG0EtSyu6GvvW@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZkSUG0EtSyu6GvvW@yuki>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tcindex01: Pass if the tcindex module is
 blacklisted
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
> > > diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
> > > index 70e5639f1..07239f9c0 100644
> > > --- a/testcases/cve/tcindex01.c
> > > +++ b/testcases/cve/tcindex01.c
> > > @@ -106,8 +106,19 @@ static void run(void)
> > >  	NETDEV_ADD_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle, "htb",
> > >  		qd_config);
> > >  	NETDEV_ADD_TRAFFIC_CLASS(DEVNAME, qd_handle, clsid, "htb", cls_config);
> > > -	NETDEV_ADD_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP, 1,
> > > -		"tcindex", f_config);
> > > +	ret = tst_netdev_add_traffic_filter(__FILE__, __LINE__, 0, DEVNAME,

> I do not like that much that we add the __FILE__ and __LINE__ into the
> test by hand. Maybe just add another macro
> NETDEV_ADD_TRAFIC_FILTER_RET() so that we don't have to write these into
> the testcases?

> > nit: we now don't use NETDEV_ADD_TRAFFIC_FILTER() macro any more. I guess it can
> > stay because you sooner or later will use it.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > > +		qd_handle, 10, ETH_P_IP, 1, "tcindex", f_config);
> > > +	TST_ERR = tst_netlink_errno;
> > Out of curriosity, I suppose you save tst_netlink_errno to TST_ERR because it
> > would be overwritten later in other LTP netlink API functions.

> Because he wants to print it with TTERRNO later.

> > > +
> > > +	if (!ret && TST_ERR == ENOENT) {
> > > +		tst_res(TPASS | TTERRNO,
> > > +			"tcindex module is blacklisted or unavailable");
> > > +		return;
> > > +	}

> I guess that our .needs_drivers does not take blacklists into account,
> otherwise we could have just added tcindex into .needs_drivers.

That reminds me .modprobe_module WIP patchset. I was not able to continue with
it, also I'm still gathering what is needed, I was not sure if it's needed to
add it or it'd be possible to enhance .needs_drivers. Also, I'd be great to
collect these few tests with non-standard requirements into a single ticket.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
