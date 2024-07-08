Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F61C3271E
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 08:54:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2FB73D39FC
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 10:54:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35B593D115C
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 10:53:51 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 33D252079E6
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 10:53:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 13DB5219AD;
 Mon,  8 Jul 2024 08:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720428830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jH8kA9r1VEJJkoXfOVNJieydka5wyEuNskeY+VC2jA4=;
 b=bw+cDGCRX75MrQnURqgdnyHVNv8/Me6ZadGHaBLpXnXdQrWT00D2w+4rp/8esEbTSE0JOH
 84MDgMWc/yr5+znCM9H1h4c2ibxcYLxf8Zk2j5UaRUm5wkIQTP/tQQbhQuSWGqY2DyGp8K
 rLrbH2E/p509dg49DBW3gqUC1T0nD5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720428830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jH8kA9r1VEJJkoXfOVNJieydka5wyEuNskeY+VC2jA4=;
 b=wgLrUYTc0O8djP8uTd0KmjhgZKeg8Hc48d2/dPdxpz1dv5A62tQyO/jMh67t/VAMaUABdI
 +KHmk4UdSkoly8Cw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bw+cDGCR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wgLrUYTc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720428830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jH8kA9r1VEJJkoXfOVNJieydka5wyEuNskeY+VC2jA4=;
 b=bw+cDGCRX75MrQnURqgdnyHVNv8/Me6ZadGHaBLpXnXdQrWT00D2w+4rp/8esEbTSE0JOH
 84MDgMWc/yr5+znCM9H1h4c2ibxcYLxf8Zk2j5UaRUm5wkIQTP/tQQbhQuSWGqY2DyGp8K
 rLrbH2E/p509dg49DBW3gqUC1T0nD5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720428830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jH8kA9r1VEJJkoXfOVNJieydka5wyEuNskeY+VC2jA4=;
 b=wgLrUYTc0O8djP8uTd0KmjhgZKeg8Hc48d2/dPdxpz1dv5A62tQyO/jMh67t/VAMaUABdI
 +KHmk4UdSkoly8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04D821396E;
 Mon,  8 Jul 2024 08:53:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id C5y/OB2pi2abKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 08 Jul 2024 08:53:49 +0000
Date: Mon, 8 Jul 2024 10:56:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: =?utf-8?B?6Lev5paQ?= <lufei@uniontech.com>
Message-ID: <Zoupv921-4Zmw1Wt@rei>
References: <20240606065506.1686-1-lufei@uniontech.com> <Zoajv8Y1HEbjvhmh@yuki>
 <tencent_29288C9E297DDACC1D8B73FC@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_29288C9E297DDACC1D8B73FC@qq.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 13DB5219AD
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] acct01: add EFAULT errno check
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
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> In the beginning, replace ENOSYS with .needs_kconfigs is for fixing
> one of the `make check` warnings. Should I still split .needs_kconfigs
> and make check fixes to seperate patches?

Yes please. Ideally keep one type of a change in each patch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
