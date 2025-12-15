Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51875D5B844
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 15:54:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBD293D0228
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 16:53:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E958E3C1817
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 16:53:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A5C3C10006C0
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 16:53:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDB4B5BD01;
 Mon, 15 Dec 2025 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765814013;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOjIHPRp3yy+tP+g3u1/6TEiFSlCb7h3kARs4V1OMeg=;
 b=LT8p2Mc43Hfn/sBbGn8lGRcQVuRtzdOJNE3lDvAkPZKhiH+oCurGpaZkVoEoxgTyXLVt1k
 soLMacaKltdsPTSDes0LUxc4mdTeKbu3qb/awODVKtDaMobwHLbAeJKB2Wx+gqGiWuSZG1
 PZ0LasRRdr5XKCuMdayQcZws5lPEn24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765814013;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOjIHPRp3yy+tP+g3u1/6TEiFSlCb7h3kARs4V1OMeg=;
 b=XD9rl5NnzN9z2dmhgOfPoatPJqrDpem8hR6g+y/7SrIbry69XajM73Veh0fFAcp54UVoH7
 v0sbx634jmjWXqCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=k5qe7ilu;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IFuR6b+U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765814011;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOjIHPRp3yy+tP+g3u1/6TEiFSlCb7h3kARs4V1OMeg=;
 b=k5qe7ilu+YQU2zRiSUNVYqNRBid67zigetxqOBNJf77YYSHw86NAwS9M8p6RohGnD5/vXo
 gYIpSNniCCm+fzBF/TGEKtDMq1SbCSoP7J4RLjj8vD8b+nfecOkHwGJJURi2bIDOqyY5r+
 1ADbeQ/qQWztf3a1PbiCD36siQCXf4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765814011;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOjIHPRp3yy+tP+g3u1/6TEiFSlCb7h3kARs4V1OMeg=;
 b=IFuR6b+UWzp3ZXyHD1tWHjKusFJxUrrv8QDaOg/1KMPGXn0MWqRw6NuR3j8DjKI2YqdM/y
 6dqdtEoZ2yExIUBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DEB33EA63;
 Mon, 15 Dec 2025 15:53:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id efSwIfsuQGkJbQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Dec 2025 15:53:31 +0000
Date: Mon, 15 Dec 2025 16:53:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Terry Tritton <terry.tritton@linaro.org>
Message-ID: <20251215155330.GC272695@pevik>
References: <20251209211629.95436-1-terry.tritton@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251209211629.95436-1-terry.tritton@linaro.org>
X-Rspamd-Queue-Id: BDB4B5BD01
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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

Hi all,

> The flags CLONE_NEWUSER and CLONE_NEWPID require specific namespace support.
> Add CONFIG_USER_NS and CONFIG_PID_NS to needs_kconfigs so these tests return
> TCONF instead of failing.

> Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c | 5 +++++
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c | 5 +++++
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c | 5 +++++
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 5 +++++
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 5 +++++
>  5 files changed, 25 insertions(+)

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
> index 7eb60e7fc..6983259e4 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
> @@ -81,5 +81,10 @@ static struct tst_test test = {
>  		{&info0, .size = sizeof(*info0)},
>  		{&info1, .size = sizeof(*info1)},
>  		{}
> +	},
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_USER_NS",
> +		"CONFIG_PID_NS",

How about to check /proc/self/ns/user and /proc/self/ns/pid as ioctl_ns06.c
does?

    int exists = access("/proc/self/ns/user", F_OK);

    if (exists < 0)
        tst_res(TCONF, "namespace not available");

Long time ago we tried to avoid forcing config. Is it now considered as better?
(maybe more readable?) Or we would keep checking /proc (or /sys) but add a
comment for required functions?

Kind regards,
Petr

> +		NULL

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
