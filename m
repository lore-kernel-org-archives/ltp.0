Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FC3C5B572
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 13:19:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24A883E760C
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 15:19:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D60613DAD38
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:19:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 891EB600742
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:19:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B4FAC3E69;
 Wed, 12 Aug 2026 13:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786540772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vjUOY79JLlwc+WX5TdvBtIHhDtMe9Sc1KxVt4NVOxc4=;
 b=sbiMzycEp09M92aGyobY4oXScKIpezgX6R2cSpN9b86ULZEydSssnuUF90O5JAEMX0/XsP
 OrqY0ShbnHwNw5+b6CX4HOMnUoZQf40gju+cbx34ERRY+rEHxAmz0tZN36BecxYHUEZwMu
 WgokuWp/Bacw28W8E+5moG6z/KvDVdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786540772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vjUOY79JLlwc+WX5TdvBtIHhDtMe9Sc1KxVt4NVOxc4=;
 b=fUMcgWdeKrmHnx/E8hfIVVkCHF8ACyFjyqiBoKCCyt5x0YoTGU4/PRaL08s7NS3vni8Qjy
 UcyGLY2fD86iV7Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786540768;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vjUOY79JLlwc+WX5TdvBtIHhDtMe9Sc1KxVt4NVOxc4=;
 b=3CFfn1HwSOqLaqrpKiLPKnoJn+Se9pkOfc0WfUAX7rbKXAZvWjNhZm2w6kIQ0s3pd2FAX9
 v1PfX+qwcsTMbmJrQjJUXg66rT0SuOXa+3G+WEIzZc6qoNxi9Njv3TbXWZVnn3spAMlwKA
 munb+lkHO0ewY3rg/GKJx34LvpnMIhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786540768;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vjUOY79JLlwc+WX5TdvBtIHhDtMe9Sc1KxVt4NVOxc4=;
 b=RyzoXrGkbmANHkEDILf3R4OvGNeMzyc2LkGI28BI+jKz435oCePEiCbAG26jPN9GGrG5c1
 qji1mOfN2D9f3gBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78876779B2;
 Wed, 12 Aug 2026 13:19:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MUkwHOByfGrwWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Aug 2026 13:19:28 +0000
Date: Wed, 12 Aug 2026 15:19:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260812131927.GE1758016@pevik>
References: <20260807110541.8702-1-linuxtestproject.agent@gmail.com>
 <20260807234935.3248935-1-wakel@google.com>
 <c41e20c9-86c2-43ae-8264-04434ee54f62@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c41e20c9-86c2-43ae-8264-04434ee54f62@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] lib: Use backoff polling to wait for loop
 device nodes
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> d90d2004657b ("lib: Use backoff polling to wait for loop
>   device nodes")

> This patch introduces a regression in few old API based tests which
> call tst_acquire_device() -> tst_find_free_loopdev()/tst_attach_device()):

>     - linkat02
>     - mknodat02
>     - rename11
>     - renameat01
>     - umount2_01

> these fail with
> tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
> linkat02    1  TBROK  :  tst_sig.c:232: unexpected signal SIGCHLD(17)
> received (pid = 122504).
> linkat02    2  TBROK  :  Remaining cases broken

> which comes from def_handler(int sig) in lib/tst_sig.c

> The old API treats SIGCHLD as fatal, which is now being generated while
> reading the kconfig file. So we need to address this until we convert
> these tests to new API, maybe by intentionally avoiding
> TST_RETRY_FN_EXP_BACKOFF()/tst_multiply_timeout() for now.

Avinesh, thanks for the report.

I vote to revert d90d2004657b until we convert the tests above.
Anybody objects?

If you reply ack, I can revert it later tonight/tomorrow morning (UTC timezone)
and add your ABT to the commit.

Kind regards,
Petr

> Regards,
> Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
