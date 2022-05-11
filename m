Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CAAC433EF
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 11:53:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 082F53CA990
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 13:53:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BBDC3CA974
 for <ltp@lists.linux.it>; Wed, 11 May 2022 13:53:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1ED2A14001FC
 for <ltp@lists.linux.it>; Wed, 11 May 2022 13:53:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2AAB3219FB;
 Wed, 11 May 2022 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652269982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Xuwq3KLeMeZh7gwKp6kwTXY+2KQStsRHCVh5Oe6Q1w=;
 b=uCBv3N/WjahNzQjRGOtxCytGcUMBJzS5GMUQrTh0obWeV/LQu/H54D9CTlfVp91n3DWeu9
 R1Bw+xm2vZ4gNDTqaCHAsUlHmm9JVOesRpCMe74S8bc++FOj7+IBWl+zAEwvWPlTjppzTa
 qFnkGGYdgI3LnFE+V01JBeRBmglDbzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652269982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Xuwq3KLeMeZh7gwKp6kwTXY+2KQStsRHCVh5Oe6Q1w=;
 b=69ryuLIu0MPxoovv4WCNKQWWOQSCPkEhClZbSj4+EYshZcsIahBpXM3wvrrnoEm44t4vKC
 UG0Pe42DuArAXRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 142FF13A76;
 Wed, 11 May 2022 11:53:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3f2jA56je2I1VAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 11 May 2022 11:53:02 +0000
Date: Wed, 11 May 2022 13:55:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YnukIyHN39MO5lLN@yuki>
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-2-chrubis@suse.cz>
 <CAEemH2eydibco7J0nmgzi2DnMi9Z8iGpj5eqHxDXnhNwhmU1Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eydibco7J0nmgzi2DnMi9Z8iGpj5eqHxDXnhNwhmU1Kw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 01/30] Introduce a concept of max runtime
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > --- a/doc/user-guide.txt
> > +++ b/doc/user-guide.txt
> > @@ -25,6 +25,10 @@ For running LTP network tests see
> > `testcases/network/README.md`.
> >  | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is
> > useful for
> >                            slow machines to avoid unexpected timeout).
> >                            Variable is also used in shell tests, but
> > ceiled to int.
> > +| 'LTP_RUNTIME_MUL'     | Multiplies maximal test iteration runtime.
> > Tests
> >
> 
> Seems 'LTP_RUNTIME_MUL'  does not take effect, maybe there is a bug
> in saving multiply runtime to results->max_iteration_runtime?
> 
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1634,7 +1634,7 @@ void tst_run_tcases(int argc, char *argv[], struct
> tst_test *self)
>         SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
> 
>         if (tst_test->max_iteration_runtime)
> -               results->max_iteration_runtime =
> tst_test->max_iteration_runtime;
> +               results->max_iteration_runtime = multiply_runtime();
> 
>         set_timeout();

My bad it's actually used in the -h switch but not when the runtime is
actually set. Will fix.

> $ LTP_RUNTIME_MUL=2 ./test_runtime01
> tst_test.c:1522: TINFO: Timeout per run is 0h 00m 35s
> test_runtime01.c:16: TINFO: Remaining runtime 5
> test_runtime01.c:16: TINFO: Remaining runtime 4
> test_runtime01.c:16: TINFO: Remaining runtime 3
> test_runtime01.c:16: TINFO: Remaining runtime 2
> test_runtime01.c:16: TINFO: Remaining runtime 1
> test_runtime01.c:16: TINFO: Remaining runtime 0
> test_runtime01.c:20: TPASS: Finished loop!
> 
> Summary:
> passed   1
> failed   0
> broken   0
> skipped  0
> warnings 0
> 
> 
> +++ b/lib/newlib_tests/test_runtime02.c
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2021, Linux Test Project
> > + */
> > +/*
> > + * This test is set up so that the timeout is not long enough to guarantee
> > + * enough runtime for two iterations, i.e. the timeout without offset and
> > after
> > + * scaling is too small and the tests ends up with TBROK.
> > + *
> > + * You can fix this by exporting LTP_MAX_TEST_RUNTIME=10 before executing
> > the
> >
> 
> I didn't find where to achieve this LTP_MAX_TEST_RUNTIME function in the
> patchset.

That is a leftover from the v1 of the patchset that should be removed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
