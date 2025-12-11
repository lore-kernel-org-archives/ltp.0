Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35D2D41C21
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 11:14:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D6913CF425
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 12:14:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBAF53C8F97
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 12:14:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 22A70100097F
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 12:14:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9896033698;
 Thu, 11 Dec 2025 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765451644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsDZ8YDyrNjwOnvMo6L5aewP/vOs2IbqKO2PppKsFb8=;
 b=XssTEUZ/a3dMkXsBJix3kEeGZHLoa0r4FvFJaEKyEFjaB4Ru1bi09cX/vLKhVWk3i9vYJt
 UtI+9gYjqaM8hAOxLQOiXKG33saV/z+fakgXCyCbYE4DuxwKrUIUSKbzg6gLR6RC88Zq+S
 3XrnaemDsMTedklpi0t0SoaS3omGDZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765451644;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsDZ8YDyrNjwOnvMo6L5aewP/vOs2IbqKO2PppKsFb8=;
 b=0ZUDopHZrWV6Gt5hJmNEh3sV9MNCKPaMLS1oblNZ5NK+5I9lOMlsqpJpzJvQrMY9tdww3e
 qa3aiI11BleO6pCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EXssruSQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LwReQVEh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765451643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsDZ8YDyrNjwOnvMo6L5aewP/vOs2IbqKO2PppKsFb8=;
 b=EXssruSQ8xZ6P45uLI4uBTIJt95Am8Sbd6Y3kisbIHP9FphQ3CeN5O2WrRQWuGKYVgvdpd
 H7lqSkdzj5vssenjmBaVJcFi/aJtFmd3am35UYRZ2lWX6HJwAocgRpghlxLB+aiUMuaEuS
 /SnnhZvixZMy5R3ru27CwennjueeBd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765451643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsDZ8YDyrNjwOnvMo6L5aewP/vOs2IbqKO2PppKsFb8=;
 b=LwReQVEh29cIiu8pkMNZ6NMUmtbD6XnTIzw85jgTV+H2qsls1UqYtM1+pYAQdhp/gbu9gY
 aT9pLCT60UonWGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E70B3EA63;
 Thu, 11 Dec 2025 11:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VZRuHHunOmmlWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 11 Dec 2025 11:14:03 +0000
Date: Thu, 11 Dec 2025 12:15:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aTqnt-lgcX2KLHPK@yuki.lan>
References: <20251118143607.45308-1-pvorel@suse.cz>
 <20251118143607.45308-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251118143607.45308-3-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9896033698
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] swapon03: Try to swapon() as many files
 until it fails
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
Cc: Michal Hocko <mhocko@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v2->v3:
> * Add -i2 to runtest/syscalls.
> * Slightly simpler code (no mmap() needed) due cleanup in a previous
>   commit (removed fork()).
> 
>  runtest/syscalls                            |  2 +-
>  testcases/kernel/syscalls/swapon/swapon03.c | 54 +++++++++++++--------
>  2 files changed, 34 insertions(+), 22 deletions(-)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 54d94c0ca2..80dedef749 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1646,7 +1646,7 @@ swapoff02 swapoff02
>  
>  swapon01 swapon01
>  swapon02 swapon02
> -swapon03 swapon03
> +swapon03 swapon03 -i2
>  
>  #Exclusive syscall() for POWER6 machines only
>  switch01 endian_switch01
> diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
> index c014a48912..548a5a522f 100644
> --- a/testcases/kernel/syscalls/swapon/swapon03.c
> +++ b/testcases/kernel/syscalls/swapon/swapon03.c
> @@ -6,9 +6,12 @@
>   */
>  
>  /*\
> - * This test case checks whether swapon(2) system call returns:
> + * Test checks whether :man2:`swapon` system call returns EPERM when the maximum
> + * number of swap files are already in use.
>   *
> - *  - EPERM when there are more than MAX_SWAPFILES already in use.
> + * NOTE: test does not try to calculate MAX_SWAPFILES from the internal
> + * kernel implementation, instead make sure few swaps were created before
> + * maximum was reached.
>   */
>  
>  #include <stdio.h>
> @@ -20,6 +23,13 @@
>  #include "lapi/syscalls.h"
>  #include "libswap.h"
>  
> +/*
> + * MAX_SWAPFILES from the internal kernel implementation is currently <23, 29>,
> + * depending on kernel configuration (see man swapon(2). Chose small enough
> + * value for future changes.
> + */
> +#define NUM_SWAP_FILES 15

It would be slightly better if we renamed this to MIN_SWAP_FILES since
this is the minimal number of swapfiles we expect to be able to create.

>  #define MNTPOINT	"mntpoint"
>  #define TEST_FILE	MNTPOINT"/testswap"
>  
> @@ -27,31 +37,33 @@ static int swapfiles;
>  
>  static int setup_swap(void)
>  {
> -	int j, max_swapfiles, used_swapfiles;
> +	int used_swapfiles, expected_swapfiles;

Here as well, s/expected_swapfiles/min_swapfiles/

>  	char filename[FILENAME_MAX];
>  
> -	/* Determine how many more files are to be created */
> -	max_swapfiles = tst_max_swapfiles();
>  	used_swapfiles = tst_count_swaps();
> -	swapfiles = max_swapfiles - used_swapfiles;
> -	if (swapfiles > max_swapfiles)
> -		swapfiles = max_swapfiles;
> +	expected_swapfiles = NUM_SWAP_FILES - used_swapfiles;
>  
> -	/*create and turn on remaining swapfiles */
> -	for (j = 0; j < swapfiles; j++) {
> +	if (expected_swapfiles < 0)
> +		tst_brk(TCONF, "too many used swap files (%d)", used_swapfiles);

Do we really have to quit here? If all swap slots are already used we
will not create any additioinal swaps and just go directly to the test.
If there are some slot left, we will fill them.

The only difference is taht we shouldn't expect a failure until this
number of swaps has been reached.

So we should do:

	if (swapon(filename, 0) == -1) {
		if (errno == EPERM && swapfiles > min_swapfiles)
			break;

		tst_res(TFAIL | TERRNO, "swapon(%s, 0)", filename);
	}

> -		/* Create the swapfile */
> -		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
> -		SAFE_MAKE_SMALL_SWAPFILE(filename);
> +	SAFE_MAKE_SMALL_SWAPFILE(TEST_FILE);
> +	swapfiles++;

Why do we increase the number of swapfiles here? We only created the
file. Isn't the swapfiles counter for swaps that were enabled by
swapon()?

> -		/* turn on the swap file */
> -		TST_EXP_PASS_SILENT(swapon(filename, 0));
> -		if (!TST_PASS)
> -			tst_brk(TFAIL, "Failed to setup swap files");
> +	while (true) {
> +		/* Create the swapfile */
> +		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, swapfiles);
> +		MAKE_SMALL_SWAPFILE(filename);
> +
> +		/* Quit on a first swap file over max, check for EPERM */
> +		if (swapon(filename, 0) == -1) {
> +			if (errno != EPERM)
> +				tst_res(TFAIL | TERRNO, "swapon(%s, 0)", filename);
> +			break;
> +		}
> +		swapfiles++;
>  	}
>  
>  	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
> -	MAKE_SMALL_SWAPFILE(TEST_FILE);
>  
>  	return 0;
>  }
> @@ -61,7 +73,7 @@ static int setup_swap(void)
>   */
>  static int check_and_swapoff(const char *filename)
>  {
> -	char cmd_buffer[256];
> +	char cmd_buffer[FILENAME_MAX+28];
>  	int rc = -1;
>  
>  	snprintf(cmd_buffer, sizeof(cmd_buffer), "grep -q '%s.*file' /proc/swaps", filename);
> @@ -82,8 +94,8 @@ static void clean_swap(void)
>  	int j;
>  	char filename[FILENAME_MAX];
>  
> -	for (j = 0; j < swapfiles; j++) {
> -		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
> +	for (j = 1; j < swapfiles; j++) {
> +		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j);
>  		check_and_swapoff(filename);
>  	}
>  
> -- 
> 2.51.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
