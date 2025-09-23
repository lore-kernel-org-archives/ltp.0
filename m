Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E538DCAC5A7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 11:39:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5546F3CDEB0
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 13:39:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B04923CDE7A
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 13:39:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3D8D8600071
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 13:39:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F01321ADE;
 Tue, 23 Sep 2025 11:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758627558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b72mNL084i2UsoUETLUZf78RGVMvi40O48e2p6d+EvM=;
 b=pAWviy4sVkH8AGSGIeqfrKozl5mbSRrDGvsTT2Z0GX0dkJEp88ewURXDxQiBELHkHIWzO+
 h2UK7G98XNYcbmHfqh+8br2lo/Olw62e3rKriL8QFYm6GIORu3xHfeia8eBPnXdcudfdGp
 rp7GvDKgoEFDlPgW84slcLV+0a24Rug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758627558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b72mNL084i2UsoUETLUZf78RGVMvi40O48e2p6d+EvM=;
 b=LSpLUQLifWt4Xlr7vLFeghSm6TMq6H4tJy3Ctrwn+mtMNw50iWo9WML9D4GRmemFJ8hiW7
 +3hNHGNjwnTg1tDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pAWviy4s;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LSpLUQLi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758627558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b72mNL084i2UsoUETLUZf78RGVMvi40O48e2p6d+EvM=;
 b=pAWviy4sVkH8AGSGIeqfrKozl5mbSRrDGvsTT2Z0GX0dkJEp88ewURXDxQiBELHkHIWzO+
 h2UK7G98XNYcbmHfqh+8br2lo/Olw62e3rKriL8QFYm6GIORu3xHfeia8eBPnXdcudfdGp
 rp7GvDKgoEFDlPgW84slcLV+0a24Rug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758627558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b72mNL084i2UsoUETLUZf78RGVMvi40O48e2p6d+EvM=;
 b=LSpLUQLifWt4Xlr7vLFeghSm6TMq6H4tJy3Ctrwn+mtMNw50iWo9WML9D4GRmemFJ8hiW7
 +3hNHGNjwnTg1tDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42A171388C;
 Tue, 23 Sep 2025 11:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ef9bD+aG0mjLBgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Sep 2025 11:39:18 +0000
Date: Tue, 23 Sep 2025 13:39:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250923113912.GA15673@pevik>
References: <20250922210723.GA44059@pevik>
 <20250923075118.29757-1-akumar@suse.de> <aNKBrcI4ZuHL8RE0@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aNKBrcI4ZuHL8RE0@yuki.lan>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 5F01321ADE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
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

Hi Avinesh, Cyril,

...
> >  	memset(&info, 0, sizeof(struct pidfd_info));
> > -	info.mask = PIDFD_INFO_EXIT;

> We have to keep the PIDFD_INFO_EXIT in the mask, otherwise it will never
> be set back by the kernel.

+1, I'm sorry to overlook this change.

> >  	pid = SAFE_FORK();
> >  	if (!pid)
> > @@ -31,23 +28,39 @@ static inline int ioctl_pidfd_info_exit_supported(void)
> >  	SAFE_WAITPID(pid, NULL, 0);

> >  	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
> > +	SAFE_CLOSE(pidfd);
> > +
> >  	if (ret == -1) {
> > -		/* - ENOTTY: old kernels not implementing fs/pidfs.c:pidfd_ioctl
> > -		 * - EINVAL: until v6.13 kernel
> > -		 * - ESRCH: all kernels between v6.13 and v6.15
> > +		/* - ENOTTY: kernel too old, ioctl(PIDFD_GET_INFO) not implemented; return -1 */
> > +		if (errno == ENOTTY)
> > +			return -1;
> > +
> > +		/* - EINVAL: ioctl(PIDFD_GET_INFO) exists but invalid args
> > +		 * - ESRCH: ioctl(PIDFD_GET_INFO) exists but task already exited
> > +		 * both mean supported, but info.mask is not set; return 0
> >  		 */
> > -		if (errno != ENOTTY &&
> > -			errno != EINVAL &&
> > -			errno != ESRCH)
> > -			tst_brk(TBROK | TERRNO, "ioctl error");
> > -	} else {
> > -		if (info.mask & PIDFD_INFO_EXIT)
> > -			supported = 1;
> > +		if (errno == EINVAL || errno == ESRCH)
> > +			return 0;

> If we do not pass the PIDFD_INFO_EXIT above we will end up with ESRCH
> here all the time.

+1 (again, I'm sorry to overlook it).

> Generally I do not like this code that much, since we depend on the fact
> that we get ESCHR from the syscall if PIDFD_INFO_EXIT is not
> implemented. Without the PIDFD_INFO_EXIT flag the pidfd_info() syscall
> is supposed to work on a process before it's waited for and
> PIDFD_INFO_EXIT does not work before the process is waited for, mixing
> these two checks is a bit ugly.

Avinesh, I'm sorry, I see my suggestion to reuse code to detect PIDFD_INFO_EXIT
for checking PIDFD_GET_INFO was not a good idea. It'll be clearer to have them
separated.

BTW although ioctl_pidfd_info_exit_supported() should be kept as is, it does not
harm to use bool for it. But that's not related to this fix.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
