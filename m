Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93D3CA0FEC
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 17:48:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 588E13CCA78
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 19:48:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 200143CBE12
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 19:48:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6BE02602820
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 19:48:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 90FD21F45E;
 Fri,  1 Sep 2023 17:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693590498;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PoEf8T51lG+KGubMoNOKIRyBmHWnNh7kH4YFuzF+xtQ=;
 b=OSF9Y0QS2mQdZcndzoTTwHLIRYgUL2vII7SvQkMDcorUCADHgb799JZ7FvIaGv7oOI/btl
 Wk4QWnj2JT/bZUF8GGr1n0rJ6gvAmAmk6ek2pkbUaI1rwGS3e1pW+3ouHzKrjMkeiAHv27
 eMrPI/kddY/odRy6BB7+RvlNINgvBXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693590498;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PoEf8T51lG+KGubMoNOKIRyBmHWnNh7kH4YFuzF+xtQ=;
 b=eGDANx1cs7Pk1dsV7Osx1BBkToKTZ66Y9Yifg94+R0D1PS60adSHxdDqHT94Llka5OeQ8q
 J1qZq8GOOWuk+FBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C91A13582;
 Fri,  1 Sep 2023 17:48:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +15AA+Ij8mQmPwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 01 Sep 2023 17:48:18 +0000
Date: Fri, 1 Sep 2023 19:48:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230901174815.GA390265@pevik>
References: <20230901144433.2526-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230901144433.2526-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched: add sched sysctl sanity test
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

Hi Cyril,

...
> +++ b/testcases/kernel/sched/sysctl/proc_sched_rt01.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Sanity tests for the /proc/sys/kernel/sched_r* files.
> + *
> + * - The sched_rt_period_us range is 1 to INT_MAX
> + *   try invalid values and check for EINVAL
> + *
> + * - The sched_rt_runtime_us range is -1 to INT_MAX
> + *   try invalid values and check for EINVAL

As I wrote to the kernel patch, Documentation/scheduller/sched-rt-group.rst [1]
specifies this as values from -1 to (INT_MAX - 1).

Kind regards,
Petr

[1] https://www.kernel.org/doc/html/latest/scheduler/sched-rt-group.html#system-wide-settings

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
