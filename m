Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B88D25051
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 08:33:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A96F13C2DCF
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 09:33:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F7983C2C23
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 09:32:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B89F860005A
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 09:32:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E8E535BD61;
 Mon, 12 Jan 2026 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768206765;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZqxQi8KGgOgk4uasrlVhR3MPDFP/rubawQJd3YNXPJw=;
 b=oUMcjzqYenSeJpZPIe5I/UfAij1Oapodo1d50MoOG7y8Son0h5RGi8lQW5ZUfDZp5ZqTdQ
 Cf0HduSG3iBUdMjcMHAXs3k+1H44sDdGs+WcpKEJBNVfHIaH7Exa22FKudrm2+Bo1Ct4eS
 QZsrKBT5qi3IKyJND4GqczaRBRqgauc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768206765;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZqxQi8KGgOgk4uasrlVhR3MPDFP/rubawQJd3YNXPJw=;
 b=x1g7R/VN9m4f1gAgnCM4ztBeg8OZVEgcDtDRYuT4Do2u8lhX3jxl33dbjxX+VLXGoGeb7d
 Q1+ttBXTUhdBxIDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="EndZn/b9";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zSiNSaZ1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768206764;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZqxQi8KGgOgk4uasrlVhR3MPDFP/rubawQJd3YNXPJw=;
 b=EndZn/b9mqKXZ1sqzDQifRGjULxcrDmjWZMs5R7npgDTOY77XroMWiqrQmExLiunmS14rf
 LcyktBHflzaXYCypyLbZHQ0GbPwNWxLal3kJZvcs6GolzrrnRN9hXLa3aqmm6jb50yv3Wk
 hc95Dc8mINdgU/N0DjvlheYcyVMwgYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768206764;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZqxQi8KGgOgk4uasrlVhR3MPDFP/rubawQJd3YNXPJw=;
 b=zSiNSaZ1+M+YnsqiEhCaOEI4va0sNcIdhkO9QYeP7hry2F75j+mtlcojm8jHqfBiqTqRbu
 qP+r97jR0wkDznDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0C213EA66;
 Mon, 12 Jan 2026 08:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e0gFMqyxZGnMBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 12 Jan 2026 08:32:44 +0000
Date: Mon, 12 Jan 2026 09:32:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260112083238.GB203801@pevik>
References: <20260107111133.27041-1-chrubis@suse.cz>
 <20260107111133.27041-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260107111133.27041-2-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: E8E535BD61
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] doc: Document process_state
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

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/conf.py                    |  1 +
>  doc/developers/api_c_tests.rst |  5 ++++
>  include/tst_process_state.h    | 47 +++++++++++++++++++---------------
>  3 files changed, 33 insertions(+), 20 deletions(-)

> diff --git a/doc/conf.py b/doc/conf.py
> index b8ec1c31c..5d7362439 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -36,6 +36,7 @@ extlinks = {
>      'master': (f'{ltp_repo}/blob/master/%s', '%s'),
>      'shell_lib': (f'{ltp_repo}/blob/master/testcases/lib/%s', '%s'),
>      'git_man': ('https://git-scm.com/docs/git-%s', 'git %s'),
> +    'man1': ('https://man7.org/linux/man-pages/man1/%s.1.html', '%s(1)'),

I'm sorry, due today's improvement
https://github.com/linux-test-project/ltp/commit/de27451e837a6d17c8ebf1a55b5ade87223882f4
could you please drop doc/conf.py change because :man1: is not needed any more.

>      'man2': ('https://man7.org/linux/man-pages/man2/%s.2.html', '%s(2)'),
>      'man3': ('https://man7.org/linux/man-pages/man3/%s.3.html', '%s(3)'),
>      # TODO: allow 2nd parameter to show page description instead of plain URL
> diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
> index 2ca0f0464..13fc8651b 100644
> --- a/doc/developers/api_c_tests.rst
> +++ b/doc/developers/api_c_tests.rst
> @@ -43,6 +43,11 @@ Kernel
>  .. kernel-doc:: ../../include/tst_kernel.h
>  .. kernel-doc:: ../../include/tst_kvercmp.h

> +Process state
> +-------------
> +
> +.. kernel-doc:: ../../include/tst_process_state.h
> +
>  NUMA
>  ----
>  .. kernel-doc:: ../../include/tst_numa.h
> diff --git a/include/tst_process_state.h b/include/tst_process_state.h
> index b1d83e109..fd94ee207 100644
> --- a/include/tst_process_state.h
> +++ b/include/tst_process_state.h
> @@ -15,39 +15,46 @@

>  #ifdef TST_TEST_H__

> -/*
> - * Waits for process state change.
> +/**
> + * TST_PROCESS_STATE_WAIT() - Waits for a process state change.
> + *
> + * Polls `/proc/$PID/state` for a process state changes.
>   *
> - * The state is one of the following:
> + * @pid: A process pid.
> + * @state: A state to wait for.
> + * @msec_timeout: A timeout for the wait.
>   *
> - * R - process is running
> - * S - process is sleeping
> - * D - process sleeping uninterruptibly
> - * Z - zombie process
> - * T - process is traced
> + * Possible process states (see :man1:`ps`):

And this should be now :manpage:`ps(1)`.

Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
