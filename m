Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71C0C36010
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 12:17:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE8783CAE86
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 14:17:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49DA23CA011
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 14:17:19 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A404C1A00A3E
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 14:17:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EDC3E1F38E;
 Tue,  1 Apr 2025 12:17:11 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B645E138A5;
 Tue,  1 Apr 2025 12:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SNhTK0fZ62d3OAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 01 Apr 2025 12:17:11 +0000
Date: Tue, 1 Apr 2025 14:17:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250401121706.GA348979@pevik>
References: <20250328095747.169011-1-pvorel@suse.cz>
 <20250328095747.169011-3-pvorel@suse.cz>
 <f5949261-2e0e-4f37-bac8-bc52b74d8f91@suse.com>
 <20250331163120.GA220855@pevik> <20250331163726.GB220855@pevik>
 <9be4b701-40b8-4ada-a7cb-ff8ab1931a7b@suse.com>
 <20250331175342.GA276600@pevik>
 <fc779eef-5408-46a9-b9b9-e012f912261a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fc779eef-5408-46a9-b9b9-e012f912261a@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: EDC3E1F38E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
Cc: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> On 3/31/25 19:53, Petr Vorel wrote:
> > > On 3/31/25 18:37, Petr Vorel wrote:
> > > > Wait, one thing: we use doc/requirements.txt in .readthedocs.yml. Is it really a
> > > > good idea to add there sphinx, when it uses containers? I can test it in a
> > > > separate branch, but we discussed some time ago that we should avoid adding
> > > > sphinx for readthedocs.
> > > > Wouldn't be in the end better to keep 'pip install sphinx' in Makefile instead
> > > > (the previous proposal).
> > > > Kind regards,
> > > > Petr
> > > I forgot about it. Thanks for remembering. At the moment readthedocs
> > > installs sphinx via pip, so if we add just sphinx ro requirements.txt
> > > without version, pip should reinstall the same version which is already
> > > available before building the website.
> > > We should give a try and eventually get back to the old way.
> > To be honest I would prefer to avoid experimenting with readthedoc as much as
> > possible. How about just forcing 'pip install sphinx' only in Makefile?
> > It can be the simplest version - without checking if it's installed.
> The thing is that readthedoc is already doing "pip install sphinx" before
> building the website, so any other "pip install sphinx" or "pip install
> requirements.txt" (with sphinx in it) won't create issues. pip will check
> the cache, finding sphinx already installed and it will skip its
> installation.

> The only thing we should avoid is the usage of sphinx version. So we just
> keep "sphinx" as a generic package inside requirements.txt and pip will take
> care about the version.

Of course we have to *not* version also sphinx-rtd-theme, because it's release
is tight to sphinx version. That was obvious (2.0.0 requires sphinx < 8), but I
tried it in our readthedocs.org to verify it really fails.

IMHO it'd be better to keep sphinx and sphinx-rtd-theme to these which are used
in readthedocs.org. Because that way we still use the same version (we control
the version used in readthedocs.org via os version used in .readthedocs.yml.

Kind regards,
Petr

> > Because I don't see any benefit to add sphinx to readthedocs where it's not
> > needed - in the best case it will takes time to reinstall, in worst it just take
> > time to experiment to find it breaks things. We are going to diverge from
> > readthedocs anyway, unless we manually sync with the sphinx version it uses.
> > You asked for newest version (which is 8.2.3, if I don't count broken 8.3),
> > but in readthedocs we use old ubuntu-22.04, which uses sphinx 4.3.2 [1].

> > We could update to noble (24.04LTS) (if supported by readthedocs) to get newer
> > 7.2.6 (as I can test it as a separate effort.

> > [1] https://packages.ubuntu.com/jammy/python3-sphinx
> > [2] https://packages.ubuntu.com/noble/python3-sphinx

> > I guess controlling the version is important, therefore I would prefer b) or c).

> > a) simple version in Makefile, without version:

> > $(VENV_DIR):
> > 	$(PYTHON) -m virtualenv $(VENV_DIR)
> > 	$(VENV_CMD) && pip install sphinx && pip install -r requirements.txt

> > b) simple version with specifying sphinx version:

> > SPHINX_VERSION := 8.2.3 # or 7.2.6 or 4.3.2?
> > ...
> > $(VENV_DIR):
> > 	$(PYTHON) -m virtualenv $(VENV_DIR)
> > 	$(VENV_CMD) && pip install sphinx==$(SPHINX_VERSION) && pip install -r requirements.txt

> > c) more complicated version (you did not like) which install sphinx only when
> > needed:

> > SPHINX_VERSION := 8.2.3
> > INSTALL_SPHINX := $(shell $(PYTHON) -c "import sphinx" 2>/dev/null && echo ":" || echo "pip install sphinx==$(SPHINX_VERSION)")
> > ...
> > $(VENV_DIR):
> > 	$(PYTHON) -m virtualenv $(VENV_DIR)
> > 	$(VENV_CMD) && pip install -r requirements.txt && $(INSTALL_SPHINX)

> > Kind regards,
> > Petr

> > > Andrea
> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
