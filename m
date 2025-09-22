Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB22ACA100F
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 20:44:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A25AE3CDE85
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 22:44:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C562E3C0433
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 22:44:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C57EA601098
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 22:44:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 02C7E21E9B;
 Mon, 22 Sep 2025 20:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758573841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeIQsSrqGmOaTF+t1/R8fXdxz7U3EpK0PGzhpvVprxE=;
 b=VJG7JnKV0NjgIjaw+z3iT42d+VGSPh1v9st1gx77tYXwwUxhaAtChkWTj0sLcdDicFMzlS
 XPN8rqY7Pr2oOuD+lS1yPoxV8sjG1+NWMhJ/Hrfs04JAiLmUgMX5WxyXQfI3Jutc8xT4ud
 QVlb2dlSVvARMTr1UzvCY/KL+jyERYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758573841;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeIQsSrqGmOaTF+t1/R8fXdxz7U3EpK0PGzhpvVprxE=;
 b=IFx//Nhh5BjcMkhnV6KRacZMFA8B8V5pYVoE/ZVTeo9rREr+gUwNnM01yylzSB1vv6AdTu
 wm5/Bh4wZ8+2ZwDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VJG7JnKV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="IFx//Nhh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758573841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeIQsSrqGmOaTF+t1/R8fXdxz7U3EpK0PGzhpvVprxE=;
 b=VJG7JnKV0NjgIjaw+z3iT42d+VGSPh1v9st1gx77tYXwwUxhaAtChkWTj0sLcdDicFMzlS
 XPN8rqY7Pr2oOuD+lS1yPoxV8sjG1+NWMhJ/Hrfs04JAiLmUgMX5WxyXQfI3Jutc8xT4ud
 QVlb2dlSVvARMTr1UzvCY/KL+jyERYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758573841;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeIQsSrqGmOaTF+t1/R8fXdxz7U3EpK0PGzhpvVprxE=;
 b=IFx//Nhh5BjcMkhnV6KRacZMFA8B8V5pYVoE/ZVTeo9rREr+gUwNnM01yylzSB1vv6AdTu
 wm5/Bh4wZ8+2ZwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E14441388C;
 Mon, 22 Sep 2025 20:44:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6Q8ENhC10WjefwAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 22 Sep 2025 20:44:00 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Sep 2025 22:44:00 +0200
Message-ID: <12744042.O9o76ZdvQC@thinkpad>
In-Reply-To: <aMwJlyCe-jHCPMey@yuki.lan>
References: <20250917165403.6038-1-akumar@suse.de>
 <20250917174600.GA354055@pevik> <aMwJlyCe-jHCPMey@yuki.lan>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 02C7E21E9B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 CTE_CASE(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
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

Hi Petr and Cyril,

On Thursday, September 18, 2025 3:31:03 PM CEST Cyril Hrubis wrote:
> Hi!
> > > This test also needs this check as it might fail with
> > > ioctl_pidfd05.c:45: TFAIL: ioctl(pidfd, PIDFD_GET_INFO, NULL) expected EINVAL: ENOTTY (25)
> > > ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)
> > > when system does not have PIDFD_INFO_EXIT implementation.
> > 
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > 
> > Thanks for the fix!.  As a quick fix this would work, because
> > ioctl_pidfd_info_exit_supported() is using ioctl(fd, PIDFD_GET_INFO, ...).
> > 
> > But because PIDFD_GET_INFO was added in 6.12:
> > cdda1f26e74b ("pidfd: add ioctl to retrieve pid info") # v6.12-rc3
> > and PIDFD_INFO_EXIT in v6.14:
> > 7477d7dce48a ("pidfs: allow to retrieve exit information") # v6.14-rc1
> > it'd make sense to create ioctl_pidfd_get_info_supported() which would
> > be also used by ioctl_pidfd_info_exit_supported().
> > Why? There is 6.12 LTSS kernel branch which will get TCONF instead of being
> > tested.
> > 
> > It could be done ioctl_pidfd_get_info_supported() could return int64_t mask
> > (__u64 mask struct pidfd_info member if supported or -1 if ioctl() returned -1.
> > ioctl_pidfd_info_exit_supported() would just evaluate that. Other option is just
> > code duplicity.
> 
> Yes please, we need another check just for PIDFD_GET_INFO with empty
> mask.
> 
> 
Thank you both for reviewing and suggesting the correct approach. I have sent
the new patch [1].

[1] https://patchwork.ozlabs.org/project/ltp/patch/20250922203927.14552-1-akumar@suse.de/


Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
