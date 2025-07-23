Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CB8C83F1A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:03:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76ECE3CCD81
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 16:03:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EE4D3C1CEA
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:02:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B118260084A
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:02:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D0EE1F78E;
 Wed, 23 Jul 2025 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753279365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QGwGEigfFrJB4DbsoBRfvIOR0twPYlEssMKw11F+ygo=;
 b=T7mhhnZiFrCCjNL01nPMeU2U8gdjCue3OTdnEkOi7cFS62tE1FgcVzZwry2CfgsRxKZEOD
 p7rJn06UfXJBdiO6hJ+J4Aia7vwRJ4AwKhQlfSNyjR1Ni/ZjSm5sVVDQG+fprqxXofSfKi
 HUqC0q6/6XdbmQzHzJuMNeI3Cx1TTvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753279365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QGwGEigfFrJB4DbsoBRfvIOR0twPYlEssMKw11F+ygo=;
 b=Zjx2Ly6jyGIt7t3tizTPx6vaBH9kOMX4spsXNjNKyLiLna8m6EwRhpbSFE03dsNauv5zCl
 eyqt+6FnFbMVJkDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T7mhhnZi;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Zjx2Ly6j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753279365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QGwGEigfFrJB4DbsoBRfvIOR0twPYlEssMKw11F+ygo=;
 b=T7mhhnZiFrCCjNL01nPMeU2U8gdjCue3OTdnEkOi7cFS62tE1FgcVzZwry2CfgsRxKZEOD
 p7rJn06UfXJBdiO6hJ+J4Aia7vwRJ4AwKhQlfSNyjR1Ni/ZjSm5sVVDQG+fprqxXofSfKi
 HUqC0q6/6XdbmQzHzJuMNeI3Cx1TTvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753279365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QGwGEigfFrJB4DbsoBRfvIOR0twPYlEssMKw11F+ygo=;
 b=Zjx2Ly6jyGIt7t3tizTPx6vaBH9kOMX4spsXNjNKyLiLna8m6EwRhpbSFE03dsNauv5zCl
 eyqt+6FnFbMVJkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60C1013ABE;
 Wed, 23 Jul 2025 14:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J5FvFoXrgGjEKwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 23 Jul 2025 14:02:45 +0000
Date: Wed, 23 Jul 2025 16:03:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aIDrsQ4XqEGpvq6v@yuki.lan>
References: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
 <20250707-ioctl_pidfd_suite-v3-8-22ba4d15ee02@suse.com>
 <aIDe4n_4kTZE9feR@yuki.lan>
 <e22bb254-b97c-4866-900c-126d7f06ffd8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e22bb254-b97c-4866-900c-126d7f06ffd8@suse.com>
X-Rspamd-Queue-Id: 7D0EE1F78E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 8/8] Add ioctl_pidfd06 test
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c =

> b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> index df4bec384..66b96a29c 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> @@ -44,6 +44,10 @@ static void run(void)
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 TST_EXP_FAIL(ioctl(pidfd, =
PIDFD_GET_INFO, info), ESRCH);
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit(0);
>  =A0=A0=A0=A0=A0=A0=A0 }
> +
> +=A0=A0=A0=A0=A0=A0 tst_reap_children();

Don't we wait() for the children in the test?

> +=A0=A0=A0=A0=A0=A0 SAFE_CLOSE(pidfd);

Otherwise yes, we need to close the pidfd at the end of the iteration.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
