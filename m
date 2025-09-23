Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E54CCAC5AC
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 18:45:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F4A63CDEFB
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 20:45:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF4793CDED7
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 20:45:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 360481000455
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 20:44:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46E5922414;
 Tue, 23 Sep 2025 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758653099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/1fFns1sj3gkuzXzIAYWn4gJcWsDCMk16qmU1GVvOdo=;
 b=wFU0DAP7cS9vAtgXyRQD7WQwxJ7vw/WJ/r/HoQRe4GdlnJC2okOpxWy3zqfz28Rue5RxSp
 m7QQsXozC/4kurUNuweIObwOasvlhTCb6lxKQZMXYWXy0GVaUKXVtBIAVbLNMhyYMciQRN
 n7sjKwK609OEDSHyOaCR92wTib26UvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758653099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/1fFns1sj3gkuzXzIAYWn4gJcWsDCMk16qmU1GVvOdo=;
 b=NaxoebfHp0341KhHWQezziit6+UpgdLCVZYOm13QhvCKAii5WAYQrV1YIr87nc9im61Tla
 Ic0z4tXCMoNNTgDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wFU0DAP7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NaxoebfH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758653099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/1fFns1sj3gkuzXzIAYWn4gJcWsDCMk16qmU1GVvOdo=;
 b=wFU0DAP7cS9vAtgXyRQD7WQwxJ7vw/WJ/r/HoQRe4GdlnJC2okOpxWy3zqfz28Rue5RxSp
 m7QQsXozC/4kurUNuweIObwOasvlhTCb6lxKQZMXYWXy0GVaUKXVtBIAVbLNMhyYMciQRN
 n7sjKwK609OEDSHyOaCR92wTib26UvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758653099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/1fFns1sj3gkuzXzIAYWn4gJcWsDCMk16qmU1GVvOdo=;
 b=NaxoebfHp0341KhHWQezziit6+UpgdLCVZYOm13QhvCKAii5WAYQrV1YIr87nc9im61Tla
 Ic0z4tXCMoNNTgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23299132C9;
 Tue, 23 Sep 2025 18:44:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2tRLB6vq0mh5GAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Sep 2025 18:44:59 +0000
Date: Tue, 23 Sep 2025 20:44:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20250923184449.GA45748@pevik>
References: <aNKJP8fKNn6JcT5I@yuki.lan> <20250923150337.19821-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250923150337.19821-1-akumar@suse.de>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 46E5922414
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Introduce ioctl_pidfd_get_info_supported()
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

> use this routine in ioctl_pidfd05 before proceeding with the test

Reviewed-by: Petr Vorel <pvorel@suse.cz>

BTW, when testing on 6.11, I got:
ioctl_pidfd05.c:45: TFAIL: ioctl(pidfd, PIDFD_GET_INFO, NULL) expected EINVAL: ENOTTY (25)

Which is error unrelated to this patch, it's from original.
196988f7d1 ("Add ioctl_pidfd05 test")

Doc in ioctl_pidfd_info_exit_supported() is clear about it:
		/* - ENOTTY: old kernels not implementing fs/pidfs.c:pidfd_ioctl
		 * - EINVAL: until v6.13 kernel
		 * - ESRCH: all kernels between v6.13 and v6.15
		 */

But test happily ignores the fact :).

@Cyril do we want to fix it? Do we want to check for kernel versions or we just
take any of these values?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
