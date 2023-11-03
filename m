Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B37C4167B
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 15:22:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE1E83CC8A5
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 16:22:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 892D53CAA14
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 16:22:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BD8C91000927
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 16:22:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F68C1F388;
 Fri,  3 Nov 2023 15:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699024927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CQvgzM65QvsdDIaLnYUcNfAlb4bZbKIgO302hvsd+Dw=;
 b=BGH2d7ipWfGmuGm57uns0WqlkhFIyKt4rYllgTksoaeNwsn4+ae2JlsSNwe6Wo3TcaB722
 ShwaRKX42208qb+BNs7ZTdzNAYfDMjwtU2rNGNWrPVPv3vT/cFZ43zErS6la09l1Oa3IPH
 P1s+EozZgwqfXJ3ZutPQX0aHfh2ADHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699024927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CQvgzM65QvsdDIaLnYUcNfAlb4bZbKIgO302hvsd+Dw=;
 b=237okvKPFDea9j1kUBhd4tC2sTDufrSQeCzY2E2d76wTHZLJxeWj7AB5rDJ712oR2z3+yi
 SSXO/Sw1oAPXecDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F2AA1348C;
 Fri,  3 Nov 2023 15:22:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8ZugER8QRWXwKwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Nov 2023 15:22:07 +0000
Date: Fri, 3 Nov 2023 16:22:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231103152205.GA1087887@pevik>
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-3-pvorel@suse.cz>
 <CAEemH2fQuqPhd+5wjiBeswJQOG=FikpKmL6eubdWgyWqehX6fw@mail.gmail.com>
 <20231027120104.GA657078@pevik> <ZUJ9vJG2gSdyBfAF@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZUJ9vJG2gSdyBfAF@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > > What about renaming it as tst_module_is_loaded() and move into tst_kernel.h?
> > > I guess we could make use of it widely for checking module loading or not.

> > I can do that, but lib/tst_kernel.c uses the old API. I guess it would fit
> > better in lib/tst_module.c, but that also uses the old API. Most of the tests
> > are converted, but at least these modules are still in the old API and use
> > tst_module_load from tst_module.h:

> > IMHO We need another file, which would be new API only. I'm also not sure if
> > it's a good idea to put another file with just single function to it. We already
> > have 38 lib/tst_*.c files which use new API. Any tip, what to use?
> > Or should I really put it into lib/tst_module.c ain include/tst_module.h, but
> > not into include/old/old_module.h (as we want old tests to be converted first?).

> I would just put the new functions into tst_module.h and we can put the
> into tst_module_new.c in lib/ and move the function to tst_module.c once
> the tst_module.c has been converted to new API.

+1. IMHO some other functions from lib/tst_kernel.c should be moved there
(tst_search_driver(), tst_check_builtin_driver(), tst_check_driver()).

> > > And here print the name to tell people the module is loaded.
> > +1

...
Thanks for your input.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
