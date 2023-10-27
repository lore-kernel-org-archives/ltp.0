Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ACDC25B48
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 17:27:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8749A3CF4A7
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 19:27:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B99153CACCC
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:27:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E9639201169
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:27:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 32FA01FDCD;
 Fri, 27 Oct 2023 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698427620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LrnNEvH0n9+6zCbmKPxgzPWz0qLTZo6k7NffkQanU8k=;
 b=fqwtR5QxyeJBv/zB4qoi4SwP3XJzQO1Ewnop9cbs3rNS7pw4DGka+5YGO/Wc7m9VDzfasg
 H6Injwm41w6P4talLHshfkeyo/BrCpxPcp7uyfTSU+8052HKvC0XC7JopMZD93W5JmucyU
 SVhbwsM0xedeyVpIGixnPA9yNFV0Fvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698427620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LrnNEvH0n9+6zCbmKPxgzPWz0qLTZo6k7NffkQanU8k=;
 b=5ztp3nhH2O4u0iRtZHW2uIge6e1/ypMjhPQUxXhpOyA54S3k29pWHV6riStaGQT6CCyuF4
 C0OUDcxn54GpanAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC42E1358C;
 Fri, 27 Oct 2023 17:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cNrdNuPyO2WnTwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 27 Oct 2023 17:26:59 +0000
Date: Fri, 27 Oct 2023 19:26:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231027172658.GC673099@pevik>
References: <20231027093801.51947-1-xuyang2018.jy@fujitsu.com>
 <20231027171815.GB673099@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231027171815.GB673099@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] umount01: Simplify test using TST_ macros
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Xu,

> [ Cc Cyril, who wrote gvfsd-trash note in 10b61174c ("syscalls: umount01: Give a
> hint on failure with EBUSY") ]

I merged the patch. I'm sorry on the system which I tested the patch was really
running gvfsd-trash. I guess there is no easy solution to handle gvfsd-trash.
I guess the test should TCONF on running gvfsd-trash.

Kind regards,
Petr

> While this patch looks to be OK, there is a problem when run several times
> (either with -i > 1 or even just repeatedly run without -i):

...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
