Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1E9C001E0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 15:06:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4958F3CECCB
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 17:05:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF6FE3CECAD
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 17:05:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 32C74601158
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 17:05:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D99B921AC9;
 Mon, 23 Oct 2023 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698073546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mWTVa79HQEs30YJosG7Xs8WTeG58jk7WGWj+1lNAzsI=;
 b=JYeCHCQVBdTlYwqdjoAp820d1IMo36UU4ruH0wBEKMH5pA4k74Np59HyBDqzeWJ5gie2/I
 33ZyTlrSQ9z6K/gVVr+SOxKdpBaFyxt4WbtoiHaUixnbEcLUmZfnXavkvucIBcO5CcTCRk
 xsee2a0pmAbNvv9KgxrHRc+F4oF9+4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698073546;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mWTVa79HQEs30YJosG7Xs8WTeG58jk7WGWj+1lNAzsI=;
 b=/xQLkbT1l8jx+UtylTsySF4o2N7YDXl7Sly2jk6Ohcspj8KwyToBIwthZRFA541mjiHtCs
 rEB8yt2Zt/y1TeDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6B60139C2;
 Mon, 23 Oct 2023 15:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NPHmL8qLNmXvBAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 23 Oct 2023 15:05:46 +0000
Date: Mon, 23 Oct 2023 17:06:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <ZTaL6rLETxHwvFDr@yuki>
References: <20231023135647.2157030-1-kevin.brodsky@arm.com>
 <20231023135647.2157030-4-kevin.brodsky@arm.com>
 <ZTaF2kM1R1i3_JpR@yuki>
 <87291cdf-0245-c825-d3a3-235e4a4d1f9d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87291cdf-0245-c825-d3a3-235e4a4d1f9d@arm.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[44.23%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Provide a PATH_MAX-long buffer when expecting
 ENAMETOOLONG
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
> >> A number of tests check that syscalls manipulating paths return
> >> -ENAMETOOLONG when the specified path is longer than allowed. There
> >> are actually two ways this error can be triggered:
> >>
> >> 1. If the given string is longer than PATH_MAX, i.e. 4096 as far as
> >>    the kernel is concerned, then the getname() helper will fail and
> >>    the kernel will return -ENAMETOOLONG right away.
> >>
> >> 2. If the string fits in PATH_MAX, but the filesystem rejects the
> >>    path name, for instance because one of its components is longer
> >>    than the support file name length (e.g. 255 for ext4).
> > Ideally we should have at least one test that would hit the 1. as well...
> 
> This is what patch 3 is meant to achieve: instead of hitting 2. we now
> systematically hit 1.

Sigh, I meant 2. I guess that we would have to loop over filesystems
(easily done with .all_filesystems = 1) and pass very long filename. Or
do we have such test already?

Looking at our tests, the rename10.c is actually one of two tests that
sets .all_fileystems and checks for ENAMETOOLONG. Looking at the
filesystem limits, all seems to have limits that are <= 255 characters,
the only problem is a definition of character. For utf8 character 255
characters are around 1021 (including nul terminator). So I suppose that
if we pass another buffer that is PATH_MAX in length and has PATH_MAX-1
characters we should consistenly hit 2. Or do I miss something?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
