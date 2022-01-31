Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4188FC433F5
	for <ltp@archiver.kernel.org>; Mon, 31 Jan 2022 07:21:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54EBE3C97FA
	for <ltp@archiver.kernel.org>; Mon, 31 Jan 2022 08:21:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAFFF3C2159
 for <ltp@lists.linux.it>; Mon, 31 Jan 2022 08:21:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 880EE140098F
 for <ltp@lists.linux.it>; Mon, 31 Jan 2022 08:21:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D00121100;
 Mon, 31 Jan 2022 07:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643613675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kSCTMZFRSTKsTRgaIXrWuXrHrwfHq/Hn567W+OTnU/0=;
 b=pzZkzEa113Us/0d8PbXRq9ELS6cTPdGNdo9EB68JKoRR3iiTJtMhzSQ8NNasT9/kXlOlPL
 /3D2Jxbm5/w+/oAOh/i6mW7lXfvbDIqJtYOeEQXCSStXI8N07pduXy826RTUYVFoGd+Oxi
 5RLcMuGJkmBRzhLzUjOnRROiPxFDwxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643613675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kSCTMZFRSTKsTRgaIXrWuXrHrwfHq/Hn567W+OTnU/0=;
 b=FckHMtJlTK3u/4ATzM31iBKCkZn8gnCAZ5LHU4DcZ3oVEs7779vzBDw1XNoZDmtIHa6bCe
 IKsj5MmgNJRs9eBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F84013638;
 Mon, 31 Jan 2022 07:21:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zhQeDuuN92ESRAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 31 Jan 2022 07:21:15 +0000
Date: Mon, 31 Jan 2022 08:21:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YfeN6fG28AVNC44n@pevik>
References: <20220127171455.9809-1-pvorel@suse.cz>
 <61F609C7.1080803@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61F609C7.1080803@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run
 at all
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

...
> > +++ b/lib/tst_test.c
> > @@ -811,6 +811,9 @@ static void do_exit(int ret)
> >   		fprintf(stderr, "broken   %d\n", results->broken);
> >   		fprintf(stderr, "skipped  %d\n", results->skipped);
> >   		fprintf(stderr, "warnings %d\n", results->warnings);
> > +		fprintf(stderr, "not run  %d\n", tst_test->tcnt -
> > +				results->passed - results->failed - results->broken -
> > +				results->skipped - results->warnings);
> IMO, these values are not necessary related. Refer to quotactl01.c( 
> tst_test->tcnt is less than results->passed)
Ah, correct. Also .test_all means tst_test->tcnt to be 0.
So my patch is utterly wrong.

> Also, if you want to add a new tag, you should define the situation for it.

What is my point: number of the defined tests does not mean they are all run.

Maybe printing number of the tests in the test (tst_test->tcnt or 1 when
tst_test->test_all)?

My point is to have an idea without looking into the code know how many tests
have been skipped on certain setup.

Kind regards,
Petr

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
