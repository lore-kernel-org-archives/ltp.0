Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BABC02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 15:20:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 358FF3C98BD
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 16:20:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 077703C9881
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:19:52 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 83E9B1BF3D80
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:19:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A68C71F392;
 Mon, 10 Feb 2025 15:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739200791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1GNAhAPet+7H1ddfzW8ivnj8j3janJbIKwC+WYSIobs=;
 b=zd8RvKSM1YGavtSO1Sx5BdNtXHX0ZGwP5Pz9F9ICjdA1n34QOKDTh3tm4FqeZQud4/V08m
 kFoEPlcomIYA2fNFx8rWIjvT3qf+uOnzK/DieNBJdrKgdW6A+O0iapYw8u6Z8mmOTKmC8Z
 xGZoAlUccKjHmPL0PXM0KOTlGORfSsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739200791;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1GNAhAPet+7H1ddfzW8ivnj8j3janJbIKwC+WYSIobs=;
 b=DEyr7ZRgW6NEP81jLgzFosV468IRWmH39ddJFGB8RYqX833VKLsBexex+MuMnByv1ueSiX
 bxknb4dEt8JEJhAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739200791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1GNAhAPet+7H1ddfzW8ivnj8j3janJbIKwC+WYSIobs=;
 b=zd8RvKSM1YGavtSO1Sx5BdNtXHX0ZGwP5Pz9F9ICjdA1n34QOKDTh3tm4FqeZQud4/V08m
 kFoEPlcomIYA2fNFx8rWIjvT3qf+uOnzK/DieNBJdrKgdW6A+O0iapYw8u6Z8mmOTKmC8Z
 xGZoAlUccKjHmPL0PXM0KOTlGORfSsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739200791;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1GNAhAPet+7H1ddfzW8ivnj8j3janJbIKwC+WYSIobs=;
 b=DEyr7ZRgW6NEP81jLgzFosV468IRWmH39ddJFGB8RYqX833VKLsBexex+MuMnByv1ueSiX
 bxknb4dEt8JEJhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9830913A62;
 Mon, 10 Feb 2025 15:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RtIlJRcZqmfgMwAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 10 Feb 2025 15:19:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 35E79A095C; Mon, 10 Feb 2025 16:19:47 +0100 (CET)
Date: Mon, 10 Feb 2025 16:19:47 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <n2r5nj3nk7oyh7pvbqqaidg4pqhxjxu77swkx26iopsf7nd5yl@a4bxlu7nrjem>
References: <20250210151316.246079-1-amir73il@gmail.com>
 <20250210151316.246079-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250210151316.246079-2-amir73il@gmail.com>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-0.998];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_LAST(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] fanotify14: Test invalid init flags with
 permission and pre-content events
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

On Mon 10-02-25 16:13:13, Amir Goldstein wrote:
> Those events require an high priority fanotify group.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/lapi/fanotify.h                       |  5 +++++
>  .../kernel/syscalls/fanotify/fanotify14.c     | 20 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/lapi/fanotify.h b/include/lapi/fanotify.h
> index 40ea7ead7..e5b930f4e 100644
> --- a/include/lapi/fanotify.h
> +++ b/include/lapi/fanotify.h
> @@ -109,6 +109,9 @@
>  #ifndef FAN_FS_ERROR
>  #define FAN_FS_ERROR		0x00008000
>  #endif
> +#ifndef FAN_PRE_ACCESS
> +#define FAN_PRE_ACCESS		0x00100000
> +#endif
>  #ifndef FAN_RENAME
>  #define FAN_RENAME		0x10000000
>  #endif
> @@ -134,6 +137,8 @@
>  #define LTP_ALL_PERM_EVENTS	(FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
>  				 FAN_ACCESS_PERM)
>  
> +#define LTP_PRE_CONTENT_EVENTS	(FAN_PRE_ACCESS)
> +
>  struct fanotify_group_type {
>  	unsigned int flag;
>  	const char *name;
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
> index ee583a095..b17bffd18 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify14.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
> @@ -239,6 +239,26 @@ static struct test_case_t {
>  		.pfd = pipes,
>  		.expected_errno = EINVAL,
>  	},
> +	/* permission events in mask with priority < FAN_CLASS_CONTENT are not valid */
> +	{
> +		.init = FLAGS_DESC(FAN_CLASS_NOTIF),
> +		.mark = FLAGS_DESC(FAN_MARK_INODE),
> +		.mask = FLAGS_DESC(LTP_ALL_PERM_EVENTS),
> +		.expected_errno = EINVAL,
> +	},
> +	/* pre-content events in mask with priority < FAN_CLASS_PRE_CONTENT are not valid */
> +	{
> +		.init = FLAGS_DESC(FAN_CLASS_NOTIF),
> +		.mark = FLAGS_DESC(FAN_MARK_INODE),
> +		.mask = FLAGS_DESC(LTP_PRE_CONTENT_EVENTS),
> +		.expected_errno = EINVAL,
> +	},
> +	{
> +		.init = FLAGS_DESC(FAN_CLASS_CONTENT),
> +		.mark = FLAGS_DESC(FAN_MARK_INODE),
> +		.mask = FLAGS_DESC(LTP_PRE_CONTENT_EVENTS),
> +		.expected_errno = EINVAL,
> +	},
>  };
>  
>  static void do_test(unsigned int number)
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
