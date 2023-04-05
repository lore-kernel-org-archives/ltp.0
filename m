Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0978C7619A
	for <ltp@archiver.kernel.org>; Wed,  5 Apr 2023 09:21:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D92F93CDBDE
	for <ltp@archiver.kernel.org>; Wed,  5 Apr 2023 11:21:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 101643CC771
 for <ltp@lists.linux.it>; Wed,  5 Apr 2023 11:21:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3C68C600684
 for <ltp@lists.linux.it>; Wed,  5 Apr 2023 11:21:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 26FED2065A;
 Wed,  5 Apr 2023 09:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680686480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FaaFGAqJj9soTzFfYUYNiSDcXPrOPa0EBSwH2sbncTI=;
 b=gWvUMHvXaHtbURpc1WMfaCRKl2Ik5VVn/7gYihjNFneYZQvHCBPpxWFTQHjYvhWkL+4b4d
 DWoq0mZ0btaaA4Ts1zyHFIw+Kj8vVHDgG5eziGkPheYhUr8mC1uykJli/+Rtur5v8WhGj+
 XTO/XmX8dMLzqjvvLFnPQs+d5twflJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680686480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FaaFGAqJj9soTzFfYUYNiSDcXPrOPa0EBSwH2sbncTI=;
 b=mxueVhPsYjOw8FsAl+XGHTu//mOKnxSB1rgOYASVjou2ukGFRXo/rTwn78Uepstzsfvt6S
 AIuomVoplr0FpRCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1468F13A31;
 Wed,  5 Apr 2023 09:21:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7aDKA5A9LWTaXgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 05 Apr 2023 09:21:20 +0000
Date: Wed, 5 Apr 2023 11:22:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZC092GCT+OvTHgUX@yuki>
References: <20230308132335.29621-1-andrea.cervesato@suse.de>
 <20230308132335.29621-2-andrea.cervesato@suse.de>
 <20230314234000.GA10628@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230314234000.GA10628@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/3] Rewrite eventfd2_01 test using new LTP API
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
> > +static inline int eventfd2(unsigned int count, unsigned int flags)
> > +{
> > +	int ret;
> > +
> > +	ret = tst_syscall(__NR_eventfd2, count, flags);
> > +	if (ret == -1)
> > +		tst_brk(TBROK | TERRNO, "eventfd2");
> > +
> > +	return ret;
> > +}
> Normally we need put file or store this file into some lib directory?

As long as there are no other testcases that will need this it's okay if
this stays here.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
