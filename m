Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A29C4167B
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 16:22:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2402E3CDE0B
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 17:22:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF21F3CC9A0
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 17:22:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C3B761001F3F
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 17:22:43 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC79E1FB4A;
 Mon, 27 Nov 2023 16:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701102160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1TH4OXl0RRJbqPAPuDpjE83eP12aCntX7GDuCyAsJCo=;
 b=p9TwNiS0g8J4drDRF7Yw269zA9wKM6I1PQRqDWHY+Q8HD0lCO3BNav66TC3WyBYoXC9APz
 5fZ3tdst6C1BNGNcNC6ABfNQnNKmB7/Mk4r1tKcylqhEU153QN+tvatxeq2ynBMu3uRqIs
 d8yJd84zujRSB5QzZpvfyxodp14D6Vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701102160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1TH4OXl0RRJbqPAPuDpjE83eP12aCntX7GDuCyAsJCo=;
 b=t3trqYbQY5pFDMJOgD43/6LcyqmsjLJHUXxplItsRkYLCjLJA9pPffyCIFCCyR7PeiGH2m
 AGvA3XD54tOs6aBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6425B13440;
 Mon, 27 Nov 2023 16:22:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id N48qDlDCZGUyYgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 27 Nov 2023 16:22:40 +0000
Date: Mon, 27 Nov 2023 17:22:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20231127162237.GA288945@pevik>
References: <20231127154013.2625-1-jack@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231127154013.2625-1-jack@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify: Fix broken tests due to
 fanotify_events_supported_by_kernel()
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

Hi Jan,

> When LTP test is run with CWD in btrfs subvolume, tests like fanotify16
> fail with:

> fanotify.h:169: TBROK: fanotify_mark (3, FAN_MARK_ADD, ..., AT_FDCWD, ".") failed: EXDEV (18)

I'll have a deeper look tomorrow, but actually with this patch it fails

LTP_SINGLE_FS_TYPE=btrfs ./fanotify16
...
fanotify.h:168: TBROK: fanotify_mark (3, FAN_MARK_ADD | 0, 10000000, AT_FDCWD, ".") failed: EXDEV (18)

And it works without it. What am I missing?

Tested on 6.7.0-rc1-2.g86e46c2-default

> This is because fanotify_events_supported_by_kernel() try to place a
> mark onto CWD and that is forbidden for btrfs subvolumes. Change
> fanotify_events_supported_by_kernel() to use "/" instead of "." which
> has higher chances of working for btrfs.

> Also update the error message to provide a bit more info.

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 32b510cdc178..f2fe0c05b449 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -161,12 +161,13 @@ static inline int fanotify_events_supported_by_kernel(uint64_t mask,

>  	fd = SAFE_FANOTIFY_INIT(init_flags, O_RDONLY);

> -	if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, ".") < 0) {
> +	if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, "/") < 0) {
>  		if (errno == EINVAL) {
>  			rval = -1;
>  		} else {
>  			tst_brk(TBROK | TERRNO,
> -				"fanotify_mark (%d, FAN_MARK_ADD, ..., AT_FDCWD, \".\") failed", fd);
> +				"fanotify_mark (%d, FAN_MARK_ADD | %x, %llx, AT_FDCWD, \".\") failed",
				"fanotify_mark (%d, FAN_MARK_ADD | %x, %llx, AT_FDCWD, \"/\") failed",

(You changed directory . to /, thus error message should be updated as well)

Kind regards,
Petr

> +				fd, mark_flags, (unsigned long long)mask);
>  		}
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
