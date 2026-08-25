Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C6CC61DB4
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 10:37:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E04C93C29B6
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 12:37:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 831ED3C2220
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 12:37:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 456692000A0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 12:37:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A5941F7B9;
 Tue, 25 Aug 2026 10:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787654181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVNg+gi6Poa6bPV5CvT9Ise3GI+9dvmUfs0f/AN1Vgg=;
 b=LcqKOkC9GszggP6T0qbIt1GcvCTa47Tt6ajUwwhGnm3xlNTzWsymAwQrSHXpv7MNKh6vdL
 QagD36PlD7FtJGoal+R8jfnTFPz5Jk7gytGAnpRb27PzwaIFbxkLkobCVHhkEHsBN3VkGW
 +dv/A/bimqsSaXOquQF7zh4BMHc26w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787654181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVNg+gi6Poa6bPV5CvT9Ise3GI+9dvmUfs0f/AN1Vgg=;
 b=NoLmHp5fqVxDb+/77Uy2SmYxnAmwEGvqlz8mVT6CLTcjT5+9Fz7NfWVaWdeXmv1gRkmGvV
 DWTNdUtuUWeQgMDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787654177;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVNg+gi6Poa6bPV5CvT9Ise3GI+9dvmUfs0f/AN1Vgg=;
 b=zdhhkiwKqcFBuvtQ4oifjVw/WPYbX8IUKhrgVjtAFTvEVGSw2SHdypyZO+9DyuBz471Lnk
 Rl5HSpoxf0QE9e+iyG8kzammvN3LibfjAS6T/E5hC2LEbnWl5eeeL5nhd9KzPmbRUU7Qym
 dcHeysV9WIJFtreN9bB9Eu2OvIHbvnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787654177;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVNg+gi6Poa6bPV5CvT9Ise3GI+9dvmUfs0f/AN1Vgg=;
 b=Tk3nNqxxj/xejdAaeNjFOLdUfISy+o541iYiI+RmCjJxPJRD5/3J9W3zdjYNxBOLOrBsE+
 lerdgCSc7NxpGMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92C9413332;
 Tue, 25 Aug 2026 10:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BXMUGSBwjWoPDQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Aug 2026 10:36:16 +0000
Date: Tue, 25 Aug 2026 12:36:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: AnonymeMeow <anonymemeow@gmail.com>
Message-ID: <20260825103609.GA56957@pevik>
References: <20260616210448.12175-1-anonymemeow@gmail.com>
 <20260616210448.12175-3-anonymemeow@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260616210448.12175-3-anonymemeow@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] fanotify21: Stop relying on exited child
 for pidfd error
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
Cc: amir73il@gmail.com, jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> fanotify21 used to verify the pidfd error case by generating an event
> from a child process and reading the event after the child had exited.
> This is no longer a stable way to trigger a pidfd error, because newer
> kernels can report pidfds for exited event processes.

> Read the event from a child process in a descendant PID namespace
> instead. The reader cannot get the pidfd in the parent PID namespace
> from fanotify, so pidfd creation will fail and the test can verify
> FAN_NOPIDFD, or -ESRCH with FAN_REPORT_FD_ERROR.

> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

...
>  	/*
> -	 * Generate the event in either self or a child process. Event
> -	 * generation in a child process is done so that the FAN_NOPIDFD case
> -	 * can be verified.
> +	 * Read the event in either self or a child process in a descendant
> +	 * PID namespace. A reader in a descendant PID namespace cannot obtain
> +	 * the pidfd of the event process in the parent PID namespace so that
> +	 * the FAN_NOPIDFD case can be verified.
>  	 */
> -	if (tc->fork)
> -		do_fork();
> -	else
> -		generate_event();
> +	if (tc->want_pidfd_err && (reader_pid = SAFE_CLONE(&clone_args))) {
nit: although I'd write it this way as well, checkpatch does not like this
effective way :) (do not use assignment in if condition).

> +		SAFE_WAITPID(reader_pid, &reader_exit_status, 0);
> +		if (!WIFEXITED(reader_exit_status) || WEXITSTATUS(reader_exit_status))
> +			tst_brk(TBROK, "reader process exited incorrectly");

nit: And the above should be probably replaced with tst_reap_children().

But because I should have merged this long time ago to prevent false positive on
7.2, merging it now. Cleanup can be done later (together with using designated
initializers).

Merged the rest of the patch, thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
