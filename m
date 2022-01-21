Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E615C433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 09:18:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E8AB3C96F1
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:18:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 522D73C9232
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:18:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E316F600D6F
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:18:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 032971F45E;
 Fri, 21 Jan 2022 09:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642756706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+g/tP3suQa3Sx1ZV3IF3Px13/PtWdA+RZ+RHgPyT+c=;
 b=eQ516/MnncyjGBmGyZ11d9NANodu18X/hjJ2mxDw0Yh9J6WoXh7ilWsLhXeaguzqJdax3r
 B3Zzf/VYy2NVvrHULB93LpxcmEnAQ7n7jRVNEJ5ibgRFaMqzFxTf41w0OJEdfo4ngHjraz
 asQUMbQMzEK0fk95CPcdGtney5o5qgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642756706;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+g/tP3suQa3Sx1ZV3IF3Px13/PtWdA+RZ+RHgPyT+c=;
 b=mCjYbC+QAz+EJT3kg/K5Z60/znCgwdlw5WwFY6BrJQa7qSFg9dQBasV25CT51qEMzFpyAF
 yTxHEAizdyQ4ABBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6E6D13C1A;
 Fri, 21 Jan 2022 09:18:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XTGdM2F66mHdTQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Jan 2022 09:18:25 +0000
Date: Fri, 21 Jan 2022 10:20:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Kautuk Consul <kautuk.consul.80@gmail.com>
Message-ID: <Yep6yovcY2qJkXSR@yuki>
References: <CAKWYkK3a-Qp5bZNyL67JkTtzD=_55c0tk7eb69rsikYr+r=QqA@mail.gmail.com>
 <Yep4yrsnTZuNPCKL@yuki>
 <CAKWYkK3-Wf7AW2Ofh_Md4q_z0SktrZwvEFVgVGOfQGO9Zyvsyg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKWYkK3-Wf7AW2Ofh_Md4q_z0SktrZwvEFVgVGOfQGO9Zyvsyg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] msgstress03: "Fork failed (may be OK if under stress)"
 problem observed on qemu.
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
> Thanks for the quick response. Any idea when changes to these
> test-cases is merged in the mainline ?

The current patchset is not finished, so unless somebody picks up the
patchset to finish it it's not going to get merged at all...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
