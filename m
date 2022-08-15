Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62DDC00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 09:45:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C607F3C95EE
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 11:45:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C5E33C01CC
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 11:45:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1C8BC200261
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 11:45:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C405334BF9;
 Mon, 15 Aug 2022 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660556702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mID2E+Pq6xAShaVdKcPFDtS4fE2PaKykL3B/ziTbsOU=;
 b=GNph4uHCh2RS2Iwi0gtv7pkbRYQFPbEEn3WcR6BD+TbnQhQ0PcFPOi0PoUsrTckfB+FeCk
 Cf7zayNVig14kn/N75TN2YcLIQEv2XULWDdlOJ1OHLyg0pwozud0n96f2wR9/H1YrY+Gaq
 fCN6htGOPqPv4KIUQKEadKVnQy8XcYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660556702;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mID2E+Pq6xAShaVdKcPFDtS4fE2PaKykL3B/ziTbsOU=;
 b=3EQ5JTDFm2psGg/Bm8KJJXVIrZ4+A/si74Ah3cQo//mh8OdDvx3azk6iOLCam2wrCsAaHT
 2LZ+tK16idS+UXCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC2C713A99;
 Mon, 15 Aug 2022 09:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Mv/PKJ4V+mKcYQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 15 Aug 2022 09:45:02 +0000
Date: Mon, 15 Aug 2022 11:46:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YvoWEVb9eZIHqrBI@yuki>
References: <20220808071439.741-1-pvorel@suse.cz>
 <20220808071439.741-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220808071439.741-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] github: pull_request_template.md
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
Cc: Petr Vorel <pevik@users.noreply.github.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Create pull request template to inform people that we prefer patches to
> our mailing list. We have this info in README.md, but even experienced,
> who send patches with git send-email to other projects overlook this
> info and open github pull requests.
> 
> While at it, add links to the test case tutorial, lore and patchwork.
> 
> Template does not support any formatting, therefore using plain links.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: you can test it if you fork from my fork:
> https://github.com/pevik/ltp
> 
>  .github/pull_request_template.md | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 .github/pull_request_template.md
> 
> diff --git a/.github/pull_request_template.md b/.github/pull_request_template.md
> new file mode 100644
> index 000000000..68c8a6499
> --- /dev/null
> +++ b/.github/pull_request_template.md
> @@ -0,0 +1,6 @@
> +Although we *occasionally* also accept GitHub pull requests, the *preferred* way is sending patches to our mailing list: https://lore.kernel.org/ltp/
> +
> +There is an example how to use it: https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial#7-submitting-the-test-for-review (using git format-patch and git send-email).
> +
> +LTP mailing list is archived: https://lore.kernel.org/ltp/.
                        ^
			archived at:
> +We also have a patchwork instance: https://patchwork.ozlabs.org/project/ltp/list/.

So this text is filled in the pull request as a message when user
creates it, right?

I guess that this is a creative misuse but I kind of like it :-).

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
