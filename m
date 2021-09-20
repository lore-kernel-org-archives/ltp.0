Return-Path: <SRS0=cJ4o=OK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1B6C433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 12:02:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A2760EE2
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 12:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76A2760EE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DB863C8790
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 14:02:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF37B3C19F3
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 14:01:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 34D861400E54
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 14:01:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3AFBB200C8;
 Mon, 20 Sep 2021 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632139314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XnzaKFY9wseh/1uFFjV4bDumonOBM9UBNfjLg3mwNas=;
 b=A8UyRAlygUvq/dap1GRaURPyDJfLNg8NenxgVsxt/+snrO0ipQysNsfESXXUs1bm1jWx2u
 JJDdyjII+dx2Heh+EnACNxrgfqTWSlmz2G1WuslFRBRX/rfcihL5s/2Rha2euLDHxNCx0B
 mQYqZOcSNeG5b5Y2y8aWtE3iCwJW27g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632139314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XnzaKFY9wseh/1uFFjV4bDumonOBM9UBNfjLg3mwNas=;
 b=NivOC1ruSqSPhOzhZ4aLcEuhDE0Du1Z4ZTuqlIpFaXOBm3scAUggYVybnCXOHuiNZO5Gt/
 PCz45E1gBfwm70BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2615513483;
 Mon, 20 Sep 2021 12:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FDvhCDJ4SGECHwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 20 Sep 2021 12:01:54 +0000
Date: Mon, 20 Sep 2021 14:02:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YUh4TsjTZeFh/UYO@yuki>
References: <20210917141719.5739-1-chrubis@suse.cz>
 <01fb50a1-8edb-77ac-fba4-b70965022b3f@jv-coder.de>
 <YUg6BM39OKgI5Ovl@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YUg6BM39OKgI5Ovl@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [RFC] lib: shell: Fix timeout process races
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
> > Shouldn't this be reused from the library instead of being reimplemented?
> 
> I wanted to avoid calling the tst_res() functions to keep things simple,
> but I guess that there is no reason not to use it.

And there actuall was a reason, since we cannot do tst_res(TBROK,
"..."); in the C library.

And looking at the C library, we avoid using the tst_res() on timeouts
as well, actually we just write to stderr because we do that from a
signal handler context. So I guess that we can just print to stderr here
instead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
