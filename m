Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E08C02181
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 12:46:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 197F63C56B1
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 13:46:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B202D3C55B3
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 13:45:57 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B8DF061D997
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 13:45:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 336F11F444;
 Fri, 24 Jan 2025 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737722755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uJ0AtCJpZnYtAVoa9MXT9Z2i/DDRIqLxsQNaALtYaMw=;
 b=A2WGJ5s5tBgw5zekluG5NtqwJsIemEhU2degmXlH2DvPSyoBiKW0Dko+Hw0VMjB8+PDxvO
 RHmRKKWckUOJODssZg7OoHSJ7hf7TMEWM2KtRZ0zIRxklzoYw4RehMAAOKLAwIV77EDbrn
 qA6tpIiqpjftJXrwgP7h4HeysQdATdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737722755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uJ0AtCJpZnYtAVoa9MXT9Z2i/DDRIqLxsQNaALtYaMw=;
 b=ghms3v55CzNcGCQQKvi9s9zK+Ac8jmUUeTFkEcQFQPcvVuFf6vhECqjF8mWPk5a1yVRw+h
 IjOGcaTYycavWlBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737722755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uJ0AtCJpZnYtAVoa9MXT9Z2i/DDRIqLxsQNaALtYaMw=;
 b=A2WGJ5s5tBgw5zekluG5NtqwJsIemEhU2degmXlH2DvPSyoBiKW0Dko+Hw0VMjB8+PDxvO
 RHmRKKWckUOJODssZg7OoHSJ7hf7TMEWM2KtRZ0zIRxklzoYw4RehMAAOKLAwIV77EDbrn
 qA6tpIiqpjftJXrwgP7h4HeysQdATdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737722755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uJ0AtCJpZnYtAVoa9MXT9Z2i/DDRIqLxsQNaALtYaMw=;
 b=ghms3v55CzNcGCQQKvi9s9zK+Ac8jmUUeTFkEcQFQPcvVuFf6vhECqjF8mWPk5a1yVRw+h
 IjOGcaTYycavWlBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E787813999;
 Fri, 24 Jan 2025 12:45:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P0iHNYKLk2fRPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Jan 2025 12:45:54 +0000
Date: Fri, 24 Jan 2025 13:45:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250124124549.GB198620@pevik>
References: <20250122172440.506677-1-amir73il@gmail.com>
 <20250122172440.506677-2-amir73il@gmail.com>
 <20250123171826.GA125552@pevik> <20250124101140.GE159953@pevik>
 <CAOQ4uxjntVZSfgAgu66VpHdZ=KsKc_moRG=3fxNEphh2w2Vhjw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjntVZSfgAgu66VpHdZ=KsKc_moRG=3fxNEphh2w2Vhjw@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-0.998];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fanotify13: Verify that we did not get an
 extra event
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

...
> > > Any hint what could be wrong?

> That would be the simplest fix:

> --- a/testcases/kernel/syscalls/fanotify/fanotify13.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
> @@ -48,7 +48,7 @@
>  #define FILE_ONE "file_one"
>  #define FILE_TWO "file_two"
>  #define MOUNT_PATH "tstmnt"
> -#define EVENT_MAX ARRAY_SIZE(objects)
> +#define EVENT_MAX (ARRAY_SIZE(objects)+1)

Indeed, that fixes the problem, thanks!

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
