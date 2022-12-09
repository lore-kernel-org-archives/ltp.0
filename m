Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDEDC4332F
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 15:28:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F33F3CBFCA
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 16:28:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A71B83CBFA9
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 16:28:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6FFD81A00CC1
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 16:28:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B3C8722B45;
 Fri,  9 Dec 2022 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670599696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fJH5VjuJgFLFlikc/qqOoqi2PrLkPZzqu/3CatJe1pw=;
 b=MuO/OO8SHIQWIY+b6/qRBFvk0jhdZQA0zaztJhNVDoig8FvtQNP92Xszx8wBCFdNEGYj53
 pynmBSsNhe/4isv62PEpBQS8tNcm9rKHZxWfp4CS1ZQo7qrI+aK+w4UBqr28vsXM8ZmZr9
 jTiDIAOpcKpGtoAAAiSLkLXlZQLpwOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670599696;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fJH5VjuJgFLFlikc/qqOoqi2PrLkPZzqu/3CatJe1pw=;
 b=UNrVx4I0b25IExc1MMCQRhnsubHpIKZGZoDNhP+mtNV2onEpr702q4btDadabxbgGYDBoH
 Vfe+orMGPz8g+wBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F1BD13597;
 Fri,  9 Dec 2022 15:28:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id E+ATJRBUk2MULAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 09 Dec 2022 15:28:16 +0000
Date: Fri, 9 Dec 2022 16:28:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y5NUBXVhtfSzgtHa@rei>
References: <20221206115329.17760-1-rpalethorpe@suse.com>
 <20221206115329.17760-2-rpalethorpe@suse.com>
 <Y49EjvZHd1npsXS7@rei> <87edtctuos.fsf@suse.de>
 <Y49qssvWl2g+rvOu@yuki> <87a640trg1.fsf@suse.de>
 <Y4+Dx/K8sglGix0m@yuki> <87o7seqlry.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87o7seqlry.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] fill_fs: Ensure written data is not easily
 compressed
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
> > The test is supposed to test what happens when filesystem is altmost
> > full and being written to, which may trigger all kinds of corner cases.
> > In that sense it makes sense to randomize the access patterns a bit so
> > that we have higher chances of utilizing different code paths. But of
> > course the question where should we stop in randomizing things and what
> > makes sense and what does not.
> 
> I think there are multiple scenarious which are totally different.
> 
> For example, Redis uses an append only file (AOF) and IIRC you can
> choose to batch writes for performance at the expense of data
> integrity. It's common for the AOF to have it's own volume.
> 
> OTOH if we have a classic server with 1000s of daemons running, then we
> can expect writes to happen in parallel and be random.
> 
> I'd be in favor of trying to test these things separately and to keep
> each scenario as simple (and reproducible) as possible. I think mixing
> together different access patterns is better handled by fuzzing.

I suppose.

Or we can run the test a few times with different access patters and do
not mix them in a single run.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
