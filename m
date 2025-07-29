Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C3DC83F26
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 14:03:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A565E3CAB87
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 16:03:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 037083C9FCD
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 16:03:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 67C671A00999
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 16:03:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 55B5221A2D;
 Tue, 29 Jul 2025 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753797796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RBeoJnpFdLZnFyM6w3ZJxuI5y7I80EYBwX/P6ADB/9U=;
 b=xxgsiQ8m8cEE/cgwK4DKg8S6SKcpNpgmsGZkLRU+5acI9/hj13+Gc5dhKb13zUqR9hNC8Y
 /w5JLMr/Z6jMMIQpqQVsHraiePIF5jyn4Q5FGBIA8omgKPrJ75JkxghIsvNuefEv6/J3Lt
 K6CJ7hpSaLhdAFBYFCUsqnnILrmWXXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753797796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RBeoJnpFdLZnFyM6w3ZJxuI5y7I80EYBwX/P6ADB/9U=;
 b=ySBKmJOGkFNRcN8/2V4dKoZt4p3xQMu0t9hVv3nKDP76QNkqtL9RX/hatPzykiKVdWn3P6
 tmDcTofnfqbZJVBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xxgsiQ8m;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ySBKmJOG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753797796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RBeoJnpFdLZnFyM6w3ZJxuI5y7I80EYBwX/P6ADB/9U=;
 b=xxgsiQ8m8cEE/cgwK4DKg8S6SKcpNpgmsGZkLRU+5acI9/hj13+Gc5dhKb13zUqR9hNC8Y
 /w5JLMr/Z6jMMIQpqQVsHraiePIF5jyn4Q5FGBIA8omgKPrJ75JkxghIsvNuefEv6/J3Lt
 K6CJ7hpSaLhdAFBYFCUsqnnILrmWXXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753797796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RBeoJnpFdLZnFyM6w3ZJxuI5y7I80EYBwX/P6ADB/9U=;
 b=ySBKmJOGkFNRcN8/2V4dKoZt4p3xQMu0t9hVv3nKDP76QNkqtL9RX/hatPzykiKVdWn3P6
 tmDcTofnfqbZJVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D70813A73;
 Tue, 29 Jul 2025 14:03:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5daqEqTUiGgPKwAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 29 Jul 2025 14:03:16 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Jul 2025 16:03:08 +0200
Message-ID: <3368425.aeNJFYEL58@thinkpad>
In-Reply-To: <20250729-ioctl_pidfd_supported-v1-1-985626a0c46b@suse.com>
References: <20250729-ioctl_pidfd_supported-v1-1-985626a0c46b@suse.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim, suse.com:email]
X-Rspamd-Queue-Id: 55B5221A2D
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

Hi Andrea, 

Thank you for the fix.

Reviewed-by: Avinesh Kumar <akumar@suse.de>
Tested-by: Avinesh Kumar <akumar@suse.de>

-
Avinesh

On Tuesday, July 29, 2025 3:38:13 PM CEST Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> When systems are not having the PIDFD_INFO_EXIT implementation,
> ioctl_pidfd testing suite might fail with:
> 
> 	ioctl_pidfd.h:32: TBROK: ioctl(...) failed: ENOTTY (25)
> 
> Fix the ioctl_pidfd_info_exit_supported() behavior, considering ENOTTY
> error like a sign for not having PIDFD_INFO_EXIT implemented in the
> system.
> 
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
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
