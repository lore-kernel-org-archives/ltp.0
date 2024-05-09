Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55848C10F1A
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 10:23:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E38CB3CE185
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 12:23:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E769D3CAEB6
 for <ltp@lists.linux.it>; Thu,  9 May 2024 12:23:42 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F2DFC60032D
 for <ltp@lists.linux.it>; Thu,  9 May 2024 12:23:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2DC145FCC1;
 Thu,  9 May 2024 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715250221;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AeULZXP87gLnO4BkJmQvY/ukVCfVfokC2U8E4aItnrc=;
 b=tSvkjq3cYE3++uybIDQn0Sn3IYHLaqA85KBRrQYk0EO6lJ4DMSaFz72eddZffvT3EXzQSJ
 PI6bIsMq0g835RHD6knQSYpJC6c4gtttXxvFl4DVX3Utk6/jzKCS79pErd0uA0gYZZ5Ank
 UdKLYSywYtHVmJeJB2UdH3j0Z2TBl6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715250221;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AeULZXP87gLnO4BkJmQvY/ukVCfVfokC2U8E4aItnrc=;
 b=HBOvNguvkqRdY72ZTEy9KY6DmsimaqH2QfRL41qWwzKIqg/z0bHEglhww/v9TLleJLutZ6
 rdwn6vc6FKBAicBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715250221;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AeULZXP87gLnO4BkJmQvY/ukVCfVfokC2U8E4aItnrc=;
 b=tSvkjq3cYE3++uybIDQn0Sn3IYHLaqA85KBRrQYk0EO6lJ4DMSaFz72eddZffvT3EXzQSJ
 PI6bIsMq0g835RHD6knQSYpJC6c4gtttXxvFl4DVX3Utk6/jzKCS79pErd0uA0gYZZ5Ank
 UdKLYSywYtHVmJeJB2UdH3j0Z2TBl6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715250221;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AeULZXP87gLnO4BkJmQvY/ukVCfVfokC2U8E4aItnrc=;
 b=HBOvNguvkqRdY72ZTEy9KY6DmsimaqH2QfRL41qWwzKIqg/z0bHEglhww/v9TLleJLutZ6
 rdwn6vc6FKBAicBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A85813941;
 Thu,  9 May 2024 10:23:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QfRUAC2kPGZKPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 May 2024 10:23:41 +0000
Date: Thu, 9 May 2024 12:23:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240509102339.GB243374@pevik>
References: <20240419124221.207445-1-pvorel@suse.cz>
 <20240419124221.207445-2-pvorel@suse.cz> <Zjyfukg9pEwAb4aP@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zjyfukg9pEwAb4aP@yuki>
X-Spamd-Result: default: False [-6.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 URI_HIDDEN_PATH(1.00)[https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

Hi Cyril,

> Hi!
> > Also convert .github/workflows/ci.yml as link to github
> > (unfortunately that remove code formatting).

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  doc/developers/writing_tests.rst | 4 ++--
> >  doc/users/supported_systems.rst  | 9 +++++++++
> >  2 files changed, 11 insertions(+), 2 deletions(-)

> > diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
> > index 032fbcbd5..3db56a558 100644
> > --- a/doc/developers/writing_tests.rst
> > +++ b/doc/developers/writing_tests.rst
> > @@ -346,8 +346,8 @@ Testing builds with GitHub Actions
> >  Master branch is tested in `GitHub Actions <https://github.com/linux-test-project/ltp/actions>`_
>                    ^
> 		   build

"build tested" is much better wording, thank you!

> >  to ensure LTP builds in various distributions, including old, current and
> >  bleeding edge. ``gcc`` and ``clang`` toolchains are also tested for various
> > -architectures using cross-compilation. For a full list of tested distros, please
> > -check ``.github/workflows/ci.yml``.
> > +architectures using cross-compilation. For a full list of tested distros, please check
>                                                             ^
> 							    build
> > +`.github/workflows/ci.yml <https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml>`_.

> >  .. note::

> > diff --git a/doc/users/supported_systems.rst b/doc/users/supported_systems.rst
> > index 82774c2ef..a9086f4d8 100644
> > --- a/doc/users/supported_systems.rst
> > +++ b/doc/users/supported_systems.rst
> > @@ -3,6 +3,12 @@
> >  Supported systems
> >  =================

> > +Build testing is done with `GitHub Actions <https://github.com/linux-test-project/ltp/actions>`_.
> > +
> > +.. note::
> > +
> > +      There is no CI testing of the actual tests run.

> Maybe a bit better "There is no CI for the actual test runs."

+1, again thanks.


> >  Kernel version
> >  --------------

> > @@ -38,6 +44,9 @@ Oldest tested distributions
> >        - 10.2.1
> >        - 11.0.1

> > +For a full list of tested distros, please tested distros, pleae check
>                      ^
> 		     build


Do we want to wait for more people acking it?
Or can I merge it with just your and Li's ack?

Kind regards,
Petr

> > +`.github/workflows/ci.yml <https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml>`_.
> > +
> >  Older distributions are not officially supported, which means that it
> >  may or may not work. It all depends on your luck. It should be possible
> >  to compile latest LTP even on slightly older distributions than we
> > -- 
> > 2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
