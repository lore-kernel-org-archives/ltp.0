Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B36C54EE9
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 08:26:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 532193CACC7
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 10:26:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22C2A3CA493
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 10:26:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 222E6600869
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 10:26:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 58A291F9E3;
 Mon, 19 Sep 2022 08:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663575970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VBEullX66gim8BXlwf6kUfckyjqc0Ydh3YSstLi1K0=;
 b=x58pMRONmXHbSuaH3oVec+i/uFtQIcA+k5a3FvefBnw7Hoj+H9HRxg0E5qY4BEgMB4JJVk
 Xi7nRVedt+KMTL4EehJf5DU8Xqip8Gv5mLclZaKlri3ui9fNr22PHP9qM/NqPiumsJzfDc
 yzdBTkS1s9buSu1rmkWZ4Pusre9pmJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663575970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VBEullX66gim8BXlwf6kUfckyjqc0Ydh3YSstLi1K0=;
 b=pfZwj9CICIGfP9Puy2uELY3myBplVAnR90kKRxVAdPGRj74bDjCrixfNEmT+nI4TFq/OZj
 q+3T+6/3uBUHbGDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4509113ABD;
 Mon, 19 Sep 2022 08:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id B6DoD6InKGP0OQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 19 Sep 2022 08:26:10 +0000
Date: Mon, 19 Sep 2022 10:28:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YygoFpOWW4Cuh2BB@yuki>
References: <010001834b528ae5-11a8d4c7-4e72-4f8d-af66-e9ec2a864017-000000@email.amazonses.com>
 <YyfeaeMsvACB5dcf@pevik>
 <CAEemH2ddod62+jkLjvxbNAwPxF8DrVGcyH3fKEJfkLrGaLZJng@mail.gmail.com>
 <CAEemH2cLKhrE5SVjfd5Got3adf9+C0dJeuP-qY_r98fDUr2gMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cLKhrE5SVjfd5Got3adf9+C0dJeuP-qY_r98fDUr2gMQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for cea142b
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
Cc: Martin Doucha <martin.doucha@suse.com>, lkft@linaro.org,
 lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > tst_pollute_memory() consume time is proportional to the amount of
> > free RAM, it is hard to find one fixed value of max_runtime to fit all test
> > platforms.
> >
> > From my experience, if you limited this test only run with small
> > machine (e.g. RAM <= 32G), that performs well with whatever
> > bare metal or VM, no timeout ever.
> >
> 
> Btw, we did that by setting a test filter before LTP running, also we could
> add a field .max_mem_avail to tst_test struct for achieving that, but not
> sure if it's worth doing that at this moment.

The proper solution will be adding a separate timeouts for setup/cleanup
and limiting the setup runtime to something sensible, but that is
something for the next development cycle.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
