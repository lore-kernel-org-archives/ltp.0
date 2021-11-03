Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B57EC433EF
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 11:08:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4009C610EA
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 11:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4009C610EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 795173C71CF
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 12:08:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34B6B3C1B3C
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 12:08:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 54714200DD1
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 12:08:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E7DB1FD4F;
 Wed,  3 Nov 2021 11:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635937684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DCtDMyEpwTxjMb+BxHnV339ERVNUwBCmPnIhX5aRpjs=;
 b=fpSG5BaFKXDXZhwXmep+kNVa5exRCcmy1Fx2nVll2QhQ3LCUmw3VjsraUXxvlvGoUBgnBC
 JkdMZnJsyO4gMkYDmHf7PBRdeOeMX8MxKqJdg4Ojf8m7HBRw++mceOq9gsuugwrNk/DS/e
 9PW4o4fPKEvd+vaz+9FvA13H5odHhKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635937684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DCtDMyEpwTxjMb+BxHnV339ERVNUwBCmPnIhX5aRpjs=;
 b=mvEsPEWJozUfJDFANL0PpqxhzJSeVTrtZYTkuIXhR8VRObYRa6nPMVVKXqIjrHKx4w/Kry
 seXY1lx7BDgADlBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C01A13CCA;
 Wed,  3 Nov 2021 11:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nexODpRtgmF+KQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 03 Nov 2021 11:08:04 +0000
Date: Wed, 3 Nov 2021 12:09:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YYJtzPQCAjvmgv05@yuki>
References: <20211025160134.9283-1-chrubis@suse.cz>
 <20211025160134.9283-3-chrubis@suse.cz> <87bl31o6ek.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bl31o6ek.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] lib: Add .max_runtime and
 tst_remaining_runtime()
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
> > This is another attempt of decoupling test runtime from timeouts.
> 
> Do we have documentation explaining what runtimes and timeouts are?
> 
> These two words are interchangeable.

Not yet I plan to rewrite documentation once things are finalized
enough.

> > Fundamentally there are two types of tests in LTP. First type are tests
> > that are rather quick (much less than a second) and can live with
> > whatever default timeout we set up. Second type of tests are tests that
> > run in a loop until timeout or a number of iterations is reached, these
> > are the tests that are going to be converted to the .max_runtime added
> > by this patch and followups.
> 
> The code looks good, but this all feels quite hard to parse on a
> more abstract level. I think it is because you are trying to over
> generalise between different categories of test.
> 
> So we have tests which run to completion as fast as they can. Then we
> have tests which iterate for some arbitrary time period (usually capped
> by some number of iterations as well, but it's not important).
> 
> In the first case the concept of a target runtime makes no sense. So we
> end up with 'max runtime' which is the same type of thing as the timeout
> (although the value of timeout is greater).
>
> In the second case, where the test tries to execute for some length of
> time. Then the target runtime and timeout are really seperate things.
> 
> I would suggest renaming 'max_runtime' to just 'runtime' and make it
> optional (defaults to 0). All tests which are of the second type can set
> .runtime = DEFAULT_RUNTIME (or whatever). If the test tries to use
> tst_remaining_runtime() without runtime being set, then an error is
> thrown.

That more of less what the patchset attempts to do. It hardcodes the
runtime as a number instead of having DEFAULT_RUNTIME constant though.

> If runtime is present then it can simply be added to the timeout to
> produce the "total timeout" (total_timeout = runtime + timeout).

I guess that would work reasonably well.

> This has the advantage of clearly showing in the meta data which tests
> are likely to run for some time. Also it means that the concept of
> 'runtime' doesn't change depending on the type of test. Finally we can
> set timeout very low by default.
> 
> So when calculating how long a test executable may run for we have
> 
> (runtime + timeout) * variants * iterations
>
> The wording is still not great. runtime is more like "deliberate
> runtime" and timeout is "maximal expected runtime after the deliberate
> runtime".

Sounds good. I will work on v2 that would include these changes.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
