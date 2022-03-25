Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B51C433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 07:19:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 090113C8781
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 08:19:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5F8D3C54FB
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 08:18:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 185D3601AC5
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 08:18:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 50EC71F745;
 Fri, 25 Mar 2022 07:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648192731;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H08M900IiwLl2eIucpsi/mxFFkIUbl55M4fw8geM/EM=;
 b=LfdYTsybPPhswSKRl+HT39Kkh4NwN+0lTqaP2FGsA3N+8GMt5pHRWfZDF1osdCWb1nfHLH
 RnClr6FgxBSK6fggczvJhee+SvPkmVf7Fqq/vr2gXCHAW9BCsXM1ITFy4vuJ1tF1C+96gE
 MY8IxhvWh2Nl666Bfl2yKTZqYJTSb8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648192731;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H08M900IiwLl2eIucpsi/mxFFkIUbl55M4fw8geM/EM=;
 b=g72ug+x1bWvqmldnIh5Zo6TmQ/IJOhw4fHySTgF8ItFJ1aqtBt1bH2DdOdvdHQN7zssA3N
 A1ph/G9YYD5aw8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27AF9132E9;
 Fri, 25 Mar 2022 07:18:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mvX/B9tsPWIHTwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Mar 2022 07:18:51 +0000
Date: Fri, 25 Mar 2022 08:18:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Yj1s2cKWf7oNwSVR@pevik>
References: <20220315122351.8556-1-andrea.cervesato@suse.de>
 <20220315122351.8556-9-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220315122351.8556-9-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 8/8] Rewrite userns08.c using new LTP API
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
Cc: rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

[Cc Richie]

This subject: "Rewrite userns08.c using new LTP API" is misleading,
userns08.c was already using new API.

You're:
* s/tst_res/tst_brk/ (that would deserve explanation why)
* removing tst_reap_children()
* changing formatting (some of them create too long lines)

...
>  static pid_t clone_newuser(void)
>  {
> -	const struct tst_clone_args cargs = {
> -		CLONE_NEWUSER,
> -		SIGCHLD
> -	};
> +	const struct tst_clone_args cargs = { CLONE_NEWUSER, SIGCHLD };

>  	return SAFE_CLONE(&cargs);
>  }

> -static void write_mapping(const pid_t proc_in_ns,
> -			  const char *const id_mapping)
> +static void write_mapping(const pid_t proc_in_ns, const char *const id_mapping)
>  {
>  	char proc_path[PATH_MAX];
>  	int proc_dir;
> @@ -61,11 +58,11 @@ static void write_mapping(const pid_t proc_in_ns,
>  static void ns_level2(void)
>  {
>  	if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
> -		tst_res(TINFO | TERRNO, "Failed to set dumpable flag");
> +		tst_brk(TBROK | TTERRNO, "Failed to set dumpable flag");
Not sure which one is correct (whether tst_res or tst_brk).
But TTERRNO is obviously wrong, that's for using TEST(). Here should remain
TERRNO.

> +
>  	TST_CHECKPOINT_WAKE_AND_WAIT(1);

> -	TST_EXP_FAIL(open("restricted", O_WRONLY), EACCES,
> -		     "Denied write access to ./restricted");
> +	TST_EXP_FAIL(open("restricted", O_WRONLY), EACCES, "Denied write access to ./restricted");

I'd keep this one.

>  	exit(0);
>  }
> @@ -89,7 +86,6 @@ static void ns_level1(void)
>  	write_mapping(level2_proc, map_over_5);

>  	TST_CHECKPOINT_WAKE(1);
> -	tst_reap_children();
Well, test works without it, but not really sure if it can be removed.

Kind regards,
Petr

>  	exit(0);
>  }
> @@ -111,7 +107,6 @@ static void run(void)
>  	write_mapping(level1_proc, "0 100000 1000");

>  	TST_CHECKPOINT_WAKE(0);
> -	tst_reap_children();

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
