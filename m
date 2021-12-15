Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52147C433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 11:34:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C2183C8E61
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 12:34:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91D603C0B90
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 12:33:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A51D31001365
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 12:33:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E34001F382;
 Wed, 15 Dec 2021 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639568031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tbgmenaWCu+vbVfqIO1YHZLGuUz7Z4sWxdcf5Xo8IIE=;
 b=1VMIhGgbQdROisuVeZ7eiobVvFK2YiFBwCVZUgYsJQMBIGRm+6aoEFts54fRBhyRS+USbj
 Kl0tVPWgcjQuW4zcNM0EVSk4BwPahjYfaUZYw+WimnUJ57h76WC5fCGs7aTfX7aWg/Cx55
 jXkEAogbK6Eo3xVgYPUkWOPZc0Pv52s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639568031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tbgmenaWCu+vbVfqIO1YHZLGuUz7Z4sWxdcf5Xo8IIE=;
 b=An4azqkSd6tK2+Aty1OSj33l540Zqm2im+vkFRDNuOUwZ/oTwhegZ9M0ZZwCmT515uU7MQ
 dpluex/Q5+IeDPBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C880513B09;
 Wed, 15 Dec 2021 11:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id D6yGMJ/SuWEhFQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 15 Dec 2021 11:33:51 +0000
Date: Wed, 15 Dec 2021 12:35:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YbnS9OiBV0V0CwuD@yuki>
References: <20211213160437.32353-1-andrea.cervesato@suse.com>
 <YbiyhLnljUy2K7Mv@pevik> <Ybi0mHK4s3X7nLlD@yuki>
 <YbjIqypOcAYAnLbl@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YbjIqypOcAYAnLbl@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Refactoring dio_append.c using LTP API
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
> > > I wonder what I'm missing:
> > > ./dio_append
> > > tst_test.c:1409: TINFO: Timeout per run is 0h 05m 00s
> > > dio_append.c:69: TINFO: Parent append to file
> > > common.h:45: TBROK: open(dio_append,16449,0666) failed: EINVAL (22)
> 
> > That's an O_DIRECT open() EINVAL probably means that O_DIRECT is not
> > supported. Is your /tmp/ on tmpfs?
> Yes. As we cannot use SAFE_OPEN() in io_read_eof() [1], there should be check
> for errno I guess.

Maybe it would be a bit cleaner to add a check that would attempt to
open a dummy file in the test setup and exit the O_DIRECT tests before
they attempt to fork children...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
