Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFB0C36014
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 10:11:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8948C3CAFC4
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 12:11:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F05A83CADF2
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 12:10:57 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 176E710009A4
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 12:10:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EDEB2211C6;
 Tue,  1 Apr 2025 10:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743502256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3EZiF5bZT9YiH5NEsm9/mVAkCWOvqrrztPwKIwhxIlg=;
 b=HHXaw4L4Tx59WGvY3BvNuhoZhaa/gEfpSKOQj8TOnTS8QpZxWizFP140ukagl8CAywZGTO
 wyECksKXR6CLdyB8oTXNrr0rg6zonIetgGNQP+1sy2cY9J0XBVtBGzRSOB10+j0Ilxz/kB
 2cZhiE8JKePdnFCvRMxOr9OvhYJjXHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743502256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3EZiF5bZT9YiH5NEsm9/mVAkCWOvqrrztPwKIwhxIlg=;
 b=8EngYfBEoUOgn8B2DKxqBvf83WFikM1EEf6xrzZqKo7moelww77yPzdlav4Kymq6BnjZFU
 jhBiDO1ZrR13CrDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E25zEdTn;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Iu/GCs6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743502255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3EZiF5bZT9YiH5NEsm9/mVAkCWOvqrrztPwKIwhxIlg=;
 b=E25zEdTnNr7E6q8b4ib+aqF7LJLl+nsxhSlVqF8YCB9ySCkq/Isl1r3KHfT37rUtdWrdP8
 x6v5g3oI640+EtSaxoSGqIHpIAbYBcP3Rx7ognSVOhJNa3tM0Wkcwg0dkUqybCYOLh+b3n
 UxJwqhAfOlZY5IxQTCqbYiTKsJeafzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743502255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3EZiF5bZT9YiH5NEsm9/mVAkCWOvqrrztPwKIwhxIlg=;
 b=Iu/GCs6nP9iUwcYpst20YQFbdZPsYQkhy5EBptG0tGS7qfqRds07CG12EyYHFCmpHuQhbf
 nbvOuvpdd9JoPHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD4BA138A5;
 Tue,  1 Apr 2025 10:10:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CFzFNK+762cKDwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 01 Apr 2025 10:10:55 +0000
Date: Tue, 1 Apr 2025 12:11:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <Z-u7yYJpTBG8Hi6A@yuki.lan>
References: <20250314044257.1673303-1-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250314044257.1673303-1-lufei@uniontech.com>
X-Rspamd-Queue-Id: EDEB2211C6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] unshare03: using soft limit of NOFILE
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
> I think it's safer to set NOFILE increasing from soft limit than from
> hard limit.
> 
> Hard limit may lead to dup2 ENOMEM error which bring the result to
> TBROK on little memory machine. (e.g. 2GB memory in my situation, hard
> limit in /proc/sys/fs/nr_open come out to be 1073741816)
> 
> Signed-off-by: lufei <lufei@uniontech.com>
> ---
>  testcases/kernel/syscalls/unshare/unshare03.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/unshare/unshare03.c b/testcases/kernel/syscalls/unshare/unshare03.c
> index 7c5e71c4e..bb568264c 100644
> --- a/testcases/kernel/syscalls/unshare/unshare03.c
> +++ b/testcases/kernel/syscalls/unshare/unshare03.c
> @@ -24,7 +24,7 @@
>  
>  static void run(void)
>  {
> -	int nr_open;
> +	int rlim_max;
>  	int nr_limit;
>  	struct rlimit rlimit;
>  	struct tst_clone_args args = {
> @@ -32,14 +32,12 @@ static void run(void)
>  		.exit_signal = SIGCHLD,
>  	};
>  
> -	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
> -	tst_res(TDEBUG, "Maximum number of file descriptors: %d", nr_open);
> +	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
> +	rlim_max = rlimit.rlim_max;
>  
> -	nr_limit = nr_open + NR_OPEN_LIMIT;
> +	nr_limit = rlim_max + NR_OPEN_LIMIT;
>  	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_limit);
>  
> -	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
> -
>  	rlimit.rlim_cur = nr_limit;
>  	rlimit.rlim_max = nr_limit;
>  
> @@ -47,10 +45,10 @@ static void run(void)
>  	tst_res(TDEBUG, "Set new maximum number of file descriptors to : %d",
>  		nr_limit);
>  
> -	SAFE_DUP2(2, nr_open + NR_OPEN_DUP);
> +	SAFE_DUP2(2, rlim_max + NR_OPEN_DUP);
>  
>  	if (!SAFE_CLONE(&args)) {
> -		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
> +		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", rlim_max);
>  		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
>  		exit(0);
>  	}

Why do we bother with reading the /rpoc/sys/fs/nr_open file? All that we
need to to do is to dup() a file descriptor and tnen set the nr_open
limit to fd - 2. And if we do so we can drop the rlimit that increases
the limit so that it's greater than nr_open as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
