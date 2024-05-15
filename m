Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA15DC25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 10:54:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18C2B3CF772
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 12:54:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D6373C04BB
 for <ltp@lists.linux.it>; Wed, 15 May 2024 12:54:05 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C62DD1007CB6
 for <ltp@lists.linux.it>; Wed, 15 May 2024 12:54:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E0F0521BF0;
 Wed, 15 May 2024 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715770443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I6pe99eivygr0uehIhBbpbNgQoAhlzZaqFBU2eaAHmQ=;
 b=yUGdNZjfCTO4HR3KB8gSwM2Tn2ycCG7ab0+xVowHzz51WkJ7lXF6qSXv3AX3mCoU7zNXLt
 WasU+I/lCo49K0wMOuyxDN46E9WPYkt5KulaaY3uza9we5dZoNArn7/dHM/+uG24kva2+Z
 MHpTtn47arSYKE/VtAv7FuJjEAjffGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715770443;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I6pe99eivygr0uehIhBbpbNgQoAhlzZaqFBU2eaAHmQ=;
 b=vqgWOfXpDy0Ztq66yk5Hj13FzVte45K+OICJ9jT2xk2MtCe6gbBejMDkxp+4LweVbsfwua
 obJsEAXOtTRLaBBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FgvV2G0x;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Lpc8wJmy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715770442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I6pe99eivygr0uehIhBbpbNgQoAhlzZaqFBU2eaAHmQ=;
 b=FgvV2G0xxL3b5cSezMX+LtgqeL/uUsXCtVCR2PuHQEAQBrCHBq2uLL9HQBVi/XYqVl+a3P
 6q/tHEN9IxLc36mhGJzhDz88jUYy7WiVlErjmxR/9paAGMjlv24nop23bRV4DYsgBbvYe/
 JCeS0y9AVu8uqclaxX8iQNio/J1BuQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715770442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I6pe99eivygr0uehIhBbpbNgQoAhlzZaqFBU2eaAHmQ=;
 b=Lpc8wJmymubLzclItl4TecbKaZAU4Oexd/H6y72MDdvmWVWHXpS2BF8+4Y8XiHXZZcYIdh
 8xsfKi57PhSSH6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C52C6139B3;
 Wed, 15 May 2024 10:54:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p702L0qURGZDQAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 15 May 2024 10:54:02 +0000
Date: Wed, 15 May 2024 12:53:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZkSUG0EtSyu6GvvW@yuki>
References: <20240515094753.1072-1-mdoucha@suse.cz>
 <20240515101511.GA211618@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240515101511.GA211618@pevik>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E0F0521BF0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
> > index 70e5639f1..07239f9c0 100644
> > --- a/testcases/cve/tcindex01.c
> > +++ b/testcases/cve/tcindex01.c
> > @@ -106,8 +106,19 @@ static void run(void)
> >  	NETDEV_ADD_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle, "htb",
> >  		qd_config);
> >  	NETDEV_ADD_TRAFFIC_CLASS(DEVNAME, qd_handle, clsid, "htb", cls_config);
> > -	NETDEV_ADD_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP, 1,
> > -		"tcindex", f_config);
> > +	ret = tst_netdev_add_traffic_filter(__FILE__, __LINE__, 0, DEVNAME,

I do not like that much that we add the __FILE__ and __LINE__ into the
test by hand. Maybe just add another macro
NETDEV_ADD_TRAFIC_FILTER_RET() so that we don't have to write these into
the testcases?

> nit: we now don't use NETDEV_ADD_TRAFFIC_FILTER() macro any more. I guess it can
> stay because you sooner or later will use it.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> > +		qd_handle, 10, ETH_P_IP, 1, "tcindex", f_config);
> > +	TST_ERR = tst_netlink_errno;
> Out of curriosity, I suppose you save tst_netlink_errno to TST_ERR because it
> would be overwritten later in other LTP netlink API functions.

Because he wants to print it with TTERRNO later.

> > +
> > +	if (!ret && TST_ERR == ENOENT) {
> > +		tst_res(TPASS | TTERRNO,
> > +			"tcindex module is blacklisted or unavailable");
> > +		return;
> > +	}

I guess that our .needs_drivers does not take blacklists into account,
otherwise we could have just added tcindex into .needs_drivers.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
