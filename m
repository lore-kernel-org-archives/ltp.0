Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE9AEB64DA
	for <ltp@archiver.kernel.org>; Fri,  7 Jul 2023 09:02:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 106673CBD78
	for <ltp@archiver.kernel.org>; Fri,  7 Jul 2023 11:02:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA8703C9989
 for <ltp@lists.linux.it>; Fri,  7 Jul 2023 11:01:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C8A83200AED
 for <ltp@lists.linux.it>; Fri,  7 Jul 2023 11:01:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DDF51227B0;
 Fri,  7 Jul 2023 09:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688720509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gvYV/hJRycH9GavFAWtxFJ7+8UmTx3nfRD+a5zhX8WA=;
 b=Hlo1p3ROdqpBxRrRBuKkOg6+al2vqwl1y5XAdUHTWKdUVR5LgmSflEBJDqV56iSlM4jLT3
 ZsLLdX/FP05Ksu0sMFuAJIbTxdG08YBWd6uQBsIR50+JXyhdJOFBw/eTCe0mq4tVMFYUqb
 G+YennQ3XIDoSWulZXPFCZ3crRVkXY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688720509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gvYV/hJRycH9GavFAWtxFJ7+8UmTx3nfRD+a5zhX8WA=;
 b=NehLPuUDh7RC+rPW4LXidTo+sPAEpO9L+UWEGdspHhg3TQtN4PVqsf79f7oji+/UU7Rlfp
 nhTiYx16X2N8EmAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE5C51346D;
 Fri,  7 Jul 2023 09:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QjryLH3Up2Q6TgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jul 2023 09:01:49 +0000
Date: Fri, 7 Jul 2023 11:01:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230707090148.GC571797@pevik>
References: <1688637954-17765-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1688637954-17765-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1688637954-17765-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/geteuid02: Convert into new api
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

Hi Xu,

> -		if (pwent == NULL)
> -			tst_resm(TFAIL | TERRNO, "getpwuid failed");
> -
> -		UID16_CHECK(pwent->pw_uid, geteuid, cleanup);
Don't we need to use UID16_CHECK()? In the new API version from
compat_tst_16.h

Kind regards,
Petr

> -		if (pwent->pw_uid != TEST_RETURN)
> -			tst_resm(TFAIL, "getpwuid value, %d, "
> -				 "does not match geteuid "
> -				 "value, %ld", pwent->pw_uid,
> -				 TEST_RETURN);
> -		else
> -			tst_resm(TPASS, "values from geteuid "
> -				 "and getpwuid match");
> -	}
...
> +	TST_EXP_EXPR(TST_RET == uid[1],
> +		     "geteuid() ret %ld == /proc/self/status EUID: %ld",
> +		     TST_RET, uid[1]);
>  }

> +static struct tst_test test = {
> +	.test_all = verify_geteuid,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
