Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44801C433F5
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 08:47:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D0D73CA8A8
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 10:47:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F37E73CA789
 for <ltp@lists.linux.it>; Thu,  5 May 2022 10:47:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3A80F1A009BE
 for <ltp@lists.linux.it>; Thu,  5 May 2022 10:47:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 273AB218EB;
 Thu,  5 May 2022 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651740423;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZ1Li3gq8hmuZkBNyaj+Pr2y85neJjkkN9Raw7KHBh8=;
 b=w37levZ0SvtORtmLYKK65OIEYkygpDaEuzk7azyVZ+tXVIGxxi0hctVd1iZwe54CvrLA5s
 mrHCqSUtSo7EZXrfPLwaGYNolWWjmkJDySU/lAgtHwahUoRSEbeccNoWBXeKC30EIyuIe3
 4gItoi1LruLB5M1rGjXm2Dt1SR3F6is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651740423;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZ1Li3gq8hmuZkBNyaj+Pr2y85neJjkkN9Raw7KHBh8=;
 b=HYeKHgHBPLefllMarlj2TLyKwFgqXFFZMw0pTNoQh53E/bKvy8qA1Ruba/DC28CNhjAdlr
 Cx9DqJtlTFShd9Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB14B13B11;
 Thu,  5 May 2022 08:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BUu7NwaPc2JWFwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 05 May 2022 08:47:02 +0000
Date: Thu, 5 May 2022 10:47:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YnOPBSPQ6UMYtC5g@pevik>
References: <20220503174718.21205-1-chrubis@suse.cz> <875ymke631.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <875ymke631.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 00/30] Introduce runtime
 and conver tests
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> > TODO:

> > This patchset is reasonably complete in a sense that it removes the
> > timeout API at the end. Still there are a few things to consider:

> > - is reusing the -I parameter a good idea? Wouldn't adding new parameter
> >   (-r) be better?

But -r is using only when .max_iteration_runtime set, right?
How should it behave on tests which don't set it?
Should -I and -r be mutually exclusive?
Maybe reusing -I would be simpler for users.

> Perhaps we could deprecate -I, but convert it to use the new mechanism
> while trying to keep the behaviour similar.

> I'm not sure we need a global -r option, but unlike -i it's not much
> effort to support. It would not surprise me if there are existing tests
> which don't work with -i.
                        ^^ Do you mean -I ?

Kind regards,
Petr

> > - there are quite likely tests that run for more than a second or a two
> >   and should be made runtime aware

> > - anything else?

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
