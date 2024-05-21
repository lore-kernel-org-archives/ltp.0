Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3295DC25B75
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 12:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716293028; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=zx8SuQfjBQdSTFXkukln/5c7c17J7/L+C3b7kgXxtqQ=;
 b=Okle9a/V/x+vGiQnYlauudVkTA45U35uAyI5DuviGqM3JLMlk43RUwp9a+rfX+ySLVKQT
 Ci2Q4pPU+/YrZXNxZbWS8lsDOeYwUfZNBM1zm+VfMVbmwsJslcDNK/RS7csCrHkYvdp6w0Y
 LZuT+W2tXqpYy5Mp2S4qFi7wRxi232c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 394783D0093
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 14:03:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06A523CE539
 for <ltp@lists.linux.it>; Tue, 21 May 2024 14:03:26 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DA98D600C8D
 for <ltp@lists.linux.it>; Tue, 21 May 2024 14:03:25 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-574bf7ab218so9333284a12.1
 for <ltp@lists.linux.it>; Tue, 21 May 2024 05:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716293005; x=1716897805; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eKz+CDWDOop0nEu8PjfJleNdqoRO+NJkDTGmnyTQTbo=;
 b=c6UkZtpV2YcAxAJ7IZamBqZuMeOxc/4hiUsaUHzYy5SSh2q+i2dTChNuD0eYXnThX+
 +uOYdBKdz22BSh9Rt2hFTYeE93CQDg2Hpi21pMRhiNV3dQwavUwtuSXxB7d5f/cRoZjd
 0v9XdXG37yD80ZdlQjaJtWaL9KhL6a7vOJwGiOzA4H4RAtG+6c0RPCXNDz/DjIMVppym
 GNN0A3CviYSBd7PrFVObc3kmc9DIpLzw1q0EZ+I5axC1xKJ2IZh83upTyTKWv2cURjBd
 pGQrbfltKy4xFhCOzE+bmEZWrNo8r6zv8YGeGfoR38hjA+YOU6CIrfFFwnCFLaEacta5
 oj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716293005; x=1716897805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eKz+CDWDOop0nEu8PjfJleNdqoRO+NJkDTGmnyTQTbo=;
 b=XzO1Tf0jxGRRFiTTuocCPtinyC2Ofa7f7G58d+cAVIs/hMW46Y5zZGw6VNp0H5AibY
 MrGCOoWKivSt2YY0lelZxpIIvptiiPesirrbWZO8RN+H64GDPn6HTUrXIWCqn+P9NPvD
 kmd2s+cdnOAdc/1yEkU6IfFEgi7PVsZ2//2L7EJWTpTVlUAukFjiKWXN2lP9sM8055Jg
 UUde2yRPUMfKuMk51TPa3yo0jEclqEDIgXmTbZswLaU4oxbA7+JfEdAf1O6LXeECdRXD
 vMlIluhebe56lHz4abzwsqlQ04k2V6uchq35m7XFMWi2RlZENTaaTMOKi15jLQ2RJ5/u
 xOGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv60onWV8gLpuQGMtDG3SpdFSOO9ee+G8czosGaGqmPsxsGYOpUNg9t6M/R/JJKUxsi+2ji/tu4UPRZLdYUGa+bqo=
X-Gm-Message-State: AOJu0YwETObwv/cc+LISDXbBwfdqNeCwkEdkTP5M3MLMXOyBoNEcGVps
 FPzfC3ChXaSb+PdyuiVZC1MFbUh9W3De9oMR7A4jDZumlfLQ6Dnkx1PPpe//iL/hZUIa7k03IlK
 OG8E=
X-Google-Smtp-Source: AGHT+IGInFQmJqkpMBRKdvQkMmeJ3VoqqnaQKbzf0483DNRVLDnMvIow1pnfHXzyXD+KUX+yDSlsjw==
X-Received: by 2002:a17:907:7003:b0:a5d:15ec:7793 with SMTP id
 a640c23a62f3a-a5d15ec8398mr662256366b.35.1716293005173; 
 Tue, 21 May 2024 05:03:25 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:843f:e00:d596:e8e:78c7:ff41?
 ([2a02:a31b:843f:e00:d596:e8e:78c7:ff41])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5cebb3cd33sm681555766b.34.2024.05.21.05.03.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:03:24 -0700 (PDT)
Message-ID: <1d952ceb-1e8e-482d-99cf-3e1186cbdc6a@suse.com>
Date: Tue, 21 May 2024 14:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240521105348.126316-1-pvorel@suse.cz>
 <20240521105348.126316-4-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240521105348.126316-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/5] Refactor fork14 using new LTP API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Looks good to me, thanks

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 5/21/24 12:53, Petr Vorel wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Reviewed-by: Martin Doucha <mdoucha@suse.cz>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> [ pvorel: replace .skip_in_compat = 1 with .needs_abi_bits = 64 ]
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> * Change from .skip_in_32bit = 1 to .needs_abi_bits = 64
>
>   testcases/kernel/syscalls/fork/fork14.c | 209 +++++++++++-------------
>   1 file changed, 95 insertions(+), 114 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
> index 93af2ebac..d61864b52 100644
> --- a/testcases/kernel/syscalls/fork/fork14.c
> +++ b/testcases/kernel/syscalls/fork/fork14.c
> @@ -1,143 +1,124 @@
> -/*********************************************************************
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
>    * Copyright (C) 2014  Red Hat, Inc.
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
>    *
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
> + * This test is a reproducer for kernel 3.5:
> + * 7edc8b0ac16c ("mm/fork: fix overflow in vma length when copying mmap on clone")
>    *
> - * This test is a reporducer for this patch:
> - *              https://lkml.org/lkml/2012/4/24/328
> - * Since vma length in dup_mmap is calculated and stored in a unsigned
> + * Since VMA length in dup_mmap() is calculated and stored in a unsigned
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
> -
> -#define GB		(1024 * 1024 * 1024L)
>   
> -/* set mmap threshold to 16TB */
>   #define LARGE		(16 * 1024)
>   #define EXTENT		(16 * 1024 + 10)
>   
> -static char **pointer_vec;
> +static char **memvec;
>   
> -static void setup(void);
> -static void cleanup(void);
> -static int  fork_test(void);
> -
> -int main(int ac, char **av)
> +static void run(void)
>   {
> -	int lc, reproduced;
> -
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
> +	int i, j, ret;
> +	pid_t pid;
> +	void *mem;
> +	int prev_failed = 0;
> +	int passed = 1;
> +	int failures = 0;
>   
> -static void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> +	memset(memvec, 0, EXTENT);
>   
> -	pointer_vec = SAFE_MALLOC(cleanup, EXTENT * sizeof(char *));
> -}
> +	for (i = 0; i < EXTENT; i++) {
> +		mem = mmap(NULL, 1 * TST_GB,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS,
> +			0, 0);
>   
> -static void cleanup(void)
> -{
> -	free(pointer_vec);
> -}
> +		if (mem == MAP_FAILED) {
> +			failures++;
>   
> -static int fork_test(void)
> -{
> -	int i, j, prev_failed = 0, fails = 0, cnt = 0;
> -	int reproduced = 0;
> -	void *addr;
> +			tst_res(TINFO, "mmap() failed");
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
> -			 */
> -			if (fails == 11) {
> -				tst_brkm(TCONF, cleanup, "mmap() fails too many"
> -					 "times, so we are almost impossible to"
> -					 " get an vm_area_struct sized 16TB.");
> +			if (failures > 10) {
> +				tst_brk(TCONF, "mmap() fails too many "
> +					"times, so it's almost impossible to "
> +					"get a vm_area_struct sized 16TB");
>   			}
> -		} else {
> -			pointer_vec[i] = addr;
> +
> +			continue;
>   		}
> -		cnt++;
>   
> -		switch (tst_fork()) {
> -		case -1:
> +		memvec[i] = mem;
> +
> +		pid = fork();
> +
> +		if (pid == -1) {
> +			/* keep track of the failed fork() and verify that next one
> +			 * is failing as well.
> +			 */
>   			prev_failed = 1;
> -		break;
> -		case 0:
> +			continue;
> +		}
> +
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
> +		tst_res(TDEBUG, "fork() passed at %d attempt", i);
>   	}
>   
> -clear_memory_map:
> -	for (j = 0; j < cnt; j++) {
> -		if (pointer_vec[j])
> -			SAFE_MUNMAP(cleanup, pointer_vec[j], 1 * GB);
> +	for (j = 0; j < i; j++) {
> +		if (memvec[j])
> +			SAFE_MUNMAP(memvec[j], 1 * TST_GB);
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
> +	.needs_abi_bits = 64,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "7edc8b0ac16c"},
> +		{}
> +	}
> +};

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
