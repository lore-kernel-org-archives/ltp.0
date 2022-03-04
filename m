Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E074EC433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 08:02:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2510B3CA33A
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 09:02:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DCB33C96D2
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 09:01:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6A0BE201095
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 09:01:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 529121F385;
 Fri,  4 Mar 2022 08:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646380909;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4VuofUepdj1Bynl8NnKzvtGJ25lEaan2gXDuXU3jW8I=;
 b=qXp+PQScJ5DGHXOECpLZtAs+DvnF7q+a9YRxN6KbTeiHCFCWS61C1kVIURj8L+m1R1xaK2
 BXjC/AEGju0y4bBR/YQON/bHq+OGBHQP1C6uK9Z3u/oNZDM93tNJbuncsJeGZc7I8+iUjF
 9T4XdNG6rnlNpAKKTeNyO3ksCDapm50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646380909;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4VuofUepdj1Bynl8NnKzvtGJ25lEaan2gXDuXU3jW8I=;
 b=o8HI2vp3RKKpASYl7hEAqT9srOxUzpp1F11r9uxAjXkBk3mpgNAdFyP2kmYvSAws8w21kl
 wZo2neP/IeIWO+CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2AE651340A;
 Fri,  4 Mar 2022 08:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3z3PCG3HIWKcWgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 04 Mar 2022 08:01:49 +0000
Date: Fri, 4 Mar 2022 09:01:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YiHHa51Lekmkpp6u@pevik>
References: <1646297678-2141-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YiDK7g1pwLj2aXBD@pevik> <6221869A.9040109@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6221869A.9040109@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setsockopt09: Add another linux git
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr
> > Hi Xu,

> >> On centos7.9ga, I still hit another crash problem because of use-after-free in
> >> prb_retire_rx_blk_timer_expired(). Since we free it when timer expired, so this
> >> case will crash after we print TPASS info.

> > Reviewed-by: Petr Vorel<pvorel@suse.cz>

> > LGTM.
> > I tested two old kernels, the one with patch survives, the other got reboot.

> > BTW funny enough the affected system manages to print "TPASS: Nothing bad
> > happened, probably" before reboot :).
> Yes, it crash when timer expired, so it will print TPASS before reboot. 
> Also, I try sleep 10ms, but it still print TPASS and reboot after serval 
> seconds.

> I have wrote it in my commit message, so this should  be friendly for 
> user to know this situation.

Sure, I didn't expect we would be able to fix this (I'm *not* voting for sleep
10+ s). It can just be a bit confusing when you read test logs if the framework
does not clearly show that system got rebooted (I saw reset in dmesg but didn't
believe it's caused by this test output due TPASS. Lesson learned :)).

Kind regards,
Petr

> Best Regards
> Yang Xu

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
