Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4CBC433F5
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 15:55:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AA533C9606
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 16:55:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 718773C93DA
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 16:55:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7AD2D1401177
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 16:55:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B54D221763;
 Tue, 25 Jan 2022 15:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643126115;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1NpOvKf+E4F/1/DHJ5neMt4Q46wN32UEkd31aZ1ZVxE=;
 b=tyKDVLwj42/kR67hLsFEuSFFmnkhSAh/3ZJ7yMbEhGdg11u9bYqOeaxvgyFTdbYzzyr7ep
 DhNIBFyL4FBxR/cSdzmmYytOQoCDSeiOKNlGqZPLWNKYXMfwUP5IFu/TriIZB3OuAZBjmG
 VQKpZhdxchwmB/CuzYsB846kZ+Uqqvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643126115;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1NpOvKf+E4F/1/DHJ5neMt4Q46wN32UEkd31aZ1ZVxE=;
 b=r6/y/Jj45EQ5iktKM0UWRv0weIFGzZatEt/CZzYWlHvRxx5AqyMItRzcjhFK7wr/+O05Dg
 IkeTxbw1tOUzV7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F58E13E0E;
 Tue, 25 Jan 2022 15:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id viwwH2Md8GF5HwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Jan 2022 15:55:15 +0000
Date: Tue, 25 Jan 2022 16:55:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YfAdYd0Ju407w0wx@pevik>
References: <20220125144043.31798-1-pvorel@suse.cz>
 <YfARoEoyhkTsWg9d@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YfARoEoyhkTsWg9d@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/4] sched_{g,s}etattr01: Add missing policies
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

Hi Cyril,

> Hi!
> > sched_getattr and sched_setattr are 99% identical (2 values are
> > different). I was thinking to use the same approach from e197796f22
> > ("sethostname: Convert to new API"), but not sure if it's a good
> > approach.

> Actually I do not think that the approach in sethostname is good. There
> should be a C file for each test. If they share code that should be put
> into headers or libraries.

> We used to have more tests like that that build binaries in different
> directories from a single source with different macros and I find it
> utterly confusing.
Thanks for info. Agree, it's confusing.

I guess in tests which are very simple like sethostname or even these
sched_getattr we'll just endup with duplicity, right?
Because putting one function into header which is shared with tests in different
directory is just confusing and not worth of doing.

So I can recreate sethostname01.c.

And for these tests I can make a note just to remember update struct for the
other test.

> > Do we want to reduce files needed to be updated after new policy is
> > added? If yes, shouldn't there be just a single directory?
> > (what name should be using to show 2 syscalls are in sources in this
> > directory?)

> I would vote against this.
Understand now.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
