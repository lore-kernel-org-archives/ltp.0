Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C14E7717F
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 23:35:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0A8A3E945D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 00:35:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CB5B3E93B6
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 00:35:01 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D1F2762094E
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 00:35:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4ADEB1F38C;
 Tue, 10 Dec 2024 23:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733873699;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VKyJzkDF48wko9vRM/A7/YGvyl12c9DI/+nNIqo1QFU=;
 b=AA5PICnhEEYCtuxeVnL5pSU0yCq5jnnkBu646mZhN8X7X9nNO3ryLGILXXVGYpBG7DEpnl
 idRg5oRCj++0LQQpBdhjZcFioISHhlHcU2+7k7yV1Pe1nPgFNttLBTEHax9yfAS0UiJHR/
 aKMX6g1eyP/zRAZNbV2CHOhbkUpYxTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733873699;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VKyJzkDF48wko9vRM/A7/YGvyl12c9DI/+nNIqo1QFU=;
 b=yQRvbbIg1FZX9dSTxoibhipj2nvdwt6JrlWxmgG64cHKJYAIYaDeH/efxjzxGzV6FKrp1a
 ucmny518057lBvAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733873699;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VKyJzkDF48wko9vRM/A7/YGvyl12c9DI/+nNIqo1QFU=;
 b=AA5PICnhEEYCtuxeVnL5pSU0yCq5jnnkBu646mZhN8X7X9nNO3ryLGILXXVGYpBG7DEpnl
 idRg5oRCj++0LQQpBdhjZcFioISHhlHcU2+7k7yV1Pe1nPgFNttLBTEHax9yfAS0UiJHR/
 aKMX6g1eyP/zRAZNbV2CHOhbkUpYxTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733873699;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VKyJzkDF48wko9vRM/A7/YGvyl12c9DI/+nNIqo1QFU=;
 b=yQRvbbIg1FZX9dSTxoibhipj2nvdwt6JrlWxmgG64cHKJYAIYaDeH/efxjzxGzV6FKrp1a
 ucmny518057lBvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D932138D2;
 Tue, 10 Dec 2024 23:34:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t0QICSPQWGfFMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Dec 2024 23:34:59 +0000
Date: Wed, 11 Dec 2024 00:34:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241210233453.GA386508@pevik>
References: <20241203151530.16882-1-chrubis@suse.cz>
 <20241203151530.16882-6-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241203151530.16882-6-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] mem/vma05.sh: Convert to the new shell library
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

Hi Cyril,

> +# env
> +# {
> +#  "needs_root": true,
> +#  "needs_tmpdir": true,
> +#  "needs_cmds": ["gdb"],
> +#  "save_restore": [
> +#   ["/proc/sys/kernel/core_pattern", "TBROK"],
> +#   ["/proc/sys/kernel/core_uses_pid", "TBROK"]
C API .save_restore has 3 members:

struct tst_path_val {
        const char *path;
        const char *val;
	unsigned int flags;
};

Why don't you use it here? (e.g. NULL).

Kind regards,
Petr

> +#  ],
> +#  "tags": [
> +#   ["linux-git", "103efcd9aac1"],
> +#   ["linux-git", "b6558c4a2378"],
> +#   ["linux-git", "e5b97dde514f"]
> +#  ]
> +# }
> +# ---

> -TST_SETUP=setup
> -TST_CLEANUP=cleanup
> -TST_TESTFUNC=vma_report_check
> -TST_NEEDS_ROOT=1
> -TST_NEEDS_TMPDIR=1
> -TST_NEEDS_CMDS="gdb"
> -
> -CORE_LIMIT=$(ulimit -c)
> -CORE_PATTERN=$(cat /proc/sys/kernel/core_pattern)
> -CORE_USES_PID=$(cat /proc/sys/kernel/core_uses_pid)
> -
> -setup()
> -{
> -	ulimit -c unlimited
> -	echo "core" > /proc/sys/kernel/core_pattern
> -	echo 0 > /proc/sys/kernel/core_uses_pid
> -	unset DEBUGINFOD_URLS
> -}
> +. tst_loader.sh

> -cleanup()
> -{
> -	ulimit -c "$CORE_LIMIT"
> -	echo "$CORE_PATTERN" > /proc/sys/kernel/core_pattern
> -	echo $CORE_USES_PID > /proc/sys/kernel/core_uses_pid
> -}
> +ulimit -c unlimited
> +echo "core" > /proc/sys/kernel/core_pattern
> +echo 0 > /proc/sys/kernel/core_uses_pid

> -vma_report_check()
> -{
> -	if [ $(uname -m) = "x86_64" ]; then
> -		if LINE=$(grep "vsyscall" /proc/self/maps); then
> -			RIGHT="ffffffffff600000-ffffffffff601000[[:space:]][r-]-xp"
> -			if echo "$LINE" | grep -q "$RIGHT"; then
> -				tst_res TPASS "[vsyscall] reported correctly"
> -			else
> -				tst_res TFAIL "[vsyscall] reporting wrong"
> -			fi
> +if [ $(uname -m) = "x86_64" ]; then
> +	if LINE=$(grep "vsyscall" /proc/self/maps); then
> +		RIGHT="ffffffffff600000-ffffffffff601000[[:space:]][r-]-xp"
> +		if echo "$LINE" | grep -q "$RIGHT"; then
> +			tst_res TPASS "[vsyscall] reported correctly"
> +		else
> +			tst_res TFAIL "[vsyscall] reporting wrong"
>  		fi
>  	fi
> +fi

> -	rm -rf core*
> -	{ vma05_vdso; } > /dev/null 2>&1
> -	[ -f core ] || tst_brk TBROK "missing core file"
> +rm -rf core*
> +{ vma05_vdso; } > /dev/null 2>&1
> +[ -f core ] || tst_brk TBROK "missing core file"

> -	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
> -		vma05_vdso ./core* 2> /dev/null)
> -	if echo "$TRACE" | grep -qF "??"; then
> -		tst_res TFAIL "[vdso] bug not patched"
> -	else
> -		tst_res TPASS "[vdso] backtrace complete"
> -	fi
> -}
> +TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
> +	vma05_vdso ./core* 2> /dev/null)

> -. tst_test.sh
> -tst_run
> +if echo "$TRACE" | grep -qF "??"; then
> +	tst_res TFAIL "[vdso] bug not patched"
> +else
> +	tst_res TPASS "[vdso] backtrace complete"
> +fi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
