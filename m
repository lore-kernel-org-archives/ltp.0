Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14267C433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 13:01:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7225B3C9AD1
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 14:01:37 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C885E3C094F
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 14:01:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0B37B14010CA
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 14:01:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4C5E91F440;
 Thu,  3 Feb 2022 13:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643893287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t7GWI79ZWMoRhfQFj8r2ar4c17yS0Hj9sx/QrN7jnbU=;
 b=f5HBv1RX7ehHKnPTkE5f+SAsMECyQeOEwau4w1++fnJmmwo+PIpzYox0jNqDvG1r0aGejr
 rLsIQJRUmOkPyt4nmUk1uNiZSOS+YDcGHRoYFBHL37+mBjgHUBWAtFboUy+FAL4fUjccub
 LkkkX7AOSWtWzBH05xbidMNKq6KoCCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643893287;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t7GWI79ZWMoRhfQFj8r2ar4c17yS0Hj9sx/QrN7jnbU=;
 b=+Klx+AJ4w0IlJaoeFDXH91ehLSMzuHdozporoaYnBo5q0lj90BS5GdwD7V1/7FIg7j+hU4
 GsaBCn/FTLNHSQDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 358D413BC0;
 Thu,  3 Feb 2022 13:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TQbICyfS+2FVKwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 03 Feb 2022 13:01:27 +0000
Date: Thu, 3 Feb 2022 14:03:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YfvSnMMWf/T3siZl@yuki>
References: <20220203081820.29521-1-rpalethorpe@suse.com>
 <20220203081820.29521-3-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220203081820.29521-3-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] API/cgroup: Declare required controllers
 and version in test struct
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

Hi!
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -133,6 +133,14 @@ extern unsigned int tst_variant;
>  
>  #define TST_NO_HUGEPAGES ((unsigned long)-1)
>  
> +/* CGroups Kernel API version */
> +enum tst_cgroup_ver {
> +	TST_CGROUP_V1 = 1,
> +	TST_CGROUP_V2 = 2,
> +};
> +
> +struct tst_cgroup_group;

This is no longer needed here.

The rest looks good:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
