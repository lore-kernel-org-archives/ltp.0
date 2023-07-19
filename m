Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572D1EB64DA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 09:54:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DFCF3CDCED
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 11:54:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61DA93C1812
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 11:54:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8EABF1000DCC
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 11:54:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E0301FE1B;
 Wed, 19 Jul 2023 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689760463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MHNkuktLMTvYCpYSLbZnAWZFUc7Cc7Sm5wq3Wf7frIo=;
 b=T2O6dGB1WhTo4L0ZVUh3kRS3apzTbY6SfETYcISKEn2Ha/VfB2HhpEtyy8k5rC3E2qpDWA
 tC6L0G0iKgTr7IcMk14xFEGJWns9bDBQlL+fvepfa2IBaa3o2UHscP94KKDc6Kv7EhErYA
 FT67K5YHl3fuISA5PYHUz0DRstm1Qps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689760463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MHNkuktLMTvYCpYSLbZnAWZFUc7Cc7Sm5wq3Wf7frIo=;
 b=4xSxYVlTNewlEf2pFKbdgyCyClHcrJfA0UjsshvmbqO9FhwTAv2O8iKqPrN15GWix70V2Z
 rddDe4NwEYWqlMBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FB9213460;
 Wed, 19 Jul 2023 09:54:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iIl0Dc+yt2R0LgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jul 2023 09:54:23 +0000
Date: Wed, 19 Jul 2023 11:54:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230719095421.GA1221211@pevik>
References: <20230717094348.1105467-1-pvorel@suse.cz> <ZLapjxuvD2KkQHi0@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZLapjxuvD2KkQHi0@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] mremap06: Add mremap() reproducer for
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
Cc: Fabian Vogt <fvogt@suse.com>, Jiri Slaby <jirislaby@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, Vlastimil,

thanks for your time, merged!

> Hi!
> > +	ret = fallocate(fd, 0, 0, mmap_size);
> > +	if (ret == -1)
> > +		tst_brk(TBROK, "fallocate() failed");

> I'm slightly surprised that we do not have SAFE_FALLOCATE().

It's on my todo list.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
