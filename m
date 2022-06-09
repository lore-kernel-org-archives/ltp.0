Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9D6C433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 12:31:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BF233C91FC
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 14:31:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 609303C1424
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 14:31:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A220C14010DB
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 14:31:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C9E4D1FE57;
 Thu,  9 Jun 2022 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654777888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GlyD/9rIneT+BwBBmN1Y9oNHRh6bsyKesrET/XLYgTo=;
 b=ev8DMpCB+0cZEQK7k7ATcpfu+vRF4xlHexy/9sh3xRu0VVvKvuO6jnM3ZFcYL86nm9byRa
 /A6RxaEc6ycXb+CjJb+3msee74+7S8AmbmuIJEJ9Z5vPJHvTU6G79prQhXzg7GNkyWa+xG
 bncbtJ51YGRUJBAhlGyicq//vcPuj9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654777888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GlyD/9rIneT+BwBBmN1Y9oNHRh6bsyKesrET/XLYgTo=;
 b=wIY+85bvGnv0gp8hpPbbGuwwmk5W3YANRVAl6gEY+UDsczysd2opHcwBFKxf115NJOeXjX
 EDnd4G1GlNxKUcCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72C2B13A8C;
 Thu,  9 Jun 2022 12:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id C7bAGiDooWLsPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 09 Jun 2022 12:31:28 +0000
Date: Thu, 9 Jun 2022 14:33:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YqHon8fNg2+Jqody@yuki>
References: <3e9f91c4-b94b-21c4-4cfa-cb39af5e1110@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3e9f91c4-b94b-21c4-4cfa-cb39af5e1110@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Open Posix Testsuite install layout
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I am currently reviewing openembedded's recipe ([1]). It is currently
> installing the openposix testsuite twice: Once in
> /opt/ltp/testcases/open_posix_testsuite and also directly into
> /opt/ltp/. This is probably due to the fact, that the open posix
> testsuite had no install target until 20110606 and then it was installed
> into a different directory:
> 
> 
> 
> 
> In 3b808b4 ("Add install target; shuffle around/cleanup code."), make
> install was added to open posix testsuite, but the install layout is a
> bit odd.
> 
> It installs:
> 
> /opt/ltp/bin/run-all-posix-option-group-tests.sh
> /opt/ltp/bin/t0
> /opt/ltp/bin/run-tests.sh
> /opt/ltp/bin/Makefile
> /opt/ltp/bin/run-posix-option-group-test.sh
> 
> This is mostly ok, although run-tests.sh should be called
> run-posix-tests.sh, otherwise it looks like it would run "normal" ltp tests.
> And the scripts are structured a bit weird, at least
> run-all-posix-option-group-tests.sh and run-posix-option-group-test.sh
> could be merged into a single script. And
> run-all-posix-option-group-tests.sh does not execute all tests, but only
> (maybe not even all) conformance/interface tests. Based on the name of
> the script and the available documentation, this makes sense, but I
> don't see how these scripts are useful. Why would anyone want to only
> run tests for optional posix features, but not for other?

No idea about these choices, there is a lot of historicall mess in there
feel free to clean things up.

> The Makefile shouldn't be installed at all.

Sure.

> But what is worth is the fact, that the open posix testsuites are
> installed directly into /opt/ltp
> 
> /opt/ltp/stress
> /opt/ltp/conformance
> /opt/ltp/functional
> 
> They should be installed into /opt/ltp/testcases/open_posix_testsuite or
> maybe /opt/ltp/open_posix_testsuite otherwise it is very confusing.
> This would of course require the shell scripts, that execute open posix
> tests to be changed during installation (currently they use "$(dirname
> "$0")/../conformance/interfaces"). Additionally all generated run.sh
> scripts would need adaption, as they use run-tests.sh.

Another option would be /opt/open_posix_testsuite/ since apart from
being in the LTP git repository these are not integrated with the rest
of the LTP at all.

> I would propose and volunteer to:
> 1. Move testsuites to /opt/ltp/testcases/open_posix_testsuite
> 2. Move run-tests.sh and t0 to /opt/ltp/testcases
>    /open_posix_testsuite/bin, because it is only used by run.sh scriptss
>    from the suites directories
> 3. Fix paths in run-posix-option-group-test.sh during installation
>    (or drop them completely? Are they even used by anyone?)
> 2. Remove the Makefile from /opt/ltp/bin

Sounds good.

> For the future it would probably be a good idea to integrate the tests
> into the default ltp testrunner or at least provide something, that can
> execute the installed tests automatically. But to be honest, I don't
> care about this, because we are executing the tests with our own testrunner.

This is in the long term plan for the new LTP testrunner, hopefully we
will have something by the end of the year.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
