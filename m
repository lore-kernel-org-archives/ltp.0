Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0CCC433F5
	for <ltp@archiver.kernel.org>; Tue, 24 May 2022 09:26:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C56E3CAC36
	for <ltp@archiver.kernel.org>; Tue, 24 May 2022 11:26:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96B2D3C0895
 for <ltp@lists.linux.it>; Tue, 24 May 2022 11:26:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2F4FD1400B69
 for <ltp@lists.linux.it>; Tue, 24 May 2022 11:26:04 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 72C461F8E6;
 Tue, 24 May 2022 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653384364;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qkL+612stYDRgftMUF7X1zVAlFbja6zahyaJGYOKKh0=;
 b=YhV2p5+8tWnUGoZLOqSogKBw1+wcxHoMl+tHXb8CoQr1ZGA74Ox29LLMjpCTq3iiMH6qvk
 a7mMx18RGYR531S7umCcjl8QxZJ6pP4rVZgM5XJO4h63uBX8s4Cb3DSot7T2qBEHMHUYZV
 QFZTLs8jPkR6j7r04fTww7WZXEfnVYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653384364;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qkL+612stYDRgftMUF7X1zVAlFbja6zahyaJGYOKKh0=;
 b=jeiN09rwOMh38RBTId4orJBuEvOXvszNlRVK4n9WH7NaYUETozG/dOVklZ7KUFJ6xn3VvL
 RpvMU9b7PjZeBiAA==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2F4CB2C141;
 Tue, 24 May 2022 09:26:04 +0000 (UTC)
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-2-chrubis@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 May 2022 10:25:22 +0100
In-reply-to: <20220512123816.24399-2-chrubis@suse.cz>
Message-ID: <87zgj7qo2c.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v3 01/29] Introduce a concept
 of max runtime
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

"Cyril Hrubis" <chrubis@suse.cz> writes:

> This commit introduces a concept of max test runtime. In other words
> test runtime is capped at a certain value in order to make testruns more
> deterministic. Test is free to to finish before the runtime is used up,
> for example when maximal number of iterations was reached, but test must
> stop once the runtime has been used up.
>
> Testcases that run for more than a second or two must check for
> remaining runtime by regular calls to tst_remaining_runtime() and should
> exit when zero is returned.
>
> The test max runtime must be set either by the .max_iteration_runtime in
> the tst_test structure or in the test setup by a call to
> tst_set_runtime().
>
> The test timeout is then computed as a sum of DEFAULT_TIMEOUT (currently
> set to 30 seconds) and the test runtime. The DEFAULT_TIMEOUT is nothing
> more than a safety margin for teardown of the test.
>
> This commit also maps the -I parameter to the test max runtime if
> available and introduces LTP_RUNTIME_MUL enviroment variable so that we
> have an easy controll over the runtime cap.
>
> Lastly but not least the function related to the timeout are turned into
> no-op by this commit and removed after all test are converted to the
> runtime API.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
