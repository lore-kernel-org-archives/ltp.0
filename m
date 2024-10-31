Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFA1D74958
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 13:18:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E379E3CC03A
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 14:18:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A05993CBF68
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 14:18:25 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ECA8611F1E27
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 14:18:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08B2321C70;
 Thu, 31 Oct 2024 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730380704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xN4/+/1HlAlAoI32rEQbYXXwoFNaURnxM+bFNt7dkqo=;
 b=2EUggpaEB4VEAyTtJwv/m3O+oboCMQSVeMJTtA5+ADyAnKz8/PL1Trd4Sn4EOFEtRjIn6a
 cNwy/d+A/1vE3lQXmheVZWyXtOC20SS94MYUu+Ebvmzqbe3AIqgdB5sAjyQ7nypMezHAqJ
 kNfVMLoPJ048xMGx5XZ01mqCTjB9aYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730380704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xN4/+/1HlAlAoI32rEQbYXXwoFNaURnxM+bFNt7dkqo=;
 b=RT9tPkM04Z1ZwIe0bw7pdvnBFoSCtYnXxCXVThkxJ9b4uOB04vUnynHU0MpquIbQlmDM/Y
 Wh2KtdvIPLCalvBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730380704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xN4/+/1HlAlAoI32rEQbYXXwoFNaURnxM+bFNt7dkqo=;
 b=2EUggpaEB4VEAyTtJwv/m3O+oboCMQSVeMJTtA5+ADyAnKz8/PL1Trd4Sn4EOFEtRjIn6a
 cNwy/d+A/1vE3lQXmheVZWyXtOC20SS94MYUu+Ebvmzqbe3AIqgdB5sAjyQ7nypMezHAqJ
 kNfVMLoPJ048xMGx5XZ01mqCTjB9aYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730380704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xN4/+/1HlAlAoI32rEQbYXXwoFNaURnxM+bFNt7dkqo=;
 b=RT9tPkM04Z1ZwIe0bw7pdvnBFoSCtYnXxCXVThkxJ9b4uOB04vUnynHU0MpquIbQlmDM/Y
 Wh2KtdvIPLCalvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDB78136A5;
 Thu, 31 Oct 2024 13:18:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q459OZ+DI2fzdAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 31 Oct 2024 13:18:23 +0000
Date: Thu, 31 Oct 2024 14:18:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZyODpGheJSyv3EL9@yuki.lan>
References: <20241031-generate_syscalls-v7-0-f3e26c06814e@suse.com>
 <20241031-generate_syscalls-v7-1-f3e26c06814e@suse.com>
 <20241031130117.GA1017691@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241031130117.GA1017691@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/4] Refactor regen.sh script to generate
 syscalls
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
> $ ./configure
> ...
> + syscall_nr=__NR_writev
> + echo # ifndef __NR_writev
> + echo #  define __NR_writev __LTP__NR_INVALID_SYSCALL
> + echo # endif
> + echo #endif
> 
> $ ./configure > /tmp/out 2> /tmp/err; wc -l /tmp/out /tmp/err
> 
> on master:
>   290 /tmp/out
>     3 /tmp/err
>   293 total
> 
> on v7 (at least what I apply from https://patchwork.ozlabs.org/series/430633/mbox/):
>     289 /tmp/out
>   48706 /tmp/err
>   48995 total

The /tmp/out now looks fine, there is a single line difference, that is
the empty newline at the start of the file I asked to remove.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
