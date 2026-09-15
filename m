Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F95C88E53
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 12:57:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBFD33E8CB5
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 14:57:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFDBB3E20C0
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 14:57:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4E14B60028E
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 14:57:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E55D91FD86;
 Tue, 15 Sep 2026 12:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789477045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U1i9nILzEnoggGIKgFsbNc24BqDtbUdhmhl5Zo5sauA=;
 b=k40umbweznpW16Tt2EfrSJtIgyEa1dctL0PC2zzoodqWHAVXnaJNoXyaRFrB8kMAV+EeXQ
 Bu1ViQpPE1tBqmzlorj+WiSVgjnDaqFIXfoakwNYjMx6K+5Q+YtA9WHs7onA6RX9URgXQY
 aKatm6wtfiVchLKUVA7AWh0MsESG0dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789477045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U1i9nILzEnoggGIKgFsbNc24BqDtbUdhmhl5Zo5sauA=;
 b=diLWwsAFezTVxS01/8uEzgCk6rZYGSLSEP0Efl18trPeuccSKJvh+WpJGM9F0EeMzscHD6
 lZSxRMOsCa3ss9BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="eHy5C/fF";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TjHNoria
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789477040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U1i9nILzEnoggGIKgFsbNc24BqDtbUdhmhl5Zo5sauA=;
 b=eHy5C/fFkulUCbrGsP/qeCMV6s+eiVOln7Y1MK3MTt1vBYuTRZd1nP4AEGVYjwcM4Nuc27
 zc8tvTRNickHjps5iY6YCMWR9NL2bOhxgtQwSFC1OHF9EN7R356WKin+4RSUHNnMTVdDdd
 jWFObGNOfLtOLiMtG1dM4aEl1VYy2oY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789477040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U1i9nILzEnoggGIKgFsbNc24BqDtbUdhmhl5Zo5sauA=;
 b=TjHNoriaN9nUCd3lLGyUTh1Eyy1DpPOOKHZzkx8DJmYQ4fm603mUZWQ7FhHKnYFKE7ab0y
 WpCUivoHFGbq0MAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B35E313432;
 Tue, 15 Sep 2026 12:57:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mqupI7BAqWrhTwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 15 Sep 2026 12:57:20 +0000
Date: Tue, 15 Sep 2026 14:57:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Michael Menasherov <mmenashe@redhat.com>
Message-ID: <aqlAt5wCGegscwBS@yuki.lan>
References: <20260908092248.15774-1-mmenashe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260908092248.15774-1-mmenashe@redhat.com>
X-Rspamd-Queue-Id: E55D91FD86
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] read_all: Fix buffer too small for long paths
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
> diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
> index 5720ffb99..ec9454fc9 100644
> --- a/testcases/kernel/fs/read_all/read_all.c
> +++ b/testcases/kernel/fs/read_all/read_all.c
> @@ -51,8 +51,8 @@
>  #include "tst_timer.h"
>  
>  #define QUEUE_SIZE 16384
> -#define BUFFER_SIZE 1024
> -#define MAX_PATH 4096
> +#define BUFFER_SIZE PATH_MAX
> +#define MAX_PATH PATH_MAX
>  #define MAX_DISPLAY 40

This part looks good.

>  struct queue {
> @@ -131,7 +131,7 @@ static int queue_pop(struct queue *q)
>  	while (q->data[i]) {
>  		q->popped[j] = q->data[i];
>  
> -		if (++j >= BUFFER_SIZE - 1)
> +		if (++j >= BUFFER_SIZE)
>  			tst_brk(TBROK, "Buffer is too small for path");
>  
>  		 i = (i + 1) % QUEUE_SIZE;

However here we do:

q->popped[j] = '\0';

So j must be at most BUFFER_SIZE-1 and with the change above j may end
up equal to BUFFER_SIZE and we will land off by one in the array.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
