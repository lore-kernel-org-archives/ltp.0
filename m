Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB37E7E648
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 15:22:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CD3C3CDC8F
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 17:22:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B61E3CDC7C
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 17:21:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7438A20473B
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 17:21:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 060631F891;
 Tue, 26 Sep 2023 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695741717;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X/3gxGXYgckfxT9ood/JhH9mVAZWp6lPlG14IkgyT2I=;
 b=LsWy/bgQeYxtTN6FqgYtEUIOMsIbIbXombL+4OiRCeFj37DPTo68xiRXVZG1yO8zfuQlch
 QhlFZ1WnUD8rrG2XR537Z3MTDqxFvQePAJdVCe6YFnpg8louModiCqy8nnCplrwF1lAVQC
 VstZGMxpHO/V5at5K5EtDtRM4ZmdVOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695741717;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X/3gxGXYgckfxT9ood/JhH9mVAZWp6lPlG14IkgyT2I=;
 b=bxBl+Yq4r/nmEwFnFl7YBEtOYSXjFStCq8UFmLHduBZKFVwKOCHBfsneYNU0NonQLDKM4b
 cq/iYLOeJ5eLFrCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D279113434;
 Tue, 26 Sep 2023 15:21:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7MggMhT3EmUvewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Sep 2023 15:21:56 +0000
Date: Tue, 26 Sep 2023 17:21:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230926152155.GE159673@pevik>
References: <20230926124647.152972-1-pvorel@suse.cz>
 <20230926124647.152972-3-pvorel@suse.cz> <ZRLn7-PoVhomEB-v@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZRLn7-PoVhomEB-v@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 2/2] vma05.sh: Add check for core file
 presence
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Maybe this sanity check is useless. WDYT?

> I guess that it does not harm.

Thanks for your review!

> >  testcases/kernel/mem/vma/vma05.sh | 2 ++
> >  1 file changed, 2 insertions(+)

> > diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
> > index c9e4becdb..30b1d689a 100755
> > --- a/testcases/kernel/mem/vma/vma05.sh
> > +++ b/testcases/kernel/mem/vma/vma05.sh
> > @@ -54,6 +54,8 @@ vma_report_check()

> >  	rm -rf core*
> >  	{ vma05_vdso; } > /dev/null 2>&1
> > +	[ -f core ] || tst_brk TCONF "missing core file"

> TCONF or TBROK that is the question.

I guess TBROK is better in this case. I wonder myself why I type TCONF.
If nobody complains, I'll merge this with TBROK and your ack.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
