Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A508C02194
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 10:53:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EEE53C91E2
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 11:53:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 811B43C91DE
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 11:53:32 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2EA28231D3A
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 11:53:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75BC81F45E;
 Wed,  5 Feb 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6920E139D8;
 Wed,  5 Feb 2025 10:53:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uIoUGSpDo2e8SQAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 05 Feb 2025 10:53:30 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 05 Feb 2025 11:53:30 +0100
Message-ID: <8511918.T7Z3S40VBb@thinkpad>
In-Reply-To: <20250205101938.25689-1-mdoucha@suse.cz>
References: <20250205101938.25689-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 75BC81F45E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] flock07: Initialiaze the sigaction structure
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On Wednesday, February 5, 2025 11:19:36 AM CET Martin Doucha wrote:
> The sigaction structure for child SIGUSR1 handler was uninitialized,
> which sometimes resulted in SA_RESTART flag being enabled by accident
> and the child flock() call never returning. Make sure the sigaction
> structure is properly initialized.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

Reviewed-by: Avinesh Kumar <akumar@suse.de>

Thanks,
Avinesh
> ---
>  testcases/kernel/syscalls/flock/flock07.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/flock/flock07.c b/testcases/kernel/syscalls/flock/flock07.c
> index 652fe3777..368147370 100644
> --- a/testcases/kernel/syscalls/flock/flock07.c
> +++ b/testcases/kernel/syscalls/flock/flock07.c
> @@ -42,7 +42,7 @@ static void cleanup(void)
>  
>  static void child_do(int fd)
>  {
> -	struct sigaction sa;
> +	struct sigaction sa = {};
>  
>  	sa.sa_handler = handler;
>  	SAFE_SIGEMPTYSET(&sa.sa_mask);
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
