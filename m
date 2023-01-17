Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312B3C6379F
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 16:32:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB33E3CD99A
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 17:32:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 459063CB4A2
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 17:32:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 939532005E6
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 17:32:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F2DCF38977;
 Tue, 17 Jan 2023 16:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673973121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n645qsIVJKEFgY4aoIDqNlkh9fjdbO8qFS4iXenfapk=;
 b=ANcq7VsPOcxYa1IMyldv0XFdJXQOpA/p4B0fS5cFeavSnqgFPb2gWuQHS9PFYa+Y8/AP5P
 8/wca7KQ3mom8YqMpya6Ew9iAqnf1sVKMHsYfvKbz0SF3eOn2GyxFKaQo8T9X17LcTvCQw
 Uns/N3D89vPJkJOa4sAWo3BOHn3V5uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673973121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n645qsIVJKEFgY4aoIDqNlkh9fjdbO8qFS4iXenfapk=;
 b=/zmLRyBmZW+ajNxDlEnBs06MD2Q3YhtiJ5dRVq7zbZMY1lXQB0u931xas7HzJGkLaWqdxi
 WrBAnq1qXBn4YvBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF0C013357;
 Tue, 17 Jan 2023 16:32:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4AJqNYHNxmPCbwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 17 Jan 2023 16:32:01 +0000
Date: Tue, 17 Jan 2023 17:33:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y8bN4Bxkook8BZvs@yuki>
References: <20230116074101.1264-1-wegao@suse.com> <87fscawlku.fsf@suse.de>
 <20230117021631.GA20825@aa> <877cxlwk66.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877cxlwk66.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] readahead02.c: Use fsync instead of sync
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
> > The motivation of this change is base on the https://github.com/linux-test-project/ltp/issues/972
> > which give following suggestion:
> > "As we run the test inside a loop device I guess that we can also 
> > sync and drop caches just for the device, which should be faster 
> > than syncing and dropping the whole system. Possibly we just need 
> > to umount it and mount it again."
> 
> I see. Well unless Cyril can show that the test is actually failing
> somewhere (or there is a strong logical argument this will cause a
> failure). Then this task is still valid, but low priority IMO.

We do sync more than needed here, since we are looking at the per device
counters we have to sync just the device we mount for the test, so this
is optimization for the case that the system has many dirty cases and
will need seconds or a minute to write them to the pernament storage.

> > But currently i can not find any API to sync and drop caches just 
> > ONLY for device, so base my view just replace sync whole 
> > system to single file also can make a small help.
> 
> If we don't have one or more concrete failures to focus on then we
> really have to research whether fsync (or syncfs FYI) or unmounting the
> device are the correct thing to do. They will all have subtly different
> effects.

Looking at the code closely I'm starting to think that the sync is not
required at all. What we do in the test is that we create file and sync
it to the external storage. Then we read it a few times and mesure
differences in cache. As far as I can tell we just need to drop the page
cache after we have read the file. What do you think?

In any case I would avoid changing the test before the release, but it's
certainly something we can look at after that.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
