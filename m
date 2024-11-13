Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EB1D41C33
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 11:30:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B7053D65FF
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 12:30:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 138723D6322
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 12:29:47 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D1D714001E6
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 12:29:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 962B7211A6;
 Wed, 13 Nov 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B91D13301;
 Wed, 13 Nov 2024 11:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bGfQIaeNNGfxXAAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 13 Nov 2024 11:29:43 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 13 Nov 2024 12:29:43 +0100
Message-ID: <6126477.lOV4Wx5bFT@thinkpad>
In-Reply-To: <20241113105925.295697-1-pvorel@suse.cz>
References: <20241113105925.295697-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 962B7211A6
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] select03: Fix false positive on TCONF
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
Cc: Dominique Leuenberger <dleuenberger@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Wednesday, November 13, 2024 11:59:25 AM CET Petr Vorel wrote:
> This fixes error on unsupported __NR__newselect:
> select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported on your arch
> select03.c:90: TFAIL: Child exited with 32
> 
> Fixes: ffdd3b36cd ("syscalls: Add missing exit status check")
> Reported-by: Dominique Leuenberger <dleuenberger@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Avinesh Kumar <akumar@suse.de>


> ---
> Alternatively, we could revert to previous state (remove
> "!WEXITSTATUS(status)" check), if we really don't care about any other
> exit code.
> 
> Kind regards,
> Petr
> 
>  testcases/kernel/syscalls/select/select03.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
> index 216b22104f..34aea12603 100644
> --- a/testcases/kernel/syscalls/select/select03.c
> +++ b/testcases/kernel/syscalls/select/select03.c
> @@ -77,8 +77,10 @@ static void run(unsigned int n)
>  
>  	SAFE_WAITPID(pid, &status, 0);
>  
> -	if (WIFEXITED(status) && !WEXITSTATUS(status))
> +	if (WIFEXITED(status) &&
> +		(WEXITSTATUS(status) == 0 || WEXITSTATUS(status) == TCONF)) {
>  		return;
> +	}
>  
>  	if (tst_variant == GLIBC_SELECT_VARIANT &&
>  	    tests[n].timeout == &invalid_to &&
> 

Thanks,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
