Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A00EC43334
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 08:55:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3FF83CA0FA
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 10:55:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE5F23C021B
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 10:55:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 86C301400742
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 10:55:05 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DD16E1FA6E;
 Tue, 26 Jul 2022 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658825704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KmwucH6g3Bxbc4qB21hD23g+ZPDT/DzaDNFEI0lba6s=;
 b=yHPcwcywLcemwij7cn1HXQhyQj9QuyB8rEbyjGkKz8eC62BAX4ZG6nv/9GP314DpeuGkCK
 I0HGQRdsxdc9RLdGbAd4utMyQZgMJKXdWjVF/HEyuoePnU/bte+SjQImAw/aNSfiFskxOG
 J0SnUkKtlAWFXPqNCIwZrpBT5Y7sEA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658825704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KmwucH6g3Bxbc4qB21hD23g+ZPDT/DzaDNFEI0lba6s=;
 b=wCfbCNEGyOHgxpP859y+YsMYyiAqHtYHlclg4M2mI4evIOaCMxp+JHZOR1imU+BNtBGb0i
 vD1OfdfkDjx3OeCQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8436D2C15D;
 Tue, 26 Jul 2022 08:55:04 +0000 (UTC)
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2cW-yEk598waeFkDT4tkN0hoXqDwKL3LKCuzBqWfNqvUg@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Tue, 26 Jul 2022 09:52:34 +0100
In-reply-to: <CAEemH2cW-yEk598waeFkDT4tkN0hoXqDwKL3LKCuzBqWfNqvUg@mail.gmail.com>
Message-ID: <87y1wg45jr.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 00/18] Expand Cgroup lib and modify controller
 tests
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
Cc: LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Li Wang <liwang@redhat.com> writes:

> Hi All,
>
> I have completed my review (and test) on this patch set, generally looks good!
>
> With regard to the tiny issues, I think Luke you can just against the concrete
> problem to follow up and fix it. No need to resend all patches with a new version.
>
> I would suggest merging this patchset at present (in case of blocking other's (or duplicate) work).
>
> CI builds pass: https://github.com/wangli5665/ltp/runs/7460955660
>
> Reviewed-by: Li Wang <liwang@redhat.com>

I'm also very keen to get this merged and can make the necessary
fixups. However I will give Petr Vorel chance to look at the shell
tests.

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
