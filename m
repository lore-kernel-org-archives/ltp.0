Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01971EB64DD
	for <ltp@archiver.kernel.org>; Tue,  1 Aug 2023 08:43:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C421B3CDB4A
	for <ltp@archiver.kernel.org>; Tue,  1 Aug 2023 10:43:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D160D3CD616
 for <ltp@lists.linux.it>; Tue,  1 Aug 2023 10:43:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 820281000B66
 for <ltp@lists.linux.it>; Tue,  1 Aug 2023 10:43:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6780B1F6E6;
 Tue,  1 Aug 2023 08:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690879406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FQzWDZWGP5t7BCynUI1hdGtL6LWZL+UVBZhOK5BOnP4=;
 b=nzQwTYUQcTHwb0Co4djXQ9iCQp5CkNRxwafm6yXMsysTZO0fMnBZSdqQpx6zov9IeNAg68
 qs7DOxJ5gmd0K17WddfOMuIXHTXod+v8zAStWmnHI91r/UPLFWABkYUu983G2/wxgHpPI6
 yzzdSjWkdh0+LqUD5XfIn57vKa7Jz6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690879406;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FQzWDZWGP5t7BCynUI1hdGtL6LWZL+UVBZhOK5BOnP4=;
 b=+d1LVnrU8+0XFBxtZKlqGn7HPboEVyr1zVnpY/nYy0sqBaW+0C9nqFfisbHvoPbjvgVLb8
 mveQa/zaMmWBv1AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44B08139BD;
 Tue,  1 Aug 2023 08:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PLf3BK7FyGS6KwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 01 Aug 2023 08:43:26 +0000
Date: Tue, 1 Aug 2023 10:44:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZMjF5WK60ziGD6yt@yuki>
References: <20230731114931.13656-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230731114931.13656-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Remove ltp_clone_quick usage from pidns suite
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
> -int find_cinit_pids(pid_t * pids)
> +static int find_cinit_pids(pid_t *pids)
>  {
> -	int next = 0, pid_max, i;
> +	int i;
> +	int next = 0;
>  	pid_t parentpid, pgid, pgid2;
>  
> -	pid_max = max_pid();
>  	parentpid = getpid();
> -	pgid = getpgid(parentpid);
> +	pgid = SAFE_GETPGID(parentpid);
>  
> -	/* The loop breaks, when the loop counter reaches the parentpid value */
>  	for (i = parentpid + 1; i != parentpid; i++) {
>  		if (i > pid_max)
>  			i = 2;

Can we please, as I asked for in v1 review, just do loop from 2 to
pid_max here instead? It's effectively the same we do here but much
clearer code...

The rest looks good to me.

With the change to the loop above:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
