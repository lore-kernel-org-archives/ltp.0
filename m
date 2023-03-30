Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D509AC6FD1D
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 05:58:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 526723CC9BE
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 07:58:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18E9A3CA2AB
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 07:58:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2743F1000937
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 07:58:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C221821A27;
 Thu, 30 Mar 2023 05:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680155883;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g++C+gxzArrOV/GxWXgfH3EifEtfUQj4+zLSrwDHNsg=;
 b=rYLVl+Pp91Ybkg7nsGL469MfkaSLAPpNJrAuLdCORaD8wfKjI4P2rK3JH3zBm3xx5hx2w1
 WYV2C5iul/Erz9QfkMT8JN9PHkZAJg/76EtGZwJw5tNvz749O7m4SUwwu3/1m8KppWr456
 bJJo3NOFVCojjsKC8z2lP5MJN0fr4Uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680155883;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g++C+gxzArrOV/GxWXgfH3EifEtfUQj4+zLSrwDHNsg=;
 b=LUezv/ogatWXAdB/Hdlu6adeZOTZtosLEiSX6ePZtN22Dnw/w1iwFiwY8CaPQyW8W+tpt7
 P0t5RE6dgouUQ7Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4A66138FF;
 Thu, 30 Mar 2023 05:58:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XlVrJuskJWSiTgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 30 Mar 2023 05:58:03 +0000
Date: Thu, 30 Mar 2023 07:58:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230330055802.GB937278@pevik>
References: <20230329133828.24835-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230329133828.24835-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] recvmsg01: Refactor using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

	{
	PF_INET, SOCK_STREAM, 0, iov, 1, (void *)buf, sizeof(buf),
		    &msgdat, -1, (struct sockaddr *)&from, -1, -1,
		    EINVAL, setup1, cleanup1, "invalid socket length"},
.flags is -1 here, it's unsigned int, please use UINT_MAX (the same value, but
more obvious).

> -	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> -		tst_count = 0;
> -		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -			if ((tst_kvercmp(3, 17, 0) < 0)
> -			    && (tdat[testno].flags & MSG_ERRQUEUE)
> -			    && (tdat[testno].type & SOCK_STREAM)) {
> -				tst_resm(TCONF, "skip MSG_ERRQUEUE test, "
> -						"it's supported from 3.17");
> -				continue;
> -			}
...

> +	if ((tst_kvercmp(3, 17, 0) < 0)
> +			&& (tc->flags & MSG_ERRQUEUE)
> +			&& (tc->type & SOCK_STREAM)) {
> +		tst_res(TCONF, "skip MSG_ERRQUEUE test, "
> +				"it's supported from 3.17");

The reason for the MSG_ERRQUEUE on SOCK_STREAM was described in
e5fd512d8 ("skip MSG_ERRQUEUE+tcp test on kernels < 3.17")

The limitation for MSG_ERRQUEUE is only on SOCK_STREAM, but because MSG_ERRQUEUE
is tested only on SOCK_STREAM, it should be enough to check just MSG_ERRQUEUE.
Also, UINT_MAX & MSG_ERRQUEUE is always true (in "invalid socket length") and I
don't think that test should be skipped.

The check could be:

	if (tc->flags != UINT_MAX && tc->flags & MSG_ERRQUEUE
		&& tst_kvercmp(3, 17, 0) < 0) {
		tst_res(TCONF, "MSG_ERRQUEUE support for TCP has been added in 3.17");
	}

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
