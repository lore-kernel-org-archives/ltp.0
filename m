Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5111D609CF
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 10:40:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 900793DB608
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 11:40:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10C503D94CF
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 11:40:17 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 81F57218EDB
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 11:40:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A1E4B21176;
 Wed, 27 Nov 2024 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732704015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M3cUv88kIQ0jLd+qKPQ7Ly5lN9JC6/I7BEecijAl4Q0=;
 b=gbrpHCUU9e0lf5FBq1N4GWKtggTbFaWWJ/G+Nhmk2Ohjd6Q33rZ7otfaRNVs/ATjRXtykz
 BCfi92FFoa2MIKfNaRwkBlkeLzv3DzkCo3AsWSk9dMqi+nydHbqhaUETdBA/Bim0McG6W/
 2DJcIFQPzO63IFsdXN/aHhqHlKnT+gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732704015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M3cUv88kIQ0jLd+qKPQ7Ly5lN9JC6/I7BEecijAl4Q0=;
 b=+fuIwA3bNpfi991N+XVBIRFL8UNUwyJq3DrJVj/DZYnX1+2ZgAL1er3Z3e48r6qPj+321b
 OAoh4+9Nd7XPLTDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732704015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M3cUv88kIQ0jLd+qKPQ7Ly5lN9JC6/I7BEecijAl4Q0=;
 b=gbrpHCUU9e0lf5FBq1N4GWKtggTbFaWWJ/G+Nhmk2Ohjd6Q33rZ7otfaRNVs/ATjRXtykz
 BCfi92FFoa2MIKfNaRwkBlkeLzv3DzkCo3AsWSk9dMqi+nydHbqhaUETdBA/Bim0McG6W/
 2DJcIFQPzO63IFsdXN/aHhqHlKnT+gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732704015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M3cUv88kIQ0jLd+qKPQ7Ly5lN9JC6/I7BEecijAl4Q0=;
 b=+fuIwA3bNpfi991N+XVBIRFL8UNUwyJq3DrJVj/DZYnX1+2ZgAL1er3Z3e48r6qPj+321b
 OAoh4+9Nd7XPLTDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C3A4139D0;
 Wed, 27 Nov 2024 10:40:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uy00IQ/3Rmf0UQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 27 Nov 2024 10:40:15 +0000
Date: Wed, 27 Nov 2024 11:40:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Z0b3F2PHzRZq8WeL@yuki.lan>
References: <20241126100445.17133-1-liwang@redhat.com>
 <Z0WitZsMZat6wdA2@yuki.lan>
 <CAEemH2cpYA28nknKOhNV0D4q8G+xPw6EuvScMHbgOO3jpRPv7w@mail.gmail.com>
 <Z0Wvsq571rTt46Ie@yuki.lan>
 <CAEemH2e3H0w52LKXs+UURdg5dq2bP5dXokWYb98DxHu5qcsOQg@mail.gmail.com>
 <Z0bqZAiaOo7E3E9I@yuki.lan>
 <CAEemH2cJmBra=SajChZ-KKe9GimCBtdvwcnWNiwEz2dHFP8f4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cJmBra=SajChZ-KKe9GimCBtdvwcnWNiwEz2dHFP8f4Q@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_FIVE(0.00)[6]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] starvation: set a baseline for maximum runtime
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
Cc: Philip Auld <pauld@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> After thinking it over, I guess we'd better _only_ apply this method
> to some special slow tests (aka. more easily timeout tests). If we do
> the examination of those kernel options in the library for all, that
> maybe a burden to most quick tests, which always finish in a few
> seconds (far less than the default 30s).
> 
> Therefore, I came up with a new option for .max_runtime, which is
> TST_DYNAMICAL_RUNTIME. Similar to the TST_UNLIMITED_RUNTIME
> we ever use. Test by adding this .max_runtime = TST_DYNAIMCAL_RUNTIME
> that will try to find a proper timeout value in the running time for the
> test.

I was thinking to only multiply the max_runtime defined by the test in
the library. That way only slow tests that set the max_runtime would be
affected.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
