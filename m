Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429D2C43458
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 08:38:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D813B3E626D
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 10:38:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59DBF3E176A
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 10:38:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 946C6600848
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 10:38:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C506E75B7D;
 Wed,  1 Jul 2026 08:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782895111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1jVCWDLWMPwfFuj2drrXegrQKWl/S0dvvvfI2cYjfHk=;
 b=oNREWcKjw07AJn31lXh6daM+PimwbDVpyVpjsgxEpgOFwc/g9/Bq/ZClOYXckYx0wZ3hgb
 lXjPCua9GbABPbNW4VYsLHzvND2P68pOOOG4eKJb7hDeOu6TEkbkg7RjhrNRjETdGesxZo
 VxYyNz2RzAGjF77BezqHANg++QdUsso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782895111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1jVCWDLWMPwfFuj2drrXegrQKWl/S0dvvvfI2cYjfHk=;
 b=KxpQHlWdY4VUgnmmilwcse5AGLOWwPNStcVzGRUzOsV9+zWq/0cTiXEKrKBKzTjBEmhAx1
 X0XUljpfkfEBqXDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=s8ssF71v;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UezhBTil
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782895110;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1jVCWDLWMPwfFuj2drrXegrQKWl/S0dvvvfI2cYjfHk=;
 b=s8ssF71vTPqmWlBCBf2Fx1lkybeuzreZu+7L1KOzQIuoL2ZBxTJaKg83Ir/W93kY3rql8k
 LPwiQlrp0zm0x37Mo2gdWY2QkazJvHx+q7q1W5dtBHvcuz7d3SGlyW9M1P/QvAjXaY01SP
 5xxKDoaprtAMMOtmPY9sHNv75PMQEkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782895110;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1jVCWDLWMPwfFuj2drrXegrQKWl/S0dvvvfI2cYjfHk=;
 b=UezhBTil40l3J3UYQgrOywcCKlIuPyc+N1B66HMGm5Yeehl/iazOkASlu2NcNcOuINeBFf
 W39vnN434qhM26Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE055779AA;
 Wed,  1 Jul 2026 08:38:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QqRVKAbSRGqjXQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 01 Jul 2026 08:38:30 +0000
Date: Wed, 1 Jul 2026 10:38:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260701083825.GB477554@pevik>
References: <20260616052452.8353-2-wegao@suse.com>
 <20260616093119.8654-1-wegao@suse.com>
 <20260616093119.8654-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260616093119.8654-3-wegao@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C506E75B7D
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/2] connect01: Add negative tests
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

Hi Wei,

> Add negative cases for connect(), when errno is EPROTOTYPE or EACCES.
> These error paths were not exercised by the existing test.

...
> @@ -49,6 +62,10 @@ static struct test_case_t {
>  		"connect on a socket found no one listening on remote address"},
>  	{&fd_socket, &sock3, sizeof(sock3), EAFNOSUPPORT,
>  		"address doesn't have the correct address family in sa_family"},
> +	{&fd_unix_dgram, &sock4, sizeof(sock4), EPROTOTYPE,
> +		"socket type does not support the protocol"},
> +	{&fd_unix_stream, &sock4, sizeof(sock4), EACCES,
> +		"write permission is denied on the socket file"},
>  };

>  static int sys_connect(int sockfd, const struct sockaddr *addr,
> @@ -103,6 +120,19 @@ static void setup(void)
>  	sock3.sin_family = 47;
>  	sock3.sin_port = 0;
>  	sock3.sin_addr.s_addr = htonl(0x0AFFFEFD);
> +
> +	sock4.sun_family = AF_UNIX;
> +	strncpy(sock4.sun_path, SOCK_FILE, sizeof(sock4.sun_path));
> +
> +	fd_unix_server = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
> +	SAFE_BIND(fd_unix_server, (struct sockaddr *)&sock4, sizeof(sock4));
> +	SAFE_CHMOD(SOCK_FILE, 0700);
> +	SAFE_LISTEN(fd_unix_server, 5);
> +
> +	fd_unix_dgram = SAFE_SOCKET(AF_UNIX, SOCK_DGRAM, 0);
> +	fd_unix_stream = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
> +
> +	pw = SAFE_GETPWNAM("nobody");
>  }

...

> -	TST_EXP_FAIL(sys_connect(*tc->fd, addr, tc->salen),
> -		     tc->exp_errno, "%s", tc->desc);
> +	if (tc->exp_errno == EACCES) {
> +		if (!SAFE_FORK()) {
> +			SAFE_SETUID(pw->pw_uid);
> +			TST_EXP_FAIL(sys_connect(*tc->fd, addr, tc->salen),
> +				     tc->exp_errno, "%s", tc->desc);
> +			exit(0);
> +		}
> +		tst_reap_children();
> +	} else {
> +		TST_EXP_FAIL(sys_connect(*tc->fd, addr, tc->salen),
> +			     tc->exp_errno, "%s", tc->desc);
> +	}

This looks to me way complicated when put into an existing test. Wouldn't be
better to create to add them to a new file (connect03.c)? Please use the style I
introduced in connect01.c (designated initializers, errnos in doc, void =>
struct sockaddr_in, ...).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
