Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7C0ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 09:47:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 710653CABCF
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 11:47:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A4F03CA9C6
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:47:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EA6041401264
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:47:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 42F115CD19;
 Wed, 14 Sep 2022 09:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663148866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hpsqf1GSlww8BkrXepgc10H0ajNa7WwMklJmY+UJv3A=;
 b=te7uAMevYxCj3FCJOYrFv8urjEOSPozmdto8/M+0cgZwbAq1Gra9icBmGUl59YHXHfEPSO
 aXzankkN9lXdt+AjHGiWfn2rOXZyUdfiMkoEYgXCb1aNmH53tMvC2pZHQhiUJtdYj2Jzs1
 mmpatQq2sxCMnKhVxBlc+sJuSLvfQIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663148866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hpsqf1GSlww8BkrXepgc10H0ajNa7WwMklJmY+UJv3A=;
 b=1DyJUEWAJqhQidTyaBUrxWvAkUsKHWAB5G8g6mIynu7raknN6LKoayO5j5jBFgJUY/62o6
 3IGrC0U9WxwQBUDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 309AA134B3;
 Wed, 14 Sep 2022 09:47:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ss6tCkKjIWOeNQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 14 Sep 2022 09:47:46 +0000
Date: Wed, 14 Sep 2022 11:49:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyGjt23DZS8M4Ryx@yuki>
References: <20220913151907.26763-1-mdoucha@suse.cz>
 <20220913151907.26763-4-mdoucha@suse.cz> <YyGg8VilN9Jhv1lQ@yuki>
 <a6fbe570-109d-a7f8-1a56-99791fcdd7b4@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a6fbe570-109d-a7f8-1a56-99791fcdd7b4@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] dio_sparse: Fix child exit code
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
> > Ah, this is the fix. I would go for tst_res(TFAIL, ""); and return 1;
> > otherwise this looks fine applied over the previous changes.
> 
> If I returned from io_read(), I'd have to rewrite the calls in 
> dio_sparse.c and aiodio_sparse.c to exit(io_read()). Otherwise testrun() 
> in LTP library would always force the exit code to 0. This is less work 
> and you won't need to remember LTP library implementation details when 
> you reuse io_read() in a new test.

What about tst_res(TFAIL, ""); followed by exit(1). Really this is a
case where the test does fail we and we should report failure properly.
Or even just exit(1) as we do check the exit value after your changes.

> Should I send a v2 for tst_validate_children() or will you delete the 
> if(WCOREDUMP()) branch and merge it now?

Is there a good reason why you are trying to avoid tst_strstatus() that
simplifies the whole inner body of the loop to a single if?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
