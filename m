Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AFDCF8552
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 14:01:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D526E3C633E
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 16:01:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B9303C4D32
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 16:01:39 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7F063100117F
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 16:01:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC37B21CA8;
 Fri,  4 Oct 2024 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728050497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w8cpr4Du8cUk5hRONXDCo/vW8OB5pbiH1PY/I/KVo5g=;
 b=EaQexhtgUFgJfkN3WE035rm62k4b8tfbAqOXuhPYTmd7GQxcnEqkzhAsBJSnfkcUFXG+6/
 PrfyY6/1mWbM+0R6nWM9nzs/5H8FSV1jbzYfi9fdhdGawLe1dRwwjsk0GCxIVdMhv3EqSD
 mfuaLafrVb5f1rtG7FfzG4TpTtiphd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728050497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w8cpr4Du8cUk5hRONXDCo/vW8OB5pbiH1PY/I/KVo5g=;
 b=0maYjtlv5Pp3Laok+qXVsKQDtZWXg/PXy252PYw9QXF9lRzu42uGxsRNExxONsFr4ep1CS
 4PCrdtyp82JXeNBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CuvAc99X;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=C3y1LDXJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728050496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w8cpr4Du8cUk5hRONXDCo/vW8OB5pbiH1PY/I/KVo5g=;
 b=CuvAc99X8YQuDedIUuqKUoVzM1mNemnQ+UPEWJ7ZhEcyBi1qwNSFNkaFGoLiZQ1IAXWDMk
 2pecKEObDit1xr3hvRancSkA/bB+k8ut1u7NH2xFvWxxEy1PIzmeddFEnw+YKIJaxAkw1O
 IGO6B4GFf8dXwIxS2SQkiKKbmBYQgG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728050496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w8cpr4Du8cUk5hRONXDCo/vW8OB5pbiH1PY/I/KVo5g=;
 b=C3y1LDXJsL4aFx5IzhOI+s4+Z98oJ+t2s6vf0wuwgVBNkMTpVVmw6VAvmuMxwDjGUf9G5T
 vJu7yEFeyucrt5Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA06A13A6E;
 Fri,  4 Oct 2024 14:01:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OYJbLED1/2YgYAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 04 Oct 2024 14:01:36 +0000
Date: Fri, 4 Oct 2024 16:00:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zv_0_tsJE6XMSKMz@yuki.lan>
References: <20241002-ioctl_ficlone01_fix-v3-0-7e077918dfd4@suse.com>
 <20241002-ioctl_ficlone01_fix-v3-1-7e077918dfd4@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241002-ioctl_ficlone01_fix-v3-1-7e077918dfd4@suse.com>
X-Rspamd-Queue-Id: DC37B21CA8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] Filter mkfs version in tst_fs
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
> +		if (ver_parser >= ver_get)
> +			break;
> +
> +		check_msg = "%s required >= %d, but got %d, "
> +			"the version is required in order run the test.";

I would drop the "the version is required in order to run the test."
part from these messages, since it does not add any more value on the
top of the first part of the meassage.

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index d226157e0..192fee309 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1250,6 +1250,7 @@ static const char *default_fs_type(void)
>  static void do_setup(int argc, char *argv[])
>  {
>  	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
> +	int ret = 0;
>  
>  	if (!tst_test)
>  		tst_brk(TBROK, "No tests to run");
> @@ -1310,7 +1311,7 @@ static void do_setup(int argc, char *argv[])
>  		int i;
>  
>  		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
> -			tst_check_cmd(cmd);
> +			tst_check_cmd(cmd, 1);
>  	}
>  
>  	if (tst_test->needs_drivers) {
> @@ -1415,8 +1416,15 @@ static void do_setup(int argc, char *argv[])
>  
>  		tdev.fs_type = default_fs_type();
>  
> -		if (!tst_test->all_filesystems && count_fs_descs() <= 1)
> +		if (!tst_test->all_filesystems && count_fs_descs() <= 1) {
> +			if (tst_test->filesystems->mkfs_ver)
> +				ret = tst_check_cmd(tst_test->filesystems->mkfs_ver, 0);
> +
> +			if (ret)
> +				return;

And if we are here, it means that the test runs only for a single
filesystem, so we should instead do:

			if (tst_test->filesystem->mkfs_ver)
				tst_check_mcd(tst_test->filesystems->mkfs_ver, 1);

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
