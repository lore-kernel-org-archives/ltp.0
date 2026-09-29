Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E94CA5FA5
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 14:40:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF6913E5812
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 16:40:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2365D3CE13E
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:40:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EDA3A200AE3
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:40:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 958DF1F449;
 Tue, 29 Sep 2026 14:40:33 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66D57133F1;
 Tue, 29 Sep 2026 14:40:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7JRIEeHNu2okawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 29 Sep 2026 14:40:33 +0000
Date: Tue, 29 Sep 2026 16:40:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <arvN7MPnBolwnT3z@yuki.lan>
References: <20260929-fix_epoll_bpf-v1-1-39b19ab043c7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260929-fix_epoll_bpf-v1-1-39b19ab043c7@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 958DF1F449
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] epoll_ctl06: Fix BPF map on old kernels
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +	case TST_FD_BPF_MAP:
> +		/*
> +		 * The BPF poll callback returns POLLERR for array maps. Without
> +		 * the callback, poll() returns the default readiness mask.
> +		 */
> +		SAFE_POLL(&pfd, 1, 0);
> +		return pfd.revents & POLLERR ? 0 : EPERM;

Should't this be guarded with kernel version? I.e. only enabled for
kernels older than 5.8?


>  	default:
>  		return 0;
>  	}
> @@ -50,7 +61,7 @@ static void run(void)
>  	TST_FD_FOREACH(fd) {
>  		efd = SAFE_EPOLL_CREATE1(0);
>  		ev.data.fd = fd.fd;
> -		err = exp_errno(fd.type);
> +		err = exp_errno(&fd);
>  
>  		TST_EXP_PASS_OR_FAIL(epoll_ctl(efd, EPOLL_CTL_ADD,
>  				 fd.fd, &ev), err,
> 
> ---
> base-commit: 0596b09f22f449cb300e8ad2d08d8b186f551a05
> change-id: 20260929-fix_epoll_bpf-5e472da8e63c
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
