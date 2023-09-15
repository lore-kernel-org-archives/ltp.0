Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C63CEE645D
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 14:01:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEE0C3CB23E
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 16:01:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB50D3CB13B
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 16:01:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BA71D14002BC
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 16:01:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B7619218B5;
 Fri, 15 Sep 2023 14:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694786460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=seLMXOLntFmyanBzAeiwisZO3x/Od9QyczVc4T+3n8k=;
 b=YYHttAPfOwjU4601hupiwZLUYPiC15FWTZlixp/Ze+uk2rbf1PgCFv86QyncmnncWqMT5x
 3LTbjc2FSL75+dWlkqQhKKD/ov76RkUbS2/o7hqHfibIY3tifLoHnb0YgCh5kDwkGbZBep
 vlkDoherLS1zTvSZkiDJA0ueU75pcKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694786460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=seLMXOLntFmyanBzAeiwisZO3x/Od9QyczVc4T+3n8k=;
 b=H5Or/LWEWf15KgAeucq5kGqGMYM4hujSwXnKWKOawgwBii5f4Ty4v35yNFeS1XUk5PEJE3
 uYH1jEZ01wdTohBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A144D13251;
 Fri, 15 Sep 2023 14:01:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rVAzJpxjBGUycAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 15 Sep 2023 14:01:00 +0000
Date: Fri, 15 Sep 2023 16:01:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZQRjyhN5FYDamyr9@yuki>
References: <ZQF5J0UJ25_QLwcQ@yuki>
 <8b1ed832-2c6d-4e1c-8227-234e5864b300@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8b1ed832-2c6d-4e1c-8227-234e5864b300@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
> it would be nice to add the ltx tool into the next release.
> https://github.com/acerv/ltx

So this is the tool for kirk (aka runltp-ng ng) used for the parallel
execution.

I suppose that we should add it as another LTP submodule, right?

But firstly I guess that we should move that under the
linux-test-project umbrela, since this is part of the kirk.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
