Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8EAC4345F
	for <ltp@archiver.kernel.org>; Thu,  2 May 2024 13:20:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AE013CC1F9
	for <ltp@archiver.kernel.org>; Thu,  2 May 2024 15:20:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BABB3C8658
 for <ltp@lists.linux.it>; Thu,  2 May 2024 15:20:14 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8C44F100184D
 for <ltp@lists.linux.it>; Thu,  2 May 2024 15:20:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6DFF41FB53;
 Thu,  2 May 2024 13:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714656012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DgCuLeML2zpyRJNR1UlMKMUG3Am8W32x8h9+dS14gEM=;
 b=FJzxAOJN/JpDYCQHFheMcV4vGg7k8ISBjIN3zXXclZW68kZ0IAwmjpVjQp4uZqPaOpt56R
 OdvZrtPb4IL32LLrFXaSHsM/nCpLArFvSImi5RSHYnNT87vBgO+Cx88aYecWy/g641jT9I
 BI72pABYOAW72ZPK1zo7KSqk6sxZnFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714656012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DgCuLeML2zpyRJNR1UlMKMUG3Am8W32x8h9+dS14gEM=;
 b=5PgtxnFpf0HM3bJtih6mOrIy1w99CnzPqZPp+UP4zg7Qy3lqLQn20bat2y3yg0TQad7RR1
 itFg8OQpYXA8AkBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FJzxAOJN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5PgtxnFp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714656012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DgCuLeML2zpyRJNR1UlMKMUG3Am8W32x8h9+dS14gEM=;
 b=FJzxAOJN/JpDYCQHFheMcV4vGg7k8ISBjIN3zXXclZW68kZ0IAwmjpVjQp4uZqPaOpt56R
 OdvZrtPb4IL32LLrFXaSHsM/nCpLArFvSImi5RSHYnNT87vBgO+Cx88aYecWy/g641jT9I
 BI72pABYOAW72ZPK1zo7KSqk6sxZnFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714656012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DgCuLeML2zpyRJNR1UlMKMUG3Am8W32x8h9+dS14gEM=;
 b=5PgtxnFpf0HM3bJtih6mOrIy1w99CnzPqZPp+UP4zg7Qy3lqLQn20bat2y3yg0TQad7RR1
 itFg8OQpYXA8AkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 627D51386E;
 Thu,  2 May 2024 13:20:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iYPKFwyTM2YvTAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Thu, 02 May 2024 13:20:12 +0000
Message-ID: <b4d53d0b-5b13-494e-bd01-18bc52af3069@suse.cz>
Date: Thu, 2 May 2024 15:20:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20240322090435.11756-1-andrea.cervesato@suse.de>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240322090435.11756-1-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6DFF41FB53
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Refactor fork14 using new LTP API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
there's a stale pointer issue in memvec if you run the test with 
multiple iterations. See below.

On 22. 03. 24 10:04, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> .skip_in_compat usage
> Fixed typos
> Fixed license
> 
>   testcases/kernel/syscalls/fork/fork14.c | 205 +++++++++++-------------
>   1 file changed, 92 insertions(+), 113 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
> index 93af2ebac..421f2caa3 100644
> --- a/testcases/kernel/syscalls/fork/fork14.c
> +++ b/testcases/kernel/syscalls/fork/fork14.c
> @@ -1,143 +1,122 @@
> -/*********************************************************************
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
>    * Copyright (C) 2014  Red Hat, Inc.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it
> - * is free of the rightful claim of any third person regarding
> - * infringement or the like.  Any license provided herein, whether
> - * implied or otherwise, applies only to this software file.  Patent
> - * licenses, if any, provided herein do not apply to combinations of
> - * this program with other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
>    *
>    * This test is a reporducer for this patch:
> - *              https://lkml.org/lkml/2012/4/24/328
> + * https://lore.kernel.org/lkml/1335289853-2923-1-git-send-email-siddhesh.poyarekar@gmail.com/
>    * Since vma length in dup_mmap is calculated and stored in a unsigned
>    * int, it will overflow when length of mmaped memory > 16 TB. When
> - * overflow occur, fork will  incorrectly succeed. The patch above
> - * fixed it.
> - ********************************************************************/
> + * overflow occurs, fork will incorrectly succeed. The patch above fixed it.
> + */
>   
> -#include <sys/mman.h>
> +#include "tst_test.h"
> +#include <stdlib.h>
>   #include <sys/wait.h>
> -#include <stdio.h>
> -#include <unistd.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/abisize.h"
> -
> -char *TCID = "fork14";
> -int TST_TOTAL = 1;
>   
> -#define GB		(1024 * 1024 * 1024L)
> -
> -/* set mmap threshold to 16TB */
>   #define LARGE		(16 * 1024)
>   #define EXTENT		(16 * 1024 + 10)
>   
> -static char **pointer_vec;
> -
> -static void setup(void);
> -static void cleanup(void);
> -static int  fork_test(void);
> +static char **memvec;
>   
> -int main(int ac, char **av)
> +static void run(void)
>   {
> -	int lc, reproduced;
> +	int i, j, ret;
> +	pid_t pid;
> +	void *mem;
> +	int prev_failed = 0;
> +	int passed = 1;
> +	int failures = 0;
>   
> -	tst_parse_opts(ac, av, NULL, NULL);
> -/*
> - * Tested on ppc64/x86_64/i386/s390x. And only 64bit has this issue.
> - * Since a 32bit program can't mmap so many memory.
> - */
> -#ifdef TST_ABI32
> -	tst_brkm(TCONF, NULL, "This test is only for 64bit.");
> -#endif
> -	setup();
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		reproduced = fork_test();
> -		if (reproduced == 0)
> -			tst_resm(TPASS, "fork failed as expected.");
> -	}
> -	cleanup();
> -	tst_exit();
> -}
> +	for (i = 0; i < EXTENT; i++) {
> +		mem = mmap(NULL, 1 * TST_GB,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS,
> +			0, 0);
>   
> -static void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> +		if (mem == MAP_FAILED) {
> +			failures++;
>   
> -	pointer_vec = SAFE_MALLOC(cleanup, EXTENT * sizeof(char *));
> -}
> +			tst_res(TINFO, "mmap() failed");
>   
> -static void cleanup(void)
> -{
> -	free(pointer_vec);
> -}
> +			if (failures > 10) {
> +				tst_brk(TCONF, "mmap() fails too many "
> +					"times, so it's almost impossible to "
> +					"get a vm_area_struct sized 16TB.");
> +			}
>   
> -static int fork_test(void)
> -{
> -	int i, j, prev_failed = 0, fails = 0, cnt = 0;
> -	int reproduced = 0;
> -	void *addr;
> +			continue;
> +		}
>   
> -	for (i = 0; i < EXTENT; i++) {
> -		addr = mmap(NULL, 1 * GB, PROT_READ | PROT_WRITE,
> -			    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> -		if (addr == MAP_FAILED) {
> -			pointer_vec[i] = NULL;
> -			fails++;
> -			/*
> -			 * EXTENT is "16*1024+10", if fails count exceeds 10,
> -			 * we are almost impossible to get an vm_area_struct
> -			 * sized 16TB
> +		memvec[i] = mem;
> +
> +		pid = fork();
> +
> +		if (pid == -1) {
> +			/* keep track of the failed fork() and verify that next one
> +			 * is failing as well.
>   			 */
> -			if (fails == 11) {
> -				tst_brkm(TCONF, cleanup, "mmap() fails too many"
> -					 "times, so we are almost impossible to"
> -					 " get an vm_area_struct sized 16TB.");
> -			}
> -		} else {
> -			pointer_vec[i] = addr;
> +			prev_failed = 1;
> +			continue;
>   		}
> -		cnt++;
>   
> -		switch (tst_fork()) {
> -		case -1:
> -			prev_failed = 1;
> -		break;
> -		case 0:
> +		if (!pid)
>   			exit(0);
> -		default:
> -			SAFE_WAITPID(cleanup, -1, NULL, 0);
>   
> -			if (prev_failed > 0 && i >= LARGE) {
> -				tst_resm(TFAIL, "Fork succeeds incorrectly");
> -				reproduced = 1;
> -				goto clear_memory_map;
> -			}
> +		ret = waitpid(pid, NULL, 0);
> +		if (ret == -1 && errno != ECHILD)
> +			tst_brk(TBROK | TERRNO, "waitpid() error");
> +
> +		if (prev_failed && i >= LARGE) {
> +			passed = 0;
> +			break;
>   		}
> +
> +		prev_failed = 0;
> +
> +		tst_res(TINFO, "fork() passed at %d attempt", i);
>   	}
>   
> -clear_memory_map:
> -	for (j = 0; j < cnt; j++) {
> -		if (pointer_vec[j])
> -			SAFE_MUNMAP(cleanup, pointer_vec[j], 1 * GB);
> +	for (j = 0; j < i; j++) {
> +		if (memvec[j])
> +			SAFE_MUNMAP(memvec[j], 1 * TST_GB);

The memvec array never gets cleared after setup() so if you run the test 
with multiple iterations (e.g. -i 5), non-NULL pointers will accumulate 
in memvec between test iterations and you may end up unmapping an 
address range that was reused by libc.

>   	}
>   
> -	return reproduced;
> +	if (passed)
> +		tst_res(TPASS, "fork() failed as expected");
> +	else
> +		tst_res(TFAIL, "fork() succeeded incorrectly");
>   }
> +
> +static void setup(void)
> +{
> +	memvec = SAFE_MALLOC(EXTENT * sizeof(char *));
> +	memset(memvec, 0, EXTENT);
> +}
> +
> +static void cleanup(void)
> +{
> +	for (long i = 0; i < EXTENT; i++) {
> +		if (memvec && memvec[i])
> +			SAFE_MUNMAP(memvec[i], 1 * TST_GB);
> +	}
> +
> +	if (memvec)
> +		free(memvec);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +	.skip_in_compat = 1,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "7edc8b0ac16c"},
> +		{}
> +	}
> +};

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
