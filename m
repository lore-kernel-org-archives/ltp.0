Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D90C982FA
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 11:12:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23CEA3E6CA0
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 13:12:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EDB53E6C01
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 13:11:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9531410009F5
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 13:11:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4C0E31FF4D;
 Wed, 23 Sep 2026 11:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790161901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12O8K8u5aq4ASIDiVdMMvp96E5zVgAue4OJw/KeaJE0=;
 b=zRTAba5yjBWLMc7AnpJV2k+YSXz5cLhPwX9rNDNyoyXlj5vISNIapcCjJ3epNF+fVubiIM
 dj8iRANUBPkjSjUWnPFQ5KFcZguJtv7dLVYHWzT+guT8z37LRf+jwYwlOyNRW8kwUwTY8/
 YZp4On6YdZI9fXzbwAwgrb69hcw0QWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790161901;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12O8K8u5aq4ASIDiVdMMvp96E5zVgAue4OJw/KeaJE0=;
 b=S+WICPQXXcRg2hQp3dZOXcpIyHVErT2LvweaYCtsH2GrMFNUBpLcbYmLQgb+qxcy/EHKgT
 XbEBRrAcbVQ0MDBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790161897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12O8K8u5aq4ASIDiVdMMvp96E5zVgAue4OJw/KeaJE0=;
 b=gjE9uumpzhvzMQO3ZXPcGpcgBbtZ7WhNQlFJixqU4DDWoC+CjnWxYajsRCOiaIX98Z2vzH
 e6yuO7Bnge+im8IR+RY2EysCP7BGxwFjgxMxNPFqcRxcTcQmdEB9jElV+3XL7x34vMSfro
 OyNE8zx3NoSbkKPyFNhUJp1ZUv6InM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790161897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12O8K8u5aq4ASIDiVdMMvp96E5zVgAue4OJw/KeaJE0=;
 b=nf0iO/w436CVxUcDCMVJMRRmrpDYgeS2LsKOevp08wUh8sVuo84OtfOmN+Fc9rqAda4VSY
 AsD7Q/XtekWyTZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F07113432;
 Wed, 23 Sep 2026 11:11:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id //YLO+izs2pbCwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 23 Sep 2026 11:11:37 +0000
Date: Wed, 23 Sep 2026 13:11:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <arOz8kIcqqlWEdJ6@yuki.lan>
References: <20260918125021.1939455-1-pvorel@suse.cz>
 <20260918125021.1939455-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260918125021.1939455-3-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] shmctl03: Fix shmmax clamped to INT_MAX in
 32bit compat mode
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
> Reported-by: Wei Gao <wegao@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> [ pvorel: separate into its own commit, write the commit message ]
> Co-developed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/shmctl/shmctl03.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
> index 9e1c2f0990..0056f2c4b4 100644
> --- a/testcases/kernel/syscalls/shmctl/shmctl03.c
> +++ b/testcases/kernel/syscalls/shmctl/shmctl03.c
> @@ -30,7 +30,11 @@ static void verify_ipcinfo(void)
>  	else
>  		tst_res(TPASS, "shmmin = 1");
>  
> -	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> +	if (tst_is_compat_mode() && info.shmmax == INT_MAX)
> +		tst_res(TPASS, "shmmax clamped to INT_MAX in compat mode");

This should be turned into PATH_KERN_SHMMAX >= INT_MAX check instead of
printing TPASS blindly.

> +	else
> +		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> +
>  	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
>  	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
>  }
> -- 
> 2.55.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
