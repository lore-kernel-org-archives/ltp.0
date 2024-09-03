Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C1ACD3420
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 11:26:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 295AA3C4DF4
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 13:26:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A317D3C2F20
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 13:26:21 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5300B600C99
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 13:26:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D9EC1FD09;
 Tue,  3 Sep 2024 11:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725362778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+PRQCZkFU7j4s52ruh6wgJgo4rlF/xvrDSp1hgzJ0g=;
 b=00n9yVEEH0nmWd2zp/74aYRF+rUcTElW24sQ1rg7YN7Wf4SFGI6Zc2MRYUj80qF2GJNLPI
 8s3zKFMfYrkY/nrN9T4DPNQrMCcOieLMf87gDS2Z/3R4DDgNs+Izlzupo6qQsN+e/QNmE7
 j0AfhkjU3xJKynEw6gq5N4GzkwoeMuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725362778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+PRQCZkFU7j4s52ruh6wgJgo4rlF/xvrDSp1hgzJ0g=;
 b=KMiZIwmgkfezsnJw62orJuKDhKZkRFdl8lRMcQdcZLKpwrdQjf8XPc77vFGO54hKe/mPVh
 aBS0oN3SGivljGAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725362777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+PRQCZkFU7j4s52ruh6wgJgo4rlF/xvrDSp1hgzJ0g=;
 b=n+Lv9zbHVUxRas8jvKdTqJpAV/UldDJJ59k/OPahoTmZsPBJOV78W+/W1tkOxXgzGNRvBP
 B9Vto6Oulrvzypo3AovNAhixqG3935wr7uU8Eyy9uMJwZZHq4dHky0kH2T6oJEzwYvIud7
 s9deJWADd7oALyTsWCiBlXkbLYnvmcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725362777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+PRQCZkFU7j4s52ruh6wgJgo4rlF/xvrDSp1hgzJ0g=;
 b=xz0gkXibzzAP/6n/3BoPr53mhDLXBAGvwBquv2wIFocNknfL7WXVzDQr2EfTpAmBzyay2W
 GMulyTKMvNpmu9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81E8A13A52;
 Tue,  3 Sep 2024 11:26:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /iXGHlny1mZhIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Sep 2024 11:26:17 +0000
Date: Tue, 3 Sep 2024 13:26:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240903112616.GA745263@pevik>
References: <20240902024017.6404-1-wegao@suse.com>
 <20240903081916.27033-1-wegao@suse.com> <Ztbh5qyDln_t5C18@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ztbh5qyDln_t5C18@yuki.lan>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mpls01.sh: Add --allow-unsupported for modprobe
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

Hi Cyril,

> Hi!
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/network/mpls/mpls01.sh | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)

> > diff --git a/testcases/network/mpls/mpls01.sh b/testcases/network/mpls/mpls01.sh
> > index 196b5b2f9..892b5bd85 100755
> > --- a/testcases/network/mpls/mpls01.sh
> > +++ b/testcases/network/mpls/mpls01.sh
> > @@ -21,7 +21,11 @@ cleanup()

> >  setup()
> >  {
> > -	ROD modprobe mpls_router
> > +	if grep -q 'sl-micro' /etc/os-release; then

> I do not like how specific is this check. The --allow-unsupported should
> be at best no-op for SLE and openSUSE, right?

Yes. I would personally avoid it (not needed so far), but sure it can work.

> So I would go for the
> check of ID=suse rather than specifying just single variant.

$ grep ^ID /etc/os-release # SLE Micro
ID="sl-micro"
ID_LIKE="suse"

$ grep ID_ /etc/os-release # Tumbleweed
ID="opensuse-tumbleweed"
ID_LIKE="opensuse suse"

$ grep ^ID /etc/os-release # SLES 15-SP6
ID="sles"
ID_LIKE="suse"

$ grep ^ID /etc/os-release # SLES 12-SP5 (still supported)
ID="sles"

If we dare to ignore SLE12-SP5 (and older), we could use:
=> grep -q -w ID_LIKE.*suse /etc/os-release
(Using -w to mitigate "suse" as part of longer word.)

There is another problem: mpls_setup() also tries to load modules

modprobe -a mpls_router mpls_iptunnel mpls_gso failed
on both lhost and rhost via:

tst_net_run -s "modprobe -a $TST_NEEDS_DRIVERS"

which is run on all mpls tests. And even mpls01.sh gets fixed,
the other 3 remaining tests fails due missing --allow-unsupported for other mpls
modules.

I guess we can expect both sides are the same distros, thus we could do
evaluation only on lhost. And, we could for simplicity run modprobe also on both
sides in mpls01.sh, thus putting it into function. This code could be in new
function and called in mpls_setup + in mpls01.sh:

	local module
	local args

	grep -q 'sl-micro' /etc/os-release && args='--allow-unsupported'

	if [ "$TST_NEEDS_DRIVERS" ]; then
		tst_net_run -s "modprobe $args -a $TST_NEEDS_DRIVERS"
	fi

Wei, feel free to add it into new version. I can fix your grep in your version
and send a follow up patch. Whatever you prefer.

Kind regards,
Petr

> > +		ROD modprobe --allow-unsupported mpls_router
> > +	else
> > +		ROD modprobe mpls_router
> > +	fi
> >  }

> >  test1()
> > -- 
> > 2.35.3


> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
