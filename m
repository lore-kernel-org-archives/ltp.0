Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C46CAC5A0
	for <ltp@archiver.kernel.org>; Thu, 18 Sep 2025 13:30:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 083BC3CDD34
	for <ltp@archiver.kernel.org>; Thu, 18 Sep 2025 15:30:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB2233CDC01
 for <ltp@lists.linux.it>; Thu, 18 Sep 2025 15:30:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 67E9A6005C9
 for <ltp@lists.linux.it>; Thu, 18 Sep 2025 15:30:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1409722DED;
 Thu, 18 Sep 2025 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758202222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FJc1BGnUph4MbP9CP1VtLsgjeLP0BQN8i+xFt/lMBJE=;
 b=P9E5dSNSxAIANo8JTDOjZY7SjOcz90PQ/wegNMnM9o2XLU7wriVOgMgXarDifD07f/UuCm
 im8R+bCPO9eaTfu2x+a+Qc6sYSNZGldxHu4Pj0hhfaVlpwFd/j28ksV1QjAJovqzM76oR8
 q9/fXxDykwJe47RTL9qJ1n8pA7Ck8lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758202222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FJc1BGnUph4MbP9CP1VtLsgjeLP0BQN8i+xFt/lMBJE=;
 b=d3H+wx98w40/i6sbhAiDZ/FPTSpHzQBrTc6cs83d9kNIoBdN95fdgYtYkwIQQ/EY7xlZgf
 dib96/WbKEuIIVBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758202221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FJc1BGnUph4MbP9CP1VtLsgjeLP0BQN8i+xFt/lMBJE=;
 b=M9m1mN7fW1lXWniiNh581JTsGSAzRL5a7Av0mrWR/YTtBmZKYF8/U2YsajNwX/Y/HOWc5y
 Ew2/rv97cffoVMWlCR0fwntxo4uxry08oPXrzIsxfwJdr2mSnIom3gFszeqwq/2E7hVVGb
 TmT9T3FL84hP2CLJjHK3GhSOs4ptF4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758202221;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FJc1BGnUph4MbP9CP1VtLsgjeLP0BQN8i+xFt/lMBJE=;
 b=GXH2I11/rzn/u1GsGDLucKuYLIO36dSHRwJ9HZYUpTSLR5CX7jLIOcV3vfeMsW5aR3E91k
 DonWxpHUP3vX11AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F293213A51;
 Thu, 18 Sep 2025 13:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5v9ZOmwJzGihMAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 18 Sep 2025 13:30:20 +0000
Date: Thu, 18 Sep 2025 15:31:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aMwJlyCe-jHCPMey@yuki.lan>
References: <20250917165403.6038-1-akumar@suse.de>
 <20250917174600.GA354055@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250917174600.GA354055@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd05: Check if PIDFD_INFO_EXIT is
 available
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
> > This test also needs this check as it might fail with
> > ioctl_pidfd05.c:45: TFAIL: ioctl(pidfd, PIDFD_GET_INFO, NULL) expected EINVAL: ENOTTY (25)
> > ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)
> > when system does not have PIDFD_INFO_EXIT implementation.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Thanks for the fix!.  As a quick fix this would work, because
> ioctl_pidfd_info_exit_supported() is using ioctl(fd, PIDFD_GET_INFO, ...).
> 
> But because PIDFD_GET_INFO was added in 6.12:
> cdda1f26e74b ("pidfd: add ioctl to retrieve pid info") # v6.12-rc3
> and PIDFD_INFO_EXIT in v6.14:
> 7477d7dce48a ("pidfs: allow to retrieve exit information") # v6.14-rc1
> it'd make sense to create ioctl_pidfd_get_info_supported() which would
> be also used by ioctl_pidfd_info_exit_supported().
> Why? There is 6.12 LTSS kernel branch which will get TCONF instead of being
> tested.
> 
> It could be done ioctl_pidfd_get_info_supported() could return int64_t mask
> (__u64 mask struct pidfd_info member if supported or -1 if ioctl() returned -1.
> ioctl_pidfd_info_exit_supported() would just evaluate that. Other option is just
> code duplicity.

Yes please, we need another check just for PIDFD_GET_INFO with empty
mask.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
