Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B012ECCF9F8
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 10:11:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 157E53CEA0D
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 11:11:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1C6E3C3264
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 11:11:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3AB2C6003A3
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 11:11:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9DE801F394;
 Thu,  6 Nov 2025 10:11:14 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E38313A31;
 Thu,  6 Nov 2025 10:11:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5oI4IkJ0DGmaQAAAD6G6ig
 (envelope-from <akumar@suse.de>); Thu, 06 Nov 2025 10:11:14 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 06 Nov 2025 11:11:14 +0100
Message-ID: <2396783.ElGaqSPkdT@thinkpad>
In-Reply-To: <20251105154716.995786-3-pvorel@suse.cz>
References: <20251105154716.995786-1-pvorel@suse.cz>
 <20251105154716.995786-3-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 9DE801F394
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] swapon03: Try to swapon() as many files until
 it fails
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
Cc: Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,
some comments inline

On Wednesday, November 5, 2025 4:47:15 PM CET Petr Vorel wrote:
> Previously tst_max_swapfiles() had fine tuning for a specific kernel
> version which was fragile due various backports in enterprise kernels.
> 
> Let's try to create and use as many swap files until swapon() fails.
> Then check for expected EPERM.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/swapon/swapon03.c | 63 +++++++++++++--------
>  1 file changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
> index b89d853188..0027f874be 100644
> --- a/testcases/kernel/syscalls/swapon/swapon03.c
> +++ b/testcases/kernel/syscalls/swapon/swapon03.c
> @@ -1,14 +1,18 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> + * Copyright (c) Linux Test Project, 2009-2025
>   * Copyright (c) International Business Machines Corp., 2007
>   * Created by <rsalveti@linux.vnet.ibm.com>
> - *
>   */
>  
>  /*\
> - * This test case checks whether swapon(2) system call returns:
> + * Test checks whether :man2:`swapon` system call returns EPERM when the maximum
> + * number of swap files are already in use.
>   *
> - *  - EPERM when there are more than MAX_SWAPFILES already in use.
> + * NOTE: test does not try to calculate MAX_SWAPFILES from the internal
> + * kernel implementation (which is currently <23, 29> depending on kernel
> + * configuration). Instead test exptect that at least 15 swap files minus
> + * currently used swap can be created.
>   */
>  
>  #include <stdio.h>
> @@ -20,49 +24,54 @@
>  #include "lapi/syscalls.h"
>  #include "libswap.h"
>  
> +#define NUM_SWAP_FILES 15
>  #define MNTPOINT	"mntpoint"
>  #define TEST_FILE	MNTPOINT"/testswap"
>  
> -static int swapfiles;
> +static int *swapfiles;
>  
>  static void setup_swap(void)
>  {
>  	pid_t pid;
> -	int status;
> -	int j, max_swapfiles, used_swapfiles;
> +	int status, used_swapfiles, expected_swapfiles;
>  	char filename[FILENAME_MAX];
>  
>  	SAFE_SETEUID(0);
>  
> -	/* Determine how many more files are to be created */
> -	max_swapfiles = tst_max_swapfiles();
>  	used_swapfiles = tst_count_swaps();
> -	swapfiles = max_swapfiles - used_swapfiles;
> -	if (swapfiles > max_swapfiles)
> -		swapfiles = max_swapfiles;
> +	expected_swapfiles = NUM_SWAP_FILES - used_swapfiles;
> +
> +	if (expected_swapfiles < 0) {
do we want to proceed when expected_swapfiles is 0 here?
> +		tst_brk(TCONF, "Warning: too many used swap files (%d)",
> +			expected_swapfiles);
I think this should be used_swapfiles ?
> +	}
>  
>  	pid = SAFE_FORK();
>  	if (pid == 0) {
> -		/*create and turn on remaining swapfiles */
> -		for (j = 0; j < swapfiles; j++) {
> -
> +		while (true) {
>  			/* Create the swapfile */
> -			snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
> +			snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, *swapfiles);
>  			MAKE_SMALL_SWAPFILE(filename);
>  
> -			/* turn on the swap file */
> -			TST_EXP_PASS_SILENT(swapon(filename, 0));
> +			/* Quit on a first swap file over max */
> +			if (swapon(filename, 0) == -1)
so now first swapon() fail is here and then we check for errno==EPERM by
making another swapon() call in verify_swapon function.
Is it possible to combine setup_swap() and verify_swapon() and check for
EPERM on first swapon() fail itself?

> +				break;
> +			(*swapfiles)++;
>  		}
>  		exit(0);
>  	} else {
>  		waitpid(pid, &status, 0);
>  	}
>  
> -	if (WEXITSTATUS(status))
> +	if (WEXITSTATUS(status) || *swapfiles == 0)
>  		tst_brk(TBROK, "Failed to setup swap files");
>  
> -	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
> -	MAKE_SMALL_SWAPFILE(TEST_FILE);
> +	if (*swapfiles < expected_swapfiles) {
> +		tst_res(TWARN, "Successfully created only %d swap files (>= %d expected)",
> +			*swapfiles, expected_swapfiles);
> +	} else {
> +		tst_res(TINFO, "Successfully created %d swap files", *swapfiles);
> +	}
>  }
>  
>  /*
> @@ -86,8 +95,8 @@ static void clean_swap(void)
>  	int j;
>  	char filename[FILENAME_MAX];
>  
> -	for (j = 0; j < swapfiles; j++) {
> -		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
> +	for (j = 0; j < *swapfiles; j++) {
> +		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j);
>  		check_and_swapoff(filename);
>  	}
>  
> @@ -105,12 +114,20 @@ static void setup(void)
>  		tst_brk(TCONF, "swap not supported by kernel");
>  
>  	is_swap_supported(TEST_FILE);
> +
> +	swapfiles = SAFE_MMAP(NULL, sizeof(*swapfiles), PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +	*swapfiles = 0;
> +
>  	setup_swap();
>  }
>  
>  static void cleanup(void)
>  {
> -	clean_swap();
> +	if (swapfiles) {
> +		clean_swap();
> +		SAFE_MUNMAP(swapfiles, sizeof(*swapfiles));
> +	}
>  }
>  
>  static struct tst_test test = {
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
