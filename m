Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20903C433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 10:19:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F33B3C9797
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 12:19:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 167C53C8DD1
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 12:19:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3BB79600699
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 12:19:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 349211FA96;
 Tue, 19 Jul 2022 10:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658225963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xrx66C4s7d2P8fhGvGcFcx08EI8kS7XBLta/n+5Rr/4=;
 b=zEz2CEgF1cVLKaS2Q9gbYzlHdsESAe4h5mJIDmpngcKKTPOB2kZ2tUAU0TOEZX2+GU+ZRK
 Aon4zmethISvI8mfio6Qffj3zZZVf1qR7ihCUJkloNkaMDVHEloTwzzVPZrRx8x77uueyi
 Y695UUwxccXmu7TiiEpdmhwA8cSYF2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658225963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xrx66C4s7d2P8fhGvGcFcx08EI8kS7XBLta/n+5Rr/4=;
 b=CrBRL3myCjh+hQFgkvxqvqskFYrpGKlrmwjQ5XRJfQUuvbEfo72AN1/itQddt3aGp6q0hP
 sQB4+knJ2oD0RTAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E5DF13488;
 Tue, 19 Jul 2022 10:19:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id G2beBSuF1mLGfgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 19 Jul 2022 10:19:23 +0000
Date: Tue, 19 Jul 2022 12:20:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <YtaFddMFjVPMTpme@rei>
References: <20220712173921.2623135-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220712173921.2623135-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/signal06: add volatile to loop
 variable
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> On Android compiled with clang, the loop variable will be optimized out
> unless it is tagged with volatile.

Looking at the code it looks strange that it's optimized out since we
use the value for the loop as:

	loop = 0;

	D = VALUE;
	while (D == VALUE && loop < LOOPS) {
		asm(...);
		loop++;
	}

And the D variable is properly marked as volatile so it's not like the
loop can be expected to iterate preciselly LOOPS iterations.

It looks to me like the compiler actually forgets about the volatility
of D for some reason and then assumes that the loop does LOOPS
iterations.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
