Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8F0C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 12:00:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AAE13C9457
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 14:00:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9841E3C902D
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 13:59:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E448C2005C7
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 13:59:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 32F961F37C;
 Mon, 13 Jun 2022 11:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655121597;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=br+4NT/wiW9SClsoPOlz78jzZWnttvJtu6LYM9o9P2g=;
 b=PD2iAKyQc8JqcDDd2VQG8xGeJIEz88W2Nel7W+CLxcPLnbpiK7T6XnH4NfqSwnIli5oOem
 9BRglRRkwfTvf+M9JrAheWvNyueOOLzz0uVdbyuUGud/8VL7fOoadPxzge8TrMAj5yr9WW
 JRer7TpuViKgR3uOAxv2ST/gS3M4VUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655121597;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=br+4NT/wiW9SClsoPOlz78jzZWnttvJtu6LYM9o9P2g=;
 b=MRqUOMckqlP2Svgn6jUZbivELyXvA86zDYMIvm2JSi+lCVqAD4anAvo0wISTksanitdngd
 TY4dEjS4YoPF5aBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F09D1134CF;
 Mon, 13 Jun 2022 11:59:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iWlqOLwmp2I/BgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Jun 2022 11:59:56 +0000
Date: Mon, 13 Jun 2022 13:59:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yqcmuv8dwtU+tntL@pevik>
References: <20220610131442.5032-1-mdoucha@suse.cz> <YqNIIb/NFVBjsZdb@rei>
 <156915a0-cd2b-e6b8-1b7c-273c67911d4b@suse.cz>
 <YqbyFKN999MTr6Xf@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqbyFKN999MTr6Xf@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure: Check for KVM linker script support
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
> > > Skipping the whole directory will actually cause problems too, since the
> > > runltp files does include the kvm_pagefault01 now which will obvious
> > > fail because the binary would be missing.

> > > I'm not sure what the best solution would be, maybe install dummy
> > > libraries that just print TCONF in a case that linker does now work?

> > KVM tests have their own runfile which can be simply skipped. These
> > tests should not be included in any other runfiles because they should
> > only be run on baremetal. That's the solution: Don't run the KVM runfile
> > if the KVM tests were not built.

> > Also, the KVM Makefile already builds nothing on non-x86 archs so the
> > problem was there from the beginning.

I thought we're using TST_TEST_TCONF() for non-x86 archs.

> Looks like these are not in default scenario either, then this is not a
> reson to block the patch. However we should really figure out how to
> deal with cases like this at least for the new testrunner.

Yes, not having to use TST_TEST_TCONF() would be nice.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
