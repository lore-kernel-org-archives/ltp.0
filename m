Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4BDC25B79
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 13:04:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 445F93CF7F6
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 15:04:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 053F83C07A6
 for <ltp@lists.linux.it>; Wed, 15 May 2024 15:04:02 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 56DCA61023B
 for <ltp@lists.linux.it>; Wed, 15 May 2024 15:04:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 602A9206BE;
 Wed, 15 May 2024 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715778241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w/yLeTzK2sC3Z2YxSx6X9w6q9lfOKrbsvEBLfQ4GQsw=;
 b=Pw+yZI2WFMr5GiG7ILmsGFrCJU9xEWx7sv3W8Cn4Km0VTrZegwtB0Efb3aDU7FB1OY2ViP
 VExrWFY90Y73E389fFHqAzK9C00KkF/2tORCOp0skaCr4cFO2QzkO6w/gQXROVTdCJ670L
 MnwA4SzJdI8e7c7NgdOKMG14znBrxLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715778241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w/yLeTzK2sC3Z2YxSx6X9w6q9lfOKrbsvEBLfQ4GQsw=;
 b=GUAIoZPwDysrSTTpfxZwDihPh5S91CWi3PLp2Z5GBDXSRgP6PPyDzuGOtiXT/ROKlXraw9
 gJa3+Jqei8YHNSBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715778241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w/yLeTzK2sC3Z2YxSx6X9w6q9lfOKrbsvEBLfQ4GQsw=;
 b=Pw+yZI2WFMr5GiG7ILmsGFrCJU9xEWx7sv3W8Cn4Km0VTrZegwtB0Efb3aDU7FB1OY2ViP
 VExrWFY90Y73E389fFHqAzK9C00KkF/2tORCOp0skaCr4cFO2QzkO6w/gQXROVTdCJ670L
 MnwA4SzJdI8e7c7NgdOKMG14znBrxLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715778241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w/yLeTzK2sC3Z2YxSx6X9w6q9lfOKrbsvEBLfQ4GQsw=;
 b=GUAIoZPwDysrSTTpfxZwDihPh5S91CWi3PLp2Z5GBDXSRgP6PPyDzuGOtiXT/ROKlXraw9
 gJa3+Jqei8YHNSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 137A2136A8;
 Wed, 15 May 2024 13:04:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SV7pAsGyRGY9ZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 May 2024 13:04:01 +0000
Date: Wed, 15 May 2024 15:03:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240515130355.GA222948@pevik>
References: <20240515094753.1072-1-mdoucha@suse.cz>
 <20240515101511.GA211618@pevik> <ZkSUG0EtSyu6GvvW@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZkSUG0EtSyu6GvvW@yuki>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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

IMHO it makes sense.

> > nit: we now don't use NETDEV_ADD_TRAFFIC_FILTER() macro any more. I guess it can
> > stay because you sooner or later will use it.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > > +		qd_handle, 10, ETH_P_IP, 1, "tcindex", f_config);
> > > +	TST_ERR = tst_netlink_errno;
> > Out of curriosity, I suppose you save tst_netlink_errno to TST_ERR because it
> > would be overwritten later in other LTP netlink API functions.

> Because he wants to print it with TTERRNO later.

+1

> > > +
> > > +	if (!ret && TST_ERR == ENOENT) {
> > > +		tst_res(TPASS | TTERRNO,
> > > +			"tcindex module is blacklisted or unavailable");

Why not TCONF? We are testing if removing tcindex does not cause bug,
right?

> > > +		return;
> > > +	}

> I guess that our .needs_drivers does not take blacklists into account,
> otherwise we could have just added tcindex into .needs_drivers.

Yes, it only searches modules.builtin and modules.dep.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
