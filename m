Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AE6D3B992
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 19:48:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 504833CAC1E
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 20:48:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB09A3CA1ED
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 20:48:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 47EC260020E
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 20:48:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A5E75BEA8;
 Tue,  9 Dec 2025 19:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765309696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ul022XY3hL2dc85aIegn3JMKqvS6vvh4ZHqPG7PQ0H0=;
 b=jkNLgSx4uXcJfZHhLlo9IhllW2MvvjwU1nAbO8ODz4Q5+cjJNZDUAv3PkCBFZXn913WDVn
 fNHKi9iJb5WGMDigM4KAmbl58Wcoe1/1wqEJa82zRnP6yJRqcTjWL2CQvhHFvYEexHYXeG
 cpkZEULKGc0KwGzoXhHj2mNiVOErBBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765309696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ul022XY3hL2dc85aIegn3JMKqvS6vvh4ZHqPG7PQ0H0=;
 b=/02wQ8v8Zl8zI0/ZzQqWoV0r/FKm2bWCd7/WExXdBaHETWCv2bWpfYMsTVAH0Dt6oyA+wn
 CI14NXM4aq+vX8DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jkNLgSx4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/02wQ8v8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765309696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ul022XY3hL2dc85aIegn3JMKqvS6vvh4ZHqPG7PQ0H0=;
 b=jkNLgSx4uXcJfZHhLlo9IhllW2MvvjwU1nAbO8ODz4Q5+cjJNZDUAv3PkCBFZXn913WDVn
 fNHKi9iJb5WGMDigM4KAmbl58Wcoe1/1wqEJa82zRnP6yJRqcTjWL2CQvhHFvYEexHYXeG
 cpkZEULKGc0KwGzoXhHj2mNiVOErBBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765309696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ul022XY3hL2dc85aIegn3JMKqvS6vvh4ZHqPG7PQ0H0=;
 b=/02wQ8v8Zl8zI0/ZzQqWoV0r/FKm2bWCd7/WExXdBaHETWCv2bWpfYMsTVAH0Dt6oyA+wn
 CI14NXM4aq+vX8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01E623EA63;
 Tue,  9 Dec 2025 19:48:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZQElOf98OGnjdgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 19:48:15 +0000
Date: Tue, 9 Dec 2025 20:48:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20251209194810.GA24627@pevik>
References: <20251208150542.704006-1-pvorel@suse.cz>
 <20251208150542.704006-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251208150542.704006-2-pvorel@suse.cz>
X-Rspamd-Queue-Id: 3A5E75BEA8
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 URIBL_BLOCKED(0.00)[ozlabs.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] safe_keyctl: Skip with TCONF on EOPNOTSUPP
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
Cc: Meng Yang <yangm50@chinatelecom.cn>, Mingyu Li <limy83@chinatelecom.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> +++ b/include/lapi/keyctl.h
> @@ -209,10 +209,11 @@ static inline long safe_keyctl(const char *file, const int lineno,
>  {
>  	long rval;
>  	int failure = 0;
> +	int res = errno == EOPNOTSUPP ? TCONF : TBROK | TERRNO;

Obviously set variable before calling keyctl() is wrong,
as Mingyu Li reported
https://lore.kernel.org/ltp/20251209124041.216542-1-simplemessager@163.com/

Therefore his patch which does not store value before use should be used:
https://patchwork.ozlabs.org/project/ltp/patch/20251209122937.212641-2-simplemessager@163.com/
https://lore.kernel.org/ltp/20251209124041.216542-2-simplemessager@163.com/

Kind regards,
Petr

>  	rval = keyctl(cmd, arg2, arg3, arg4, arg5);
>  	if (rval == -1) {
> -		tst_brk_(file, lineno, TBROK | TERRNO,
> +		tst_brk_(file, lineno, res,
>  			"keyctl(%d, %lu, %lu, %lu, %lu)",
>  			cmd, arg2, arg3, arg4, arg5);
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
