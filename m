Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E96C4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 15:06:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5CE63CE2D9
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 16:06:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 940DB3CB172
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 16:05:55 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B3F6F1BCCB4C
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 16:05:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9127C21E0B;
 Fri, 19 Jan 2024 15:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705676753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U0zS0JTXL08BCVqJTU66VISLfMpVBtUUFeroXEN7A5o=;
 b=G2/FyeQ4xzy7/guxoLXObO++fo2fu6cKEdpT0klrx9F+wjpJzS9mk72jyU0o+lwknyyaH3
 +svnoo+EVruft4c+gP/uHi8iEZckoaq4hwE9WW2Ng2zWx430AyjHFod5phUY4OBH0Lvaxx
 ktqPQCe7iBowMS2ifRiIIDvAL/JuLR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705676753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U0zS0JTXL08BCVqJTU66VISLfMpVBtUUFeroXEN7A5o=;
 b=I3RASp7LoJ83rcoOzP+k/cHPwcSx/2wPvW9M9b/BobZj5TYUk1Z3PT59u4YLJSf2FehClb
 3xwttyqkasdS0pAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705676753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U0zS0JTXL08BCVqJTU66VISLfMpVBtUUFeroXEN7A5o=;
 b=G2/FyeQ4xzy7/guxoLXObO++fo2fu6cKEdpT0klrx9F+wjpJzS9mk72jyU0o+lwknyyaH3
 +svnoo+EVruft4c+gP/uHi8iEZckoaq4hwE9WW2Ng2zWx430AyjHFod5phUY4OBH0Lvaxx
 ktqPQCe7iBowMS2ifRiIIDvAL/JuLR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705676753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U0zS0JTXL08BCVqJTU66VISLfMpVBtUUFeroXEN7A5o=;
 b=I3RASp7LoJ83rcoOzP+k/cHPwcSx/2wPvW9M9b/BobZj5TYUk1Z3PT59u4YLJSf2FehClb
 3xwttyqkasdS0pAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8017F136F5;
 Fri, 19 Jan 2024 15:05:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ylcXHtGPqmWNPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Jan 2024 15:05:53 +0000
Date: Fri, 19 Jan 2024 16:06:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZaqP2_ZeyRM1YY0w@yuki>
References: <20240119144322.41928-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240119144322.41928-1-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.02 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.42)[97.34%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] swapon01: Test on all filesystems
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
>  testcases/kernel/syscalls/swapon/swapon01.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
> index e59fb20a1..ef4ebfdcf 100644
> --- a/testcases/kernel/syscalls/swapon/swapon01.c
> +++ b/testcases/kernel/syscalls/swapon/swapon01.c
> @@ -8,6 +8,7 @@
>   * [Description]
>   *
>   * Checks that swapon() succeds with swapfile.
> + * Testing on all filesystems which support swap file.
>   */
>  
>  #include <unistd.h>
> @@ -17,13 +18,14 @@
>  #include "lapi/syscalls.h"
>  #include "libswap.h"
>  
> -#define SWAP_FILE "swapfile01"
> +#define MNTPOINT	"mntpoint"
> +#define SWAP_FILE	MNTPOINT"/swapfile01"
>  
>  static void verify_swapon(void)
>  {
>  	TST_EXP_PASS(tst_syscall(__NR_swapon, SWAP_FILE, 0));
>  
> -	if (TST_PASS && tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {
> +	if (tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {

I do not think that this should be removed, if the swapon() call fails
we still do not want TBROK here.

>  		tst_brk(TBROK | TERRNO,
>  				"Failed to turn off swapfile, system reboot recommended");
>  	}
> @@ -31,13 +33,20 @@ static void verify_swapon(void)
>  
>  static void setup(void)
>  {
> -	is_swap_supported(SWAP_FILE);
>  	make_swapfile(SWAP_FILE, 0);
>  }
>  
>  static struct tst_test test = {
> -	.needs_root = 1,
> -	.needs_tmpdir = 1,
> +	.mntpoint = MNTPOINT,
> +	.mount_device = 1,
> +	.needs_root = 1, /* for swapon() */

Can we please avoid comments like this?

I'ts pretty clear that if you are working with devices and setting up
swapfiles it's priviledged operation...

> +	.all_filesystems = 1,
>  	.test_all = verify_swapon,
> -	.setup = setup
> +	.setup = setup,
> +	.skip_filesystems = (const char *[]) {
> +		"bcachefs",
> +		"btrfs",
> +		"tmpfs",

So the rest of the filesystems work fine? If so this change looks fine
to me.

> +		NULL
> +	},
>  };


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
