Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE89F43680
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 09:03:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5A803E2DDD
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 11:03:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 665713CCB72
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 11:03:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CB26D200AD4
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 11:03:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 667626A847;
 Fri, 17 Apr 2026 09:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776416607;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oU4cxef0cCDeX5rnBwGRP8zSXeJZF7C60aK+3I2L6pc=;
 b=tXGv6JPoduI44GAbkx7iH7eGvx26KJuLzAP8Cyx5ruYr2G2IQFCB6k2O6kjYkrvitNRqlW
 VCPM6w2+Rr2D+zB/xeOGPSfPL/wNe0zsFVeeBW5HEfRV7lhySRx5ca79npbAidUFo5dulq
 G9EGGwWUkjj4LsdepScZY9IA+QxTL0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776416607;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oU4cxef0cCDeX5rnBwGRP8zSXeJZF7C60aK+3I2L6pc=;
 b=bLq6i7Rhwhp+Fe3dNgA4mN8ftwt1S7zTVWPhG47pYsocYW+3v3k45QZTG2a5CPgde+vTuR
 GpvPxxsGHSIxZaBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DM1CgGOk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BRKkRSnt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776416603;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oU4cxef0cCDeX5rnBwGRP8zSXeJZF7C60aK+3I2L6pc=;
 b=DM1CgGOksc2tZAH6MEjoA6cKBd0GHP6QC5hb2x2VXM3NNxK9SUnP6j+mtSZczYXx/KYSCU
 K3r7rFhhwNZVjwLKbkeMSM4WkJudQiWcCpm/o7zzvBHTpWyMr5WR7++Ww8jHz1tO1ZMNcN
 LVb0K/CJ2nEGxSDINA+ZWu9mqpjGEOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776416603;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oU4cxef0cCDeX5rnBwGRP8zSXeJZF7C60aK+3I2L6pc=;
 b=BRKkRSntdNXVKzzToMxDXiY4QcogedD89LjQN52pNjksmcHC7TcaxW5SwtW8/klWvPSYLP
 PMU4EH730fzR6WAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33D91593AE;
 Fri, 17 Apr 2026 09:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Nl9ECVv34Wl0YAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Apr 2026 09:03:23 +0000
Date: Fri, 17 Apr 2026 11:03:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20260417090321.GB329568@pevik>
References: <20260417085931.331281-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260417085931.331281-1-pvorel@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,ubuntu.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,suse.cz,suse.com,gmail.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 667626A847
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ci: doc: Replace Ubuntu bionic with noble
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

Hi all,

> Replace Ubuntu 18.04 LTS bionic with  Ubuntu 24.04 LTS noble (the latest
> Ubuntu LTS).

> Ubuntu 18.04 LTS bionic EOL 3 years ago (2023-04). Repositories were
> publicly available until now, remove it to fix CI.

> Exact error is missing Packages file

>     W: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/bionic-backports/InRelease  Connection failed [IP: 91.189.91.82 80]
>     E: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/bionic/universe/binary-amd64/Packages  Connection timed out [IP: 91.189.92.23 80]

> which causes gcc not being installed.

> Although repository has Packages.gz and Packages.xz (therefore it
> should somehow work or it might be GitHub Actions issue) we don't need
> to keep bionic (we have older distro openSUSE Leap 42), which we still
> use for testing SLE1-SP2 build).

Other option would be to remove 22.04 LTS jammy (previous LTS), but I'm ok to
keep it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
