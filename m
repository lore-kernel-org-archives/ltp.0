Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FBAC4332F
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 15:59:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C54533CF395
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 16:59:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8D5F3C0B8E
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 16:59:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 468D2601416
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 16:59:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1CE40211E1;
 Tue, 31 Oct 2023 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698767973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uEwJ5XRtPSIL7PQjv785PLviQ3pQEhYWg8GFSnIThFQ=;
 b=2m01em1XbQAGbsRef4X19+FrXT7gGgFLxRxXw7EWhsvul/TfbqFIBjFsanGIG4flHhNw4R
 VnWrf/As/FznictePcIUeDuV0zy67k8JJcS58ooErJADNGrJ50QbRO2TC8FLrsBwcB6ymz
 VKAddh5JtDc7K1aixl7ymwqlqX99WjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698767973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uEwJ5XRtPSIL7PQjv785PLviQ3pQEhYWg8GFSnIThFQ=;
 b=u1dKmvqzwCvqjVZm01z/PDsAqD8cmqiNRePWENiZ1jQqJibNrDdZIeo0+IXxV+UYuDewJ9
 gRkkjv3asdRwuODg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08A11138EF;
 Tue, 31 Oct 2023 15:59:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3aRBAWUkQWW7RAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 31 Oct 2023 15:59:33 +0000
Date: Tue, 31 Oct 2023 17:00:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZUEkhFYIJogalhpq@yuki>
References: <20230906080950.23155-1-andrea.cervesato@suse.de>
 <87a5sw10qb.fsf@suse.de> <87zfzzrvbc.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zfzzrvbc.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor fork12 using new LTP API
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
> This test also randomly fails outside of a container. Also other tests
> that are testing the limits. This makes me think more that setting lower
> prlimits is needed. Also this rewrite gets higher priority.

Just note that this test is not in syscalls runtest file but in the
crashme runtest file, which contains highly questionable stuff.

I guess that the original test does not really take things like
overcommit and OMM into an account, so shifting the test goals by
setting the RLIMIT_NPROC so that we effectively check that the
limits are enforced is probably reasonable way how to fix the test.
Either we do that or we remove fork12.c.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
