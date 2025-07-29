Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000FDC87FC9
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 14:36:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 170F33CA27C
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 16:36:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86F003C7AA4
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 16:35:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CFEC11A00162
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 16:35:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D5BFB1F745;
 Tue, 29 Jul 2025 14:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753799757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UcBjRkr0d4WU5yM9ZOwalzF3MMJqqQMCQ0lIOy4F90g=;
 b=dDbNVymqYq/vvdEomccHmX4pAyBGxdCD/7UlUNwW6np6ODXC8SrQBXnu1cUFV7pCTQB122
 H9d6xne/z/PguQnNtV4f9C692jUWVj4YC9iNMn/1Tq4p1n2zq8TXpGPaeGQBXZpJ8TYn7M
 Yo3tYV6KWb+SdJw9Qy6LLTb33eW7JmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753799757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UcBjRkr0d4WU5yM9ZOwalzF3MMJqqQMCQ0lIOy4F90g=;
 b=+gjq3Ki5SSqvjr6f6BCohNhoxr1slbvpmrgxaDZHrZ2e7Qc6X8/MPwjRbCUuv+x+BgR/8R
 fHmV82PCipqx6VAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0iU5tkrN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XxdOiUOj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753799756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UcBjRkr0d4WU5yM9ZOwalzF3MMJqqQMCQ0lIOy4F90g=;
 b=0iU5tkrNWYMUf/yKVu4B61vJnWaj4zNeAUSirmjIT/svSjw6ZLgC3Qq2eO6EtKb2dZHVxS
 hVdid3WxFpoFL3l+qNJ6Q5Su+6E5m+ygUBiD/WjpLDoeSrVr4EQGRyzxH5eBPqb+EEZVvQ
 OQWkVTll4mkZcJ38IzAdhzQ169YyHwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753799756;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UcBjRkr0d4WU5yM9ZOwalzF3MMJqqQMCQ0lIOy4F90g=;
 b=XxdOiUOjSZ82T5wyvXapKh7HBa4kGk024G1crVI/uH6TrMz3WAsBn7WSSI25CblGjDxQG1
 inBw5Odx+NB9ZRDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C326613A73;
 Tue, 29 Jul 2025 14:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GKyILkzciGijOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 29 Jul 2025 14:35:56 +0000
Date: Tue, 29 Jul 2025 16:36:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aIjcex1I5qh3gxHE@yuki.lan>
References: <20250729-ioctl_pidfd_supported-v1-1-985626a0c46b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250729-ioctl_pidfd_supported-v1-1-985626a0c46b@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
 URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,linux.it:url,yuki.lan:mid];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: D5BFB1F745
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Correctly check if PIDFD_INFO_EXIT is available
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
> When systems are not having the PIDFD_INFO_EXIT implementation,
> ioctl_pidfd testing suite might fail with:
> 
> 	ioctl_pidfd.h:32: TBROK: ioctl(...) failed: ENOTTY (25)
> 
> Fix the ioctl_pidfd_info_exit_supported() behavior, considering ENOTTY
> error like a sign for not having PIDFD_INFO_EXIT implemented in the
> system.

Ah, right, we have to deal wit the case that PIDFD_GET_INFO is not
implementead at all as well.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd.h | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
> index 8249ac753cf7fb8a3b749d55c7f0c3b30482c114..b2de5389ef78e530e1a3be0525b0a6a238d1d009 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
> @@ -11,7 +11,7 @@
>  
>  static inline int ioctl_pidfd_info_exit_supported(void)
>  {
> -	int ret = 0;
> +	int ret;
>  	pid_t pid;
>  	int pidfd;
>  	struct pidfd_info info;
> @@ -29,13 +29,17 @@ static inline int ioctl_pidfd_info_exit_supported(void)
>  	pidfd = SAFE_PIDFD_OPEN(pid, 0);
>  	SAFE_WAITPID(pid, NULL, 0);
>  
> -	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, &info);
> -	SAFE_CLOSE(pidfd);
> -
> -	if (info.mask & PIDFD_INFO_EXIT)
> -		ret = 1;
> +	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
> +	if (ret == -1) {
> +		if (errno != ENOTTY)
> +			tst_brk(TBROK | TERRNO, "ioctl error");
> +	} else {
> +		if (info.mask & PIDFD_INFO_EXIT)
> +			return 1;

But we do not close the fd in this branch now.

What we should do here instead is ret = 1; and keep the retrun ret login
below.

> +	}
>  
> -	return ret;
> +	SAFE_CLOSE(pidfd);
> +	return 0;
>  }
>  
>  #endif
> 
> ---
> base-commit: 91e6272febf95e19a8300695dfc2089569adf9d8
> change-id: 20250729-ioctl_pidfd_supported-437d25a4c382
> 
> Best regards,
> -- 
> Andrea Cervesato <andrea.cervesato@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
