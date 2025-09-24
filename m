Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33699CAC5A5
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 08:39:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4E3F3CDF36
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 10:39:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BACE3CCD6F
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 10:39:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 196ED1A008A5
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 10:39:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F47121AFA;
 Wed, 24 Sep 2025 08:39:20 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FF0F13A61;
 Wed, 24 Sep 2025 08:39:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VQndBjiu02gTBAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Sep 2025 08:39:20 +0000
Date: Wed, 24 Sep 2025 10:40:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aNOuYfhEU160i2gE@yuki.lan>
References: <aNKJP8fKNn6JcT5I@yuki.lan> <20250923150337.19821-1-akumar@suse.de>
 <20250923184449.GA45748@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250923184449.GA45748@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 2F47121AFA
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > use this routine in ioctl_pidfd05 before proceeding with the test
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> BTW, when testing on 6.11, I got:
> ioctl_pidfd05.c:45: TFAIL: ioctl(pidfd, PIDFD_GET_INFO, NULL) expected EINVAL: ENOTTY (25)

This is exactly what this patch is trying to address. Not sure what went
wrong there.

> Which is error unrelated to this patch, it's from original.
> 196988f7d1 ("Add ioctl_pidfd05 test")
> 
> Doc in ioctl_pidfd_info_exit_supported() is clear about it:
> 		/* - ENOTTY: old kernels not implementing fs/pidfs.c:pidfd_ioctl
> 		 * - EINVAL: until v6.13 kernel
> 		 * - ESRCH: all kernels between v6.13 and v6.15
> 		 */

And the pidfd_info_supported() tries to address that by returning zero
on ENOTTY.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
