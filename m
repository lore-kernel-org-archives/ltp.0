Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A180C07545
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 09:36:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF8053CF4F3
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 11:36:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A8C43CCE48
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 11:36:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 61D6D201728
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 11:36:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 58ADF1F459;
 Tue, 24 Oct 2023 09:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698140167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E1QSE5z4MTvh6whNtap9VZbvriIFsZl6URYKp8nA6bc=;
 b=p8/8wY86wST3E3E3GY/Xc3/j3TGCZ7dcMFToyWtK6Pot73o++5KmjLEqv0lSXgW9zoNvHU
 ZVHf59cB304zPmyTASivBjO5RQVNDXY83dad81C8aPGpldtCOZZevpyTgABvyidDsvguos
 opDrkkWtk9InRNwQ0tvagT3gvkxGNnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698140167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E1QSE5z4MTvh6whNtap9VZbvriIFsZl6URYKp8nA6bc=;
 b=sCqJ6JqGrziXCmKA7HoWoc5V31jI//+RIeiuFv9MPJYPrLmFBwXUW9H1cm5mHxWweYD2pQ
 avB6n0QBB0ly/UDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 447C4134F5;
 Tue, 24 Oct 2023 09:36:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TA+XEAeQN2UXCgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 24 Oct 2023 09:36:07 +0000
Date: Tue, 24 Oct 2023 11:36:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <ZTeQJ95GncF5yg8F@yuki>
References: <20231023135647.2157030-1-kevin.brodsky@arm.com>
 <20231023135647.2157030-4-kevin.brodsky@arm.com>
 <ZTaF2kM1R1i3_JpR@yuki>
 <87291cdf-0245-c825-d3a3-235e4a4d1f9d@arm.com>
 <ZTaL6rLETxHwvFDr@yuki>
 <e6cc15ff-cb44-4805-cba5-9f5340410746@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e6cc15ff-cb44-4805-cba5-9f5340410746@arm.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-7.73 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.13)[67.74%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
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
> > Sigh, I meant 2. I guess that we would have to loop over filesystems
> > (easily done with .all_filesystems = 1) and pass very long filename. Or
> > do we have such test already?
> >
> > Looking at our tests, the rename10.c is actually one of two tests that
> > sets .all_fileystems and checks for ENAMETOOLONG. Looking at the
> > filesystem limits, all seems to have limits that are <= 255 characters,
> > the only problem is a definition of character. For utf8 character 255
> > characters are around 1021 (including nul terminator). So I suppose that
> > if we pass another buffer that is PATH_MAX in length and has PATH_MAX-1
> > characters we should consistenly hit 2. Or do I miss something?
> 
> This is a good point, I didn't think about it this way. Your idea seems
> sensible. With this patch we always hit 1. as we specify a string that
> is longer than PATH_MAX. We could instead hit 2. without out-of-bound
> access by specifying a string that is at most PATH_MAX in length
> (including the null terminator), and at least the filesystem character
> limit. Maybe something like the diff below (just tested it, that works
> fine).

Can we actually have two long paths in the test and test both? That
should have the best test coverage.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
