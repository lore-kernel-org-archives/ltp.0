Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEE9C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 10:15:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6917D3C8811
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 11:15:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 141A13C0354
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 11:15:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 79722200FEF
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 11:15:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A6113210FD;
 Fri, 25 Mar 2022 10:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648203340;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9dgp65eT9jR0mcyOOFdwvRCWMGB+WgFAOUYmSylago=;
 b=kFwf5H59/aoURAxtQhSQbU++T4BlcwA4GnT11fYjzxWfPxE8VyaHoozAJQbKP0F7PXL0y8
 r/GvdpEhBdl29Z7Q0/99CbOAApsOX6Z1gei26NPMUWfqhqi5Kx5Is7hjza7VeIK68FQc+e
 OmhW1WRo58c/q3nQwCOxA2MKondA0W0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648203340;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9dgp65eT9jR0mcyOOFdwvRCWMGB+WgFAOUYmSylago=;
 b=HrbYAk84WfwCZlJ7/eVziH7+h7HYwfpaFobjoXQSe0qLq2LgC+WPoE/+2/BgrL1cXfH+uO
 V0aW5+fC4qCZ7mBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79CAB13A30;
 Fri, 25 Mar 2022 10:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id btkBHEyWPWIcFwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Mar 2022 10:15:40 +0000
Date: Fri, 25 Mar 2022 11:15:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <Yj2WSuxQ583m3uQG@pevik>
References: <1648243376-5306-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1648243376-5306-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/umount2_02: remove useless TST_ERR
 assignment
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

Hi Dai,

> Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
> ---
>  testcases/kernel/syscalls/umount2/umount2_02.c | 1 -
>  1 file changed, 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
> index 4c3b30e..d1aed11 100644
> --- a/testcases/kernel/syscalls/umount2/umount2_02.c
> +++ b/testcases/kernel/syscalls/umount2/umount2_02.c
> @@ -69,7 +69,6 @@ static int umount2_retry(const char *target, int flags)
>  	tst_res(TWARN, "Failed to umount('%s', %i) after 50 retries",
>  		target, flags);

> -	TST_ERR = EBUSY;

Not sure if the for loop in umount2_retry() could overwrite the original errno.

Kind regards,
Petr

>  	return -1;
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
