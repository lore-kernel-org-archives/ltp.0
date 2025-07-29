Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0697C87FC9
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 16:17:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBF4E3CAD5D
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 18:17:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E61D03C03F4
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 18:16:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EE2711A008AF
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 18:16:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B9B961F458;
 Tue, 29 Jul 2025 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753805817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmhIclxZXdAxDqvnA9kvU/JJQcC+lO/cSVmDLqtkfo4=;
 b=3cG3iyO3darmCkoxWSn+YGjSjQ10Ig6q3HYvNWIpvBHNf5fkf4U3zW3Sfyuhc3D9RraX1z
 fNpqRTL82D0gcDaYpuwVA+HBfCrKiQLmGCugCEJFkC4xhbAZQAoS5vg4fQBk9v05QjTD7H
 kyYoMyep+RGWSrl00Te3yz2Tq1u3H98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753805817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmhIclxZXdAxDqvnA9kvU/JJQcC+lO/cSVmDLqtkfo4=;
 b=VQ9VCl5LHv62xO+Z6Gewr8XxfiSmWTVMtUaMemRCT8f8hl+okxbSW0pswYb+lyKyP9vPlG
 h+qF/NmP3BR/EdBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753805817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmhIclxZXdAxDqvnA9kvU/JJQcC+lO/cSVmDLqtkfo4=;
 b=3cG3iyO3darmCkoxWSn+YGjSjQ10Ig6q3HYvNWIpvBHNf5fkf4U3zW3Sfyuhc3D9RraX1z
 fNpqRTL82D0gcDaYpuwVA+HBfCrKiQLmGCugCEJFkC4xhbAZQAoS5vg4fQBk9v05QjTD7H
 kyYoMyep+RGWSrl00Te3yz2Tq1u3H98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753805817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmhIclxZXdAxDqvnA9kvU/JJQcC+lO/cSVmDLqtkfo4=;
 b=VQ9VCl5LHv62xO+Z6Gewr8XxfiSmWTVMtUaMemRCT8f8hl+okxbSW0pswYb+lyKyP9vPlG
 h+qF/NmP3BR/EdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A625113A73;
 Tue, 29 Jul 2025 16:16:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ifQ9KPnziGgjWgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 29 Jul 2025 16:16:57 +0000
Date: Tue, 29 Jul 2025 18:17:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aIj0Jyn9cq9JVNbI@yuki.lan>
References: <20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com>
 <5913636.DvuYhMxLoT@thinkpad>
 <ea4c0dbb-c4ba-46dd-b10c-c628d6093936@suse.com>
 <20250729084720.GA13357@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250729084720.GA13357@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Disable io_uring fd in ioctl_pidfd01 for selinux
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
> > > We also have same failure for memfd_secret case in this test:
> 
> > > ioctl_pidfd01.c:37: TINFO: memfd secret -> ...
> > > ioctl_pidfd01.c:28: TFAIL: ioctl(memfd secret, PIDFD_GET_INFO, info) expected EINVAL, EBADF, ENOTTY: EACCES (13)
> 
> > > If we are opting for skipping the tests when selinux is enforcing mode,
> > > this also needs to be skipped.
> 
> > In this case we will probably need to disable the test for SELinux
> > enforcing.
> 
> Well, all tests (ioctl_pidfd01.c, this ioctl_pidfd01.c, mount08.c) are testing
> with TST_EXP_FAIL_ARR(), i.e. negative tests.  Wouldn't be better to just expect
> a different errno? At least this is what I suggested to mount08.c [1].

I'm not that sure about how to fix this. Disabling tests preventively
just because selinux is enforcing does not sound convincing to me. I
would expect that it all depends on the particular configuration of the
rules on the system.

Maybe it would make sense to inject additional errno EACESS to the
TST_EXP_FAIL() automatically if we detect that selinux is enforcing.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
