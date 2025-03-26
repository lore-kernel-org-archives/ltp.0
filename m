Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE21C3600B
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 15:04:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 075333C19F4
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 16:04:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 439683C19F4
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 16:04:36 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=jack@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6CD9F1400343
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 16:04:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B3A2D21188;
 Wed, 26 Mar 2025 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743001472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vim6E7fA2S2VTqfp2oIIL25g34Olha1bK5smPvCdRAQ=;
 b=MYh+4Fy0fFED4ik/qKOdjDGhBuXE8ZcsfuL3Z4G+sMPHRlivY9EjzkqPVzY4FIwkhhbHr0
 RmcLSUFYy0t+G8j285fixEzfhnpXpcZL927MtrwM5/cfv8GJGnW0pyKzbI1FrgxktoIuFv
 dWrYS9rAZKHbQuk2nZBnWEZfAjo/O80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743001472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vim6E7fA2S2VTqfp2oIIL25g34Olha1bK5smPvCdRAQ=;
 b=kxGrHllB4ecfrAHkTRmo5IdKKlI9YRDvS5DKfZdwbLovhrqUqYwU3rrYNeJmkJli4bm/VO
 sTYRpEuvzaXoG2DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MYh+4Fy0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kxGrHllB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743001472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vim6E7fA2S2VTqfp2oIIL25g34Olha1bK5smPvCdRAQ=;
 b=MYh+4Fy0fFED4ik/qKOdjDGhBuXE8ZcsfuL3Z4G+sMPHRlivY9EjzkqPVzY4FIwkhhbHr0
 RmcLSUFYy0t+G8j285fixEzfhnpXpcZL927MtrwM5/cfv8GJGnW0pyKzbI1FrgxktoIuFv
 dWrYS9rAZKHbQuk2nZBnWEZfAjo/O80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743001472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vim6E7fA2S2VTqfp2oIIL25g34Olha1bK5smPvCdRAQ=;
 b=kxGrHllB4ecfrAHkTRmo5IdKKlI9YRDvS5DKfZdwbLovhrqUqYwU3rrYNeJmkJli4bm/VO
 sTYRpEuvzaXoG2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CF1113927;
 Wed, 26 Mar 2025 15:04:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hh9KJoAX5GdLVAAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 26 Mar 2025 15:04:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 3E970A082A; Wed, 26 Mar 2025 16:04:32 +0100 (CET)
Date: Wed, 26 Mar 2025 16:04:32 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <xpozkmxhtqd3lamf7n2dk43z6eey5ettmdw3vayykmjrv5dqgt@zeewki7ibawg>
References: <20250319192742.999506-1-amir73il@gmail.com>
 <20250319192742.999506-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250319192742.999506-3-amir73il@gmail.com>
X-Rspamd-Queue-Id: B3A2D21188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_COUNT_THREE(0.00)[3]; FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email, suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify24: print range info for pre-content
 events
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 19-03-25 20:27:41, Amir Goldstein wrote:
> range info is expected only for pre-content events
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Just one nit below. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify24.c b/testcases/kernel/syscalls/fanotify/fanotify24.c
> index 539f74137..2d2479b39 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify24.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify24.c
> @@ -339,6 +339,7 @@ static void test_fanotify(unsigned int n)
>  	 */
>  	while (test_num < EVENT_SET_MAX && fd_notify != -1) {
>  		struct fanotify_event_metadata *event;
> +		struct fanotify_event_info_range *range;
>  
>  		if (i == len) {
>  			/* Get more events */
> @@ -367,6 +368,7 @@ static void test_fanotify(unsigned int n)
>  			test_num--;
>  
>  		event = (struct fanotify_event_metadata *)&event_buf[i];
> +		range = (struct fanotify_event_info_range *)(event + 1);
>  		/* Permission events cannot be merged, so the event mask
>  		 * reported should exactly match the event mask within the
>  		 * event set.
> @@ -386,6 +388,22 @@ static void test_fanotify(unsigned int n)
>  				(unsigned int)event->pid,
>  				(unsigned int)child_pid,
>  				event->fd);
> +		} else if (event->mask & LTP_PRE_CONTENT_EVENTS) {

You should probably check here that the event->len is sufficiently large to
contain the range info. Otherwise 'range' might point beyond the end of
event and result in odd behavior...

								Honza

> +			if (range->hdr.info_type != FAN_EVENT_INFO_TYPE_RANGE) {
> +				tst_res(TFAIL,
> +					"got event: mask=%llx pid=%u fd=%d "
> +					"(expected range info)",
> +					(unsigned long long)event->mask,
> +					(unsigned int)event->pid,
> +					event->fd);
> +			} else {
> +				tst_res(TPASS,
> +					"got event: mask=%llx pid=%u fd=%d "
> +					"offset=%llu count=%llu",
> +					(unsigned long long)event->mask,
> +					(unsigned int)event->pid, event->fd,
> +					range->offset, range->count);
> +			}
>  		} else {
>  			tst_res(TPASS,
>  				"got event: mask=%llx pid=%u fd=%d",
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
