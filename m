Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B436C4345F
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 13:54:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E48303CFFA3
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 15:54:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CAF83CFF9B
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 15:54:22 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 89BCF6013FB
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 15:54:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FE0A5FFE8;
 Tue, 23 Apr 2024 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713880460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paBPvz9zGeaD/okPuVVE3hGmInlzZZdvlDz9hJKE3fI=;
 b=b/1zl4gWw4OvSXJkvpBuM7fD6H5TGy4O2oGPoopMCwErFzqdiZAJE5HhVUBw0/nrb7PTXy
 0ULqgt69hKB/8mSGNCsib1AqdSUgdApGHE4vGLMDobTSjzlxMjJItI/PYSxTSGfWkQk8iJ
 4myeMScFn0d5syL9VIUS6TFvZRz2c6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713880460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paBPvz9zGeaD/okPuVVE3hGmInlzZZdvlDz9hJKE3fI=;
 b=wUrbpHawjht0/TW6EMma1q3Da/zA2xU/ZXTgZ9yXNqHItnmOtyUY9HJGbwpd46ew1L9mn6
 TN6T1p7zx5rxoHDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="b/1zl4gW";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wUrbpHaw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713880460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paBPvz9zGeaD/okPuVVE3hGmInlzZZdvlDz9hJKE3fI=;
 b=b/1zl4gWw4OvSXJkvpBuM7fD6H5TGy4O2oGPoopMCwErFzqdiZAJE5HhVUBw0/nrb7PTXy
 0ULqgt69hKB/8mSGNCsib1AqdSUgdApGHE4vGLMDobTSjzlxMjJItI/PYSxTSGfWkQk8iJ
 4myeMScFn0d5syL9VIUS6TFvZRz2c6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713880460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paBPvz9zGeaD/okPuVVE3hGmInlzZZdvlDz9hJKE3fI=;
 b=wUrbpHawjht0/TW6EMma1q3Da/zA2xU/ZXTgZ9yXNqHItnmOtyUY9HJGbwpd46ew1L9mn6
 TN6T1p7zx5rxoHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EEB813929;
 Tue, 23 Apr 2024 13:54:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cZ6YFoy9J2YvcQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Apr 2024 13:54:20 +0000
Date: Tue, 23 Apr 2024 15:54:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Murphy Zhou <jencce.kernel@gmail.com>
Message-ID: <20240423135419.GB195737@pevik>
References: <20240423070643.38577-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240423070643.38577-1-jencce.kernel@gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6FE0A5FFE8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] readahead01: pass on pidfd
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

Hi Murphy,

> Linux kernel added pidfs via commit b5683a37c881 in v6.9-rc1
> release. This patchset ignores readahead request instead of
> returning EINVAL, so mark the test pass.

I know that Christian Brauner suggested it (he would deserve Suggested-by: ),
but I would still appreciate kernel maintainer opinion, thus not merging yet.

> https://lkml.iu.edu/hypermail/linux/kernel/2403.2/00762.html

FYI: lore is more permanent link:
https://lore.kernel.org/lkml/20240318-fegen-bezaubern-57b0a9c6f78b@brauner/

Kind regards,
Petr

> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  testcases/kernel/syscalls/readahead/readahead01.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
> index d4b3f306f..aed8e7f31 100644
> --- a/testcases/kernel/syscalls/readahead/readahead01.c
> +++ b/testcases/kernel/syscalls/readahead/readahead01.c
> @@ -53,6 +53,7 @@ static void test_invalid_fd(struct tst_fd *fd)
>  	case TST_FD_MEMFD:
>  	case TST_FD_MEMFD_SECRET:
>  	case TST_FD_PROC_MAPS:
> +	case TST_FD_PIDFD:
>  		return;
>  	default:
>  		break;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
