Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD44C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 21:57:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA7593C884D
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 23:56:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D1A43C01CF
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 23:56:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C2421600338
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 23:56:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 06F0321CCF;
 Thu, 16 Jun 2022 21:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655416607;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mRHtxn9GFcHWW+glqRV+Kd/QmBWxoroocAD5PF8XCGY=;
 b=imBxeZTllh1it7TyMXpZz0CCpSjG2OpXZtZcwxT93nz+e1uNxlU6RIhqtogEnYBJ33Lzvt
 mDclo2sEUAa7o9APpx83xu3Yk0jqEaQqaHHx+FfEE5BQ3o4D50iEnhtFnrG/r1o2SdzTaT
 aXMsdG+vklbgGUPI7Hz/dpvaWGdivOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655416607;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mRHtxn9GFcHWW+glqRV+Kd/QmBWxoroocAD5PF8XCGY=;
 b=39OqEXRe3ZhD2r1YvMKIIzcMukYTuAXn6E4yaA44OtmnHVdc0+XE2sx4OGDoFwgJSHqmSr
 V+f2JzTu2wWj6bBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA3031344E;
 Thu, 16 Jun 2022 21:56:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Z9LqMx6nq2JoQQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jun 2022 21:56:46 +0000
Date: Thu, 16 Jun 2022 23:56:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YqunHbz3EW6DVfLK@pevik>
References: <20220616140717.23708-1-andrea.cervesato@suse.com>
 <20220616140717.23708-3-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220616140717.23708-3-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/7] Refactor mqns_01 using new LTP API
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

Hi Andrea,

> +static inline int get_clone_unshare_enum(const char* str_op)
> +{
> +	if (!str_op || !strcmp(str_op, "none"))
nit: If "none" is a default, how about drop '-m none' entirely? (use without -m)?

> +		return T_NONE;
> +	else if (!strcmp(str_op, "clone"))
> +		return T_CLONE;
> +	else if (!strcmp(str_op, "unshare"))
> +		return T_UNSHARE;
> +
> +	return T_NONE;
> +}

...

> +	mqd = SAFE_MQ_OPEN(MQNAME, O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
> +	if (mqd == -1)
> +		tst_brk(TBROK | TERRNO, "mq_open failed");
This if check is not needed (done by SAFE_MQ_OPEN()
> +}

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
