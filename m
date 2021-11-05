Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66013C433EF
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 10:40:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B701760E97
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 10:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B701760E97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB73E3C75DE
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 11:40:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFF673C6334
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 11:40:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B82FD1000CD5
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 11:39:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 843B81FD36;
 Fri,  5 Nov 2021 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636108795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1ZXLWbxeHajQ2XDShGHfM9OTUGrbhDw21Pml2JTMfs=;
 b=SUNKk+LCQ56c4M3ojDfGkRnhCerDh2YWhAd7eKli3OjSLue1En7Lwb0R3tPKn66Qp8I0SH
 bUdNdXKrrEov8YrNSQzOxCPGUqs6WrpyDNsqLFXcVXLYqvTkMFzL6Oadb6Pc/OiOYPpABs
 CE1ne9JBPAe2wIH7S8nBi3rNe6LqwoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636108795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1ZXLWbxeHajQ2XDShGHfM9OTUGrbhDw21Pml2JTMfs=;
 b=ym0du5LDX8p6siR5916JGAIR8D1nXw3tUDc6H5V+htXPaVYuf5vqJnIh5QjgtgCUZd7l1t
 zs+somX3f3JNb+Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67EBC13FE2;
 Fri,  5 Nov 2021 10:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nSTiGPsJhWHrDAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 05 Nov 2021 10:39:55 +0000
Date: Fri, 5 Nov 2021 11:40:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YYUKNOHoCDMELcIB@yuki>
References: <20211103120233.20728-1-chrubis@suse.cz>
 <20211103120233.20728-3-chrubis@suse.cz> <YYQE+v9ACqVwOc9m@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYQE+v9ACqVwOc9m@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/7] docparse: Add tests
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> How about
> 1) Run test as default (all: test)?
> 2) Propagate test target into docparse/Makefile
> 3) Run docparse testing as part of make test
> 4) Be more verbose about running docparse tests
> 
> These are in patch below.
> 
> Also part of lib/newlib_tests/runtest.sh could be put into separate file, which
> could be reused in docparse/tests/test.sh (color etc), but that should be postponed
> to later to not blocking this patchset.
> 
> Kind regards,
> Petr
> 
> diff --git Makefile Makefile
> index 4e37362f9..9ead7b205 100644
> --- Makefile
> +++ Makefile
> @@ -210,6 +210,7 @@ ifneq ($(build),$(host))
>  	$(error running tests on cross-compile build not supported)
>  endif
>  	$(call _test)
> +	$(MAKE) test-docparse
>  
>  test-c: lib-all
>  ifneq ($(build),$(host))
> @@ -223,6 +224,9 @@ ifneq ($(build),$(host))
>  endif
>  	$(call _test,-s)
>  
> +test-docparse:
> +	$(MAKE) -C docparse/tests test

That's have been moved to metadata/tests/ in the last patch of the
series.

Other than that the rest looks good. Feel free to push this on the top
of my patchset with my Reviewed-by:

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
