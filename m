Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88620CAC5A7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 09:43:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D6583CDEA7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 11:43:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 791893CDD33
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 11:43:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D52ED10007C0
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 11:43:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4436321D90;
 Tue, 23 Sep 2025 09:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758620615;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cc+LmVbsvQwt6hIurtntbdnkxL9v1N+LkXLzg0mmMb8=;
 b=r6i7lnvFg5g3sIHliwwg6xL6s7TVB/k3yI5JJxzYTioQqO4JirGmPltgCM++HKXMo6gYKv
 BSXY8y5URGCyI/Pwj9eJc9YGSMBSJOEOAGllPps5wWntZ3Ga1rMrJiOEddDvLWUT8GP+OA
 70uE8ZHxvvp1uTpnmSMDtgGpCpaaa/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758620615;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cc+LmVbsvQwt6hIurtntbdnkxL9v1N+LkXLzg0mmMb8=;
 b=JR8v+BcHwJrJvJcqVgLuvt9wxUJQt688SMhxf+3W8Np+OfNAkE+S6bCcdzYfxcvgy+z10h
 WnRAVHi1fqN16jBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758620614;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cc+LmVbsvQwt6hIurtntbdnkxL9v1N+LkXLzg0mmMb8=;
 b=2B3n2TUOec59jR/ziCDjCWHBT5AHjI7ZAW3fZYHQVSkDp3hnIjS5G4CL3NQbxhtwE2fDvu
 yBWDt7y4chcED8xoN8Csntjru0PxpPh6svhrOk7lsntPj7fDPLEa2pn2gfOvQRLH2nVrFT
 9t9HZ/lWBCW+EJ+Mvp8Z0IZdAWtmpVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758620614;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cc+LmVbsvQwt6hIurtntbdnkxL9v1N+LkXLzg0mmMb8=;
 b=FsLCXq70HLQ396IocnxCM55ScVsaqtpOjGoDfWqGOu3c7NbAEEMd0Tw44TnhMSTJMKv7So
 std0RjYOwOkjRtAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 017241388C;
 Tue, 23 Sep 2025 09:43:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s6gbOMVr0mjQXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Sep 2025 09:43:33 +0000
Date: Tue, 23 Sep 2025 11:43:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20250923094332.GA3647@pevik>
References: <20250922210723.GA44059@pevik>
 <20250923075118.29757-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250923075118.29757-1-akumar@suse.de>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Introduce ioctl_pidfd_get_info_supported()
 function
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

Hi Avinesh,

...
>  	if (ret == -1) {
> -		/* - ENOTTY: old kernels not implementing fs/pidfs.c:pidfd_ioctl
> -		 * - EINVAL: until v6.13 kernel
> -		 * - ESRCH: all kernels between v6.13 and v6.15
> +		/* - ENOTTY: kernel too old, ioctl(PIDFD_GET_INFO) not implemented; return -1 */
> +		if (errno == ENOTTY)
> +			return -1;
> +
> +		/* - EINVAL: ioctl(PIDFD_GET_INFO) exists but invalid args
> +		 * - ESRCH: ioctl(PIDFD_GET_INFO) exists but task already exited
> +		 * both mean supported, but info.mask is not set; return 0
>  		 */
I originally mean to move the docs above function signature (to the top)
and add it for both, but I suppose this is perfectly ok (it was here before).

Thanks for improving it.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> -		if (errno != ENOTTY &&
> -			errno != EINVAL &&
> -			errno != ESRCH)
> -			tst_brk(TBROK | TERRNO, "ioctl error");
> -	} else {
> -		if (info.mask & PIDFD_INFO_EXIT)
> -			supported = 1;
> +		if (errno == EINVAL || errno == ESRCH)
> +			return 0;
> +
> +		tst_brk(TBROK | TERRNO, "unexpected ioctl(PIDFD_GET_INFO) error");
>  	}

> -	SAFE_CLOSE(pidfd);
> +	/* ioctl(PIDFD_GET_INFO) successful; return mask */
> +	return info.mask;
> +}
> +
> +static inline bool ioctl_pidfd_info_exit_supported(void)
> +{
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
