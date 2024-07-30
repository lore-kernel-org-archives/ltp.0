Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754D1C3DA61
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 07:42:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BB533D1D81
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 09:42:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D940C3D0B1D
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 09:41:50 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C23541000EA0
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 09:41:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9E4E21B66;
 Tue, 30 Jul 2024 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722325308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/1/SHwLI+kEQY86Gz5+sJc6Pxqzpot5ff8KXMxQWHKI=;
 b=0wr1DLSxvPFT8OIel4IB51hbH/i54HzRPmGNUShwpJSlZbxy8repfy8q2ieOyCft1qb8Of
 /aqRCssgP/+IwYRmY3M0Omow3QghcBnPcPmMFzdBPuDTNV/uiQulBMxOIUlqDcMvO7tiJf
 71+3IpYzhArjAV2tLqkj/2hjAmPc9e8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722325308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/1/SHwLI+kEQY86Gz5+sJc6Pxqzpot5ff8KXMxQWHKI=;
 b=3ymssX3OOP9dOYSv3KuviYHaHE80YRcvpo9s/MsXnp1trAiroQyCFYcZ5BYyWPLQWyJazQ
 f8YM+X7H40yAKQBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722325307;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/1/SHwLI+kEQY86Gz5+sJc6Pxqzpot5ff8KXMxQWHKI=;
 b=vceH9Ernjl7bJtae9IYzrS7sOldL9hwZqy0J+FxY5Zg3W3WC1Sj668MYsWxMcM4AV5OE0i
 rLHo9JG0C3im+swM0LzL8QrE9+3fpLoIk6CFoQbBhgoboD1Xazhg09uNRI9PsB/XewKc5W
 EuZp0w/9oUYu2uZwZgE+f8v/TCHYLYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722325307;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/1/SHwLI+kEQY86Gz5+sJc6Pxqzpot5ff8KXMxQWHKI=;
 b=OuShKAoWPpXz/NhUmLmX9NO7V8FiN2HsmldtP4ClJaDkmiDeDmOCvkQenzeEumJV1NTJox
 k/F9pbN8pqpq96Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D22E413983;
 Tue, 30 Jul 2024 07:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9Y52MjuZqGYJcwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jul 2024 07:41:47 +0000
Date: Tue, 30 Jul 2024 09:41:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240730074147.GB1327610@pevik>
References: <20240426120051.21806-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240426120051.21806-1-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] doc: update more syscalls stats
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

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> Some more syscalls are already tested in LTP, but they are part of
> different testing suites. For example, seccomp() is tested in prctl()
> testing suite. Some other syscalls need to be blacklisted, since they
> are part of MIPS or internal kernel usage.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  doc/conf.py | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/doc/conf.py b/doc/conf.py
> index d0f185b28..b54e0e60d 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -83,6 +83,8 @@ def generate_syscalls_stats(_):
>          'getpmsg',
>          'putmsg',
>          'putpmsg',
> +        'seccomp',
> +        'semtimedop',
I guess there are more to add, right?
At least cachestat and landlock.
Could you please add them before you merge?

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Also it'd be nice to have the lists sorted.

Kind regards,
Petr

>      ]

>      # populate with not implemented, reserved, unmaintained syscalls defined
> @@ -101,6 +103,8 @@ def generate_syscalls_stats(_):
>          'sysmips',
>          'mq_getsetattr',
>          'vserver',
> +        'cachectl',
> +        'restart_syscall',
>      ]

>      # fetch syscalls file

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
