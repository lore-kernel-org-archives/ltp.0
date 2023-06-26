Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EB2EB64D7
	for <ltp@archiver.kernel.org>; Mon, 26 Jun 2023 09:22:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A98603C9A09
	for <ltp@archiver.kernel.org>; Mon, 26 Jun 2023 11:22:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8D083C99C0
 for <ltp@lists.linux.it>; Mon, 26 Jun 2023 11:22:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9E23310000D3
 for <ltp@lists.linux.it>; Mon, 26 Jun 2023 11:22:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 791DD1F896;
 Mon, 26 Jun 2023 09:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687771350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GzWx2RCyTvYZjXOUuoshOc5SAqOeHJjXEzSZyaMXcQE=;
 b=A6qzFFmXJOP0SkUCb/EUwDSeh25r+NrhNALb+TElwt9VmldyIkNjcbW1HpkkSc0Ej9DUqG
 x8IOhjRzcEw1ZAt6sOBoYYBYLdKoi602topctAk41G26YedBu2zhX5r5nG/sDDCeujDP9X
 oa51uxOpP0Znl99Q31bTlvb3jFpwwas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687771350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GzWx2RCyTvYZjXOUuoshOc5SAqOeHJjXEzSZyaMXcQE=;
 b=ukhs+uJ3iRUqxXgvAVyj7Gg5OQ4Z0jLMeg9HNNK7lGjcESrTyaPdNWmR7iuJ90pK2sFgom
 VJYxP2+giYwuN5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9704E13483;
 Mon, 26 Jun 2023 09:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id t1TvMNNYmWS8bAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 26 Jun 2023 09:22:27 +0000
Date: Mon, 26 Jun 2023 11:23:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZJlZD2fVXaVM3X5i@yuki>
References: <20230615093933.3185297-1-dylan@andestech.com>
 <CAEemH2e-PPPNHNX6_3Kj86hh3z-5o2i4XxD2GP-+Fh4Pe=B3TA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e-PPPNHNX6_3Kj86hh3z-5o2i4XxD2GP-+Fh4Pe=B3TA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc
 variant
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
Cc: minachou@andestech.com, tim609@andestech.com, x5710999x@gmail.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> You pointed the segment fault only exists on 32bit when use
> libc wrapper, but this condition skips for both 64and32 bits,
> isn't it?
> 
> I guess the strict condition should be as below?
> 
>     if (tcases[i].error == EFAULT && tv->shmctl == libc_shmctl &&
> tst_kernel_bits() == 32) {
>     ...
>     }

Actually I think that it may be safer to skip libc version regardless,
as long as we have the raw syscall test in place we are not getting any
more coverage from passing invalid address to the libc call, since
either the libc call is thin wrapper, i.e. equivalent to the syscall()
call which we already test, or it does something to the arguments, in
which case it's possible to trigger segfault, if not now in some future
libc versions.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
