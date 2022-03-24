Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD3DC433EF
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 15:02:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 496523C9A68
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 16:02:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFE6C3C97EC
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 16:02:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 54ECD2000B2
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 16:02:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4691D1F7AB;
 Thu, 24 Mar 2022 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648134165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=djTicP3nCJofsMUrxuOdP23sH7xoLIYpWjjzdZTVQyM=;
 b=w8mOHSUa8NB9kgXUG3+No2jvvrwM7ZjzDPbLN2PTDNePjvIYJXm2MNIu9nBASWw2oJeFLn
 OP0mnFlXAKcipz6mntvUgt+YBnsXTOzchxA8JVnTDgJuV6M2+pgEGJWLd6U9aa2aXuo+b4
 3IqBq9b2PmSMOYMrafyTaD+Wd3soMEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648134165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=djTicP3nCJofsMUrxuOdP23sH7xoLIYpWjjzdZTVQyM=;
 b=3oSVhODHPptWVTHxYomqrTi9UA98herqIfEBmcz+h1Ef0xrd6Q6JGZsvT0X0qFtY0MdvJY
 bhHrC8JvxIAsqcBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25F7A132E9;
 Thu, 24 Mar 2022 15:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IxwdCBWIPGL1GQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 24 Mar 2022 15:02:45 +0000
Date: Thu, 24 Mar 2022 16:04:59 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YjyImxbSuv6QZ6ep@yuki>
References: <20220315103254.7185-1-andrea.cervesato@suse.de>
 <20220315103254.7185-4-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220315103254.7185-4-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 03/10] Rewrite sem_comm.c using new LTP API
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

Hi!
> +	TEST(semop(id, &sm, 1));
> +	if (TST_RET < 0) {
> +		if (TST_ERR != EAGAIN)
> +			tst_brk(TBROK | TERRNO, "semop error");
> +
> +		tst_res(TFAIL, "can't lock semaphore between namespaces");

The message is very confusing here. If we get here the semaphone was
locked by the other child in a different namespace. We should print
something as "semaphore decremented from different namespace"

> +	} else {
> +		tst_res(TPASS, "locked semaphore between namespaces");

Here as well, confusing message.

>  	}
>  
>  	/* tell child1 to continue */
> -	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
> +	TST_CHECKPOINT_WAKE(0);
>  
>  	sm.sem_op = 1;
> -	semop(id, &sm, 1);
> +	SAFE_SEMOP(id, &sm, 1);

I wonder if it's necessary to modify the semaphore value before the
RMDID here. Can't we just remove it instead?

> +	SAFE_SEMCTL(id, 0, IPC_RMID);

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
