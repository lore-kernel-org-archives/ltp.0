Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC53C433F5
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 13:17:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F284361058
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 13:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F284361058
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BD4A3C70D1
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 14:17:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DC443C6330
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 14:17:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3EEF91A000BE
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 14:17:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 82114212C5;
 Mon,  1 Nov 2021 13:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635772662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OVedSCYuGgxyHcqZK1hV6pDTiDdM1oiMt5gcBUmFFW8=;
 b=n5mKbck2XbnLMGjUXp2SKRBc9qezhZsVmW2nTx+nomKEmBKGan8sWUlEhhJUCKzDL3zu/v
 glIOR4s27sU13EzeMM9uVN/LMmxMZeWvTnHl5KBFUZeXIYDdk/LB/161Rbc3gLfaGfm5Jx
 IhY8207iJHBZVYtUC9Tl3/84th+2Sto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635772662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OVedSCYuGgxyHcqZK1hV6pDTiDdM1oiMt5gcBUmFFW8=;
 b=z0Ay09exTFt/MjQY0kmzCIwqbglNP7+v5RARK7Fj8k1Ant1SUCmPc18imG8WghNpo5NYu1
 4G59qa+2/VCX1PCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BBAC13522;
 Mon,  1 Nov 2021 13:17:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ME7aGfbof2GyCwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 01 Nov 2021 13:17:42 +0000
Date: Mon, 1 Nov 2021 14:18:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YX/pLRk0eBpr1b6Z@yuki>
References: <20211018154800.11013-1-chrubis@suse.cz>
 <20211018154800.11013-5-chrubis@suse.cz> <878ry8ox9s.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878ry8ox9s.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/7] docparse: Implement ARRAY_SIZE()
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
> > Adds a special handlingn for ARRAY_SIZE() macro.
> >
> > If we stumble upon ARRAY_SIZE() in the tst_test structure we try to
> > lookup the array and count its members.
> 
> Note that this is the type of thing Sparse should be able to handle
> well. As it should evaluate this to a constant. Although there is the
> risk it would be too clever and eliminate some expressions (for
> example).

That's another possible problem, the parser may end up too smart, but
that is something we will see once we try.

Hi!
> > +			if (!strcmp(token, "#include")) {
> 
> Are spaces removed after the '#'?
> 
> e.g.
> 
> #if X
> #  include<Y>
> #endif

Good catch, will fix that in v2 and add a test.

> > diff --git a/docparse/tests/array_size01.c b/docparse/tests/array_size01.c
> > new file mode 100644
> > index 000000000..8a0b9252b
> > --- /dev/null
> > +++ b/docparse/tests/array_size01.c
> > @@ -0,0 +1,5 @@
> > +static int variants = {1};
> 
> I can see how this might work, but looks odd.

This supposed to be static int variants[] = {1};

The thing is that we do not even have a parser here, it's an extractor
and we depend on the C code being correct. It does compile by a compiler
before we even attempt to extract the metadata. So it will happily
process input that is not correct C.

I will fix the test in v2 as well.

> > diff --git a/docparse/tests/array_size02.c b/docparse/tests/array_size02.c
> > new file mode 100644
> > index 000000000..5c7d4471e
> > --- /dev/null
> > +++ b/docparse/tests/array_size02.c
> > @@ -0,0 +1,5 @@
> > +static int variants = {{1}, {2}, {3}};
> 
> Should this be variants[]?

Indeed, it should be also struct foo { int val } type and not int. Will
fix a swell.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
