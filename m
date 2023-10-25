Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51385C25B6B
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 22:09:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CDC53CF910
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 00:09:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E19D13CCB57
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 00:09:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3332C201DC9
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 00:09:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 56CFF1F385;
 Wed, 25 Oct 2023 22:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698271761;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FMY8DQsCa4IewL9XjH8xZhYVOGfLTU4OxU5zSAX8DEY=;
 b=ApnSMCd/Ye2e75mJ21FoSNrkXBYQlvkX2qfVlyWSvsgf8u2x9J78WGeigk5TP/X9G6sOEQ
 4xrWAOffjfndnjLia5/QnodB3Da+NudKzUoKY05FeFpbq0bH4iifSq2LcTVgte368Smxto
 AZbTkDGltPJAqs+JpMXhOOr1BjJ5ryk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698271761;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FMY8DQsCa4IewL9XjH8xZhYVOGfLTU4OxU5zSAX8DEY=;
 b=G+dcTNSK6vO6vxyJxvVXhFH9oldy3+ZGgyA92ki1k8ux0u7yhj5wZ4OwCk4HJLgE3NjV4b
 ZP3HiiBU7brUtUAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 382C7138E9;
 Wed, 25 Oct 2023 22:09:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mO5ODBGSOWV3QAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 22:09:21 +0000
Date: Thu, 26 Oct 2023 00:09:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Marius Kittler <mkittler@suse.de>, ltp@lists.linux.it
Message-ID: <20231025220919.GC477570@pevik>
References: <20231025110835.28832-1-mkittler@suse.de>
 <20231025110835.28832-2-mkittler@suse.de>
 <20231025220605.GB477570@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231025220605.GB477570@pevik>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-5.96 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.66)[98.51%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/4] Refactor ioctl02.c to use the new test API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Marius,

> > -	if (ioctl(cfd, TCFLSH, 2) < 0) {
> > -		tst_resm(TINFO, "ioctl TCFLSH failed. : errno = %d", errno);
> > -		/* signal the parent so we don't hang the test */
> > -		kill(parentpid, SIGUSR1);
> > -		return -1;
> > -	}
> > +	SAFE_IOCTL(cfd, TCFLSH, 2);
> 2 is for flushing both Rx and Tx, right?
> Maybe we could use TCIOFLUSH, right? At least it's documented in
> include/uapi/asm-generic/termbits-common.h. TCIOFLUSH is in glibc, musl and
> uclibc-ng thus safe to use.

And, more importantly, TCIOFLUSH is mentioned in man ioctl_tty(2) and
termios(3). Using constant is kind of self explaining.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
