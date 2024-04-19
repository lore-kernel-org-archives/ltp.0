Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C759C4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 13:54:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F19B33CFD8C
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 15:54:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1350E3CFD6F
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 15:54:04 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ADE942095E8
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 15:54:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A334937806;
 Fri, 19 Apr 2024 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713534841;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7//7XcvWzoX7qRQc9sKVx95wyCkM4F13PHdG/nHhlQ=;
 b=SUiHtQ4xixIEAoyXWehMi63PdUcdqnsIti/sLM/EtllXvUE4bSdJKKErx9arbMpocU5Cn+
 YaqJXXuKt+NR5gD2nQoyhwcypiI/HSdXbW88TNOYfjUQPuiiDf9HkLQzouGintPC50KNX8
 K6m+eO6KEMldW5yXduwkki7MkIuupGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713534841;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7//7XcvWzoX7qRQc9sKVx95wyCkM4F13PHdG/nHhlQ=;
 b=pgpjGQoBGX07KlKXHsO/J7FLbrob8yCL+1mw/r5tLcow4gYpBd/jCk6gp8R+kVRUcXiSde
 JdbmKTqEsuckGeBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713534840;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7//7XcvWzoX7qRQc9sKVx95wyCkM4F13PHdG/nHhlQ=;
 b=bBHi/9VIKtduq/k7msmRdY3QPHRlF0SflTY6/NANc6PxkrKhkSmIiNMDX+DCtOt2Sknc5P
 dQP0ks3Id8FPtekFmQFhuEv61fb7tNdMywRaUqQrReR9B1aNlKISCD5mrcW6l4vCxLP2Jr
 a9x9v7NDs0+9TZbJjyUjpQ/l7srctNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713534840;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7//7XcvWzoX7qRQc9sKVx95wyCkM4F13PHdG/nHhlQ=;
 b=kjPKs1lIKruV1mp4YPniAXRzvsxaSidgCCQFP7wZammPmxIkVzUUuZc6+q1oNbRVRFBzRg
 s5+LrprLnHAR8pBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E679136CF;
 Fri, 19 Apr 2024 13:54:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qI2QCnh3ImYzXwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Apr 2024 13:54:00 +0000
Date: Fri, 19 Apr 2024 15:53:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240419135354.GA211868@pevik>
References: <20240419124221.207445-1-pvorel@suse.cz>
 <20240419124221.207445-2-pvorel@suse.cz>
 <0df81a8e-d450-4806-b425-82867ca8da3d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0df81a8e-d450-4806-b425-82867ca8da3d@suse.com>
X-Spamd-Result: default: False [-2.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 URI_HIDDEN_PATH(1.00)[https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,sphinx-version-ref.readthedocs.io:url,suse.cz:replyto,sphinx-doc.org:url];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] doc: Clarify that the only public CI testing
 is build only
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

Hi Andrea,

> > +++ b/doc/developers/writing_tests.rst
> > @@ -346,8 +346,8 @@ Testing builds with GitHub Actions
> >   Master branch is tested in `GitHub Actions <https://github.com/linux-test-project/ltp/actions>`_
> >   to ensure LTP builds in various distributions, including old, current and
> >   bleeding edge. ``gcc`` and ``clang`` toolchains are also tested for various
> > -architectures using cross-compilation. For a full list of tested distros, please
> > -check ``.github/workflows/ci.yml``.
> > +architectures using cross-compilation. For a full list of tested distros, please check
> > +`.github/workflows/ci.yml <https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml>`_.
> Maybe we can store github link into a variable and use it around the
> documentation.
> I'm not sure if it works, but eventually take a look at:
> https://groups.google.com/g/sphinx-users/c/OitnjX8SIA4/m/7_kUL0TaCwAJ

Thanks for a tip. Well, I don't think it's not working, but maybe I'm wrong.

I tested it with following diff inspired by docs [1], but the text in the link
is: "issue `123`" instead of 123 being formatted as code. Maybe there is some
parameter which can be tweaked or we need find another extension or write patch
for sphinx.ext.extlinks.

Looking at sphinx_version_ref [2] it also uses `, thus it will likely not work
either.

Anyway, it's not important we just loose some formatting. It's sort of "nice to
have".

Kind regards,
Petr

[1] https://www.sphinx-doc.org/en/master/usage/extensions/extlinks.html
[2] https://sphinx-version-ref.readthedocs.io/en/stable/


diff --git doc/conf.py doc/conf.py
index fb3e83cf2..771efbb34 100644
--- doc/conf.py
+++ doc/conf.py
@@ -22,9 +22,13 @@ release = '1.0'
 
 extensions = [
     'linuxdoc.rstKernelDoc',
-    'sphinxcontrib.spelling'
+    'sphinxcontrib.spelling',
+    'sphinx.ext.extlinks'
 ]
 
+extlinks = {'issue': ('https://github.com/sphinx-doc/sphinx/issues/%s',
+                      'issue `%s`')}
+
 exclude_patterns = ["html*", '_static*']
 
 spelling_lang = "en_US"
diff --git doc/developers/documentation.rst doc/developers/documentation.rst
index 825495c50..73b76dcde 100644
--- doc/developers/documentation.rst
+++ doc/developers/documentation.rst
@@ -3,6 +3,8 @@
 Documentation
 =============
 
+:issue:`123`
+
 This section explains how to use and develop the LTP documentation. The current
 documentation format is written using
 `reStructedText <https://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html>`_


> >   .. note::
> > diff --git a/doc/users/supported_systems.rst b/doc/users/supported_systems.rst
> > index 82774c2ef..a9086f4d8 100644
> > --- a/doc/users/supported_systems.rst
> > +++ b/doc/users/supported_systems.rst
> > @@ -3,6 +3,12 @@
> >   Supported systems
> >   =================
> > +Build testing is done with `GitHub Actions <https://github.com/linux-test-project/ltp/actions>`_.
> > +
> > +.. note::
> > +
> > +      There is no CI testing of the actual tests run.
> > +
> >   Kernel version
> >   --------------
> > @@ -38,6 +44,9 @@ Oldest tested distributions
> >         - 10.2.1
> >         - 11.0.1
> > +For a full list of tested distros, please tested distros, please check
> > +`.github/workflows/ci.yml <https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml>`_.
> > +
> >   Older distributions are not officially supported, which means that it
> >   may or may not work. It all depends on your luck. It should be possible
> >   to compile latest LTP even on slightly older distributions than we

> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
