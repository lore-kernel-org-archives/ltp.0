Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53DBC5478C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 09:48:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E4293CF11C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 10:48:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C2D43CCBB9
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 10:48:38 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C0D171011BE3
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 10:48:37 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8DDE021FFB;
 Fri, 23 Feb 2024 09:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708681716;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oO9MK75o5eSDt/lB2007fCCpcZi/Py4HaFs1fbcRWk=;
 b=jN8vIq5WeZBZLfqAiHqgnF5xGyKtnL9i/r3lbv1JBkr7QL0hsECuwZm/akzUG8MwWrP4Lw
 q/iJ8iGS8jdTGaXzITPWD0VBkbSDdKFAXda2ky4CM6ovOSaMe2TIJ2uknjkNK4JkpWMmVJ
 3UuxCeBKgwaYq3jyEMnZK2iiluUF4mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708681716;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oO9MK75o5eSDt/lB2007fCCpcZi/Py4HaFs1fbcRWk=;
 b=ELAzz8Kl1lS7G74c83+yPBbTcsPVKwU8E26qmUEmQkukYCgj22NdPeGmajK4caksfBGLT/
 xzHCBNjeG/0Q8wDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708681716;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oO9MK75o5eSDt/lB2007fCCpcZi/Py4HaFs1fbcRWk=;
 b=jN8vIq5WeZBZLfqAiHqgnF5xGyKtnL9i/r3lbv1JBkr7QL0hsECuwZm/akzUG8MwWrP4Lw
 q/iJ8iGS8jdTGaXzITPWD0VBkbSDdKFAXda2ky4CM6ovOSaMe2TIJ2uknjkNK4JkpWMmVJ
 3UuxCeBKgwaYq3jyEMnZK2iiluUF4mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708681716;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oO9MK75o5eSDt/lB2007fCCpcZi/Py4HaFs1fbcRWk=;
 b=ELAzz8Kl1lS7G74c83+yPBbTcsPVKwU8E26qmUEmQkukYCgj22NdPeGmajK4caksfBGLT/
 xzHCBNjeG/0Q8wDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E44E13776;
 Fri, 23 Feb 2024 09:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id iJ0vEPRp2GVuRQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 09:48:36 +0000
Date: Fri, 23 Feb 2024 10:48:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240223094834.GE1423688@pevik>
References: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
 <20240220074218.13487-3-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240220074218.13487-3-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jN8vIq5W;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ELAzz8Kl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Queue-Id: 8DDE021FFB
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/7] syscalls/swapon03: use tst_max_swapfiles()
 and GET_USED_SWAPFILES() api
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

Hi Yang Xu,

LGTM, few comments below.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> @@ -19,7 +19,6 @@

>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
> -#include "swaponoff.h"
+1

>  #include "libswap.h"

>  #define MNTPOINT	"mntpoint"
> @@ -104,47 +103,20 @@ static void verify_swapon(void)

Here is comment:
/*
 * Create 33 and activate 30 swapfiles.
 */
This would deserve to update, because we use tst_max_swapfiles(), rirght?
Something like: "Create max number of swap files + 1 and activate max number
swap files -2."
>  static int setup_swap(void)
>  {
>  	pid_t pid;
> -	int j, fd;
>  	int status;
> +	int j, max_swapfiles, used_swapfiles;
>  	int res = 0;
>  	char filename[FILENAME_MAX];
> -	char buf[BUFSIZ + 1];
> -
> -	/* Find out how many swapfiles (1 line per entry) already exist */
> -	swapfiles = 0;

>  	if (seteuid(0) < 0)
>  		tst_brk(TFAIL | TERRNO, "Failed to call seteuid");
nit: while at it, could you please use here SAFE_SETEUID(0) ?

> -	/* This includes the first (header) line */
> -	if ((fd = open("/proc/swaps", O_RDONLY)) == -1) {
> -		tst_brk(TFAIL | TERRNO,
> -			"Failed to find out existing number of swap files");
> -	}
> -	do {
> -		char *p = buf;
> -		res = read(fd, buf, BUFSIZ);
> -		if (res < 0) {
> -			tst_brk(TFAIL | TERRNO,
> -				 "Failed to find out existing number of swap files");
> -		}
> -		buf[res] = '\0';
> -		while ((p = strchr(p, '\n'))) {
> -			p++;
> -			swapfiles++;
> -		}
> -	} while (BUFSIZ <= res);
> -	close(fd);
> -	if (swapfiles)
> -		swapfiles--;	/* don't count the /proc/swaps header */
Explicitly mention "don't count the /proc/swaps header" would not hurt in the
previous commit where you use -1.
> -
> -	if (swapfiles < 0)
> -		tst_brk(TFAIL, "Failed to find existing number of swapfiles");
> -
>  	/* Determine how many more files are to be created */
> -	swapfiles = MAX_SWAPFILES - swapfiles;
> -	if (swapfiles > MAX_SWAPFILES)
> -		swapfiles = MAX_SWAPFILES;
> +	max_swapfiles = tst_max_swapfiles();
> +	used_swapfiles = tst_count_swaps();
> +	swapfiles = max_swapfiles - used_swapfiles;
Instead of used_swapfiles directly call tst_count_swaps() can be used.
> +	if (swapfiles > max_swapfiles)
> +		swapfiles = max_swapfiles;

Please add here blank line for readability.
>  	pid = SAFE_FORK();
>  	if (pid == 0) {
>  		/*create and turn on remaining swapfiles */

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
