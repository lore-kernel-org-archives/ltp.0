Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B91EC433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 12:22:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C217E3C8A72
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 13:22:19 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EF383C14B2
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 13:22:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1BBE71A009A9
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 13:22:07 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 577891F38B;
 Mon, 24 Jan 2022 12:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643026927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=38k8EWJVKGHWUQvXLzkiT7L0y0qNQVmONu58PGu95vU=;
 b=REpHMWU7DQ3Osbm0bVMLJzVc8H6B9r0GpnL6IASuh52f3jSJUl8o6IRAP5XBp1AvrNiAkX
 diZYR54MKnBie/SuT5dfe44elTmxWkNE+Bf1f54OzJXPNfEE1b7isc8W8QGt4VZzufNFBG
 61E9yAz9vjr6LXo+yUNG4r6ZjRifF4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643026927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=38k8EWJVKGHWUQvXLzkiT7L0y0qNQVmONu58PGu95vU=;
 b=bwBrHOQhysNoS+SPcup4aYRden1DVz1NmcT5siFKvCXUGTN6a7bbAWd6JnW3sXq3jRD0d1
 Oa8LL7JGSzjQcTDw==
Received: from g78 (unknown [10.163.24.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1B721A3B8B;
 Mon, 24 Jan 2022 12:22:07 +0000 (UTC)
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <5a65fad42ee618e0191cc664d8da7feeaa754cc0.1642601554.git.luke.nowakowskikrijger@canonical.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Mon, 24 Jan 2022 12:05:19 +0000
In-reply-to: <5a65fad42ee618e0191cc664d8da7feeaa754cc0.1642601554.git.luke.nowakowskikrijger@canonical.com>
Message-ID: <87bl01z5ld.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 04/16] API/cgroup: Implement
 tst_cgroup_load_config()
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Luke,

Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> writes:

> Implement tst_cgroup_load_config which consumes the state given by
> tst_cgroup_print_config() to update the internal test state to reflect
> the given config.
>
> This allows for programs using the cgroup C API to load and reload
> state, allowing functionality such as calling tst_cgroup_require and
> tst_cgroup_cleanup to function properly between programs or between
> invocations of a binary using the C API.

I'm afraid I have to say this looks way more complicated than it needs
to be. We control the input format after all.

If you can make each line the same format then it may be possible to
just use a single scanf on each line. Note that it's only possible to
have ~14 controllers, so we can even afford to repeat the root info on
each line.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
