Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C15EB64D9
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 11:33:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FC653C99B0
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 13:33:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B910B3C8524
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 13:33:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 284021000900
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 13:33:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4692C20526;
 Tue,  4 Jul 2023 11:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688470394;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VjIOviHxeXHYb9FuFU0nnu3GafgrXx1Y7KUkREgA1r4=;
 b=SyF+ClFUkICPmVWxKOhSsPZKoNG3WijbyNnUl3FpfwucVhTb68te7t3rewpBbUlDjoTLvF
 3b5ldSWUkEHgqfIUO9pFxqhjgTvGjYCdxbduI+kN3OpWV9Z0pYJjrASUYpw9/scgjFTNwW
 ZlX3uV2HSFYHO5JOJVyTL8lSpDXjeMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688470394;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VjIOviHxeXHYb9FuFU0nnu3GafgrXx1Y7KUkREgA1r4=;
 b=yDKKW6H95LQmhs0RldignAx2QS0swpiWRWkAj3hWRFRYdT13NNiU2sH2iXbXonj0MXsUv2
 a5JOrT20NF4tEpAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26C3D133F7;
 Tue,  4 Jul 2023 11:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4wJOCHoDpGTYFAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jul 2023 11:33:14 +0000
Date: Tue, 4 Jul 2023 13:33:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230704113312.GB507064@pevik>
References: <20230703194904.445661-1-pvorel@suse.cz>
 <20230703200735.GB446620@pevik> <ZKPckA55HnH3rVV1@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZKPckA55HnH3rVV1@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] mremap06: Add mremap() reproducer for
 7e7757876f25
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

> Hi!
> > > @Cyril: I plan to add SAFE_FALLOCATE() (3 other sources),
> > > SAFE_MPROTECT() (7 other sources) and SAFE_MREMAP()
> > > (2 other sources), but as a separate effort.

> > @Jan, you added in 9120d8a22 ("safe_macros: turn functions with off_t parameter
> > into static inline") note "following functions are inline because the behaviour
> > may depend on -D_FILE_OFFSET_BITS=64 -DOFF_T=__off64_t compile flags". IMHO the
> > only source which uses SAFE_MMAP() is testcases/kernel/mem/mmapstress/mmapstress01.c
> > I'm asking because I wonder if SAFE_MPROTECT() and SAFE_MREMAP() should be also
> > static inline, IMHO it's not needed.

> As long as the return value or function parameters does not include
> off_t it's not needed.

+1

> > @all: SAFE_MPROTECT() would be needed also on some still old API sources
> > (testcases/kernel/syscalls/signal/signal06.c,
> > testcases/kernel/syscalls/mprotect/mprotect02.c,
> > testcases/kernel/syscalls/mprotect/mprotect03.c)
> > Should I ignore that and add it just to new API?

> Just add it to the new API, the old test should be cleaned up and
> converted anyways.

+1

Thanks,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
