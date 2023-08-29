Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADAAC6FA8F
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 12:28:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E28AB3CEF6E
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 14:28:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C5C93CB14B
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 14:28:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0FD13200DD2
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 14:28:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B673E1F37E;
 Tue, 29 Aug 2023 12:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693312113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FE9zxpClRXfSZHVQlnc6TG6/3ioIQ/Pyd7t8ix4FK7c=;
 b=Z889qttheCBF5jFWromTjStb08vbo2+Wdcu7HPcoc8XxIk7Y+X9bGHjNsfGTCEpNownibs
 uJgbWdKPpvPpcny7RgP826+AzIXxAYdLTPo0RcDT99gZLOOfifqpOcb8zW0AcM3q+0e/SN
 j5CIHjzcrn4oLE2vkr20lnUPcC57IOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693312113;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FE9zxpClRXfSZHVQlnc6TG6/3ioIQ/Pyd7t8ix4FK7c=;
 b=ucbzznYvqfQCy/Utyr3BF07xqLrQk7hx4G0n/EQAG475bXA1CMjqJ296UHw/uXO0ybuHST
 L4qxH/8SQGuQjtDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53F6A138E2;
 Tue, 29 Aug 2023 12:28:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HWniCnHk7WRvPAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 29 Aug 2023 12:28:33 +0000
Date: Tue, 29 Aug 2023 14:28:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZO3kXbZyOaPWimEx@rei>
References: <20230824144449.21325-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230824144449.21325-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Add epoll_wait06 test
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
Pushed with a minor change, thanks.

> +/*\
> + * [Description]
> + *
> + * Verify that edge triggering is correctly handled by epoll, for both EPOLLIN
> + * and EPOLLOUT.
> + *
> + * [Algorithm]
> + *
> + * 1. The file descriptor that represents the non-blocking read side of a pipe
> + *    (rfd) is registered on the epoll instance.

I've rewrote this part sice we register both file descriptors in the
code.

> + * 2. A pipe writer writes data on the write side of the pipe.
> + * 3. A call to epoll_wait() is done that will return a EPOLLIN event.
> + * 4. The pipe reader reads half of data from rfd.
> + * 5. A call to epoll_wait() should hang because there's data left to read.
> + * 6. The pipe reader reads remaining data from rfd.
> + * 7. A call to epoll_wait() should return a EPOLLOUT event.

And changed this list from numbered to dashes, since that renders better
in the asciidoc documentation.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
