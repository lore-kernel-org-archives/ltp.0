Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E547F0182E
	for <ltp@archiver.kernel.org>; Fri,  6 Mar 2026 12:14:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5375E3CF020
	for <ltp@archiver.kernel.org>; Fri,  6 Mar 2026 13:13:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBCF13C59D2
 for <ltp@lists.linux.it>; Fri,  6 Mar 2026 13:13:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 48F266007BB
 for <ltp@lists.linux.it>; Fri,  6 Mar 2026 13:13:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6C093E7A5;
 Fri,  6 Mar 2026 12:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772799218;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+wpOdiC+Yf711NJ4GvYM4X1Y0LvfQKlQWmlmmLRb7I=;
 b=rxOGJ/SCyTgwo1mZJ2ciQrZb6CNhpIVWFqSF7O3YwEi0faLRtTfH50WW4835yebKu7By/i
 9vlqK1e0qzZvOpwh/Yo2hai6HEyMQMqVYM8wyZTLx3f+nAKS5O0aFIxrQVOCxNCs7pNh1X
 n5gsOcdk5TDot/2goWCOpUZnq0tHEog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772799218;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+wpOdiC+Yf711NJ4GvYM4X1Y0LvfQKlQWmlmmLRb7I=;
 b=ttVXelRA3qd/e0EyqSpl3ztz1W172yP2C7Q3KVi/S8xcCO7m4Tl+5UBCyN8WBuODFWurUq
 /U2/+epP7u7o0gAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772799218;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+wpOdiC+Yf711NJ4GvYM4X1Y0LvfQKlQWmlmmLRb7I=;
 b=rxOGJ/SCyTgwo1mZJ2ciQrZb6CNhpIVWFqSF7O3YwEi0faLRtTfH50WW4835yebKu7By/i
 9vlqK1e0qzZvOpwh/Yo2hai6HEyMQMqVYM8wyZTLx3f+nAKS5O0aFIxrQVOCxNCs7pNh1X
 n5gsOcdk5TDot/2goWCOpUZnq0tHEog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772799218;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+wpOdiC+Yf711NJ4GvYM4X1Y0LvfQKlQWmlmmLRb7I=;
 b=ttVXelRA3qd/e0EyqSpl3ztz1W172yP2C7Q3KVi/S8xcCO7m4Tl+5UBCyN8WBuODFWurUq
 /U2/+epP7u7o0gAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B5F63EA75;
 Fri,  6 Mar 2026 12:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xkbVEPLEqmkyKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Mar 2026 12:13:38 +0000
Date: Fri, 6 Mar 2026 13:13:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20260306121336.GA519430@pevik>
References: <20260303105510.14305-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260303105510.14305-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,suse.cz];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify25: Trace oom_kill_process() instead of
 load_module()
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
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> The load_module() function is available only if the kernel was built
> with CONFIG_MODULES enabled. Trace a function that's unconditionally
> available instead.

+1, that's obviously better than require CONFIG_BINFMT_SCRIPT or anything else.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

@Amir @Jan will you add your ack, please?

Kind regards,
Petr

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> Reported-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify25.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify25.c b/testcases/kernel/syscalls/fanotify/fanotify25.c
> index c982f3225..db52e6a87 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify25.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify25.c
> @@ -24,10 +24,10 @@ static const struct traceconfig {
>  	const char *filename;
>  	const char *wdata;
>  } trace_cmds[] = {
> -	{EVENTS_SYSFILE, "p:ltp_load_module_0 load_module"},
> -	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "1"},
> -	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "0"},
> -	{EVENTS_SYSFILE, "-:ltp_load_module_0"},
> +	{EVENTS_SYSFILE, "p:ltp_oom_kill_process_0 oom_kill_process"},
> +	{MNTPOINT "/events/kprobes/ltp_oom_kill_process_0/enable", "1"},
> +	{MNTPOINT "/events/kprobes/ltp_oom_kill_process_0/enable", "0"},
> +	{EVENTS_SYSFILE, "-:ltp_oom_kill_process_0"},
>  	{}
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
