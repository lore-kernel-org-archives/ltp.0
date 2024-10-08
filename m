Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DF9CEF163
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 12:28:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64D7D3C19CC
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 14:28:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 088013C05D5
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 14:28:39 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B16B6608A96
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 14:28:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E633F21BF1;
 Tue,  8 Oct 2024 12:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728390517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eWxRR8is1kD+U+eYYLD2AM3m9JngGGmSzX46RR78e/o=;
 b=MproC9jDRGg+9Zb+3zbOf8Upbis2sqKPHiZTc1vOWvb3qhUzzHPguCEIUSiOFm64NLkY5H
 t0gAlxVfBGqLwsM7MTad/9MqpaOOXdDdNEduQpZkFguGFE+nWRxdk2cKWTswheqnWGprgr
 3jwZyewmBwm/jFswvQVjYsOVWgY2s0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728390517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eWxRR8is1kD+U+eYYLD2AM3m9JngGGmSzX46RR78e/o=;
 b=c5pEdopwFQhcojzMVtwLjmn/7/180UYtyce9vas/2qPOmQ855ylGBJ4Dbo7wMJv/KDmd9N
 3snYJ6oj5ShsSlBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728390517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eWxRR8is1kD+U+eYYLD2AM3m9JngGGmSzX46RR78e/o=;
 b=MproC9jDRGg+9Zb+3zbOf8Upbis2sqKPHiZTc1vOWvb3qhUzzHPguCEIUSiOFm64NLkY5H
 t0gAlxVfBGqLwsM7MTad/9MqpaOOXdDdNEduQpZkFguGFE+nWRxdk2cKWTswheqnWGprgr
 3jwZyewmBwm/jFswvQVjYsOVWgY2s0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728390517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eWxRR8is1kD+U+eYYLD2AM3m9JngGGmSzX46RR78e/o=;
 b=c5pEdopwFQhcojzMVtwLjmn/7/180UYtyce9vas/2qPOmQ855ylGBJ4Dbo7wMJv/KDmd9N
 3snYJ6oj5ShsSlBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6B2B137CF;
 Tue,  8 Oct 2024 12:28:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l1xZM3UlBWdcdQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 08 Oct 2024 12:28:37 +0000
Date: Tue, 8 Oct 2024 14:27:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZwUlOd94fKskYA6-@yuki.lan>
References: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
 <20241008-listmount_statmount-v5-13-66f4e1a9e7db@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241008-listmount_statmount-v5-13-66f4e1a9e7db@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 13/16] Add statmount07 test
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
> +} tcases[] = {
> +	{ENOENT, "mount id doesn't exist'", &mnt_id_dont_exist, 0, 0, &buff_size, &st_mount},
> +	{EOVERFLOW, "invalid mask", &mnt_id, -1, 0, &buff_size, &st_mount},

I guess that we stil miss the EOVERFLOW case here with one of the
requests that yields string reply and small buffer.

> +	{EINVAL, "flags must be zero", &mnt_id, 0, 1, &buff_size, &st_mount},
> +	{EFAULT, "invalid buffer size", &mnt_id, 0, 0, &buff_size_invalid, &st_mount},
> +	{EFAULT, "invalid buffer pointer", &mnt_id, 0, 0, &buff_size, &st_mount_null},
> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	memset(st_mount, 0, sizeof(struct statmount));
> +
> +	TST_EXP_FAIL(statmount(*tc->mnt_id, tc->mask,
> +		*tc->buff, *tc->buff_size, tc->flags),
> +		tc->exp_errno, "%s", tc->msg);
> +}
> +
> +static void setup(void)
> +{
> +	struct ltp_statx sx;
> +
> +	SAFE_STATX(AT_FDCWD, MNTPOINT, 0, STATX_MNT_ID_UNIQUE, &sx);
> +
> +	mnt_id = sx.data.stx_mnt_id;
> +	buff_size = sizeof(struct statmount);
> +}
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.min_kver = "6.8",
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.format_device = 1,
> +	.bufs = (struct tst_buffers []) {
> +		{&st_mount, .size = sizeof(struct statmount)},
> +		{}
> +	}
> +};
> 
> -- 
> 2.43.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
