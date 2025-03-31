Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C90CC3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 16:31:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F08423CACF0
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 18:31:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A0773CAB4F
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 18:31:26 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B63BB200059
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 18:31:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 428161F457;
 Mon, 31 Mar 2025 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743438683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RiBSQjwHSl8T1KoqAfW2k0olLYJ8pwf7OQHpn8eo2M4=;
 b=l95mYbKuGqp+Dn2IMOcFU3vHBh4G0REPg9TlO76muY4U4VN5DtJd4d/gIThCQlXmb36rOB
 Tw9SdeAY8nbWBVMQvNiY6GjWZQ8wIuIapRtgGxPCORAJZ1m6VIZh0M7qGDxlg5CVxPUz3F
 mec5m6dTxRAwXl5k4lrYxu39mTmNd2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743438683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RiBSQjwHSl8T1KoqAfW2k0olLYJ8pwf7OQHpn8eo2M4=;
 b=RMhYWaL5JhBdw81MS1pX9Wf2ikhW3h5YGcrTpSU4UmGsHsQVt00l88exdxYz/RMJ2Kj6R7
 Q08HCQpnMM41q/BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="v40FZf/o";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MbD+RVUV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743438682;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RiBSQjwHSl8T1KoqAfW2k0olLYJ8pwf7OQHpn8eo2M4=;
 b=v40FZf/o/PqxCmZGL2YNtsQBJT/fXiWTW9lhZu7YD6WLaNgtsngXBTXHd5jzujmkctfSdx
 kwiPnUE494hbFf/id1EpVhGQ+h+vTzJaU8sp03KGQwRYOj9FjgynHiJfXoDS1zyQYAbQif
 CuXxe0xHMofqq/ZNYkDlLzg8R7e60mU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743438682;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RiBSQjwHSl8T1KoqAfW2k0olLYJ8pwf7OQHpn8eo2M4=;
 b=MbD+RVUVuJEOVGntpgIXrlZIznbbli9qANiqjB0jaaAeabhqLD25eg7WOEl/633nXeJ8kX
 a2Rj/tfqsPQFrSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BC92139A1;
 Mon, 31 Mar 2025 16:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QchmBVrD6mcAYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 31 Mar 2025 16:31:22 +0000
Date: Mon, 31 Mar 2025 18:31:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250331163120.GA220855@pevik>
References: <20250328095747.169011-1-pvorel@suse.cz>
 <20250328095747.169011-3-pvorel@suse.cz>
 <f5949261-2e0e-4f37-bac8-bc52b74d8f91@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f5949261-2e0e-4f37-bac8-bc52b74d8f91@suse.com>
X-Rspamd-Queue-Id: 428161F457
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/5] doc: Add sphinx to requirements.txt
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
Cc: Ricardo B =?utf-8?B?LiBNYXJsacOocmU=?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> On 3/28/25 10:57, Petr Vorel wrote:
> > Although that slightly prolongs creating virtualenv, it's probably
> > better to handle it as the other requirements.

> > Suggested-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > New in v4.

> >   doc/developers/documentation.rst | 2 --
> >   doc/requirements.txt             | 1 +
> >   2 files changed, 1 insertion(+), 2 deletions(-)

> > diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
> > index 27c847e125..a303253693 100644
> > --- a/doc/developers/documentation.rst
> > +++ b/doc/developers/documentation.rst
> > @@ -23,8 +23,6 @@ Before building, make sure you have python3 ``virtualenv`` module installed.
> >       # prepare virtual environment
> >       python3 -m virtualenv .venv
> >       . .venv/bin/activate
> > -
> > -    pip install sphinx # usually packaged in distros
> >       pip install -r requirements.txt
> >       # build documentation
> > diff --git a/doc/requirements.txt b/doc/requirements.txt
> > index 742fb8b4bb..1f4cefb2c6 100644
> > --- a/doc/requirements.txt
> > +++ b/doc/requirements.txt
> > @@ -1,3 +1,4 @@
> > +sphinx
> In requirements.txt we usually put the right version of the package that we
> want to use. We can use the latest, what do you think?

I hesitated a bit if fixed versions are the best as sooner or later will have to
be manually updated when it breaks, but sure - we use it anyway for other modules

-sphinx
-sphinx-rtd-theme==2.0.0
+sphinx==8.2.3
+sphinx-rtd-theme==3.0.2

In that case I would remove python3-sphinx from apt install command in
.github/workflows/ci-sphinx-doc.yml to match the command => I'll send v5
of this change only.

Kind regards,
Petr

> >   sphinx-rtd-theme==2.0.0
> >   linuxdoc==20231020
> >   sphinxcontrib-spelling==7.7.0
> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
