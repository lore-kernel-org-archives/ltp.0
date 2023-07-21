Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B40DEB64DC
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 12:29:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 297DE3CDC7F
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 14:29:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 060F33C941F
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 14:29:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4560E1400253
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 14:29:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 337B21F8BE;
 Fri, 21 Jul 2023 12:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689942548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5HKu4pbGb1hYl3WRk5cHhGkwqIF+98osCwvu9pUetAo=;
 b=a9bCBdSIaBGBlSTJ0zyUnZGri3irS+fc7aJ//ZxWeoUH8H1WF0awEAiqZnHA2wWVeVaU2n
 9/1H9IAl0e57aLCdFx9uEWvySvDOdCEBjSxX9KAoGR959QqYsX4UP3CR30W0OZa4DIoq4j
 177fN5JcBnuD6ZH5AjW/uUS+kjcQmNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689942548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5HKu4pbGb1hYl3WRk5cHhGkwqIF+98osCwvu9pUetAo=;
 b=PyhMkOvt9u8lHPQ8EJCFQO0eqbDG+6MjP6ElhKJQAVU/JmeGm3QFW7enWYD8hpYng/c6SB
 AVj1eXzwCKGaZECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE225134BA;
 Fri, 21 Jul 2023 12:29:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8X06IRN6umT4TQAAMHmgww
 (envelope-from <akumar@suse.de>); Fri, 21 Jul 2023 12:29:07 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Jul 2023 17:59:05 +0530
Message-ID: <4864592.31r3eYUQgx@localhost>
Organization: SUSE
In-Reply-To: <20230721100330.1366932-1-pvorel@suse.cz>
References: <20230721100330.1366932-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] write05: Simplify test using TST_ macros
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

Hi Petr,

On Friday, July 21, 2023 3:33:30 PM IST Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/write/write05.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/write/write05.c
> b/testcases/kernel/syscalls/write/write05.c index c1e48f1df..1e85cce6d
> 100644
> --- a/testcases/kernel/syscalls/write/write05.c
> +++ b/testcases/kernel/syscalls/write/write05.c
> @@ -59,26 +59,12 @@ static void verify_write(unsigned int i)
> 
>  	sigpipe_cnt = 0;
> 
> -	TEST(write(*tc->fd, *tc->buf, tc->size));
> -
> -	if (TST_RET != -1) {
> -		tst_res(TFAIL, "write() succeeded unexpectedly");
> -		return;
> -	}
> -
> -	if (TST_ERR != tc->exp_errno) {
> -		tst_res(TFAIL | TTERRNO,
> -			"write() failed unexpectedly, expected %s",
> -			tst_strerrno(tc->exp_errno));
> +	TST_EXP_FAIL(write(*tc->fd, *tc->buf, tc->size), tc->exp_errno);
Should we use TST_EXP_FAIL2 instead?

Maybe we can also do the ascii doc changes and headers cleanup, but I'm fine if 
we do that in a separate patch.

Reviewed-by: Avinesh Kumar <akumar@suse.de>


Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
