Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153E3C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 12:48:46 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4593360ED4
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 12:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4593360ED4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47E683C6859
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:48:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2895C3C21FD
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 14:48:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F02B410009FA
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 14:48:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3F7DB218F6;
 Tue, 26 Oct 2021 12:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635252512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1d67UEL2VZfcE9+Luu2zmU2LMxXTrJ9bejJylfzI3Fk=;
 b=QYCOC0HJG74ZM3n4vwYQxnHkmFWOVPrJIUVt/uIdfm2buZ/QM2lB6MfbRMgh5A6fvSUyb2
 8LUv99pnlXEWDf8xqBtk1zQMXbKHLI7MeCowJj5Qn/d0wlNm5SvhHy4ax/S07M+gV3AXVD
 sbz6evBlm5Xhc7IVTqqp5L/jaU7wQtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635252512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1d67UEL2VZfcE9+Luu2zmU2LMxXTrJ9bejJylfzI3Fk=;
 b=UGoTUcGMua2Oso5FWqzueP2tUZePwjr0rQ4SGlhGqcYIQEtaZRmErmOKmvyDrrSicdj3oP
 uXHPYRDcNKEGraAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B31C13AAC;
 Tue, 26 Oct 2021 12:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tjoJCiD5d2GwXwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Oct 2021 12:48:32 +0000
Date: Tue, 26 Oct 2021 14:49:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YXf5UUK3BsUWRBJK@yuki>
References: <20211025160134.9283-1-chrubis@suse.cz>
 <20211025160134.9283-3-chrubis@suse.cz>
 <CAASaF6ziq8EbnvywTtdJeSfQkcyE7Gvc9Rn9NK-rk-gimp6ysg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6ziq8EbnvywTtdJeSfQkcyE7Gvc9Rn9NK-rk-gimp6ysg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Fundamentally there are two types of tests in LTP. First type are tests
> > that are rather quick (much less than a second) and can live with
> > whatever default timeout we set up. Second type of tests are tests that
> > run in a loop until timeout or a number of iterations is reached, these
> > are the tests that are going to be converted to the .max_runtime added
> > by this patch and followups.
> >
> > This patch does:
> >
> > - adds .max_runtime to tst_test structure - this is the maximal runtime
> >   per test iteration
> 
> I'm looking at the series, but I'm not sure I see much difference between
> runtime and timeout. Other than some margin added by library (the MAX formula)
> is there some other difference?

Well it mostly makes the code simpler and clearer since we can, for
instance, map the -I option to the test runtime in the library, we got
rid of all the custom test options for that, etc.

But it also allows us to tune the timeouts based on the expected runtime
so that the test has enough time for a cleanup and we can do that in a
single place rather than in 20 different heuristics in a different
testcases.

> > diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
> > index 220130f4b..e43bc5888 100644
> > --- a/testcases/kernel/syscalls/move_pages/move_pages12.c
> > +++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
> > @@ -153,7 +153,6 @@ static void do_test(unsigned int n)
> >         void *ptr;
> >         pid_t cpid = -1;
> >         int status;
> > -       unsigned int twenty_percent = (tst_timeout_remaining() / 5);
> >
> >         addr = SAFE_MMAP(NULL, tcases[n].tpages * hpsz, PROT_READ | PROT_WRITE,
> >                 MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
> > @@ -198,7 +197,7 @@ static void do_test(unsigned int n)
> >
> >                 SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
> >
> > -               if (tst_timeout_remaining() < twenty_percent)
> > +               if (!tst_remaining_runtime())
> >                         break;
> >         }
> >
> > @@ -339,6 +338,7 @@ static struct tst_test test = {
> >         .forks_child = 1,
> >         .setup = setup,
> >         .cleanup = cleanup,
> > +       .max_runtime = 60,
> 
> Where does 60 come from?

Ah, my bad, the code did tst_timeout_remaining() < aprox. 60 so this
should have been 300 instead. Good catch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
