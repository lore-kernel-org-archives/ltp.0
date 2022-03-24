Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDD4C433F5
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 21:08:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BADC83C2DA6
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 22:08:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C43923C020F
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 22:08:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BD92B601620
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 22:08:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0BBFC1F38D;
 Thu, 24 Mar 2022 21:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648156100;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqCNYoPJd8RvXYZOoM5faWMcsNPwNGhbeD8ZyEAS3yw=;
 b=c1qXFWfwNyxy4pSzRgV+y7rxL3RoGE/QpjXR5f21p3a/Z8KH+TJu+3EbLPcx/buyk8xNQn
 tvLWY1efrAPuQRFXc8VN6EBEmfOZ960U2erjragjY0FK27NU1U/hjp1hJEUl/23mKBvGvy
 tV1KKGbkrHFR6+926QqitpkMSHUqk/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648156100;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqCNYoPJd8RvXYZOoM5faWMcsNPwNGhbeD8ZyEAS3yw=;
 b=35jUHUYhsqWo+72Dx0/MrZBqCEvBI615KGOCgabtEWZv5FV4Bq1gHgnjFtY03grmc9huoK
 kPkezF8ApjU3kpBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1C99132E9;
 Thu, 24 Mar 2022 21:08:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id L0h8McPdPGJjJAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 24 Mar 2022 21:08:19 +0000
Date: Thu, 24 Mar 2022 22:08:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YjzdwTbMbJmLYVek@pevik>
References: <20220315122351.8556-1-andrea.cervesato@suse.de>
 <20220315122351.8556-6-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220315122351.8556-6-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/8] Rewrite userns05.c using new LTP API
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

Hi Andrea,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM, just anybody merging this should remove return; at the end of run().

>  testcases/kernel/containers/userns/userns05.c | 148 ++++++++----------
...
> -/*
> - * Verify that:
> - * A process created via fork(2) or clone(2) without the
> - * CLONE_NEWUSER flag is a member of the same user namespace as its
> - * parent.
> - * When unshare an user namespace, the calling process is moved into
> - * a new user namespace which is not shared with any previously
> - * existing process.
> +/*\
> + * [Description]
> + *
> + * Verify that if a process created via fork(2) or clone(2) without the
> + * CLONE_NEWUSER flag is a member of the same user namespace as its parent.

I'd put blank space here to create 2 paragraphs in html/pdf doc.
> + * When unshare an user namespace, the calling process is moved into a new user
> + * namespace which is not shared with any previously existing process.
>   */

...
>  static int child_fn1(void)
>  {
...
> +	SAFE_READLINK(path, userid, BUFSIZ);
> +
> +	if (sscanf(userid, "user:[%u]", &id) < 0)
> +		tst_brk(TBROK | TERRNO, "sscanf failure");
Ah, we still don't have SAFE_SSCANF() (nothing urgent, this is the first test
using new API which would use it).

> +static void run(void)
>  {
...
> +	cpid1 = ltp_clone_quick(SIGCHLD, (void *)child_fn1, NULL);
>  	if (cpid1 < 0)
> +		tst_brk(TBROK | TTERRNO, "clone failed");
Again, once we implement SAFE_LTP_CLONE_QUICK() we should use it here
(as a separate effort).

...
> +	cpid3 = SAFE_FORK();
> +	if (!cpid3) {
> +		SAFE_UNSHARE(CLONE_NEWUSER);
>  		newparentuserns = getusernsidbypid(getpid());

>  		/* When unshare an user namespace, the calling process
> +		 * is moved into a new user namespace which is not shared
> +		 * with any previously existing process
> +		 */
>  		if (parentuserns == newparentuserns)
> +			tst_res(TFAIL, "unshared namespaces with same id");
> +		else
> +			tst_res(TPASS, "unshared namespaces with different id");

> +		return;
Why this empty return?
> +	}
>  }

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
