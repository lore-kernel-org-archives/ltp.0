Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D2CCD80CD
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 13:20:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6356D3CF088
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 15:20:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6ED53C8ACD
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 15:19:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 22E2D600941
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 15:19:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D74141F45A;
 Tue, 10 Oct 2023 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696943994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5Vb6GB0GE+FDsx3580vS2ntU4j+c+h4IwqaebVjKuE=;
 b=L0rbhRBlgs+blHaWr/0k8eLsennmeRfFo3lGPKD9+QYE1FJbKu6Bax3R8aIpbmrwltin/j
 XrwlSlGXWq/ADqcK7nY9+zbzM9ymFIN7rP07fXfYOBypW1LVAh9N1MplFShYLS32yHj4sO
 IEpMGHkXdjREErOSobSFv9OLdLIHY2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696943994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5Vb6GB0GE+FDsx3580vS2ntU4j+c+h4IwqaebVjKuE=;
 b=BC8KCJ5sDV+ByXCel/EVVfa6prrX8HlRP82ItyfqsFG2fzBdOJsYVIOcfC8Ukwyccp5y/b
 ahZ4UhR6bOYRgsAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C13491358F;
 Tue, 10 Oct 2023 13:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ELVnLnpPJWViZQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 10 Oct 2023 13:19:54 +0000
Date: Tue, 10 Oct 2023 15:20:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZSVPpG4_ui4k5nES@yuki>
References: <20231004124712.3833-1-chrubis@suse.cz>
 <87o7h6zsth.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87o7h6zsth.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] Add tst_iterate_fd()
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >  - adds tst_iterate_fd() functionality
> >  - make use of tst_iterate_fd() in readahead01
> >  - add accept03 test which uses tst_iterate_fd()
> >
> > This is a prototype for how the functionality to iterate over different
> > file descriptors should look like it converts one tests and adds
> > another. There is plenty of other syscalls that can use this kind of
> > testing, e.g. all fooat() syscalls where we can pass invalid dir_fd, the
> > plan is to add these if/once we agree on the API.
> 
> I imagine the results of using this with splice could be very interesting.

Good idea, I guess that we need to figure out how to do carthesian
multiplication on the different file descriptors though. Maybe we need
to treat the tst_interate_fd() as an iterator so that we can advance to
the next fd with each call, so that we can do:

	struct tst_fd fd_in = {}, fd_out = {};

	while (tst_iterate_fd(&fd_in)) {
		while (tst_iterate_fd(&fd_out)) {
			...
			TST_TEST(splice(fd_in.fd, 0, fd_out.fd, 0, ...));
			...
		}
	}

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
