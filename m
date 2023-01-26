Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D93C05027
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 10:36:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B80423CB363
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 11:36:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 156923C07B4
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 11:36:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8380C600839
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 11:36:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D8AE81FE87;
 Thu, 26 Jan 2023 10:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674729402;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/MR/fTM04fEi79MHid6LCD2gtXrdD26v45vvsQPfvU=;
 b=EJjfyLfSLS7zObNjKaDoA6uKXDoL0IAzVC2G2DWQagoqpnxRLXyDheIFDun2KoaFr+163y
 6P8K8mD2etu3ZMZg/uQ+dXEg2N9hzw5/m+yDIJdGA0rZSTzD3jjiWIW9aYeKWHsZ4dSr5r
 kpfPcwvdltU9cJQlhEWGxQQKuQWpVxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674729402;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/MR/fTM04fEi79MHid6LCD2gtXrdD26v45vvsQPfvU=;
 b=ualVwr3qWnuhxFr/yGBPuNwHXkxZHiEOUkRVW54Mq21Ka0MDB8GBJeLeHBiiU3l7VYxHp3
 oW0vyzZfIhEsP+Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E63F13A09;
 Thu, 26 Jan 2023 10:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hpC3GrpX0mO7fwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 10:36:42 +0000
Date: Thu, 26 Jan 2023 11:36:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y9JXuPCRMYWX40tv@pevik>
References: <20230125222703.19943-1-pvorel@suse.cz>
 <20230125222703.19943-3-pvorel@suse.cz> <Y9JXW4c9FkZEKqXx@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9JXW4c9FkZEKqXx@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] hugemmap15.c: Use TST_TEST_TCONF() for
 unsupported archs
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> > +#else
> > +	TST_TEST_TCONF("Architecture not supported");
>                           ^
> 			  Maybe I would change this to be closer to the
> 			  original, so that it's clear that a piece of
> 			  code needs to be written for the test to be
> 			  enabled and that this is not inherently not
> 			  supported

> Something as:

> 	TST_TEST_TCONF("Signal handler for this architecture hasn't been written");

Very good idea, thanks!
I wait little longer for more input and merge later today.

Kind regards,
Petr

> Other than this it looks fine, with a better message:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
