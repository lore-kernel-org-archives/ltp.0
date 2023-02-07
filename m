Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3484C636CC
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 07:18:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E02E33CC1FE
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 08:18:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F1DD3CB14B
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 08:18:03 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 284002009EB
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 08:18:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7BB5660447;
 Tue,  7 Feb 2023 07:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1675754282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LnMOujy0BahzsgDkH3z8oK7pjeL2Rzlyk/slaztvmxY=;
 b=Srdv49Ag3pqI4IQXSkmdH1iHhjIv6ihB/7+PUlzTpbkINoHOkUkn4d+tIy7b6CmXw8zz5c
 CIwBVsMnZ4w77PfbLodxVmMWROWe/M7M8jBCqF2VviDJrFSWSQ9moF9g+XsSuDbET31LhN
 Zs+9bzvUPwRBysRxZ33P45XkQlwT79w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D46A613A8C;
 Tue,  7 Feb 2023 07:18:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zcuTKin74WPlTQAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 07 Feb 2023 07:18:01 +0000
Date: Tue, 7 Feb 2023 02:17:59 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20230207071759.GA4923@localhost>
References: <20230129183930.2045-1-wegao@suse.com> <Y+CQt2SpeMzibUDT@pevik>
 <Y+CaO23SoWkuOJNy@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+CaO23SoWkuOJNy@pevik>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Feb 06, 2023 at 07:12:11AM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> > Hi Wei,
> 
> ...
> > > @@ -64,7 +66,21 @@ static void verify_ioctl(unsigned int i)
> > >  	if (TST_ERR != tcases[i].error) {
> > >  		tst_res(TFAIL | TTERRNO,
> > >  			"failed unexpectedly; expected %s",
> > > -		        tst_strerrno(tcases[i].error));
> > > +			tst_strerrno(tcases[i].error));
> > > +		return;
> > > +	}
> > Could you please replace TEST(ioctl(...) with TST_EXP_FAIL(ioctl(...))?
> > That would save all error handling.
> 
> > We try to use these helping macros in include/tst_test_macros.h.
> > Although they would deserve some docs as macros are a bit harder to read.
> 
> I implemented this in 4c86809f77 ("ioctl01: cleanup"). Could you please rebase
> your commit and use TST_EXP_FAIL() in it?
Done, could you help check it, thanks!
> 
> Thank you!
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
