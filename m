Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FA0C46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 14:25:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CDA53CEE69
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 15:25:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB9BF3C1D32
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 15:25:35 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CCDBF10009A6
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 15:25:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 121BC1FD65;
 Wed, 24 Jan 2024 14:25:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C0771333E;
 Wed, 24 Jan 2024 14:25:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nm1PId0dsWWOWQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 14:25:33 +0000
Date: Wed, 24 Jan 2024 15:25:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240124142531.GA304067@pevik>
References: <20240124125813.6611-1-chrubis@suse.cz>
 <20240124141625.GC299755@pevik> <ZbEc3IMfG1d_bm4t@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZbEc3IMfG1d_bm4t@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 121BC1FD65
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_fd: Avoid tst_brk(TCONF,
 ...) on older distros
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Actually at least here tst_syscall() needs to be called or it fails on older
> > distros due missing ENOSYS check in raw syscall():

> Ah, no we have to handle the ENOSYS ourselves as we do in the other
> cases. Sorry for not realizing that.

> We likely need just:

Yes, I also realized that when I double check your commit message.

Kind regards,
Petr

> diff --git a/lib/tst_fd.c b/lib/tst_fd.c
> index ab7de81aa..8b26ff8e5 100644
> --- a/lib/tst_fd.c
> +++ b/lib/tst_fd.c
> @@ -141,7 +141,7 @@ static void open_pidfd(struct tst_fd *fd)
>  {
>         fd->fd = syscall(__NR_pidfd_open, getpid(), 0);
>         if (fd->fd < 0)
> -               tst_brk(TBROK | TERRNO, "pidfd_open()");
> +               tst_res(TCONF | TERRNO, "pidfd_open()");
>  }


> The tst_sycall() can't be called there at all _because_ it calls
> tst_brk() itself.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
