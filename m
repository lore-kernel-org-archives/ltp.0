Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEECEFB815
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 08:27:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4E663D0F71
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 09:27:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFC883CB958
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:27:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D5E621400B93
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:27:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F0D03F107;
 Tue, 24 Feb 2026 08:27:03 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 106D63EA6E;
 Tue, 24 Feb 2026 08:27:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QGk2AddgnWngQAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 24 Feb 2026 08:27:03 +0000
Date: Tue, 24 Feb 2026 09:27:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260224082701.GA28159@pevik>
References: <20260224-kirk_4-v1-1-6f706363fc4d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260224-kirk_4-v1-1-6f706363fc4d@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 5F0D03F107
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kirk: version 4.0.0
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

IMHO safe to update, just let's Li to ack it.

Kind regards,
Petr

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> - Remove --env option
> - pyproject: include sub-packages in pip package
> - libkirk: Print /proc/cmdline
> - ui: simplify repor
> - many bugs fixes and code optimizations

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Link: https://github.com/linux-test-project/kirk/releases/tag/v4.0.0
> ---
>  tools/kirk/kirk-src | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/tools/kirk/kirk-src b/tools/kirk/kirk-src
> index 6ac2644e6e469b7bc7ddf35a6b10bf1994ca0929..6b0f87c6df90b87a8c32648c94169a83b4e58024 160000
> --- a/tools/kirk/kirk-src
> +++ b/tools/kirk/kirk-src
> @@ -1 +1 @@
> -Subproject commit 6ac2644e6e469b7bc7ddf35a6b10bf1994ca0929
> +Subproject commit 6b0f87c6df90b87a8c32648c94169a83b4e58024

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
