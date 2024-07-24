Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BC8C3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 15:43:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45F453D1C3C
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 17:43:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D4193D1C1E
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 17:43:05 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B2B5A1BB932D
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 17:43:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22AB721B1A;
 Wed, 24 Jul 2024 15:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721835783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Hlj+8WpFfeKUVQMOI22az5LEf6wC8TYAi9xHxdDo9c=;
 b=gmxNtCQyE2p3O5jDPz1RRsITg4OaeNxE/4caGSuk+Ao/qXM5/J+pML5MJfaNbj9xuLNfJ1
 FtFPHEyNaktKeF2IiyAMO45h3e8lH/zyEOcx5VhN5qYB8fYzrrLR6DyWyRB9zMW/xscvsU
 6WWjH6coH+kl1Brr9/mPggDZXnbtvog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721835783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Hlj+8WpFfeKUVQMOI22az5LEf6wC8TYAi9xHxdDo9c=;
 b=VfOr29HnftniuDlA6SFXPUMd7r1fF0IHbQ2MaynY8wbJDw+4I9owhZXgixQaq/5fn0e10k
 ro8t+g0eiHX+n0CA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gmxNtCQy;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VfOr29Hn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721835783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Hlj+8WpFfeKUVQMOI22az5LEf6wC8TYAi9xHxdDo9c=;
 b=gmxNtCQyE2p3O5jDPz1RRsITg4OaeNxE/4caGSuk+Ao/qXM5/J+pML5MJfaNbj9xuLNfJ1
 FtFPHEyNaktKeF2IiyAMO45h3e8lH/zyEOcx5VhN5qYB8fYzrrLR6DyWyRB9zMW/xscvsU
 6WWjH6coH+kl1Brr9/mPggDZXnbtvog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721835783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Hlj+8WpFfeKUVQMOI22az5LEf6wC8TYAi9xHxdDo9c=;
 b=VfOr29HnftniuDlA6SFXPUMd7r1fF0IHbQ2MaynY8wbJDw+4I9owhZXgixQaq/5fn0e10k
 ro8t+g0eiHX+n0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1208D1324F;
 Wed, 24 Jul 2024 15:43:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R70nBAchoWYFQAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jul 2024 15:43:03 +0000
Date: Wed, 24 Jul 2024 17:42:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZqEg7SD35ejRYCsX@yuki>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-7-33075bbc117f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240723-ioctl_ficlone-v2-7-33075bbc117f@suse.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.81 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 22AB721B1A
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 7/7] Add ioctl_ficlone04 test
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
> +	switch (fd_src->type) {
> +	case TST_FD_DEV_ZERO:
> +	case TST_FD_PROC_MAPS:
> +	case TST_FD_PIPE_READ:
> +	case TST_FD_PIPE_WRITE:
> +	case TST_FD_UNIX_SOCK:
> +	case TST_FD_INET_SOCK:
> +	case TST_FD_EPOLL:
> +	case TST_FD_EVENTFD:
> +	case TST_FD_SIGNALFD:
> +	case TST_FD_TIMERFD:
> +	case TST_FD_PIDFD:
> +	case TST_FD_FANOTIFY:
> +	case TST_FD_INOTIFY:
> +	case TST_FD_USERFAULTFD:
> +	case TST_FD_PERF_EVENT:
> +	case TST_FD_IO_URING:
> +	case TST_FD_BPF_MAP:
> +	case TST_FD_FSOPEN:
> +	case TST_FD_FSPICK:
> +	case TST_FD_OPEN_TREE:
> +	case TST_FD_MEMFD:
> +	case TST_FD_MEMFD_SECRET:
> +		return;
> +	default:
> +		break;
> +	}

Why do we skip all these cases?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
