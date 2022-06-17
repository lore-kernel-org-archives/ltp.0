Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8D3C433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 15:02:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BAA83C8813
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 17:02:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 552333C0EBB
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 17:02:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7F4EA1400049
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 17:02:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BB97321E1A;
 Fri, 17 Jun 2022 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655478122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pPx6aFu2+C8m/s4I7i764IkxIpymMdXz3MEbjj3vaT0=;
 b=oATsqTy3tWG8Ye+OffaNGYq3oEgZNgmCNzza7t3ngrO1yGVyypI7yt2ZirBjSr64rnPsZN
 MiHEKYDroCoqvAJrUhXooL3TtOE1FOvf+qTsMQM97PhAhUH7kWhk/5PUjdsHIbdN/odghh
 plZA8x1CptqK4GLO1FXyfzp6DaSp76s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655478122;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pPx6aFu2+C8m/s4I7i764IkxIpymMdXz3MEbjj3vaT0=;
 b=DEw9fjGnI3YFS2Qar0UQ2i6XX8xUnKrGi548MpVPHdzQMbwoCyfx/htX8EycNF2hVzziS1
 PkrETsjvUBzFRzDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8A151348E;
 Fri, 17 Jun 2022 15:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7OoAKGqXrGLnPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jun 2022 15:02:02 +0000
Date: Fri, 17 Jun 2022 17:04:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Alejandro Colomar <alx.manpages@gmail.com>
Message-ID: <YqyX7E954/b+yKS3@yuki>
References: <b8d6f890-e5aa-44bf-8a55-5998efa05967@www.fastmail.com>
 <YZvIlz7J6vOEY+Xu@yuki> <1618289.1637686052@warthog.procyon.org.uk>
 <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com>
 <YaTAffbvzxGGsVIv@yuki>
 <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
 <913509.1638457313@warthog.procyon.org.uk> <YbDQW6uakG3XD8jV@yuki>
 <fe7c52f9-5ff3-95a5-2692-20f81d6decf7@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fe7c52f9-5ff3-95a5-2692-20f81d6decf7@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Ping: [PATCH] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 libc-alpha@sourceware.org,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>,
 Zack Weinberg <zack@owlfolio.org>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >>> I could be persuaded otherwise with an example of a program for which
> >>> changing __s64 from 'long long' to 'long' would break *binary* backward
> >>> compatibility, or similarly for __u64.
> >>
> >> C++ could break.
> > 
> > Thinking of this again we can detect C++ as well so it can be safely
> > enabled just for C with:
> > 
> > #if !defined(__KERNEL__) && !defined(__cplusplus) && __BITSPERLONG == 64
> > # include <asm-generic/int-l64.h>
> > #else
> > # include <asm-generic/int-ll64.h>
> > #endif
> > 
> 
> I'm very interested in seeing this merged, as that would allow 
> simplifying the man-pages by removing unnecessary kernel details such as 
> u64[1].  How is the state of this patch?

I guess that it stalled because I haven't posted it as an actual patch,
I should do so to get this back on a track.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
