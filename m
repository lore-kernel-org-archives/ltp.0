Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61D6CA0FE1
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 12:16:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B58253CC4A6
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 14:16:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93BFE3CBB99
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:16:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A3623140139D
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:16:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A94371F853;
 Fri,  1 Sep 2023 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693570568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V9wg6GhtzGEdCok6MQPLAd/w3sxLjxjV6a3F263jkSg=;
 b=TJG1bCaIznaMR9iGYtYEf4qH1mHP4FzDUbD29K2ufaaylqOL3H6P4F08LSnsGnYG5MoTG+
 Ez+CpkZ7KgWar1DlwvhbJxnTyKnE+SlQUb7Y5rEgQzuYcg4nlRLwqlP4ffLT8JT5EAWtPt
 H8pFTXwekNU1/tB7NF6kzrFExktYA9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693570568;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V9wg6GhtzGEdCok6MQPLAd/w3sxLjxjV6a3F263jkSg=;
 b=BnEtzmepusbE73U1EVo8dU3V9QT93OS5hTGoGWsXuqQy5MfWUUOof3NwsGCzDCNzYK4l7F
 oPfwVfkULSl/P+Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 953701358B;
 Fri,  1 Sep 2023 12:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id is+TIQjW8WRaHQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 01 Sep 2023 12:16:08 +0000
Date: Fri, 1 Sep 2023 14:16:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZPHWK_Msrqbpmvtt@yuki>
References: <20230829073821.2580-1-andrea.cervesato@suse.de>
 <ZO8d3GO_jFgNAXNY@rei> <20230901103758.GC323151@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230901103758.GC323151@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add process_madvise01 test
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
> > > +	TST_EXP_EXPR(map_before.swap < map_after.swap,
> > > +		"Most of the memory has been swapped out: %dkB out of %dkB",
> > > +		map_after.swap,
> 
> > Although it's unlikely that map_before.swap will be non-zero we should
> > print the difference here, so I've changed this part to:
> 
> > map_after.swap - map_before.swap
> 
> > And pushed, thanks.
> 
> FYI this new test is failing on current openSUSE Tumbleweed (kernel 6.4.12-1):
> 
> tst_test.c:1559: TINFO: Timeout per run is 0h 00m 30s
> process_madvise01.c:38: TINFO: Allocate memory: 1048576 bytes
> process_madvise01.c:99: TINFO: Reclaim memory using MADV_PAGEOUT
> process_madvise01.c:62: TFAIL: Expect: Most of the memory has been swapped out: 0kB out of 1024kB
> 
> Summary:
> passed   0
> failed   1
> broken   0
> skipped  0
> warnings 0
> 
> Test works well on current Debian unstable with kernel 6.4.11.
> Could you please have a look if it's a test or a kernel bug?

Does the machine where it fails even have any swap?

I suppose that we should check for:

1) CONFIG_SWAP in the kernel .config
2) /proc/meminfo SwapFree: > $pagesize kB

I guess that the madvise kicks off the kernel swapper, but it may take
some time for the memory to be actually swapped.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
