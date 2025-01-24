Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F278C02181
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 08:01:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5C683C526E
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 09:01:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E87DE3C1372
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 09:01:32 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 134F16278C3
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 09:01:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7EAD1F38F;
 Fri, 24 Jan 2025 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737705690;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+9+91GyOfWYSpfw6eh4wpNtOVNxKZS5Hhb9Xynw0Tc=;
 b=IjB3I4WA82SjcBQkIQ9VO8knVF2PgCAU9671C9yZ9ON56zzkKtn/ALlrRaF47pw3W08enc
 8Xc+rvy7L4HGrCQIhfsJtaTSriPfKbPHIbOGR+OBZXkKACSX1j7KP/RP4xRuIupi6hW4bv
 j14IpTcTdX4EE/uDVKXjXgYun7NfmzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737705690;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+9+91GyOfWYSpfw6eh4wpNtOVNxKZS5Hhb9Xynw0Tc=;
 b=L0SIAl0eLyrQmlIlDYcVB42RH3um98BlGBiMPvnly4TN6qRk/caauimlhW334JD+1Z0Qc+
 31XjhXoV7drmI2AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IjB3I4WA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=L0SIAl0e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737705690;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+9+91GyOfWYSpfw6eh4wpNtOVNxKZS5Hhb9Xynw0Tc=;
 b=IjB3I4WA82SjcBQkIQ9VO8knVF2PgCAU9671C9yZ9ON56zzkKtn/ALlrRaF47pw3W08enc
 8Xc+rvy7L4HGrCQIhfsJtaTSriPfKbPHIbOGR+OBZXkKACSX1j7KP/RP4xRuIupi6hW4bv
 j14IpTcTdX4EE/uDVKXjXgYun7NfmzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737705690;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+9+91GyOfWYSpfw6eh4wpNtOVNxKZS5Hhb9Xynw0Tc=;
 b=L0SIAl0eLyrQmlIlDYcVB42RH3um98BlGBiMPvnly4TN6qRk/caauimlhW334JD+1Z0Qc+
 31XjhXoV7drmI2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CE5613999;
 Fri, 24 Jan 2025 08:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4TQXG9pIk2d7YwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Jan 2025 08:01:30 +0000
Date: Fri, 24 Jan 2025 09:01:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250124080121.GB159953@pevik>
References: <20250122172440.506677-1-amir73il@gmail.com>
 <20250122172440.506677-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250122172440.506677-5-amir73il@gmail.com>
X-Rspamd-Queue-Id: B7EAD1F38F
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] fanotify21: Test reporting event with RDWR fd
 on RO mount
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir, all,

> When event_f_flags request to open O_RDWR files for event->fd, the
> event listener should not get events with fd on a read-only mount.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM.

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify21.c     | 34 +++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
> index d54930f05..4324019fa 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify21.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
> @@ -21,6 +21,7 @@
>  #include <ctype.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <sys/mount.h>
>  #include "tst_test.h"
>  #include "tst_safe_stdio.h"
>  #include "tst_safe_macros.h"
> @@ -45,16 +46,25 @@ static struct test_case_t {
>  	char *name;
>  	int fork;
>  	int want_pidfd_err;
> +	int remount_ro;
>  } test_cases[] = {
>  	{
>  		"return a valid pidfd for event created by self",
>  		0,
>  		0,
> +		0,
nit: given how many parameters fanotify tests get over time I would use
designated initializers. I can do it after the release.


>  	},
>  	{
>  		"return invalid pidfd for event created by terminated child",
>  		1,
>  		FAN_NOPIDFD,
> +		0,
> +	},
> +	{
> +		"fail to open rw fd for event created on read-only mount",
> +		0,
> +		0,
> +		1,
>  	},
>  };

> @@ -122,7 +132,7 @@ static void do_setup(void)
>  	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_PIDFD,
>  						    TEST_FILE);

> -	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_REPORT_PIDFD, O_RDONLY);
> +	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_REPORT_PIDFD, O_RDWR);
>  	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD,
>  			   TEST_FILE);

> @@ -143,6 +153,16 @@ static void do_test(unsigned int num)

>  	tst_res(TINFO, "Test #%d: %s", num, tc->name);

> +	if (tc->remount_ro) {
> +		/* SAFE_MOUNT fails to remount FUSE */
> +		if (mount(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
> +			  MS_REMOUNT|MS_RDONLY, NULL) != 0) {
> +			tst_brk(TFAIL,
> +				"filesystem %s failed to remount readonly",
> +				tst_device->fs_type);
> +		}
> +	}
nit: I would join two if into single one.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
