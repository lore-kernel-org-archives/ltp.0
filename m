Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B43C433F5
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 10:53:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4ADCA3C9524
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 11:53:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07CC23C94FA
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 11:53:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5AF691001196
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 11:53:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F1E11F45F;
 Thu, 13 Jan 2022 10:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642071192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=61PSOEnR8mx4850IvwzxXTuNcC+Rnvw+tuEqrzl/vdI=;
 b=29T3SyT+Un7MCzKXnURcWKrtXnOesCQxTLgUEPk8bzhEDsqjW+afZGUpP/mnzcxJkfIVjr
 qEWEsexfq0oePTvRx61u5B4YTS+E3zGKneGZZwBmCtoC6wWzxhVkoyeDhwBDPOnHDzks4i
 hw2NIO/uJS9pNhsIib9AWycsw5oDARU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642071192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=61PSOEnR8mx4850IvwzxXTuNcC+Rnvw+tuEqrzl/vdI=;
 b=3ZX5u/94iTHQ77le2KWpPekE55vHlCb3jW6UmEPcZ3QlxnDgmd2yyh/p9IRL1aINYKZ36a
 D7hoK0WA+hIALADw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31C1A13BF7;
 Thu, 13 Jan 2022 10:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 89fDCZgE4GGgHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Jan 2022 10:53:12 +0000
Date: Thu, 13 Jan 2022 11:53:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YeAEliyKciDMKzV0@pevik>
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641881435-2351-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1641881435-2351-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/5] sysctl/sysctl02.sh: Use kconfig shell api
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

Hi Xu, all,

subject: "sysctl/sysctl02.sh: Use kconfig shell api"
nit: s/api/API/

Maybe to explain why it's better thatn simple [ -f /proc/kallsyms ] ?
Isn't it more reliable to use /proc/kallsyms file instead of requiring kconfig?

kconfig is sort of documentation, but only if used as TST_NEEDS_KCONFIGS
(I'm going to work on enabling docparse for shell), which is not this case.

If we agree TST_NEEDS_KCONFIGS is better in this case how about to put
sysctl_test_zero into separate file? It could then define things required setup
in TST_NEEDS_KCONFIGS.

> +++ b/testcases/commands/sysctl/sysctl02.sh
> @@ -20,15 +20,14 @@ TST_CLEANUP=cleanup
>  TST_CNT=4
>  TST_NEEDS_ROOT=1
>  TST_NEEDS_CMDS="sysctl"
> +TST_NEEDS_KCONFIGS="CONFIG_SYSCTL=y, CONFIG_PROC_FS=y"
As Cyril mentioned previously CONFIG_PROC_FS can be dropped
(IMHO mandatory for today's linux).

OK, looking into sources it's disabled in:

arch/h8300/configs/edosk2674_defconfig, the other two are GDB simulators.
=> only this one relevant (Renesas EDOSK2674R)
arch/h8300/configs/h8300h-sim_defconfig
arch/h8300/configs/h8s-sim_defconfig

arch/sh/configs/edosk7705_defconfig
arch/sh/configs/sh7724_generic_defconfig
arch/sh/configs/sh7770_generic_defconfig

=> sh and h8300 are certainly not mainstream :).
I can ask the maintainers whether they really use kernel without CONFIG_PROC_FS.

But I'd still consider to safe to expect CONFIG_PROC_FS=y.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
