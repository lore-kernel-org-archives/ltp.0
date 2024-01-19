Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B42CC4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 11:42:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD7283CE2BC
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 12:42:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7BB13CAC5F
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 12:42:03 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2D78B600784
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 12:42:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B15D51FD12;
 Fri, 19 Jan 2024 11:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705664520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eLrrvFJYV0hI4Rt+MkMz3y6iwaOTObaOpCAfnLdWmIw=;
 b=zz1AKLyaRkrbqA3rbFlo6kK0+ljfJAsizuhqozmubuTfuxI9SoPS2ktPRL5O+aGyQO0Dni
 R+if6rhYoijJcI/9jM2AOedxJcfFM/kHzQz2j1MoJlGSWjcwIEfFgGkceWPV2vlDDzxvON
 2lGCdBsbc0ZYhynaxzIogrHvyRyF7nA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705664520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eLrrvFJYV0hI4Rt+MkMz3y6iwaOTObaOpCAfnLdWmIw=;
 b=8wwKOUoNesl2FbayZeDvEjP7ZHmPEcds5mX3d5kdWykZZgY0fxPEfPY6QrcpuzzCZgU6a7
 5aBSGfHiGiw2vaCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705664520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eLrrvFJYV0hI4Rt+MkMz3y6iwaOTObaOpCAfnLdWmIw=;
 b=zz1AKLyaRkrbqA3rbFlo6kK0+ljfJAsizuhqozmubuTfuxI9SoPS2ktPRL5O+aGyQO0Dni
 R+if6rhYoijJcI/9jM2AOedxJcfFM/kHzQz2j1MoJlGSWjcwIEfFgGkceWPV2vlDDzxvON
 2lGCdBsbc0ZYhynaxzIogrHvyRyF7nA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705664520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eLrrvFJYV0hI4Rt+MkMz3y6iwaOTObaOpCAfnLdWmIw=;
 b=8wwKOUoNesl2FbayZeDvEjP7ZHmPEcds5mX3d5kdWykZZgY0fxPEfPY6QrcpuzzCZgU6a7
 5aBSGfHiGiw2vaCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86A7313894;
 Fri, 19 Jan 2024 11:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TujyHghgqmXpewAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Jan 2024 11:42:00 +0000
Date: Fri, 19 Jan 2024 12:42:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZapgEnqfXwdL7_Pu@yuki>
References: <20231011162428.583911-1-pvorel@suse.cz>
 <20231011162428.583911-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231011162428.583911-2-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zz1AKLya;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8wwKOUoN
X-Spamd-Result: default: False [-2.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B15D51FD12
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] swapon01: Test on all filesystems
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Test on all filesystems to increase coverage.  btrfs and tmpfs
> currently does not support swap file, but keep it in case this get
> changed in the future.
> 
> Testing on all filesystems usually requests root, but we don't require
> it with .needs_root = 1. But using swapon() requires it as well, thus
> keep it defined.
> 
> Also detect the support on the same file as which is being tested.

For the previous iteration of this patch Li wasn't sure if this adds
enough value since there isn't ton of filesystem specific code involved
unless we actually start writing to the swapfile.

And as the patch is I would agree with that. What may make sense I think
is to require certain filesystem to support swap, i.e. fail the test in
the case that we haven't managed to create and enable the swapfile where
it's supposed to work. That would guard about accidental breakages, as
it is the test would not catch these because it woult TCONF in the
setup.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> IMHO it's not a big slowdown thus I keep btrfs and tmpfs.
> They might get support one day.
> 
>  testcases/kernel/syscalls/swapon/swapon01.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
> index b5c3f359c..6b7f96cf7 100644
> --- a/testcases/kernel/syscalls/swapon/swapon01.c
> +++ b/testcases/kernel/syscalls/swapon/swapon01.c
> @@ -9,6 +9,9 @@
>   * Checks that swapon() succeds with swapfile.
>   */
>  
> +#define MNTPOINT	"mntpoint"
> +#define SWAP_FILE	MNTPOINT"/swapfile01"
> +
>  #include <unistd.h>
>  #include <errno.h>
>  #include <stdlib.h>
> @@ -18,14 +21,14 @@
>  
>  static void verify_swapon(void)
>  {
> -	TEST(tst_syscall(__NR_swapon, "./swapfile01", 0));
> +	TEST(tst_syscall(__NR_swapon, SWAP_FILE, 0));
>  
>  	if (TST_RET == -1) {
>  		tst_res(TFAIL | TTERRNO, "Failed to turn on swapfile");
>  	} else {
>  		tst_res(TPASS, "Succeeded to turn on swapfile");
>  		/*we need to turn this swap file off for -i option */
> -		if (tst_syscall(__NR_swapoff, "./swapfile01") != 0) {
> +		if (tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {
>  			tst_brk(TBROK | TERRNO, "Failed to turn off swapfile,"
>  				" system reboot after execution of LTP "
>  				"test suite is recommended.");
> @@ -35,13 +38,15 @@ static void verify_swapon(void)
>  
>  static void setup(void)
>  {
> -	is_swap_supported("./tstswap");
> -	make_swapfile("swapfile01", 0);
> +	is_swap_supported(SWAP_FILE);
> +	make_swapfile(SWAP_FILE, 0);
>  }
>  
>  static struct tst_test test = {
> -	.needs_root = 1,
> -	.needs_tmpdir = 1,
> +	.mntpoint = MNTPOINT,
> +	.mount_device = 1,
> +	.needs_root = 1, /* for swapon() */
> +	.all_filesystems = 1,
>  	.test_all = verify_swapon,
>  	.setup = setup
>  };
> -- 
> 2.42.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
