Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50192C001B0
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 20:07:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A3123CC0BC
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 22:07:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 714E93C9A04
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 22:07:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1D9F91400278
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 22:07:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6379021CB1;
 Mon,  3 Jul 2023 20:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688414857;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gPfuDoQ8Apr/w9YdtHfamSRYsfc7DGhmZcOGcz7tEKo=;
 b=WsKjJ2Tfv81fMS/TzcWJkcb4YaZXWxsWMfxfbYgA91F31McqBaTwxj50FWldLPTAvZMvQ5
 prDZqC6iGP93xyrnKzPkOcaCO4DQyFgCSIj9/6NlDyUQELRDWPVC1Gne3RoJIJ0OzFQsrY
 jELOOmxdYWf+Har52oTIwVsdaQogUds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688414857;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gPfuDoQ8Apr/w9YdtHfamSRYsfc7DGhmZcOGcz7tEKo=;
 b=7ySSSrtSDCiBQvJDsPSpc4zKJdzoBoy800Yhx1eOE+iDfr5dfhkI1VcDmVsQtgLcLxfMfp
 UvWNkfKCI2XUw3DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37D5C1358E;
 Mon,  3 Jul 2023 20:07:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ajZMDIkqo2TYYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 03 Jul 2023 20:07:37 +0000
Date: Mon, 3 Jul 2023 22:07:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230703200735.GB446620@pevik>
References: <20230703194904.445661-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230703194904.445661-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

[ drop kernel developers, add Jan, Li ]

> ---
> @Cyril: I plan to add SAFE_FALLOCATE() (3 other sources),
> SAFE_MPROTECT() (7 other sources) and SAFE_MREMAP()
> (2 other sources), but as a separate effort.

@Jan, you added in 9120d8a22 ("safe_macros: turn functions with off_t parameter
into static inline") note "following functions are inline because the behaviour
may depend on -D_FILE_OFFSET_BITS=64 -DOFF_T=__off64_t compile flags". IMHO the
only source which uses SAFE_MMAP() is testcases/kernel/mem/mmapstress/mmapstress01.c
I'm asking because I wonder if SAFE_MPROTECT() and SAFE_MREMAP() should be also
static inline, IMHO it's not needed.

@all: SAFE_MPROTECT() would be needed also on some still old API sources
(testcases/kernel/syscalls/signal/signal06.c,
testcases/kernel/syscalls/mprotect/mprotect02.c,
testcases/kernel/syscalls/mprotect/mprotect03.c)
Should I ignore that and add it just to new API?

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
