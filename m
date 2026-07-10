Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4319C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 07:28:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B6B93E4869
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 09:28:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 092333E26B6
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:27:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7CF7E600A33
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:27:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5176176663;
 Fri, 10 Jul 2026 07:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783668472;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rKLSTK49hjl1w7oqbkQtLcHytjW2fcqUPrJc+g1hp4o=;
 b=JTxXRUa7uxvwyPoKXOg8txdjqEqkjQ8zkaS2eAf4t+efId3/Gk6KUz6b08AFzQpke/i1+I
 d5fSj/WMJwUgf4Xjcy6Nzlg+yyIuLrGflVZTvVgLYiADtjqgzwz0RCx2Vob7E4wgRWAP4p
 aqTdJCFtolKfBRPRnSnPM71tQfZaNw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783668472;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rKLSTK49hjl1w7oqbkQtLcHytjW2fcqUPrJc+g1hp4o=;
 b=PVYUqLu3pa58uWF5ebI8lW37Qa831fkclPa87B8kRLPG5KLuQ2NQmeHcddSBZcpoZ1aEj1
 MGwqmTp4isQJCHBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783668471;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rKLSTK49hjl1w7oqbkQtLcHytjW2fcqUPrJc+g1hp4o=;
 b=jwdfBnc9+ov248aK/WrMasSeQt8OlZFqNwFVJJNhtX0keAQCDh/UfXx5XFo3d7+HD8Preb
 fFFmk6DxQ55ZddZqc6yhGCK/U7JsTMOCfDLlgEbF9AJWrJ7nEjAWLboBypT18bLWpl9aAM
 fNfs1FQQ42dxlIKngXj/YxLl2FOeeNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783668471;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rKLSTK49hjl1w7oqbkQtLcHytjW2fcqUPrJc+g1hp4o=;
 b=YbF4GOH68MkTb8tf0suqqzz/vJXD6qdEhJT5dYKJ7ZIZ+wRCEnrldvLVRDm9AlabPxKoUF
 cvN6cmJV3ROi0CDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EE5B779BD;
 Fri, 10 Jul 2026 07:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H3IGBveeUGrIJgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 07:27:51 +0000
Date: Fri, 10 Jul 2026 09:27:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260710072744.GC1157094@pevik>
References: <20260709085353.345957-1-chrubis@suse.cz>
 <20260709085353.345957-9-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260709085353.345957-9-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 8/9] syscalls: Add epoll_wait12
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

Hi Cyril,

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +static void run(void)
> +{
> +	pid_t pid;
> +
> +	SAFE_PIPE(fds);
> +	fill_pipe(fds[1]);
> +
> +	efd = SAFE_EPOLL_CREATE1(0);
> +
> +	struct epoll_event ev = {
> +		.events = EPOLLOUT,
> +		.data.fd = fds[1],
> +	};
> +
> +	SAFE_EPOLL_CTL(efd, EPOLL_CTL_ADD, fds[1], &ev);
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		SAFE_CLOSE(fds[0]);
> +
> +		TEST(epoll_wait(efd, &ev, 1, 5000));
> +		if (TST_RET != 1) {
> +			tst_res(TFAIL | TTERRNO,
> +				"epoll_wait() returned %li, expected 1",
> +				TST_RET);
> +			exit(0);
> +		}

nit: Using TST_EXP_VAL_SILENT(..., 1) would be shorter:
		TST_EXP_VAL_SILENT(epoll_wait(efd, &ev, 1, 5000), 1);
		if (!TST_PASS)
			exit(0);

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
