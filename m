Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE66C00144
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 14:27:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AF183C8796
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 16:27:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 403983C812E
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 16:27:22 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6E2A41000772
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 16:27:21 +0200 (CEST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id DC8605C0178;
 Mon,  1 Aug 2022 10:27:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 01 Aug 2022 10:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
 :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm3; t=1659364039; x=1659450439; bh=MOcPvT+Aro
 bkFPSL7AKi/orcM242GMNPBPC/lb6hxK8=; b=NhYqlUlIAwoOG7HPt/tf/NWzv9
 nDACQhjMuZ8YWMx6ldBD5xI97e18UZ7jPKMlonoWLAkEacOw+0J8D67HXiFlU/Ml
 /fQV8qDg7H6FzwSPR0nG3KXLItixIbPk6U0gOIy+mrLnJT5kT1KPp91xPGlJ1uiS
 sLjdpuoxGwTxbndQhyGZHpT7JaUpH5oeEyXT7rL8II37m0U5LlD44LJXw7TAdlxx
 P15K1MsNTB0lJrw0tWke/PrmU3grSs69ZeLQikUgU6mk9ZBTtQVwOWEsNZCpu+we
 RNG9pd9lxu4lYufzgDxITw+2U/sZu/6GC4zMyWRFbG3acVw3uYZ15aBsCrGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1659364039; x=1659450439; bh=MOcPvT+ArobkFPSL7AKi/orcM242
 GMNPBPC/lb6hxK8=; b=spoLn3LqU9gEFSl3T41OZL60makD0q338xgIyMJ8Abi1
 gXvrDZrtu07JSV3JP7dO+m3ldwmfojw8t9PyqOWwUGjQCjHyzN6wooAGi84VHljm
 /103TgAlngkhqIVrFcaGzhZqZs6QkQiJERWd/qghvutyEmwpak51eKIvY1ONru6j
 fTP+L47z8DUF0iTz3lD9nffq/AqtG3RSi5DG8ZoWwzH1cnr/ZebN51T2rIDyPKwC
 P60v/VLIZlbeVjTY3aeVlqv1guSwW8qSWy4Pub98AhXTP7BtSvUApB6iTzLEojOt
 Hqc6bY9m7bIHn+OkXGJ2RivTXpTL9JGlPtAXFgneWQ==
X-ME-Sender: <xms:x-LnYoJjgzklReQtjcsT9DMaztVOSU_NaFcnjPUwJ3Pr55XU1D-bCw>
 <xme:x-LnYoJGJkhE_nALV9l5MnwQBUPMOIjYMNsIbQFSSQmG5IEUE-NHSgc7t8wyigLDk
 GnJbpbZXvnNNA>
X-ME-Received: <xmr:x-LnYosp3c4KqnbWAeyRr3z1B54OlyDrnKef11ZKwiiBNiiPhdvTbU7OKtPcT5TvBakHaZxnwbWXISR7Osy8SeY13RHvuzT7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvfedgjeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
 ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
 evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
 hhrdgtohhm
X-ME-Proxy: <xmx:x-LnYlb-hOIQBIiaNeqLB_ad5irrTbvUmdd1AHUihfxbgg3a0wQzvQ>
 <xmx:x-LnYvZSrTYDTVv8DyuiAY8PYet67WTIwx9sciZtKWDk2NsnvCXgmA>
 <xmx:x-LnYhDzA1BdZKZKEhjg2V_a6YeTbkDY9eYT_CPXN7ePfJZeMdPonQ>
 <xmx:x-LnYumINzcdqGeKgomRqehdptDa91mZZqvsFZFJUGdoT0sDLZz1jQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Aug 2022 10:27:19 -0400 (EDT)
Date: Mon, 1 Aug 2022 16:12:58 +0200
From: Greg KH <greg@kroah.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YuffaiUfSlrD1iJv@kroah.com>
References: <YufZ1ZcIhkjLFEWM@kroah.com>
 <Yufetwojkjxzwl34@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yufetwojkjxzwl34@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Linux kernel development reports for the 5.10 release
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

On Mon, Aug 01, 2022 at 04:09:59PM +0200, Cyril Hrubis wrote:
> Hi!
> Obviously the email ltp@lists.linux.it is a maling list for a Linux Test
> Project. The project is run by developers of several companies so I have
> no idea how to map that to a model where email belongs to a single
> entity.

I'll just map it to the "Linux Test Project", ok?

thanks,

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
