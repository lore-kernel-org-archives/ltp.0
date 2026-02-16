Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15641E7BD86
	for <ltp@archiver.kernel.org>; Mon, 16 Feb 2026 10:21:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D6213D050B
	for <ltp@archiver.kernel.org>; Mon, 16 Feb 2026 11:21:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B7823C7BB1
 for <ltp@lists.linux.it>; Mon, 16 Feb 2026 11:20:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8C48C1400776
 for <ltp@lists.linux.it>; Mon, 16 Feb 2026 11:20:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 959963E6D0;
 Mon, 16 Feb 2026 10:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771237249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ljc7A3v0SG6MxJbbnyXE/bGkGpD8an5eUl+shBtLkB8=;
 b=dBk/Sgf6a+t5aHN3+j8G4TrJ5zbj71PapWh6eMyHt62Z0coSfGUn110R+pInofQL+AuJb0
 LLNEKdYfgWDWWuMLI1TqrXinIaB5d+se1SylgDmyqxudAnguLZIMzr6f0x5CfJDrKRszTf
 yp7KOleSeenUOavqUrnD/ZH/qFutTHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771237249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ljc7A3v0SG6MxJbbnyXE/bGkGpD8an5eUl+shBtLkB8=;
 b=2s53HLWT+PjtgXmCri8UxjekP2OXeuGJm9dn8rjP+Ewhv38CifFOwDjI03rbmrd1LAnhzJ
 LCkZizowaHEDoiDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771237249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ljc7A3v0SG6MxJbbnyXE/bGkGpD8an5eUl+shBtLkB8=;
 b=dBk/Sgf6a+t5aHN3+j8G4TrJ5zbj71PapWh6eMyHt62Z0coSfGUn110R+pInofQL+AuJb0
 LLNEKdYfgWDWWuMLI1TqrXinIaB5d+se1SylgDmyqxudAnguLZIMzr6f0x5CfJDrKRszTf
 yp7KOleSeenUOavqUrnD/ZH/qFutTHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771237249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ljc7A3v0SG6MxJbbnyXE/bGkGpD8an5eUl+shBtLkB8=;
 b=2s53HLWT+PjtgXmCri8UxjekP2OXeuGJm9dn8rjP+Ewhv38CifFOwDjI03rbmrd1LAnhzJ
 LCkZizowaHEDoiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 582013EA62;
 Mon, 16 Feb 2026 10:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9/PfE4HvkmkAMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 16 Feb 2026 10:20:49 +0000
Date: Mon, 16 Feb 2026 11:20:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <20260216102039.GB136260@pevik>
References: <20260214175237.13794-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260214175237.13794-1-always.starving0@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inotify: cleanup - limit masks, use SAFE_ wrappers
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

Hi Jinseok Kim,

> Replace IN_ALL_EVENTS with minimal relevant masks and manual read/write
> with SAFE_READ/SAFE_WRITE for better stability and consistency.

> inotify12.c intentionally unchanged: raw read() + manual EAGAIN handling
> is required to treat missing second event as IN_IGNORED (normal case).

...
> +++ b/testcases/kernel/syscalls/inotify/inotify07.c
> @@ -88,12 +88,7 @@ void verify_inotify(void)
>  	strcpy(event_set[test_cnt].name, FILE_NAME);
>  	test_cnt++;

> -	int len = read(fd_notify, event_buf, EVENT_BUF_LEN);
> -	if (len == -1 && errno != EAGAIN) {
> -		tst_brk(TBROK | TERRNO,
> -			"read(%d, buf, %zu) failed",
> -			fd_notify, EVENT_BUF_LEN);
> -	}
> +	int len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

I suppose this should be also kept unchanged (similar to inotify12.c).
Or any reason why to skip?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
