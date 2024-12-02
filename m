Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3187D7832E
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 15:15:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34AE03DD564
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 16:15:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 866433DD556
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 16:15:28 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2C4961417869
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 16:15:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C7B321172;
 Mon,  2 Dec 2024 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733152524;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFv4xHdPm8tRn48fZbZGLALL5qg3s1WUUjExP8N6Oyg=;
 b=BUcvhQzO2WpMVZYYo03LECYhWNs6XWJKm5BrXI+azEu2ORG1nGOOyq+9HKG1Gn9kwDPdpU
 rv6niZZwqrGzlOp+Rk88M9geFKVZxhHPUkkaR4l2NUj7paAW9BkuGkqasq/5nIDpen2KmM
 nHU+jFiE3hM43AU51qJB2cU5ikEudVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733152524;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFv4xHdPm8tRn48fZbZGLALL5qg3s1WUUjExP8N6Oyg=;
 b=wrZuOfFV2JY3pVCvb54HD5jouieLpg7JX97Q/GDDPsWTO+3oY7P1tfIwGKGFDufQGdlKYk
 X92NtZEjLj2JB8BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733152523;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFv4xHdPm8tRn48fZbZGLALL5qg3s1WUUjExP8N6Oyg=;
 b=i4VOG1IBzsVVjCgptMCEYYbas2enbXppiaT9HRjCMhnX/WaeQAbY1u5bekr8DCRFp7ddA2
 oHIhiBQhLOGJHEnrkEmu/STGtrsNObRQi1wt5QcV0R3Bl+kpn3W4tyhkkVU2Nk1A+KGbup
 r5d+eQtKJcBZ9Vi3fLOCjRQsQ39uClQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733152523;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFv4xHdPm8tRn48fZbZGLALL5qg3s1WUUjExP8N6Oyg=;
 b=wEI8UlL+kpS+jD0ziW7Fdyuy4w5SOMuuTcwCIXlwaQe79GeRMOD/dwiDUXmXOHhCvzloHu
 BkIsQih7e2e2kWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54DF2139C2;
 Mon,  2 Dec 2024 15:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Aq+8EgvPTWeaLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 02 Dec 2024 15:15:23 +0000
Date: Mon, 2 Dec 2024 16:15:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241202151521.GC321427@pevik>
References: <20241202-input_refactoring-v2-0-369609492896@suse.com>
 <20241202-input_refactoring-v2-1-369609492896@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241202-input_refactoring-v2-1-369609492896@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] Refactor input01 test
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

Hi Andrea,

I would mention adding a check of the device name in /sys/devices
create_input_device(), because that modifies also a different test
(../uevents/uevent03.c).

> ---
>  libs/uinput/tst_uinput.c              |  26 ++++-
>  testcases/kernel/input/Makefile       |   5 +-
>  testcases/kernel/input/input01.c      | 205 ++++++++--------------------------
>  testcases/kernel/input/input_common.h |  97 ++++++++++++++++
>  4 files changed, 173 insertions(+), 160 deletions(-)

...
> +static void check_ui_get_sysname_ioctl(int fd)
> +{
> +	char sys_name[256];
> +	char dev_name[256];
> +	char *path;
> +
> +	SAFE_IOCTL(fd, UI_GET_SYSNAME(sizeof(sys_name)), sys_name, NULL);
> +	SAFE_ASPRINTF(&path, "/sys/devices/virtual/input/%s/name", sys_name);
> +
> +	if (FILE_SCANF(path, "%s", dev_name)) {
> +		tst_brk(TBROK|TERRNO, "Failed to read '%s'", path);
> +		free(path);
I guess free(path) here is not needed due exit() via tst_brk() right?
And if it's needed, you meant to first free and then tst_brk().

> +		return;
> +	}
> +
> +	if (strcmp(VIRTUAL_DEVICE, dev_name))
And if I'm wrong, then free(path) should be also here.
> +		tst_brk(TBROK, "ioctl UI_GET_SYSNAME returned wrong name");

The rest LGTM, nice cleanup (free can be fixed before merge).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
