Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A20C00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 12:35:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 579AC3C95BD
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 14:35:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97AD13C2D44
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 14:35:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9387C100035F
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 14:35:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B681D1F7AB;
 Wed, 10 Aug 2022 12:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660134943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5DUQOlON0QIAXRDn8man0Au8O2oMajWKSzDyZd/b+Fg=;
 b=JptfLjT3Em6811r+ZFm/05zFmWWnSKVxUOiBrQqJdYovjOyX1eQeo0RgPREi5XcnpxO4+q
 6N5+r+olzvbE6IY/aGEM+VhLRPCiZTxpX553mtE3sqEzbycrUzyC7usZdoJa6BFMjTBe4x
 9xr2Igw7DOH0YIbcX0LD1sOOoFAVYn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660134943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5DUQOlON0QIAXRDn8man0Au8O2oMajWKSzDyZd/b+Fg=;
 b=S9OW6E1AuZbthIz7T+pG61wkXfXdUTiQjaROEAldDjxJiCD31pv+nbV2nfTd41W/FIrfgJ
 o45zy5c8HTLHuqCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FE9913AB3;
 Wed, 10 Aug 2022 12:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id G9MnMh6m82KkewAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 10 Aug 2022 12:35:42 +0000
Date: Wed, 10 Aug 2022 14:37:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YvOmiXBO1njKMzUM@yuki>
References: <20220810092804.5771-1-andrea.cervesato@suse.com>
 <YvOKbt1urOeVwQ57@yuki>
 <ade189ba-4211-99a8-d5e6-c99b1950e21b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ade189ba-4211-99a8-d5e6-c99b1950e21b@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] Refactor aiocp using new LTP API
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
> Yes, we can reduce the amount of time to generate file (especially if 
> it's really big), but I wouldn't
> introduce any repetition because we would like to check that file has 
> been copied properly during
> callbacks which are asynchronous by definition.

I guess that we can do a little trick such as making the buffer with
random data slightly bigger and choosing a random start offset in that
etc.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
