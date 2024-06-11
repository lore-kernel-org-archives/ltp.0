Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1219AC25B76
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 12:11:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 420623D0B8C
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 14:11:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A390D3C0326
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 14:11:31 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E79D31A00F1C
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 14:11:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 15522206E0;
 Tue, 11 Jun 2024 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718107889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtGCN461l00Gd0WNNJSGJfcb4vTA67lUzPvL+8iBPRM=;
 b=htSm+0EJGmgjd4VUSkRReURuPFpM8pShOnD714n/hIQm7ItAxsr9NUW34Ley9dIkVTX06I
 BzwRQOMuK39S4lyPvaE7dF8LmzwNMuNi6bl9mj4ILHnI1x1w035Y9ZQU3i6+e14LWpwJU5
 6X6eJ3vHipCV/zkrCI4QkZiu75Ek23Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718107889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtGCN461l00Gd0WNNJSGJfcb4vTA67lUzPvL+8iBPRM=;
 b=0o/kXyjtqfwqBKyjFAdx5tn8Xd/NWzrWvJYePPyYHzm5zh0OiFSzoQzUg5PcMJNfU/Nksl
 yYmqqocfixLbIfDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718107889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtGCN461l00Gd0WNNJSGJfcb4vTA67lUzPvL+8iBPRM=;
 b=htSm+0EJGmgjd4VUSkRReURuPFpM8pShOnD714n/hIQm7ItAxsr9NUW34Ley9dIkVTX06I
 BzwRQOMuK39S4lyPvaE7dF8LmzwNMuNi6bl9mj4ILHnI1x1w035Y9ZQU3i6+e14LWpwJU5
 6X6eJ3vHipCV/zkrCI4QkZiu75Ek23Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718107889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtGCN461l00Gd0WNNJSGJfcb4vTA67lUzPvL+8iBPRM=;
 b=0o/kXyjtqfwqBKyjFAdx5tn8Xd/NWzrWvJYePPyYHzm5zh0OiFSzoQzUg5PcMJNfU/Nksl
 yYmqqocfixLbIfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 060E113A55;
 Tue, 11 Jun 2024 12:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oVeLAPE+aGY2JgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 11 Jun 2024 12:11:29 +0000
Date: Tue, 11 Jun 2024 14:11:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jiwei Sun <sunjw10@outlook.com>
Message-ID: <Zmg-7snwjqRFWv4K@yuki>
References: <SEZPR01MB452774E4131F00D0D2C0CE60A8C72@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SEZPR01MB452774E4131F00D0D2C0CE60A8C72@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[outlook.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[outlook.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 linux.it:url]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] genload: fix memory corruption in hogvm
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
Cc: ahuang12@lenovo.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
> ---
>  tools/genload/genload.c | 2 +-
>  tools/genload/stress.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/genload/genload.c b/tools/genload/genload.c
> index 7f56d5272..9712e7828 100644
> --- a/tools/genload/genload.c
> +++ b/tools/genload/genload.c
> @@ -642,7 +642,7 @@ int hogvm(long long forks, long long chunks, long long bytes)
>  			usleep(backoff);
>  
>  			while (1) {
> -				ptr = (char **)malloc(chunks * 2);
> +				ptr = (char **)malloc(chunks * 2 * sizeof(char *));

Good catch, however shouldn't this be just chunks * sizeof(char*) ?

>  				for (j = 0; chunks == 0 || j < chunks; j++) {
>  					if ((ptr[j] =
>  					     (char *)malloc(bytes *
> diff --git a/tools/genload/stress.c b/tools/genload/stress.c
> index 7f56d5272..9712e7828 100644
> --- a/tools/genload/stress.c
> +++ b/tools/genload/stress.c
> @@ -642,7 +642,7 @@ int hogvm(long long forks, long long chunks, long long bytes)
>  			usleep(backoff);
>  
>  			while (1) {
> -				ptr = (char **)malloc(chunks * 2);
> +				ptr = (char **)malloc(chunks * 2 * sizeof(char *));

Here as well.

>  				for (j = 0; chunks == 0 || j < chunks; j++) {
>  					if ((ptr[j] =
>  					     (char *)malloc(bytes *
> -- 
> 2.27.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
