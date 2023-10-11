Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29831CD6E42
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 08:49:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5A3D3CD4BF
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 10:49:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC1D33C8927
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 10:48:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8FD46100128D
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 10:48:50 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9AB481FDF9;
 Wed, 11 Oct 2023 08:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697014130;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d/xcucRm2vfU5BeeajNKtHojaE9B5YSooU7TxCKx8TU=;
 b=sgTbVrlXp11hAQBtz6s6jMobfstNfAs7qWFkxuKjfMzyNFl5LP0zfodXy/irp7uBeBC+mS
 0OqrOotp/M8dMsTzouyXjObVzZb1XWId9XmpCP48HIj90U2Qb1px7peCCPF9OwA//kz778
 7ZnsIT419qW/CLeebmtWgod0tb1v47Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697014130;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d/xcucRm2vfU5BeeajNKtHojaE9B5YSooU7TxCKx8TU=;
 b=95LkS4Hn2/3/zRjBF/Af/xwfLopkYRL4Lx+pRqmoxtsoRIErHAA9O8XxuPzLvsdeo0TEP9
 Jbocx4l7snoma0DQ==
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 147E32C654;
 Wed, 11 Oct 2023 08:48:50 +0000 (UTC)
References: <20231004124712.3833-1-chrubis@suse.cz> <87o7h6zsth.fsf@suse.de>
 <ZSVPpG4_ui4k5nES@yuki>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Oct 2023 09:42:37 +0100
Organization: Linux Private Site
In-reply-to: <ZSVPpG4_ui4k5nES@yuki>
Message-ID: <87fs2hzgr4.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> >  - adds tst_iterate_fd() functionality
>> >  - make use of tst_iterate_fd() in readahead01
>> >  - add accept03 test which uses tst_iterate_fd()
>> >
>> > This is a prototype for how the functionality to iterate over different
>> > file descriptors should look like it converts one tests and adds
>> > another. There is plenty of other syscalls that can use this kind of
>> > testing, e.g. all fooat() syscalls where we can pass invalid dir_fd, the
>> > plan is to add these if/once we agree on the API.
>> 
>> I imagine the results of using this with splice could be very interesting.
>
> Good idea, I guess that we need to figure out how to do carthesian
> multiplication on the different file descriptors though. Maybe we need
> to treat the tst_interate_fd() as an iterator so that we can advance to
> the next fd with each call, so that we can do:
>
> 	struct tst_fd fd_in = {}, fd_out = {};
>
> 	while (tst_iterate_fd(&fd_in)) {
> 		while (tst_iterate_fd(&fd_out)) {
> 			...
> 			TST_TEST(splice(fd_in.fd, 0, fd_out.fd, 0, ...));
> 			...
> 		}
> 	}

This looks promising. I think it would be good to try this sooner rather
than later.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
