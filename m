Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88051C4332F
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 16:32:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EA983CE9B3
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 17:32:40 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D56E03CC8DA
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 17:32:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 299886005D1
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 17:32:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E3661F74D;
 Wed,  1 Nov 2023 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698856349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vsatxyo6VIfrXmJOedE8lO+RbaLkj9Ck2ISWIGU4gUY=;
 b=gbLygYvg0g3GwIA9g8EaDN9ay7JnvZJ+MxKOy1hYNob0XyOJoZBwpzp8wB7Q0XYVpIhB0I
 OJfD1sdqhon2yVFIvtzGr3md359JLk0xg9+CVB6rGHOgKy2116pWtJ6fwlvK4wJtBlGV/O
 258KAZ/EHmUl7cAtBjUvTVxpuU+y4TA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698856349;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vsatxyo6VIfrXmJOedE8lO+RbaLkj9Ck2ISWIGU4gUY=;
 b=d6MQmFdlhPe/uQDy1tjh+BmtG3iOc8B3VvZyL0MDdzD1Ux1/50S4dtT1k9LOHuBEPoiF0w
 W2Ee22T3ndAWnQBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1238E13460;
 Wed,  1 Nov 2023 16:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MIgbOpx9QmUvQwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 01 Nov 2023 16:32:28 +0000
Date: Wed, 1 Nov 2023 17:33:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZUJ9vJG2gSdyBfAF@yuki>
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-3-pvorel@suse.cz>
 <CAEemH2fQuqPhd+5wjiBeswJQOG=FikpKmL6eubdWgyWqehX6fw@mail.gmail.com>
 <20231027120104.GA657078@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231027120104.GA657078@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] lib: Add .modprobe
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
> > What about renaming it as tst_module_is_loaded() and move into tst_kernel.h?
> > I guess we could make use of it widely for checking module loading or not.
> 
> I can do that, but lib/tst_kernel.c uses the old API. I guess it would fit
> better in lib/tst_module.c, but that also uses the old API. Most of the tests
> are converted, but at least these modules are still in the old API and use
> tst_module_load from tst_module.h:
>
> IMHO We need another file, which would be new API only. I'm also not sure if
> it's a good idea to put another file with just single function to it. We already
> have 38 lib/tst_*.c files which use new API. Any tip, what to use?
> Or should I really put it into lib/tst_module.c ain include/tst_module.h, but
> not into include/old/old_module.h (as we want old tests to be converted first?).

I would just put the new functions into tst_module.h and we can put the
into tst_module_new.c in lib/ and move the function to tst_module.c once
the tst_module.c has been converted to new API.

> > And here print the name to tell people the module is loaded.
> +1

+1

> > This part could be as a separate function like tst_load_module() and
> > built single into another lib. We prefer to keep the main tst_test.c
> > as a simple outline.
> 
> +1 for a separate function, it should be in the same file as
> tst_module_is_loaded().

+1

> > On the other hand, the extern functions can be used separately to let
> > modules to be loaded and unloaded during the test iteration.
> > It gives us more flexibility in test case design.
> 
> Having it as the separate function would allow to use it in
> kvm_pagefault01.c and zram03.c - tiny simplification as they now call
> SAFE_CMD().
> 
> kvm_pagefault01.c and can_common.h use them parameters, it might be worth
> to implement them.
> 
> > Print unload module name.
> +1

+1

> > > +               }
> > > +       }
> 
> 
> > Here as well. something maybe like tst_unload_module().
> 
> +1

+1


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
