Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DFDC433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 14:21:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF3473C8D68
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 15:20:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5DCD3C0D0B
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 15:20:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E55C600084
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 15:20:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B50F61FD49;
 Mon, 22 Nov 2021 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637590847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H/wT7gCzMmdpBHVEfjTUlKTxmmDSRe1LoNF6QofWso0=;
 b=FUZf1jc60IFYIlTtK/4GMlcILG9ii5qdZ40sfSDezqa3T7GMk+lUzO3A2Wft+mKScS2iyC
 dNZKB3jP+BKT605uD3IdJW0hjTLLN0MXcZrvye1iuLpjBcqLY4ZLC1XckonV4f9dMspX2R
 OlmAZy3cy+dtdagYNr5tMUJf3tyu2Ys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637590847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H/wT7gCzMmdpBHVEfjTUlKTxmmDSRe1LoNF6QofWso0=;
 b=5j6uv+9rzN4yPe5oJfgtasYxXX9Xya25YpBb1kY5LAMtZDefos+mGXrF1oHmJkxFlHrj4M
 w4ae6HKN5eYTLCDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A13E213B44;
 Mon, 22 Nov 2021 14:20:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BIZRJj+nm2ErcQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 22 Nov 2021 14:20:47 +0000
Date: Mon, 22 Nov 2021 15:21:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YZungO1QrUR+xbSC@yuki>
References: <20211117070708.2174932-1-liwang@redhat.com>
 <77e0b8b9-5de6-73ab-0f73-e3d95bad0935@jv-coder.de>
 <YZZCAXWRcrsYJo9+@yuki>
 <CAEemH2ehTUoDTqa21vKDvC4vQuTPBM1j23Dqa=FFEJjcPLsvvQ@mail.gmail.com>
 <87bl2cmhuw.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bl2cmhuw.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: adding .supported_archs field in
 tst_test structure
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
> I still don't understand how tst_arch.name is mapped to i386, i586 or
> i686?
> 
> It appears that we will always get TCONF on any of these architectures
> because tst_arch.name will be set to x86 and the required arch will be
> i386, i586 or i686.

Can we please have single name for 32bit intel i.e. "x86" please?

> > (From the above discussion I feel v5 is satisfied almost all of our
> > requirements.)
> 
> Otherwise, yes, I agree.

Same here, the rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
