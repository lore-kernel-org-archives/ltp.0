Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4FBC04A68
	for <ltp@archiver.kernel.org>; Thu, 28 Jul 2022 13:13:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 283AC3C4DB3
	for <ltp@archiver.kernel.org>; Thu, 28 Jul 2022 15:13:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4BC43C4DB3
 for <ltp@lists.linux.it>; Thu, 28 Jul 2022 15:12:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4D42B6005E2
 for <ltp@lists.linux.it>; Thu, 28 Jul 2022 15:12:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DDAF320AB9;
 Thu, 28 Jul 2022 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659013970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ceiJbCA0d4ixdfXSnKgeI0FQm/Qa2RwpKB89FSnV46Q=;
 b=X5qn0T/AbxjlpLVv6RU+kA8df05gmB86rP4Qn7txpvKn+k9n3r69mSeuA/hcqBj9T5YI4e
 OvGwItQd2EpiadqT91nKObDWVt6kfIlzqXEqjAI3OqkEzoYVXDbQRuBN4tnPT4urGkBPEl
 TmyHH/Wkjti377n8B7p2uVjsbSvKRcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659013970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ceiJbCA0d4ixdfXSnKgeI0FQm/Qa2RwpKB89FSnV46Q=;
 b=SmqChAozRRVCGnngDNU9GvFtNDWH4uQyHGxtqfiLhfRBnhb8aSXwjOZGOs0CJM0VFzdrBl
 COFxQGZiHKoe6mCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC36713427;
 Thu, 28 Jul 2022 13:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id j81TMVKL4mJWPwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 28 Jul 2022 13:12:50 +0000
Date: Thu, 28 Jul 2022 15:14:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YuKLvFspbOmeWhFE@yuki>
References: <20220616144207.30530-1-andrea.cervesato@suse.com>
 <YrMmFt9nD2WVrki/@yuki>
 <fb6c9172-e6f7-ba33-22fb-b4afae66478a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fb6c9172-e6f7-ba33-22fb-b4afae66478a@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor aiocp using new LTP API
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
> >> -static struct iocb *alloc_iocb(void)
> >> -{
> >> -	if (!iocb_free_count)
> >> -		return 0;
> >> -	return iocb_free[--iocb_free_count];
> >> -}
> >> +				iosize = MIN(filesize - offset, aio_blksize);
> >>   
> >> -void free_iocb(struct iocb *io)
> >> -{
> >> -	iocb_free[iocb_free_count++] = io;
> >> -}
> > This part was important as well. The I/O requests are not guaranteed to
> > be processed orderly so we stored the pointers of the finished iocb
> > structures in the async_write_done() function by calling this function
> > so that we can reuse them later.
> >
> > I guess that it would be cleaner to rename the functions to something as
> > put_iocb() and get_iocb() since they do not allcate anything but they
> > have to stay.
> Do we really need that? iocb_free buffer is always initialized and we 
> can still use it all.

I guess that you missed the part that there are no guarantees that
submitted iocbs are processed in any order. We cannot simply attempt to
reuse these that are at the beginning of the array passed tot the
io_submit() call.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
