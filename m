Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B27AC36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:53:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E66BF3CB2CD
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 16:53:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 673963CAFA6
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:53:16 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B89B3200740
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:53:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 338DE2116E;
 Mon,  7 Apr 2025 14:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744037594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LFs3oPrBecQZqjIUNPMmUlkzLIEv9yv8pmDU5bBYJi8=;
 b=EFI5WuxoW70lieL6uKIkyod9az7u2b9BfY0TXr2S86HBIGOVkR9l0NCYrcgBavwjiLECZM
 /TxVpiJyuQqF6scs07vE8R3pwcvqDufRMPQG5FIlpToSFpqPSun2jpeYA6mTd2gvqJVWMh
 68ZEklPME4p1uCU5rRqfDAGHr0vhV4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744037594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LFs3oPrBecQZqjIUNPMmUlkzLIEv9yv8pmDU5bBYJi8=;
 b=l3Y6v0FqdKSdnjVnfg5XXb20Z7K6dsYvu+oQVoIJkPXKGuz3qp/sXdNIcXY6OcUZ5APZ3F
 Vnn3RFYwJjh4zEBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EFI5Wuxo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=l3Y6v0Fq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744037594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LFs3oPrBecQZqjIUNPMmUlkzLIEv9yv8pmDU5bBYJi8=;
 b=EFI5WuxoW70lieL6uKIkyod9az7u2b9BfY0TXr2S86HBIGOVkR9l0NCYrcgBavwjiLECZM
 /TxVpiJyuQqF6scs07vE8R3pwcvqDufRMPQG5FIlpToSFpqPSun2jpeYA6mTd2gvqJVWMh
 68ZEklPME4p1uCU5rRqfDAGHr0vhV4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744037594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LFs3oPrBecQZqjIUNPMmUlkzLIEv9yv8pmDU5bBYJi8=;
 b=l3Y6v0FqdKSdnjVnfg5XXb20Z7K6dsYvu+oQVoIJkPXKGuz3qp/sXdNIcXY6OcUZ5APZ3F
 Vnn3RFYwJjh4zEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EE0C13691;
 Mon,  7 Apr 2025 14:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wVA+Atrm82eeMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 07 Apr 2025 14:53:14 +0000
Date: Mon, 7 Apr 2025 16:53:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250407145312.GA101494@pevik>
References: <20250328095747.169011-1-pvorel@suse.cz>
 <20250328095747.169011-5-pvorel@suse.cz>
 <D8RV9V5D07EO.ORPMFWGXAMSO@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D8RV9V5D07EO.ORPMFWGXAMSO@suse.com>
X-Rspamd-Queue-Id: 338DE2116E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/5] Makefile: Update 'doc' target,
 add 'doc-clean'
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

> Hi Petr,

> On Fri Mar 28, 2025 at 6:57 AM -03, Petr Vorel wrote:
> > 'doc' target previously run docparse documentation. Point it to doc/
> > directory so that it build sphinx docs. doc/ dir has metadata/ dir as
> > dependency, no need to specify it. Call also '.venv' target.

> > NOTE: it's still possible to avoid virtualenv by calling 'make -C doc'

> > Add 'doc-clean': to remove only generated data (not optional .venv).

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Changes in v4:
> > * Use 'setup' instead of '.venv' in the top level doc target

> >  Makefile | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)

> > diff --git a/Makefile b/Makefile
> > index 5066789349..6aa77e1b9b 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -170,7 +170,13 @@ INSTALL_TARGETS		+= $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))
> >  $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)

> >  .PHONY: doc
> > -doc: metadata-all
> > +doc:
> > +	$(MAKE) -C $(abs_builddir)/doc setup
> > +	$(MAKE) -C $(abs_builddir)/doc
> > +
> > +.PHONY: doc-clean
> > +doc-clean:
> > +	$(MAKE) -C $(abs_builddir)/doc clean

> IMO the top-level clean and distclean targets should be responsible of
> calling the respective targets in doc/Makefile, what do you think?

Well, we have in the top level other clean targets:
lib-clean, libs-clean, ac-clean, ac-distclean, ac-maintainer-clean.
Therefore I thought add at least doc-clean would be good. I ignored
doc-distclean.

Most of LTP is compiled and therefore handled by
include/mk/generic_leaf_target.mk. kirk and sparse are special (submodule anyway),
but even they allows to use generic_leaf_target.mk. I'm not sure if I want to
rewrite whole doc/Makefile to support generic_leaf_target.mk, I should, but my
goal was to simplify creating venv. I guess I drop this atm and send v5 and
without it and get to it later.

Kind regards,
Petr

The rest of LTP final directories is handled by
include/mk/generic_leaf_target.mk, but doc/ is somehow special, that's why I
added these targets.

If you call make clean or distclean


> >  .PHONY: check
> >  check: $(CHECK_TARGETS)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
