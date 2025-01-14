Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C28E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 16:32:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 775A53C7B1A
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 17:32:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 836C73C7A7A
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 17:32:09 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ECB152239BC
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 17:32:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 26E711F441;
 Tue, 14 Jan 2025 16:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736872327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g/CR2aLzU4e7+5D5h0Fc0a7Uy9pKcAUvnCbGI5wh0Eg=;
 b=dUr5z2/OpUnUXuiL8D2OsXVFu9+FOjDy0YfrKOhzvuyPlsQaOlC+HftZUzr891RzLRBgW8
 dU8arbZbCFbIpb2c0eNOLKXfiE+nQ00qsWwr3OM6hR/1Gi2dxQzOtkBX/hTm4JFffVLE/I
 5WMTjMYpjRiDiGQa+gdba0VNuuR2idY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736872327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g/CR2aLzU4e7+5D5h0Fc0a7Uy9pKcAUvnCbGI5wh0Eg=;
 b=mhS5EofF3M+p7F+jWPs7iWxdmfDUF4UsRqtjtSiUvL/6VIUKp149IWAb94B589akyr2olV
 0Bg9lBCJ1kgom+Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="dUr5z2/O";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mhS5EofF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736872327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g/CR2aLzU4e7+5D5h0Fc0a7Uy9pKcAUvnCbGI5wh0Eg=;
 b=dUr5z2/OpUnUXuiL8D2OsXVFu9+FOjDy0YfrKOhzvuyPlsQaOlC+HftZUzr891RzLRBgW8
 dU8arbZbCFbIpb2c0eNOLKXfiE+nQ00qsWwr3OM6hR/1Gi2dxQzOtkBX/hTm4JFffVLE/I
 5WMTjMYpjRiDiGQa+gdba0VNuuR2idY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736872327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g/CR2aLzU4e7+5D5h0Fc0a7Uy9pKcAUvnCbGI5wh0Eg=;
 b=mhS5EofF3M+p7F+jWPs7iWxdmfDUF4UsRqtjtSiUvL/6VIUKp149IWAb94B589akyr2olV
 0Bg9lBCJ1kgom+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00C4C1384C;
 Tue, 14 Jan 2025 16:32:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XPc1OoaRhmdeCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 16:32:06 +0000
Date: Tue, 14 Jan 2025 17:32:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <20250114163204.GC619334@pevik>
References: <20240814101104.1098-1-lufei@uniontech.com>
 <20240814101104.1098-3-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240814101104.1098-3-lufei@uniontech.com>
X-Rspamd-Queue-Id: 26E711F441
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] fix make check warning: using .needs_kconfigs
 instead of ENOSYS
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

> Replace ENOSYS with .needs_kconfigs `CONFIG_BSD_PROCESS_ACCT=y`

> Signed-off-by: lufei <lufei@uniontech.com>
> ---
>  testcases/kernel/syscalls/acct/acct01.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
> index de653d810..cfd25c665 100644
> --- a/testcases/kernel/syscalls/acct/acct01.c
> +++ b/testcases/kernel/syscalls/acct/acct01.c
> @@ -92,8 +92,6 @@ static void setup(void)
>  	int fd;

>  	TEST(acct(NULL));
> -	if (TST_RET == -1 && TST_ERR == ENOSYS)
> -		tst_brk(TCONF, "acct() system call isn't configured in kernel");

>  	ltpuser = SAFE_GETPWNAM("nobody");

> @@ -148,5 +146,8 @@ static struct tst_test test = {
>  		{&file_enametoolong, .size = PATH_MAX+2},
>  		{&file_erofs, .str = FILE_EROFS},
>  		{}
> +	},
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_BSD_PROCESS_ACCT=y",
>  	}
>  };

For a record, the warning was:

acct01.c:95: WARNING: ENOSYS means 'invalid syscall nr' and nothing else

This is relevant for kernel code, but not for LTP.

We in the past tried to avoid on kernel configs. Now we on many places use
.needs_kconfigs. Does it mean we just request kernel config? Nobody complained
about it and .needs_kconfigs is kind of documentation, but still I hope that
there aren't many quiet users who see many TCONF. Due this reason I think twice
before I add .needs_kconfigs, specially when ENOSYS is valid detection we use in
tst_syscall().

lib/tst_test.c
	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
