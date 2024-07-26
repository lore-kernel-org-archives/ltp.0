Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18127C3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 06:52:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51A3A3D1C11
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 08:52:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 457333CF6B9
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 08:52:11 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 829F3100608D
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 08:52:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C55E21B8A;
 Fri, 26 Jul 2024 06:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721976729;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8jZIrEMINHfSqOF+vyYESzJ7w6xtiS+7exz7llHEjM4=;
 b=W8QRJOgIJnu1J0PmF1mvi5E7SRF2M5yXspgSIiANdcGmcADHgOm0DDnfkUxay0oBHqQls2
 QTxGvPcJ+srrnzSHT2RHrJSoJAwLfZGP1ERIkT9/AhwMLo7guXtRywSg0pxGl9DAXrd/LD
 OJfQIWFqdP58Oqw9YmFuRMkxbv40ZRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721976729;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8jZIrEMINHfSqOF+vyYESzJ7w6xtiS+7exz7llHEjM4=;
 b=eyZvNn21iSZlpDroA93Jqs1BpaRHOJIkvAYGOMIoj6Xs9KiXRQJuFWEKODLEy51El6lsgk
 LglaqL/sis4fFXCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721976728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8jZIrEMINHfSqOF+vyYESzJ7w6xtiS+7exz7llHEjM4=;
 b=viB49KO+bYl81McVfGSb7WogBYshlnOcRSG0+47560W+cprO0+UN7zfndaDH/QcVVjUSCJ
 qwjIiW+EPX2TesfOyB8Qpfb6whD1fr3m6kLYFALx9cJZRpp+FJi87oZ2tIGxiyaypu54Jl
 SZpJnjIrvfFOVDDs2pQBBnx9C8DAs5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721976728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8jZIrEMINHfSqOF+vyYESzJ7w6xtiS+7exz7llHEjM4=;
 b=rEzrkEy1hbJXw6Hb+U3wbfNNENRX+bzDWHu6XYpm6+V63Q9jCyKrmmyg4TLfvBq0NF9Nqo
 scmqUjHfnMJ7fhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3FF4138A7;
 Fri, 26 Jul 2024 06:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qm/uNpdHo2aXFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 06:52:07 +0000
Date: Fri, 26 Jul 2024 08:52:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240726065205.GA1017966@pevik>
References: <20240726024447.134802-1-liwang@redhat.com>
 <b8c4a02f-d108-42d0-8da1-aa4000f789bd@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b8c4a02f-d108-42d0-8da1-aa4000f789bd@suse.com>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cachestat: remove .min_kver from cachestat tests
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
Cc: Stephen Bertram <sbertram@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Andrea,

> Hi!

> On 7/26/24 04:44, Li Wang wrote:
> > Removing the kernel version check (.min_kver) from the cachestat
> > tests to allow the test to run on distributions that backport the
> > cachestat syscall.

> > With no support just skip as TCONF:
> >    ../../../../include/lapi/mman.h:40: TCONF: syscall(451) __NR_cachestat not supported on your arch

+1. Just for sure, tested on 6.4 based SLES 15-SP6 and it works as expected (TCONF)

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Maybe we should document, that ideally we should try to avoid .min_kver unless
really needed. It's also kind of a documentation, but kernel version can be
specified in metadata documentation.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
