Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8282FC433EF
	for <ltp@archiver.kernel.org>; Fri,  3 Jun 2022 13:21:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B75D13C880A
	for <ltp@archiver.kernel.org>; Fri,  3 Jun 2022 15:21:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED9BC3C868B
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 15:20:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 58A3E200274
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 15:20:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 73EBE21A99;
 Fri,  3 Jun 2022 13:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654262455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lpe7vFjqiFVW6j3HOGJMJ0cxOfU6QvldNpih+3LkH0E=;
 b=YAFRa0e4rLX5qs3F3fmjwzaD7+tjxcVBOe31FgSibAxgWoO2CXa72k5iFDwRuxDloO5SAd
 592VXWpcF1Fpu9DLv/Ku+tPOc7LAcdNJPIiL7jraXKOMyNqUDymYKZobtM6GNTkxrfhL8v
 sjkMOHlOHtptDJolt/NOFO5vZvB8Zw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654262455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lpe7vFjqiFVW6j3HOGJMJ0cxOfU6QvldNpih+3LkH0E=;
 b=+n38GTVTqY64KUadwS08ojRjSRhFHvzYrNBWINutC7GnYLu7pDKtKQmplrwqRQruZvOwfO
 TubsRHhzOStI49Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D05F13638;
 Fri,  3 Jun 2022 13:20:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EolHFbcKmmJCdgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 03 Jun 2022 13:20:55 +0000
Date: Fri, 3 Jun 2022 15:23:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YpoLN+fBttUaBDym@yuki>
References: <20220512194557.30911-1-pvorel@suse.cz>
 <20220512194557.30911-4-pvorel@suse.cz> <YpTS99QLyFfSkrnl@rei>
 <Ypn9kQF7PTM3pA0n@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ypn9kQF7PTM3pA0n@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/8] tst_test.sh: Improve pattern for allowed
 variables
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > >  	if [ -n "$TST_TEST_PATH" ]; then
> > > -		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
> > > +		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`'"'"'].*//'); do
> >                                                                                            ^
> > 											   Isn't
> > 											   the
> > 											   content
> > 											   between
> > 											   []
> > 											   just
> > 											   set?
> 
> > Shouldn't adding just ' between the [] suffice? The " is already there.
> 
> Well, '"'"' was my version of adding ' (quoted with " and ' at the start and end
> were for ending previous '.
>
> But this is shorter: '\'', therefore suggest
> 
> -		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
> +		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[='\''"} \t\/:`].*//'); do

I would say that '\'' is stil insane, but I guess that we can't do
better than that.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
