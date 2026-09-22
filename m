Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4934BC982FA
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 12:50:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA2853E6CC8
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 14:50:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB2003E29EA
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 14:50:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7B94D1A0099D
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 14:50:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC1411F8BB;
 Tue, 22 Sep 2026 12:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790081426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9M8nmkrVj0DNsoXiSA3/ZtsCn0E4vTF/ZiuzYyJFgfc=;
 b=1LADGiaGGatF63dknSk/FQb3WTEOioM2NAQDAoGYtu2tMUoxtnThm4VnDCRQbP+FsFffZd
 I4b4x3EiGtcDAXcaHgVVPVGyyeBKRVcIv7pWoDIlLNB23q+SelJuf8gbfVDwwZ9kS6gmFv
 untTCuiUwERUFBToz0twDSBnqMTubxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790081426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9M8nmkrVj0DNsoXiSA3/ZtsCn0E4vTF/ZiuzYyJFgfc=;
 b=DHzq69Qv1s/jUaqK65CaLBxIHEfiZvbD4MLXcFCn2Kd8Lb6rXi/5oS4D6z+PGJJc6jNSw9
 00c4PIX/sFJW9MDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790081422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9M8nmkrVj0DNsoXiSA3/ZtsCn0E4vTF/ZiuzYyJFgfc=;
 b=u7zC1Fqsi+ldb3EE4IFj11cU9Wc+OOz+kCt72PLhxsVikU3yS8osTuQ7+mUQ0XAuTCFFM5
 kUCn1nlPopuU51LKaQLgsxnH/zrV9aTGLwx8NKJdpi9r69aJJ8Ml01z5HMxHtVWF8VOHNd
 QEBTuhB1U1IGmCwbHqDEVs20NJwRedA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790081422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9M8nmkrVj0DNsoXiSA3/ZtsCn0E4vTF/ZiuzYyJFgfc=;
 b=yIb+izjzdrh5EPj7jpf639tOQz5N4igbkfTWPeHcDPyuxqWUlCSw2sRrm7H1Xsxo6nwzLt
 1ldPgd7Ky9qmJKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DD83136D9;
 Tue, 22 Sep 2026 12:50:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2z4NFo55smpnSgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 22 Sep 2026 12:50:22 +0000
Date: Tue, 22 Sep 2026 14:50:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <arJ5l2SxNgKMMX-j@yuki.lan>
References: <20260922105840.2193537-1-pvorel@suse.cz>
 <arJiBgKNC80acBfY@yuki.lan> <20260922112916.GB2191017@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260922112916.GB2191017@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] keyctl30: Check module is presented before
 loading
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
> > >  	{"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
> > >  	{"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
> > >  	{"CONFIG_NET_ACT_PEDIT", "act_pedit"},
> > > +	{"CONFIG_PKCS8_PRIVATE_KEY_PARSER", "pcks8_key_parser"},
> 
> > I think that this is still cleaner, this way we skip the test even
> > before we start running it.
> 
> Yeah, exit early + having it in the metadata is better - feel free to post the
> above as a patch and we refuse this patch.
> 
> After release thinking:
> Thinking it twice having a separate metadata for "direct" module loading was
> good (the functionality we replaced by kconfig). Why? Now we need to
> 1) load module manually in the test
> 2) manual module loading is hidden in metadata behind kernel config (tester see
> that in the test output, but it's not obvious in the metadata).

It's more subtle than this, in most cases kernel actually loads the
module automatically when the functionality is used (e.g. you create a
socket and kernel loads the module with the particular socket support).
The cases where the module needs to be loaded are quite rare. It's never
unloaded though, so maybe we should attempt that too (if it wasn't
loaded and was loaded because of the test).

> Sure, we don't want to revert that whole big patchset. But maybe we could
> consider to
> 1) call tst_module_load() based on config_module_map() instead doing it
> in the test

We can do that, but I would only do so if it's actually needed, so that
the module autoload is tested as well. For that we would probably need
to add a needs_load to the config to module mapping table.

> 2) print this mapping in the metadata (that would require struct config_module_map
> being accessible also by metadata/metaparse.c.
>
> > Maybe we should attempt to auto-generate the
> > table for all CONFIG_* variables used in LTP.
> 
> Sure, that's a good idea. Useful would be some script similar to updating
> sycalls numbers. With the only exception: don't delete old modules (modules can
> be deleted, but still used by supported kernels).

As long as we have complete list of CONFIG_* variables from the tests,
which can be easily extracted from the test, we know which modules we
need mapping for. No need to keep anything that isn't in that set.

> > Also keyctl23.c and keyctl29.c have tst_modprobe("x509_key_parser",
> > NULL); So we need fix/mappping for x509_key_parser too.
> 
> Yeah, I also noted that + cve-2026-46331.c (all Andrea's agent based code,
> we should teach agent about the differences).

There are also tests that do tst_cmd("modprobe", ...) these should be
fixed as well (git grep '"modprobe"').

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
