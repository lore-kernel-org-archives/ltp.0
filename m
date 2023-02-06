Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7C9C61DA4
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 06:12:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CBE23CB182
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 07:12:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AFBC3C2A67
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 07:12:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 903A86006E0
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 07:12:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDCC260268;
 Mon,  6 Feb 2023 06:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675663933;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1hkdGMtPTUMKke3lUZge79fbgjMehqVPgQVfKiLEiJQ=;
 b=OU3HlZRCSjiqUxGFoaLEYlqVHrxZ7L6uwIxagAPPIQkRRQvSz+Z6xnn7+kGi6PQOKfDBMe
 9dBNds2wC3NhpUfJ23VEoNXgFm8zqwGY2zANzy7RLHGMVJWUtWW1WnIIDgTJ0iApZ4Ecfd
 yXZFfy7xbDEAAaVVc91dSJAkipSMnPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675663933;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1hkdGMtPTUMKke3lUZge79fbgjMehqVPgQVfKiLEiJQ=;
 b=1KRJ2mk/Ni1F3ekfXhf5aAdnVmp0/jn9NjeLjvF9sGgyDLg195zliYdze1cc2KXVWT0kas
 +HmiLz3S06PEt+BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 935B01390C;
 Mon,  6 Feb 2023 06:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 40TUIj2a4GOeNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Feb 2023 06:12:13 +0000
Date: Mon, 6 Feb 2023 07:12:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
Message-ID: <Y+CaO23SoWkuOJNy@pevik>
References: <20230129183930.2045-1-wegao@suse.com>
 <Y+CQt2SpeMzibUDT@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+CQt2SpeMzibUDT@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ioctl01.c:Test also struct termios
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> Hi Wei,

...
> > @@ -64,7 +66,21 @@ static void verify_ioctl(unsigned int i)
> >  	if (TST_ERR != tcases[i].error) {
> >  		tst_res(TFAIL | TTERRNO,
> >  			"failed unexpectedly; expected %s",
> > -		        tst_strerrno(tcases[i].error));
> > +			tst_strerrno(tcases[i].error));
> > +		return;
> > +	}
> Could you please replace TEST(ioctl(...) with TST_EXP_FAIL(ioctl(...))?
> That would save all error handling.

> We try to use these helping macros in include/tst_test_macros.h.
> Although they would deserve some docs as macros are a bit harder to read.

I implemented this in 4c86809f77 ("ioctl01: cleanup"). Could you please rebase
your commit and use TST_EXP_FAIL() in it?

Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
