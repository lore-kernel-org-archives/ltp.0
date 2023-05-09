Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502E0C7EE22
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 05:53:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 868CA3CD6EC
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 07:53:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 129A73C25BE
 for <ltp@lists.linux.it>; Tue,  9 May 2023 07:53:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F188860070D
 for <ltp@lists.linux.it>; Tue,  9 May 2023 07:53:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 69DBD21A6D;
 Tue,  9 May 2023 05:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683611578;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yt/0ZE7GGTqI6gECQ2dHVLUjeBS5apTMxiBd6Riikb8=;
 b=e/v+mTTWBJIy62Jb5EJicqYuSE34L/ZdGvJ/ItT/HceYDAoco1gtKeLlwCCBDJOf7QNvY1
 MV1CCtpBf23HfDkAmUcXzt71jUzyrullfCkU2/HbIJKZ6WwzJjXQ+DvUvVjAsigjReQLJr
 /sMQdaM7XsxHFGk79U2Y1IAb9IBVw/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683611578;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yt/0ZE7GGTqI6gECQ2dHVLUjeBS5apTMxiBd6Riikb8=;
 b=V/veJRziWRDLzNSZGWW6WVKs/2xyE4jL5MeCyn1o2d6Vsk884xTmYh1bk+rEik2tJQxCPA
 FMpX4QzW0/pXdpCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 535FB1346B;
 Tue,  9 May 2023 05:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3DJFE7rfWWSIegAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 09 May 2023 05:52:58 +0000
Date: Tue, 9 May 2023 07:52:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230509055256.GB128837@pevik>
References: <20230321110337.22970-1-wegao@suse.com>
 <20230505173137.GB31348@pevik> <ZFe1VgRXMggwVwV3@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZFe1VgRXMggwVwV3@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] starvation.c: New case for sched starvation
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Fri, May 05, 2023 at 07:31:37PM +0200, Petr Vorel wrote:
> > Hi Wei,

> > > +static struct tst_test test = {
> > > +	.test_all = do_test,
> > > +	.setup = setup,
> > > +	.forks_child = 1,
> > > +	.needs_checkpoints = 1,
> > > +	.max_runtime = 120,
> > Are you sure 2 min is enough? Maybe we need to use tst_remaining_runtime() to
> > check if we're not running out of time.

> Seems difficult to check with tst_remaining_runtime since i can use code such as:
> while(tst_remaining_runtime()) 
> 	wait_for_pid();

If you don't know how to use tst_remaining_runtime() how about getting
inspiration from lib/newlib_tests/test_runtime01.c ?

static void run(void)
{
	int runtime;

	tst_res(TINFO, "...");

	do {
		runtime = tst_remaining_runtime();
		tst_res(TINFO, "Remaining runtime %d", runtime);
		sleep(1);
	} while (runtime);

	tst_res(TPASS, "Test passed");
}

static struct tst_test test = {
	.test_all = run,
	.max_runtime = 120,
};

=> Also, it's a question, how long should the test be running.
Is it worth to be running for 2 mins? It's kind of stress test, right?
But even that wouldn't be 30 sec enough?

Kind regards,
Petr

> > Also, if we set getopt to choose number of options, we'd need to adjust it by
> > tst_set_max_runtime().

> > Kind regards,
> > Petr

> > > +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
