Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DADDC433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 08:50:42 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD52861056
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 08:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD52861056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76C043C885D
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 10:50:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD8753C80D4
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 10:50:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 40FBE201013
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 10:50:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 50C3320263;
 Fri, 17 Sep 2021 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631868628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mim2tiGNVEnR3Pq3eFr+ia1jvZrDNry2JjdHhKy8kNQ=;
 b=LotHA0yjXsZJyBqCydmUWcMbi4nYsy/3ZHx/pzyy5P4zamVNUjNsiThrLhV7FcjKGjcJei
 fGTyo1vhdshZ1tHsinUT95bIKLyPC5AnE1k4LClcYLb+chlK5IympAREeEvHCToB/MmxoO
 1Sgv0KRmFP0NRrHccsMGHMaUM9MZ9o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631868628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mim2tiGNVEnR3Pq3eFr+ia1jvZrDNry2JjdHhKy8kNQ=;
 b=lraE26m0k0naC1ntfDktEe9WJp5ZGDszLzqDykTTuZApFj9rk5jX2Kyyw0Sq6AOuggnDvs
 85Q0Hjnkg7Q69kAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EBCA13A8C;
 Fri, 17 Sep 2021 08:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kDKrDNRWRGGgQQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 17 Sep 2021 08:50:28 +0000
Date: Fri, 17 Sep 2021 10:50:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YURW7NKNSSr0J6pL@yuki>
References: <20210519085812.27263-1-liwang@redhat.com> <YUJ2XA7W3JPODyNC@pevik>
 <YUJ7SC/FoA8wTaf2@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YUJ7SC/FoA8wTaf2@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_test: using SIGTERM to terminate process
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
Cc: ltp@lists.linux.it, Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210917085052.fKdcS5fkC4BjlgsTL7zj8xDkMeZOsoOLRJK_Wxjokco@z>

Hi!
> setup()
> {
> 	tst_brk TCONF "quit now!"
> }
> 
> do_test()
> {
> 	tst_res TPASS "pass :)"
> }
> 
> tst_run
> EOF
> 
> # while true; do ./debug.sh; done

I managed to reproduce this in dash. I bet that this is a bug where
signal handler inside dash is temporarily disabled when we install the
trap and if we manage to hit that window the signal is discarded. At
least that is my working theory. After I've installed debug prints, in
the cases where it hangs the signal was sent just before have installed
the trap. And in some cases when the signal arrives the timer process is
killed but the trap is not invoked. So it really looks like signal
handling in dash is simply broken. Not sure what we can do about bugs
like this apart from switching to a real programming language.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
