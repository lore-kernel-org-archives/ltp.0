Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D690C36010
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 12:20:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 832643CAF90
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 14:20:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFCEC3CA011
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 14:20:18 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 259A91A00A35
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 14:20:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 957152115E;
 Tue,  1 Apr 2025 12:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743510015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vSx++L98kM+lEzLGdzDgqEZtj5/kb3w9NXySHK+V7Ik=;
 b=hc1gHhBcRrZ+ZwYm70P9uDUHfYn0gWJobS9B0qIa/WFy4RxfTAW4T9WRdpHSukfhzem/qj
 WfeVmhchG6RjjXduZ/c2TguttXEMp/Nl9u5w4i4wBLzbJY5X3WVBTD28HP213VXgWuyM90
 BR0sjmqdVRtCZjJagtsBLAS+kFvi8S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743510015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vSx++L98kM+lEzLGdzDgqEZtj5/kb3w9NXySHK+V7Ik=;
 b=JFGUZ+Fc9R9wHY3GOHLkTsz92FvoBLD+JpmU00EYtS+evxY+goWZkvYDf22mPYwcH3KG1g
 qM5kqzbYQqv+eEBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743510014;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vSx++L98kM+lEzLGdzDgqEZtj5/kb3w9NXySHK+V7Ik=;
 b=aVCd8LFLY60xTcU+bfKuVFg2e/y+PeSnOIs3FSMgnuR4CiGNz8/oyYOICQBetAJDbEO27j
 3TMC0mBlKJ/IZCR/I4pjoKLyRoRNrD2Va5YzcZYso20f9m4BBPCRx/A/FMIJfM6KHTo3Ue
 ozFxLdZNn2vLMutZaTNAG1nyKm7RYdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743510014;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vSx++L98kM+lEzLGdzDgqEZtj5/kb3w9NXySHK+V7Ik=;
 b=dgVHUT5IjCo1z0TppuCbdufI3dLv4PwCX9jJ5WE6NPboJb09a5L/qiy5xDXPWql7y5jImr
 b7d+8pHqABjNwlAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EC2D138A5;
 Tue,  1 Apr 2025 12:20:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aUjTGf7Z62fKOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 01 Apr 2025 12:20:14 +0000
Date: Tue, 1 Apr 2025 14:20:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it,
 Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250401122013.GA355530@pevik>
References: <20250328095747.169011-1-pvorel@suse.cz>
 <20250328095747.169011-3-pvorel@suse.cz>
 <f5949261-2e0e-4f37-bac8-bc52b74d8f91@suse.com>
 <20250331163120.GA220855@pevik> <20250331163726.GB220855@pevik>
 <9be4b701-40b8-4ada-a7cb-ff8ab1931a7b@suse.com>
 <20250331175342.GA276600@pevik>
 <fc779eef-5408-46a9-b9b9-e012f912261a@suse.com>
 <20250401121706.GA348979@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250401121706.GA348979@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> > On 3/31/25 19:53, Petr Vorel wrote:
> > > > On 3/31/25 18:37, Petr Vorel wrote:
> > > > > Wait, one thing: we use doc/requirements.txt in .readthedocs.yml. Is it really a
> > > > > good idea to add there sphinx, when it uses containers? I can test it in a
> > > > > separate branch, but we discussed some time ago that we should avoid adding
> > > > > sphinx for readthedocs.
> > > > > Wouldn't be in the end better to keep 'pip install sphinx' in Makefile instead
> > > > > (the previous proposal).
> > > > > Kind regards,
> > > > > Petr
> > > > I forgot about it. Thanks for remembering. At the moment readthedocs
> > > > installs sphinx via pip, so if we add just sphinx ro requirements.txt
> > > > without version, pip should reinstall the same version which is already
> > > > available before building the website.
> > > > We should give a try and eventually get back to the old way.
> > > To be honest I would prefer to avoid experimenting with readthedoc as much as
> > > possible. How about just forcing 'pip install sphinx' only in Makefile?
> > > It can be the simplest version - without checking if it's installed.
> > The thing is that readthedoc is already doing "pip install sphinx" before
> > building the website, so any other "pip install sphinx" or "pip install
> > requirements.txt" (with sphinx in it) won't create issues. pip will check
> > the cache, finding sphinx already installed and it will skip its
> > installation.

> > The only thing we should avoid is the usage of sphinx version. So we just
> > keep "sphinx" as a generic package inside requirements.txt and pip will take
> > care about the version.

> Of course we have to *not* version also sphinx-rtd-theme, because it's release
> is tight to sphinx version. That was obvious (2.0.0 requires sphinx < 8), but I
> tried it in our readthedocs.org to verify it really fails.

> IMHO it'd be better to keep sphinx and sphinx-rtd-theme to these which are used
> in readthedocs.org. Because that way we still use the same version (we control
> the version used in readthedocs.org via os version used in .readthedocs.yml.

I missed the main point for using the same sphinx version for development and
for the real docs in readthedocs.org: we get changes tested (both in CI job and
hopefully with development) if we use the same version. Because different
version can have incompatibilities which we discover once it gets broken on
readthedocs.org :(.

Kind regards,
Petr

> Kind regards,
> Petr

> > > Because I don't see any benefit to add sphinx to readthedocs where it's not
> > > needed - in the best case it will takes time to reinstall, in worst it just take
> > > time to experiment to find it breaks things. We are going to diverge from
> > > readthedocs anyway, unless we manually sync with the sphinx version it uses.
> > > You asked for newest version (which is 8.2.3, if I don't count broken 8.3),
> > > but in readthedocs we use old ubuntu-22.04, which uses sphinx 4.3.2 [1].

> > > We could update to noble (24.04LTS) (if supported by readthedocs) to get newer
> > > 7.2.6 (as I can test it as a separate effort.

> > > [1] https://packages.ubuntu.com/jammy/python3-sphinx
> > > [2] https://packages.ubuntu.com/noble/python3-sphinx

> > > I guess controlling the version is important, therefore I would prefer b) or c).

> > > a) simple version in Makefile, without version:

> > > $(VENV_DIR):
> > > 	$(PYTHON) -m virtualenv $(VENV_DIR)
> > > 	$(VENV_CMD) && pip install sphinx && pip install -r requirements.txt

> > > b) simple version with specifying sphinx version:

> > > SPHINX_VERSION := 8.2.3 # or 7.2.6 or 4.3.2?
> > > ...
> > > $(VENV_DIR):
> > > 	$(PYTHON) -m virtualenv $(VENV_DIR)
> > > 	$(VENV_CMD) && pip install sphinx==$(SPHINX_VERSION) && pip install -r requirements.txt

> > > c) more complicated version (you did not like) which install sphinx only when
> > > needed:

> > > SPHINX_VERSION := 8.2.3
> > > INSTALL_SPHINX := $(shell $(PYTHON) -c "import sphinx" 2>/dev/null && echo ":" || echo "pip install sphinx==$(SPHINX_VERSION)")
> > > ...
> > > $(VENV_DIR):
> > > 	$(PYTHON) -m virtualenv $(VENV_DIR)
> > > 	$(VENV_CMD) && pip install -r requirements.txt && $(INSTALL_SPHINX)

> > > Kind regards,
> > > Petr

> > > > Andrea
> > Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
