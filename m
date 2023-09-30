Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C4DE77354
	for <ltp@archiver.kernel.org>; Sat, 30 Sep 2023 06:54:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83CD93CD77D
	for <ltp@archiver.kernel.org>; Sat, 30 Sep 2023 08:54:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2636C3CB9AD
 for <ltp@lists.linux.it>; Sat, 30 Sep 2023 08:54:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5601B600952
 for <ltp@lists.linux.it>; Sat, 30 Sep 2023 08:54:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDF911F8C0;
 Sat, 30 Sep 2023 06:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696056885;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QVBj3UmEOQizTHj48fj/NKBE2+FJqx0uL6tWm72+JA=;
 b=ZFhtj4vYz2GjD5eSwU21XnNYS3ZipswTiF+Ua+ivF9licHUadWsX3vlgFQFxNquyV8grYl
 IYd9fUXS3wrQR2Mx7Bml/yDMqf6vo5B8Wp/mUhZqPQGNBXpk50IRSrpgNRQeeStQpl9pbk
 Xgj4uzduLQmuiH6VNutJYogs2senCoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696056885;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QVBj3UmEOQizTHj48fj/NKBE2+FJqx0uL6tWm72+JA=;
 b=KE+b1cE92GV6jPjkkTMpGfBkf1QK/v7jSSITvbB2J4JamoUYbblRQluey3dF9xGqVgLmuh
 9mY/m8PVl22i5lDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AAFB13456;
 Sat, 30 Sep 2023 06:54:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id g3yeFzXGF2WvHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sat, 30 Sep 2023 06:54:45 +0000
Date: Sat, 30 Sep 2023 08:54:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20230930065443.GC414289@pevik>
References: <20230930000516.4063681-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230930000516.4063681-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getpgid01: On Android, pgid(1) is 0 instead of 1
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

> Android's init does not call setpgid(0, 0) so it does not have pgid=1.
> 0 is functionally equivalent, since pgid 0 means the pgid is the same as
> the process pid.

> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  testcases/kernel/syscalls/getpgid/getpgid01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/getpgid/getpgid01.c b/testcases/kernel/syscalls/getpgid/getpgid01.c
> index 479fe5dcb..8640f2c93 100644
> --- a/testcases/kernel/syscalls/getpgid/getpgid01.c
> +++ b/testcases/kernel/syscalls/getpgid/getpgid01.c
> @@ -37,7 +37,7 @@ static void run(void)
>  		TST_EXP_EQ_LI(TST_RET, pgid);

>  		TST_EXP_PID(getpgid(1));
> -		TST_EXP_EQ_LI(TST_RET, 1);
> +		TST_EXP_EXPR(TST_RET == 1 || TST_RET == 0, "getpgid(1) == 1 or 0");
Although I don't prefer using often libc specific code, here I'd use it:

#ifndef __ANDROID__ 
		TST_EXP_EQ_LI(TST_RET, 0);
#else
		TST_EXP_EQ_LI(TST_RET, 1);
#endif

Because your code would loosen testing for other libc.
Cyril, Li, WDYT?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
