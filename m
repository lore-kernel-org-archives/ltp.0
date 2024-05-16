Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5748C25B77
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 14:43:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EECD3CFA6A
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 16:43:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 810003CF982
 for <ltp@lists.linux.it>; Thu, 16 May 2024 16:43:41 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C42F66017CB
 for <ltp@lists.linux.it>; Thu, 16 May 2024 16:43:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F48B34AC6;
 Thu, 16 May 2024 14:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715870618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z2f9ynIzlO0FLoQoXlyAd8i9TMJyLC50yfkPYp+C5tY=;
 b=GJcg2GD/3k0OYn5smt4dFXZGGr7axggm4HdGsVmCWMVonvdOT8iR8ebwxPfmKgh+tMM6Ry
 1HNg2U96M1zd496B3eMyRPogQFuZQOpd8Nc5tcIS4jlLYleqTotzk3QILsj0xS6vthNvgi
 Yn3eFOmGMZY72AM+9GSwZUyqrD66Hos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715870618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z2f9ynIzlO0FLoQoXlyAd8i9TMJyLC50yfkPYp+C5tY=;
 b=QoGrb5AXCaLpvyLrkF6H0KsHpdsw3bnLHAwOxuBs0MV1MrPQDj9ZCj5ZtWOBPEcS1Q+lgF
 kp4l0S+HPAFHgVAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715870618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z2f9ynIzlO0FLoQoXlyAd8i9TMJyLC50yfkPYp+C5tY=;
 b=GJcg2GD/3k0OYn5smt4dFXZGGr7axggm4HdGsVmCWMVonvdOT8iR8ebwxPfmKgh+tMM6Ry
 1HNg2U96M1zd496B3eMyRPogQFuZQOpd8Nc5tcIS4jlLYleqTotzk3QILsj0xS6vthNvgi
 Yn3eFOmGMZY72AM+9GSwZUyqrD66Hos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715870618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z2f9ynIzlO0FLoQoXlyAd8i9TMJyLC50yfkPYp+C5tY=;
 b=QoGrb5AXCaLpvyLrkF6H0KsHpdsw3bnLHAwOxuBs0MV1MrPQDj9ZCj5ZtWOBPEcS1Q+lgF
 kp4l0S+HPAFHgVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8CF7137C3;
 Thu, 16 May 2024 14:43:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ve+1NpkbRmazcgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 May 2024 14:43:37 +0000
Date: Thu, 16 May 2024 16:43:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240516144336.GA317330@pevik>
References: <20240516112016.309145-1-pvorel@suse.cz>
 <20240516112016.309145-2-pvorel@suse.cz>
 <9d23569c-06fe-40e2-ab49-7ad19fae4be3@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9d23569c-06fe-40e2-ab49-7ad19fae4be3@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: Convert more C API info
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

> On 5/16/24 13:20, Petr Vorel wrote:
> > Convert more C API info (both library and user).

> > These info were omitted when converted from GitHub asciidoc wiki format.

> > Fixes: 4a72aada8 ("New LTP documentation")
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   doc/developers/api_c_tests.rst |  7 +++++
> >   doc/developers/ltp_library.rst | 47 ++++++++++++++++++++++++++++++++--
> >   2 files changed, 52 insertions(+), 2 deletions(-)

> > diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
> > index ec53ab33c..c7e1a5997 100644
> > --- a/doc/developers/api_c_tests.rst
> > +++ b/doc/developers/api_c_tests.rst
> > @@ -12,6 +12,13 @@ Core LTP API
> >   .. kernel-doc:: ../../include/tst_res_flags.h
> >   .. kernel-doc:: ../../include/tst_test.h
> > +LAPI headers
> > +------------
> > +
> > +Use our LAPI headers (``include "lapi/foo.h"``) to keep compatibility with old
> > +distributions. LAPI header should always include original header. For more info
> > +see :doc:`../developers/ltp_library`.
> > +
> >   Option parsing
> >   --------------
> > diff --git a/doc/developers/ltp_library.rst b/doc/developers/ltp_library.rst
> > index 723781feb..15dde8e7b 100644
> > --- a/doc/developers/ltp_library.rst
> > +++ b/doc/developers/ltp_library.rst
> > @@ -9,8 +9,51 @@ General Rules
> >   When we extend library API, we need to apply the same general rules that we use
> >   when writing tests, plus:
> > -#. LTP library tests must go inside :master:`lib/newlib_tests` directory
> > -#. LTP documentation has to be updated according to API changes
> > +#. LTP library tests must go inside :master:`lib/newlib_tests` directory.
> > +#. LTP documentation has to be updated according to API changes.
> > +#. Environment variables should be listed in :doc:`../users/setup_tests`.
> > +
> > +C API
> > +-----
> > +
> > +LAPI headers
> > +~~~~~~~~~~~~
> > +
> > +Use our LAPI headers (``include "lapi/foo.h"``) to keep compatibility with old
> > +distributions. LAPI header should always include original header. Older linux
> > +headers were problematic, therefore we preferred to use libc headers. There are
> > +still some bugs when combining certain glibc headers with linux headers, see
> > +https://sourceware.org/glibc/wiki/Synchronizing_Headers.
> > +

> I generally prefer to have a single point where features are documented,
> otherwise we need to remember
> to update documentation in two parts instead of one.

Yes, that's preferred. But in many parts of the docs there is some info for
developing new tests and other for developing library. Sometimes even third
place: "maintainer checklist".

Kind regards,
Petr

> > +Rules checked with ``make check``
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +LTP-001: Sources have ``tst_`` prefix
> > +"""""""""""""""""""""""""""""""""""""
> > +
> > +API source code is in headers in ``include/{empty}*.h``,
> > +``include/lapi/{empty}*.h`` (backward compatibility for old kernel and libc)
> > +and C sources in ``lib/{empty}*.c``. Files have ``tst_`` prefix.
> > +
> > +LTP-002: TST_RET and TST_ERR are not modified
> > +"""""""""""""""""""""""""""""""""""""""""""""
> > +
> > +The test author is guaranteed that the test API will not modify these
> > +variables. This prevents silent errors where the return value and
> > +errno are overwritten before the test has chance to check them.
> > +
> > +The macros which are clearly intended to update these variables. That
> > +is ``TEST`` and those in 'tst_test_macros.h'. Are of course allowed to
> > +update these variables.
> > +
> > +LTP-003: Externally visible library symbols have the ``tst_`` prefix
> > +""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> > +
> > +Functions, types and variables in the public test API should have the
> > +``tst_`` prefix. With some exceptions for symbols already prefixed with
> > +``safe_`` or ``ltp_``.
> > +
> > +Static (private) symbols should not have the prefix.
> >   Shell API
> >   ---------

> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
