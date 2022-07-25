Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2496CC43334
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 11:44:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A77153C9F7C
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 13:44:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 169B33C0756
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 13:44:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 59FDC6006F1
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 13:44:33 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5C56734848;
 Mon, 25 Jul 2022 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658749473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Vv+nWrDdnzC69K9mo/5LFL6LTld6xr0jEju1J5IbAU=;
 b=ZB+5OPEgZwbX8BNb5Y5BmPeHJ5mCBuDQiiPwqBrTeksiqP3BuDvN5qcjASKlbsZSYChFvG
 bZuXAgkMetlJBbmsKRKsFOks/vXEHTEXVbPXHLzMhrS6st7gRYMVJoPnmpZohwr8z9Abso
 E7mk7BKs57tErD8llZFLrBHoOts8GiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658749473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Vv+nWrDdnzC69K9mo/5LFL6LTld6xr0jEju1J5IbAU=;
 b=LSLZzEwZ1qiWvjL0AHFEMfA8wTyDKOgpyRZC6wi5qTO/WC82lU96ke0TvU0Ccylr0nFv1m
 W6NpysZo/m0mQvDw==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E8AC92C14F;
 Mon, 25 Jul 2022 11:44:32 +0000 (UTC)
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
 <caab3f8e65b22bf00aa2fa1da9669c7f43df119d.1658433280.git.luke.nowakowskikrijger@canonical.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Mon, 25 Jul 2022 12:41:37 +0100
In-reply-to: <caab3f8e65b22bf00aa2fa1da9669c7f43df119d.1658433280.git.luke.nowakowskikrijger@canonical.com>
Message-ID: <8735ep5sdb.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 11/18] controllers: Update cgroup_fj_* to use
 newer cgroup lib and test lib
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


Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> writes:

> +setup()
> +{
> +    common_setup

This can fail and we have not set pid yet.

> +    cgroup_fj_proc&
> +    pid=$!
> +    create_subgroup "$start_path/ltp_1"
> +}
>  
> -ROD kill -9 $pid
> -wait $pid
> -ROD rmdir "$start_path/ltp_1"
> +cleanup()
> +{
> +    kill -9 $pid >/dev/null 2>&1
> +    wait $pid >/dev/null 2>&1

$pid is unset so this just waits forever. We need something like the
following:

    if [ -n "$pid" ]; then
      kill -9 $pid >/dev/null 2>&1
      wait $pid >/dev/null 2>&1
    fi


> +    rmdir "$start_path/ltp_1" >/dev/null 2>&1
> +    common_cleanup
> +}
>  

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
