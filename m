Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF87FF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 09:03:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A8F03E65A8
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 11:03:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 932683E2628
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 11:03:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D399A200B62
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 11:03:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC9616A7CD;
 Thu, 30 Apr 2026 09:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777539802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wuWeK+49G8+gltjgEPrQvgzUIRCbjLPmBVFt1uvHX0U=;
 b=yVwMzFIhX0Ow1kF6JjM60N1k5m2YM670YIKKyIcZxCTPVOaZ8CObLYr/KQ/0QJBntF1yV5
 uXaE2VHzdLHnAAUMwfbd9kFw4v2aA09XKFhzdJEyCEOF/YNfyYvzjum16hkuVjdv/jWlRG
 42+2QxL0g94kZ7AicepDS8vlZ+gGnIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777539802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wuWeK+49G8+gltjgEPrQvgzUIRCbjLPmBVFt1uvHX0U=;
 b=O3/C3SEeLJgaGO5xh12XADFX1ijvd9C9J82gw28bNPrRKTXqzHAiLfDLwuOB4+2ycJ97wS
 j8Ua1wYuG6tiXLBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=g7XGpBs7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RP8m4pIj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777539798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wuWeK+49G8+gltjgEPrQvgzUIRCbjLPmBVFt1uvHX0U=;
 b=g7XGpBs7JMOvXquiahV237RjXaZqDaPKS+dbINuH10LQ1RcN884g6b7QVIxeABoZ51+Xil
 XH0qZMzzgsD+iFlwQS3rwlXHbaFwgT2XUkFtwuaTbvlSonncIiOn2ETnZpCxkQeOWzh8Sh
 ekI1xWD79mAi8G0Z04lMGWHLpIPzAK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777539798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wuWeK+49G8+gltjgEPrQvgzUIRCbjLPmBVFt1uvHX0U=;
 b=RP8m4pIjkUcWQHOYC+6dbUgXlo3IcP30HBwPf3+NkFUvI6DDxXidQ7ee2/FXSqmMvQlg8x
 1lV4O+Syu9Yb2WDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB02C593B0;
 Thu, 30 Apr 2026 09:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4tD5J9Ya82lmKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 30 Apr 2026 09:03:18 +0000
Date: Thu, 30 Apr 2026 11:03:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <afMa06pb1En8apsu@yuki.lan>
References: <20260428161034.947614-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260428161034.947614-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BC9616A7CD
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ima_violations.sh: Wait for ima_mmap to exit
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  test3()
>  {
> +	local pid
> +
>  	tst_res TINFO "verify open_writers using mmapped files"
>  
>  	local search="open_writers"
> @@ -168,6 +170,7 @@ test3()
>  	echo 'testing testing' > $FILE
>  
>  	ima_mmap -f $FILE &
> +	pid=$!
>  	# wait for violations appear in logs
>  	tst_sleep 1s
>  
> @@ -177,7 +180,10 @@ test3()
>  	validate $num_violations $count $search
>  
>  	# wait for ima_mmap to exit, so we can umount
> -	tst_sleep 2s
> +	wait $pid

You can simplify this just by doing 'wait' that will wait for all
background jobs (we have only one here).

Either way:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> +	if [ $? -ne 0 ]; then
> +		tst_brk TBROK "failed to execute ima_mmap"
> +	fi
>  }
>  
>  test4()
> -- 
> 2.54.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
