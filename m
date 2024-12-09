Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A88E77173
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 04:43:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21E793E7981
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 05:43:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D4833E6229
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 05:43:27 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9537E22A50A
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 05:43:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E0A221161;
 Mon,  9 Dec 2024 04:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733719400;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+oRqs1RsRbSeOzuEDl8nwYuM0t+wvY8dBNegNZ/Uxrw=;
 b=kSmMKN9xJb9l+5VZ169cIYS77+bTlqRXTGzBKsznPKsQeQ9eNcyVMwd+tONeLMYHKcI1jU
 2uxVaHBZia7TnawNFc58S+hhXwJr8wdbItu7Sx3RLYqBtyRFA/Lmb6GJ/7YPR38uXHWm/L
 LAWDGNB7z4viQCokfhBOf2E6L1uOZis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733719400;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+oRqs1RsRbSeOzuEDl8nwYuM0t+wvY8dBNegNZ/Uxrw=;
 b=nM5LgPUFjekVL+SzOjJTYxzUu1P2nPvMW36bSk9HgDm1jElCz6VRP5KwusSZHXBgQIxFxp
 OtCTnb8o2IatVoBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733719399;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+oRqs1RsRbSeOzuEDl8nwYuM0t+wvY8dBNegNZ/Uxrw=;
 b=05nq5o0OYmRShvd+PWITcf6sDNxO3IdZL33g9YENaL2/DId/DZZP24SkoV2d56uHxRZ7E8
 /4Sdru9+46PBwIhNuUAp0DaBskspgSzNQbLgOp3as4ltcO+/Qal+2anAvKOtg5JabjWE/J
 ux+Mpv7neIuy3wcbCFkFGdRDpObfi0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733719399;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+oRqs1RsRbSeOzuEDl8nwYuM0t+wvY8dBNegNZ/Uxrw=;
 b=/hfpsL8Ej/iCg2NmbdYDzl3yDtb0xKRuPid1GuUwYB3kBbKFKxSpdeAib2wUng/K3kzXU8
 Ppa16PP3I1T+weAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60A2D138A5;
 Mon,  9 Dec 2024 04:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /+CCFmd1Vme+UgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Dec 2024 04:43:19 +0000
Date: Mon, 9 Dec 2024 05:43:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20241209044318.GA180329@pevik>
References: <20241207085754.159597-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241207085754.159597-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Patch V2] lib: multiply the max_runtime if detect kernel
 debug options
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

Hi Li, Cyril,

> The method adjusts the max_runtime for test cases by multiplying
> it by a factor (4x) if any debug kernel options are detected.
> Debug kernel configurations (such as CONFIG_KASAN, CONFIG_PROVE_LOCKING, etc.)
> are known to degrade performance, and this adjustment ensures
> that tests do not fail prematurely due to timeouts.

> As Cyril pointed out that a debug kernel will typically run
> slower by a factor of N, and while determining the exact value
> of N is challenging, so a reasonable upper bound is sufficient
> for practical purposes.

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---

> Notes:
>     Hi, @Cyril, @Petr, I have no openSUSE and Ubuntu at my hands, could you
>     help check if the debug configures are useful to the other two platforms?
>     Or, should we add any more options there? Thanks.

openSUSE debug kernel:

$ grep ^CONFIG_DEBUG /boot/config-6.13.0-rc1-1.g492f944-debug # openSUSE Tumbleweed
CONFIG_DEBUG_RSEQ=y
CONFIG_DEBUG_GPIO=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_DWARF5=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
CONFIG_DEBUG_NET=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_SHIRQ=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y

=> openSUSE debug kernel would be detected by:
CONFIG_DEBUG_NET=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y

=> if you want to add more:
CONFIG_DEBUG_RSEQ=y
CONFIG_DEBUG_GPIO=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_SHIRQ=y

Also FYI some options from default kernel (to see which cannot be used):

$ grep ^CONFIG_DEBUG /boot/config-6.13.0-rc1-1.g492f944-default # openSUSE
Tumbleweed
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_DWARF5=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_MEMORY_INIT=y

$ grep ^CONFIG_DEBUG /boot/config-6.11.10-amd64 # Debian
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
CONFIG_DEBUG_WX=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_LIST=y

Do Debian/Ubuntu even have debug kernel? I know only about linux-image-amd64-dbg
[1], but that package has just debugging symbols.

Which tests should I run on the kernel to see if timeout is ok?

Kind regards,
Petr

[1] https://packages.debian.org/sid/linux-image-amd64-dbg

...
> +/*
> + * List of debug-kernel config options that may degrade performance when enabled.
> + */
> +static const char * const tst_kconf_debug_options[][2] = {
> +	{"CONFIG_PROVE_LOCKING=y", NULL},
> +	{"CONFIG_LOCKDEP=y", NULL},
> +	{"CONFIG_DEBUG_SPINLOCK=y", NULL},
> +	{"CONFIG_DEBUG_RT_MUTEXES=y", NULL},
> +	{"CONFIG_DEBUG_MUTEXES=y", NULL},
> +	{"CONFIG_DEBUG_PAGEALLOC=y", NULL},
> +	{"CONFIG_KASAN=y", NULL},
> +	{"CONFIG_SLUB_RCU_DEBUG=y", NULL},
> +	{"CONFIG_TRACE_IRQFLAGS=y", NULL},
> +	{"CONFIG_LATENCYTOP=y", NULL},
> +	{"CONFIG_DEBUG_NET=y", NULL},
> +	{"CONFIG_EXT4_DEBUG=y", NULL},
> +	{"CONFIG_QUOTA_DEBUG=y", NULL},
> +	{"CONFIG_FAULT_INJECTION=y", NULL},
> +	{"CONFIG_DEBUG_OBJECTS=y", NULL},
> +	{NULL, NULL}
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
