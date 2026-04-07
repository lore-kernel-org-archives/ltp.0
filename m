Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECF2FEEF25
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 11:41:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BC1C3E26B1
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 13:40:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1E883C1987
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 13:40:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E58110007C5
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 13:40:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD0AD4E426;
 Tue,  7 Apr 2026 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775562037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T2EXT/xMwsKCh8vdLTVgEWJJYLoGJBHBM8i2MzsLs3o=;
 b=0oBYJWV8xz75Y8YgF6EhyB8vV51w37RgH5DQkpdFEPqfaRHX4e5LOGB8zqe7A5Ec2XK5gK
 9xfO2ds08Hz1GXJMKubc9p25ZgYdBZ3xJWvo7SXKZV9B5Huagt81U8kvsA2qF1lAAfWvJ0
 S7NBZnF1pwHbniYD6uioEcyJ+/p2LAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775562037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T2EXT/xMwsKCh8vdLTVgEWJJYLoGJBHBM8i2MzsLs3o=;
 b=KxUtjfX6xH3adnnPEb2Je7L61uylvrFkD7s6w0qHIudN5xkCpLQWR8QxRcPYd3ISZop+gs
 7SLXyYZ5Il3gYrDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775562037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T2EXT/xMwsKCh8vdLTVgEWJJYLoGJBHBM8i2MzsLs3o=;
 b=0oBYJWV8xz75Y8YgF6EhyB8vV51w37RgH5DQkpdFEPqfaRHX4e5LOGB8zqe7A5Ec2XK5gK
 9xfO2ds08Hz1GXJMKubc9p25ZgYdBZ3xJWvo7SXKZV9B5Huagt81U8kvsA2qF1lAAfWvJ0
 S7NBZnF1pwHbniYD6uioEcyJ+/p2LAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775562037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T2EXT/xMwsKCh8vdLTVgEWJJYLoGJBHBM8i2MzsLs3o=;
 b=KxUtjfX6xH3adnnPEb2Je7L61uylvrFkD7s6w0qHIudN5xkCpLQWR8QxRcPYd3ISZop+gs
 7SLXyYZ5Il3gYrDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98CF74A0B0;
 Tue,  7 Apr 2026 11:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id odoxJDXt1GkqYwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Apr 2026 11:40:37 +0000
Date: Tue, 7 Apr 2026 13:40:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <adTtPJNHn9O9IuCz@yuki.lan>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-17-chrubis@suse.cz>
 <CAEemH2c5OfBhcR_KB6LY4yJdxAUDR7HbWAf-V0KjiZMN2Jkarw@mail.gmail.com>
 <adTWHgQO2gLj_bXX@yuki.lan> <adTs52bG8FpUVhFD@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adTs52bG8FpUVhFD@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 16/17] lib: tst_test: Remove now unused
 needs_drivers
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
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -511,6 +511,13 @@ struct tst_fs {
> >   *                  and parenthesis are supported, e.g.
> >   *                  "CONFIG_X86_INTEL_UMIP=y | CONFIG_X86_UIMP=y" is evaluated
> >   *                  to true if at least one of the options is present.
> 
> > + *                  For some config options their presence in the config file
> > + *                  is not enough to assure the functionality is present or
> 
>   Merely finding a config option in the config file does not
>   guarantee that the corresponding functionality is available.
> 
> > + *                  enabled. E.g. config option may be set to 'm' but the
> > + *                  module may not be installed or functionality may be
> > + *                  disabled on the kernel command line. The kconfig library
> 
>   For instance, an option might be set to 'm' without the
>   module being installed, or the feature could be disabled via
>   the kernel command line.
> 
> > + *                  has a set of additonal checks for a few config options that
> > + *                  are used in the tests and need additional checks.
> 
>   To address this, the kconfig library implements supplementary
>   runtime checks for specific options required by the tests.

Thanks, will use that version for the final patchset.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
