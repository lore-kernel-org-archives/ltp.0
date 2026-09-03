Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58F0C624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 17:03:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB86B3EB0A3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 19:03:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABA823E9844
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 19:03:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 19C3E600A81
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 19:03:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D36DA21C7E;
 Thu,  3 Sep 2026 17:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788455004;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MvjwUbxuYPWXRlVQv+9Ni5Ueb5+xdOt5QP36WmtZuTo=;
 b=WeZY4Rba0PIUg6KAHG15EpLp5gEikGXL47D01LBk+4Z1W8VWLFjwa9zyJFCWjQ4GYaPxk8
 qsFc6XCHqV6sv6XDhcSc82JFNAABvsrV1exGgKJNB2QxuJqVPsAsYR+VV8dOGFA+914cfV
 3O27Zva4Vgt0zc+7L2U9E9swEms6JNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788455004;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MvjwUbxuYPWXRlVQv+9Ni5Ueb5+xdOt5QP36WmtZuTo=;
 b=Jpu2JzObizn2wWPPNJDSyyPsyFUoZ2EjwKsno/NOy8RFWWMmPzuunAgFaGMieMHXtsL3d7
 xU28GShE2lfuyTDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zMb1xxTH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f9unfTJi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788454999;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MvjwUbxuYPWXRlVQv+9Ni5Ueb5+xdOt5QP36WmtZuTo=;
 b=zMb1xxTHtfh1XTzn8qCGFCDzSvGi7ZjvpkufbhybXBP3Po9ftHyzsoyno5KsbEiC3/KxAj
 NODGdcNQ4GpeLLNHFtAKvIS/2GDSApD4QYhAsG8IQJCAWiiy4yd9j+g8GvT99Vpmr8z6/s
 +KqKTp25kpuLkfvWvghnHz/iZWAJ+ZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788454999;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MvjwUbxuYPWXRlVQv+9Ni5Ueb5+xdOt5QP36WmtZuTo=;
 b=f9unfTJi2oA71khAC6QarldBapV2Tj5PGztTSYy2U2u94wBwqCGvaWMmB/rumZ77+FLKhk
 YZnRxmBhyB01skCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EC72136E6;
 Thu,  3 Sep 2026 17:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mKHXBleomWrQLgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Sep 2026 17:03:19 +0000
Date: Thu, 3 Sep 2026 19:03:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260903170317.GI1107507@pevik>
References: <20260827112157.1748734-1-chrubis@suse.cz>
 <20260827112157.1748734-24-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260827112157.1748734-24-chrubis@suse.cz>
X-Rspamd-Queue-Id: D36DA21C7E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 23/31] testcases: sysfs: Add sys_net04
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

> +++ b/testcases/kernel/sysfs/class/net/sys_net04.c
...

> +	TST_RETRY_FUNC(read_operstate(&s1, "down"), TST_RETVAL_EQ0);
> +	check_state(&s1, 0, "down", "tun detached");
> +	check_state_delta(&s0, &s1, 0, 1, "detach transition");
nit: I was thinking if this part would deserve it's own function as it was used
at least also in sys_net03.c, but that's really minor detail.

All sysctl networking tests have really impressive coverage.

Kind regards,
Petr

> +
> +	tun_fd = open_tun(IFNAME_TUN, IFF_TUN | IFF_NO_PI);
> +	TST_RETRY_FUNC(read_operstate(&s2, "up"), TST_RETVAL_EQ0);
> +	check_state(&s2, 1, "up", "tun reattached");
> +	check_state_delta(&s1, &s2, 1, 0, "reattach transition");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
