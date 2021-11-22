Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4EAC433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 09:40:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D2703C8D81
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 10:40:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BB073C06B2
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 10:40:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DBC4F14011A0
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 10:40:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC62C212BA;
 Mon, 22 Nov 2021 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637574020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hipe1uCMh82OSQ19ug14py3RVzwgKqYeHsCGCev0CIM=;
 b=k4JRUQhvmGX8MsfPVfKy7sGcWBzJ/M/RLMU4vY+0CL5aPwlMzXibm+DMBIaTGTOs/uTthf
 gWkp6O8T4VvVcMKKC2zITJMXpk4htrx7WAGCmI/yc6K39sq3uVX5kdBc+vf08v/zYhQUED
 48tfnqpbknKGx6G0ZoamBWE1UleBq4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637574020;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hipe1uCMh82OSQ19ug14py3RVzwgKqYeHsCGCev0CIM=;
 b=v/t8ZLXFA/jXWM/fTcDLbNsZZB57lqi1f6Yznkt/pkQM5ZaxJNEaCCg90dnhwhPWEM6cnN
 dur0pXZePt5I3lBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA32C13C23;
 Mon, 22 Nov 2021 09:40:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KsucMIRlm2FrWwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 22 Nov 2021 09:40:20 +0000
Date: Mon, 22 Nov 2021 10:41:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YZtlxQZn06aplsvw@yuki>
References: <20211122072601.4096577-1-lkml@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211122072601.4096577-1-lkml@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] posix/conformance/interfaces/fork/7-1: Fix
 test
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> -static void read_catalog(nl_catd cat, char *who)
> +static int read_catalog(nl_catd cat)
>  {
> +	static const char *notfound = "not found";

Why static here?

>  	char *msg = NULL;
>  	int i, j;
>  
> -#if VERBOSE > 0
> -	output("Reading the message catalog from %s...\n", who);
> -#endif
> -
> -	errno = 0;
> -
> -	for (i = 1; i <= 2; i++) {
> +	for (i = 1; i <= 3; i++) {

Actually this change makes the test fail for me since there is no set 3.

Have you modified this to check if the test fails and then forget to
change it back?


Other than these two the changes looks good to me. If you agreen I can
fix the two small issues before pushing it to the repo.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
