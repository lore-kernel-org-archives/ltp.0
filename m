Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD5EC433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 17:25:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA4D63C989C
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 18:24:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FFDA3C9574
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 18:24:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE9AE1A007E3
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 18:24:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C6FA1F397;
 Tue,  1 Feb 2022 17:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643736285;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RT511HirDYhDwv23wig4GjgXsc0OunFvmrSj524fOcY=;
 b=qSYnEqyN/T25MPl4JcV8jM+vrxoQ2V7DJD4rpoNOOeJcblwB1LA61MIEJ/l1+1CMAoPocy
 J4stC1FcbQ4SzQbqdHL/JPjA3ogoRomlJKHmRR0oinRSrk58Neymjzzqw1v/mpXyBY3PR5
 OtAcBYbKVGBzO5tzc1kzQe3XoiGH81w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643736285;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RT511HirDYhDwv23wig4GjgXsc0OunFvmrSj524fOcY=;
 b=I2w8q33oq0lSjHy9wYB83Ip/I+SQQkyWbE8J6rNUY77ij4mRaHNk9yZinj4sch9dnDU4D5
 p+Wll5UfxJD4JSBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A46013B64;
 Tue,  1 Feb 2022 17:24:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XsgaE91s+WEYbQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 01 Feb 2022 17:24:45 +0000
Date: Tue, 1 Feb 2022 18:24:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Yfls2zBSl/DcHucs@pevik>
References: <20220126164703.7177-1-pvorel@suse.cz> <YfkgZ8Ab6Jl8udbv@yuki>
 <YflRs6o15kRQ7aiI@pevik> <877daey2wp.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877daey2wp.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Fix tst_mkfs_ doc
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

Hi Richie,
> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Cyril,

> >> >   * @fs_opts: NULL or NULL terminated array of mkfs options
> >> > - * @extra_opt: extra mkfs option which is passed after the device name
> >> > + * @extra_opts: NULL or NULL terminated array of extra mkfs options which is
> >>                                                                              ^
> >> 									     are
> > I wasn't sure about the grammar, I thought the NULL *is* passed or
> > the NULL terminated array *is* passed. But not really sure.

> > Kind regards,
> > Petr

> *are* sounds more natural to me. Probably due to the order of specifying
> the array (singular) then its contents (plural). If you wrote something
> like "The extra mkfs options NULL terminated array is ...", then it
> would be more natural to use *is*.
Thanks for the explanation, merged with are.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
