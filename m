Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674ABC63797
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 08:05:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B8DE3CC8A4
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 09:05:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46EF33C13C2
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 09:04:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 488A21000927
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 09:04:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 421D3380BC;
 Tue, 17 Jan 2023 08:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673942697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hG38+pCTBFyyrEugqjran5Z8nevlP3GzwI41cqEyAQs=;
 b=ncS5NL7kFspv8wIrgArLxpWdwlXqQK0ij5OyhfEc13UCQiFFg9l9uoIiBlxMDhO7T+8Ql/
 cIX+V2XPLqI3lIDugeQOLNMaPpS5tJDJa6pKIFEqr66ZlqKpes6pf8pGxrsqoiG6tJnU/f
 slo4s7RrFx/G/JQLSuK7gry2oqLX7os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673942697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hG38+pCTBFyyrEugqjran5Z8nevlP3GzwI41cqEyAQs=;
 b=We+Qrm2nlC38BkCHj9+1f9qNjxQ83l9faZZBjYbsT161uE1YnYCzFgGoEk9k3PVvD8s85d
 dkoJ6coDSmkQZ5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CB4313357;
 Tue, 17 Jan 2023 08:04:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0qtIAalWxmMMSQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 17 Jan 2023 08:04:57 +0000
Date: Tue, 17 Jan 2023 09:04:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y8ZWp8n+qFPOIAhh@pevik>
References: <Y8VRpdW7LUh4uFm9@yuki> <87bkmywlb7.fsf@suse.de>
 <Y8V7+U1p/Zk1LWye@pevik> <Y8YfDqFtZ+tDY/Uk@aa>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8YfDqFtZ+tDY/Uk@aa>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release
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

> On Mon, Jan 16, 2023 at 05:31:53PM +0100, Petr Vorel wrote:
> > Hi Cyril, Richie, Wei,

> > > Hello,

> > > Cyril Hrubis <chrubis@suse.cz> writes:

> > > > Hi!
> > > > It's about the time to start preparing for the LTP January release. Well
> > > > we should have started at least a week ago, but my family was sick and
> > > > nobody else seemd to start to work on that...

> > Thanks for remembering. Time flies + obviously nobody set any calendar event to
> > remember the release months.

> > > > Anyways let's start with listing patches that should be considered for
> > > > the release, looking at patchwork the queueu is nice and short so I
> > > > suppose there will not be many and that we can start with pre-release
> > > > testing now and do a git freeze at the start of the next week. Does that
> > > > sound reasonable?

> > +1

> > > > Also are there any volunteers for picking up various release tasks?

> > > > -- 
> > > > Cyril Hrubis
> > > > chrubis@suse.cz

> > > My fix for fcntl36/34 doesn't seem to fully work for fcntl36 on 32bit
> > > compat. Hopefully I can fix that before next week.

> > +1, thanks for working on it.

> > I'd like to fix tst_rhost_run.sh failing.
> > @Wei do you plan to fix it or shell I have look into it?

> @Petr

> I create following new patch today help fix tst_rhost_run.sh fail
> https://patchwork.ozlabs.org/project/ltp/patch/20230117040132.5245-1-wegao@suse.com/

> Also i suggest also merge old PATH patch together then at least we can run single test case currently.
> https://patchwork.ozlabs.org/project/ltp/patch/20230111195231.23596-1-wegao@suse.com/

I'll reply to the patches.

Kind regards,
Petr

> Info me if any further action i need take, thanks : )


> > BTW the move of testcases/kernel/containers/share/ content to testcases/lib
> > which I suggested and we got Cyril's ack [1] is trivial, but as it's just a make
> > dependency fix, it can wait after the release. The test failure is what matters
> > more.

> > Kind regards,
> > Petr

> > [1] https://lore.kernel.org/ltp/Y8UubJZcN89y77AA@yuki/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
