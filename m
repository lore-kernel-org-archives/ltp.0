Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8374EEB64DA
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 15:01:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAD753CEB3A
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 17:01:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D869D3C9753
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 17:01:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2F37F100098B
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 17:01:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 318031FDBD;
 Tue, 18 Jul 2023 15:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689692496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7dws4Bz/r9nMwZNEiP2TxLr0PCCxVTzQm6mmK18xYM=;
 b=Woxp3PigDjocosRpehcDCzHGQh6yhuFXGyEpDDoByvgT7fl/RJCLbhQt9z2TXbdyp1NyXM
 v2nzgVVnkjb7uuSfPbOhu7K22zpCYhyRzomHU58mMg8qZyIoAdpfTlhG7VFByFMFUDdjrQ
 WB7lksLlcPkJrUmJeb1ghz4vtRxdafw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689692496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7dws4Bz/r9nMwZNEiP2TxLr0PCCxVTzQm6mmK18xYM=;
 b=awoqmI4G4GxBRQd2wh7CLWrQOPJvxrAU+VZIOaeLk/iTmgUeoU3HShG+n0lWq9Y8ie7fit
 UdpAcXvXRz90QAAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0081E13494;
 Tue, 18 Jul 2023 15:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yyXrOU+ptmRnGwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 18 Jul 2023 15:01:35 +0000
Date: Tue, 18 Jul 2023 17:02:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZLapjxuvD2KkQHi0@yuki>
References: <20230717094348.1105467-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230717094348.1105467-1-pvorel@suse.cz>
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
Cc: Fabian Vogt <fvogt@suse.com>, Jiri Slaby <jirislaby@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +	ret = fallocate(fd, 0, 0, mmap_size);
> +	if (ret == -1)
> +		tst_brk(TBROK, "fallocate() failed");

I'm slightly surprised that we do not have SAFE_FALLOCATE().

Anyways:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
