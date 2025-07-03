Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5031CC77B7C
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 14:12:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0A643C998B
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 16:12:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41CF53C4DF6
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 16:12:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 08BD71400B89
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 16:12:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17E152116E;
 Thu,  3 Jul 2025 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751551948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f6v+3IE8Y1+xVxgLSeUCHlf4/KuM/KcfFlLDOkTQ9y8=;
 b=aZta3Db59YSlbMLJOrbFXQWoZx4Cbt/kikxG60DQmAE0+qzsY/heY5giDfECJHkmF530Ws
 DDpOw42ihKrW28sLp51TG+3BLrNV3Luxo2w+ZV6YwcbBzKgdv6MgNGfttK7C4RuqhGhfkr
 ajyxCCEyuS5n962g/huHvW+t5Gu7s3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751551948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f6v+3IE8Y1+xVxgLSeUCHlf4/KuM/KcfFlLDOkTQ9y8=;
 b=zVhZnIHFPGLVeVD9JFof6LhOpbY6gI/BhO+QeZMzu8RuplkxBYh1mQfSCrcRBKBXn4egki
 L9q0AeBTh85eZSAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751551948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f6v+3IE8Y1+xVxgLSeUCHlf4/KuM/KcfFlLDOkTQ9y8=;
 b=aZta3Db59YSlbMLJOrbFXQWoZx4Cbt/kikxG60DQmAE0+qzsY/heY5giDfECJHkmF530Ws
 DDpOw42ihKrW28sLp51TG+3BLrNV3Luxo2w+ZV6YwcbBzKgdv6MgNGfttK7C4RuqhGhfkr
 ajyxCCEyuS5n962g/huHvW+t5Gu7s3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751551948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f6v+3IE8Y1+xVxgLSeUCHlf4/KuM/KcfFlLDOkTQ9y8=;
 b=zVhZnIHFPGLVeVD9JFof6LhOpbY6gI/BhO+QeZMzu8RuplkxBYh1mQfSCrcRBKBXn4egki
 L9q0AeBTh85eZSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BE911368E;
 Thu,  3 Jul 2025 14:12:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FeimAsyPZmi/XgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Thu, 03 Jul 2025 14:12:28 +0000
Message-ID: <135e7656-ce26-4ac4-98e2-1982bf1c5454@suse.cz>
Date: Thu, 3 Jul 2025 16:12:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250702-crash02_rewrite-v3-1-260cc6db6017@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20250702-crash02_rewrite-v3-1-260cc6db6017@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:mid,
 suse.cz:email, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] misc: rewrite crash02 test
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
Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 02. 07. 25 10:28, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Rewrite the crash02 test, introducing new API but maintaining the logic
> behind it. The test generates random syscall executions with random data
> and it verifies that system didn't crash.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v3:
> - simplify random number generator
> - add __SYS_clone2 to blacklist
> - set runtime according to the number of tries
> - Link to v2: https://lore.kernel.org/r/20250624-crash02_rewrite-v2-1-c4eaeee8598f@suse.com
> 
> Changes in v2:
> - simplify number generator
> - take seed with -s parameter or use time(NULL)
> - move loop inside child, so we can use the same seed  via srand()
> - take back in_blacklist() method
> - Link to v1: https://lore.kernel.org/r/20250611-crash02_rewrite-v1-1-1becd9dc163d@suse.com
> ---
>   testcases/misc/crash/crash02.c | 557 ++++++++---------------------------------
>   1 file changed, 108 insertions(+), 449 deletions(-)
> 
> diff --git a/testcases/misc/crash/crash02.c b/testcases/misc/crash/crash02.c
> index c68f580ef62ad3b3c644093f72646a8908e55076..04f56c619f5bfd12b30f90d6d0158556ebbeab6c 100644
> --- a/testcases/misc/crash/crash02.c
> +++ b/testcases/misc/crash/crash02.c
> @@ -1,497 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - * crash02.c - Test OS robustness by executing syscalls with random args.
> - *
> - * Copyright (C) 2001 Stephane Fillod <f4cfe@free.fr>
> - *
> - * This test program was inspired from crashme, by GEORGE J. CARRETT.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA	02111-1307, USA.
> + * Copyright (C) 2025 SUSE LLC <andrea.cervesato@suse.com>
>    */
>   
> -/*
> -A signal handler is set up so that in most cases the machine exception
> -generated by the illegal syscall, bad operands, etc in the procedure
> -made up of random data are caught; and another round of randomness may
> -be tried. Eventually a random syscall may corrupt the program or
> -the machine state in such a way that the program must halt. This is
> -a test of the robustness of the hardware/software for instruction
> -fault handling.
> -
> -Note: Running this program just a few times, using total CPU time of
> -less than a few seconds SHOULD NOT GIVE YOU ANY CONFIDENCE in system
> -robustness. Having it run for hours, with tens of thousands of cases
> -would be a different thing. It would also make sense to run this
> -stress test at the same time you run other tests, like a multi-user
> -benchmark.
> -
> -CAUTION: running this program may crash your system, your disk and all
> -	your data along! DO NOT RUN IT ON PRODUCTION SYSTEMS!
> -	CONSIDER YOUR DISK FRIED.
> -	REMEMBER THE DISCLAIMER PART OF THE LICENSE.
> -
> -	Running as user nobody and with all your filesystems
> -	remounted to readonly may be wise..
> -
> -TODO:
> -	* in rand_long(), stuff in some real pointers to random data
> -	* Does a syscall is supposed to send SIGSEGV?
> -*/
> -
> -#define _GNU_SOURCE
> -#include <sys/syscall.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <signal.h>
> -#include <setjmp.h>
> -#include <time.h>
> -#include <unistd.h>
> -#include <errno.h>
> -#include <sys/types.h>
> -#include <sys/wait.h>
> -
> -#include "test.h"
> -
> -char *TCID = "crash02";
> -int TST_TOTAL = 1;
> -
> -static int x_opt = 0;
> -static int v_opt = 0;
> -static char *v_copt;
> -static int s_opt = 0;
> -static char *s_copt;
> -static int l_opt = 0;
> -static char *l_copt;
> -static int n_opt = 0;
> -static char *n_copt;
> -
> -int verbose_level = 2;
> -
> -/* depends on architecture.. */
> -unsigned int sysno_max = 127;
> -
> -int nseed;
> -int ntries = 100;
> -
> -/* max time allowed per try, in seconds */
> -#define MAX_TRY_TIME 5
> -
> -void cleanup(void)
> -{
> -
> -	tst_rmdir();
> +/*\
> + * Test the robustness of the system generating random syscalls execution
> + * with random data and expecting that the current system is not crashing.
> + */
>   
> -}
> +#include <stdlib.h>
> +#include <limits.h>
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +#define MAX_SYSCALLS 465
> +
> +static int *num_errors;
> +static char *str_num_tries;
> +static char *str_seed;
> +static int num_tries = 1000;
> +static int seed;
> +
> +static int blacklist[] = {
> +	__NR_vfork,
> +	__NR_fork,
> +	__NR_clone,
> +	__NR_clone2,
> +	__NR_clone3,
> +	__NR_vhangup,		/* terminal logout */
> +	__NR_pause,		/* sleep indefinitely */
> +	__NR_read,		/* sleep indefinitely if the first argument is 0 */
> +	__NR_kill,		/* might kill test */
> +	__NR_restart_syscall,	/* restart random syscalls */
> +	__LTP__NR_INVALID_SYSCALL,
> +};
>   
> -void setup(void)
> +static long rand_number(void)
>   {
> -	/*
> -	 * setup a default signal hander and a
> -	 * temporary working directory.
> -	 */
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	long num = 0;
>   
> -	TEST_PAUSE;
> +	for (size_t i = 0; i < sizeof(long); i++)
> +		num |= ((rand() & 0xFFUL) << (i * 8));
>   
> -	tst_tmpdir();
> +	return num;
>   }
>   
> -void help(void)
> +static int in_blacklist(const int sysno)
>   {
> -	printf
> -	    ("	-x		dry run, hexdump random code instead\n");
> -	printf("	-l x		max syscall no\n");
> -	printf("	-v x		verbose level\n");
> -	printf("	-s x		random seed\n");
> -	printf("	-n x		ntries\n");
> -}
> -
> -/*
> - */
> -option_t options[] = {
> -	{"v:", &v_opt, &v_copt},
> -	{"l:", &l_opt, &l_copt},
> -	{"s:", &s_opt, &s_copt},
> -	{"n:", &n_opt, &n_copt},
> -	{"x", &x_opt, NULL},
> -
> -	{NULL, NULL, NULL}
> -};
> -
> -void badboy_fork();
> -void badboy_loop();
> +	for (size_t i = 0; i < ARRAY_SIZE(blacklist); i++)
> +		if (sysno == blacklist[i])
> +			return 1;
>   
> -void summarize_errno();
> -void record_errno(unsigned int n);
> +	return 0;
> +}
>   
> -int main(int argc, char *argv[])
> +static void try_crash(const int num)
>   {
> -	int lc;
> -
> -	tst_parse_opts(argc, argv, options, help);
> +	long sysno, arg0, arg1, arg2, arg3, arg4, arg5, arg6;
> +	int ret;
>   
> -	if (v_opt)
> -		verbose_level = atoi(v_copt);
> -
> -	if (n_opt)
> -		ntries = atoi(n_copt);
> -
> -	if (l_opt)
> -		sysno_max = atoi(l_copt);
> -
> -	if (s_opt)
> -		nseed = atoi(s_copt);
> -	else
> -		nseed = time(NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> +	do {
> +		sysno = rand() % MAX_SYSCALLS;
> +	} while (in_blacklist(sysno));
>   
> -		tst_resm(TINFO, "crashme02 %d %d %d", sysno_max, nseed, ntries);
> +	arg0 = rand_number();
> +	arg1 = rand_number();
> +	arg2 = rand_number();
> +	arg3 = rand_number();
> +	arg4 = rand_number();
> +	arg5 = rand_number();
> +	arg6 = rand_number();
>   
> -		srand(nseed);
> -		badboy_fork();
> +	tst_res(TDEBUG,
> +		"%d: syscall(%ld, %#lx, %#lx, %#lx, %#lx, %#lx, %#lx, %#lx)",
> +		num, sysno, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
>   
> -		/* still there? */
> -		tst_resm(TPASS, "we're still here, OS seems to be robust");
> +	ret = syscall(sysno, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
> +	if (ret == -1) {
> +		(*num_errors)++;
>   
> -		nseed++;
> +		tst_res(TDEBUG, "syscall error: %s", strerror(errno));
>   	}
> -	cleanup();
> -	tst_exit();
>   }
>   
> -/* ************************* */
> -int badboy_pid;
> -
> -void my_signal(int sig, void (*func) ());
> -
> -void monitor_fcn(int sig)
> +static void run(void)
>   {
> +	pid_t pid;
>   	int status;
> +	int num_signals = 0;
>   
> -	if (verbose_level >= 3)
> -		printf("time limit reached on pid. using kill.\n");
> +	*num_errors = 0;
>   
> -	status = kill(badboy_pid, SIGKILL);
> -	if (status < 0) {
> -		if (verbose_level >= 3)
> -			printf("failed to kill process\n");
> -	}
> -}
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		for (int i = 0; i < num_tries; i++)
> +			try_crash(i);
>   
> -void badboy_fork(void)
> -{
> -	int status, pid;
> -	pid_t child = fork();
> -
> -	switch (child) {
> -	case -1:
> -		perror("fork");
> -	case 0:
> -#ifdef DEBUG_LATE_BADBOY
> -		sleep(ntries * MAX_TRY_TIME + 10);
> -#else
> -		badboy_loop();
> -#endif
>   		exit(0);
> -	default:
> -		badboy_pid = child;
> -		if (verbose_level > 3)
> -			printf("badboy pid = %d\n", badboy_pid);
> -
> -		/* don't trust the child to return at night */
> -		my_signal(SIGALRM, monitor_fcn);
> -		alarm(ntries * MAX_TRY_TIME);
> -
> -		pid = waitpid(-1, &status, WUNTRACED);
> -		if (pid <= 0)
> -			perror("wait");
> -		else {
> -			if (verbose_level > 3)
> -				printf("pid %d exited with status %d\n",
> -				       pid, status);
> -#if 0
> -			record_status(status);
> -#endif
> -		}
> -	}
> -	alarm(0);
> -}
> -
> -/* *************** status recording ************************* */
> -
> -/* errno status table (max is actually around 127) */
> -#define STATUS_MAX 256
> -static int errno_table[STATUS_MAX];
> -
> -void record_errno(unsigned int n)
> -{
> -	if (n >= STATUS_MAX)
> -		return;
> -
> -	errno_table[n]++;
> -}
> -
> -/* may not work with -c option */
> -void summarize_errno(void)
> -{
> -	int i;
> -
> -	if (x_opt || verbose_level < 2)
> -		return;
> -
> -	printf("errno status ... number of cases\n");
> -	for (i = 0; i < STATUS_MAX; i++) {
> -		if (errno_table[i])
> -			printf("%12d ... %5d\n", i, errno_table[i]);
>   	}
> -}
> -
> -/* ************* badboy ******************************************* */
>   
> -jmp_buf again_buff;
> +	SAFE_WAITPID(pid, &status, 0);
>   
> -unsigned char *bad_malloc(int n);
> -void my_signal(int sig, void (*func) ());
> -void again_handler(int sig);
> -void try_one_crash(int try_num);
> -void set_up_signals();
> -int in_blacklist(int sysno);
> +	if (WIFSIGNALED(status)) {
> +		num_signals++;
>   
> -/* badboy "entry" point */
> -
> -/*
> - * Unlike crashme, faulty syscalls are not supposed to barf
> - */
> -void badboy_loop(void)
> -{
> -	int i;
> -
> -	for (i = 0; i < ntries; ++i) {
> -		/* level 5 */
> -
> -		if (!x_opt && verbose_level >= 5) {
> -			printf("try %d\n", i);
> -		}
> -
> -		if (setjmp(again_buff) == 3) {
> -			if (verbose_level >= 5)
> -				printf("Barfed\n");
> -		} else {
> -			set_up_signals();
> -			alarm(MAX_TRY_TIME);
> -			try_one_crash(i);
> -		}
> +		tst_res(TDEBUG, "syscall signaled: %s",
> +			strsignal(WTERMSIG(status)));
>   	}
> -	summarize_errno();
> -}
>   
> -void again_handler(int sig)
> -{
> -	char *ss;
> -
> -	switch (sig) {
> -	case SIGILL:
> -		ss = " illegal instruction";
> -		break;
> -#ifdef SIGTRAP
> -	case SIGTRAP:
> -		ss = " trace trap";
> -		break;
> -#endif
> -	case SIGFPE:
> -		ss = " arithmetic exception";
> -		break;
> -#ifdef SIGBUS
> -	case SIGBUS:
> -		ss = " bus error";
> -		break;
> -#endif
> -	case SIGSEGV:
> -		ss = " segmentation violation";
> -		break;
> -#ifdef SIGIOT
> -	case SIGIOT:
> -		ss = " IOT instruction";
> -		break;
> -#endif
> -#ifdef SIGEMT
> -	case SIGEMT:
> -		ss = " EMT instruction";
> -		break;
> -#endif
> -#ifdef SIGALRM
> -	case SIGALRM:
> -		ss = " alarm clock";
> -		break;
> -#endif
> -	case SIGINT:
> -		ss = " interrupt";
> -		break;
> -	default:
> -		ss = "";
> -	}
> -	if (verbose_level >= 5)
> -		printf("Got signal %d%s\n", sig, ss);
> +	tst_res(TINFO, "Detected errors: %d", *num_errors);
> +	tst_res(TINFO, "Detected signals: %d", num_signals);
>   
> -	longjmp(again_buff, 3);
> +	tst_res(TPASS, "System is still up and running");
>   }
>   
> -void my_signal(int sig, void (*func) ())
> +static void setup(void)
>   {
> -	struct sigaction act;
> +	if (tst_parse_int(str_num_tries, &num_tries, 1, INT_MAX))
> +		tst_brk(TBROK, "Invalid number of entries '%s'", str_num_tries);
>   
> -	act.sa_handler = func;
> -	memset(&act.sa_mask, 0x00, sizeof(sigset_t));
> -	act.sa_flags = SA_NOMASK | SA_RESTART;
> -	sigaction(sig, &act, 0);
> -}
> +	if (tst_parse_int(str_seed, &seed, 0, INT_MAX))
> +		tst_brk(TBROK, "Invalid seed number '%s'", str_num_tries);
>   
> -void set_up_signals(void)
> -{
> -	my_signal(SIGILL, again_handler);
> -#ifdef SIGTRAP
> -	my_signal(SIGTRAP, again_handler);
> -#endif
> -	my_signal(SIGFPE, again_handler);
> -#ifdef SIGBUS
> -	my_signal(SIGBUS, again_handler);
> -#endif
> -	my_signal(SIGSEGV, again_handler);
> -#ifdef SIGIOT
> -	my_signal(SIGIOT, again_handler);
> -#endif
> -#ifdef SIGEMT
> -	my_signal(SIGEMT, again_handler);
> -#endif
> -#ifdef SIGALRM
> -	my_signal(SIGALRM, again_handler);
> -#endif
> -	my_signal(SIGINT, again_handler);
> -}
> -
> -/*
> - * NB: rand() (ie. RAND_MAX) might be on 31bits only!
> - *
> - * FIXME: 64-bit systems
> - *
> - * TODO: improve arg mixing (16bits and 8bits values, NULLs, etc.).
> - *	big values as returned by rand() are no so interresting
> - *	(except when used as pointers) because they may fall too
> - *	quickly in the invalid parameter sieve. Smaller values,
> - *	will be more insidious because they may refer to existing
> - *	objects (pids, fd, etc.).
> - */
> -long int rand_long(void)
> -{
> -	int r1, r2;
> +	num_errors = SAFE_MMAP(
> +		NULL, sizeof(int),
> +		PROT_READ | PROT_WRITE,
> +		MAP_SHARED | MAP_ANONYMOUS,
> +		-1, 0);
>   
> -	r1 = rand();
> -	r2 = rand();
> +	seed = str_seed ? seed : time(NULL);
> +	srand(seed);
>   
> -	if (r1 & 0x10000L)
> -		r1 = 0;
> -	if (!r1 && (r2 & 0x50000L))
> -		r2 = 0;
> -	else if (!r1 && (r2 & 0x20000L))
> -		r2 &= 0x00ffL;
> +	tst_res(TINFO, "Random seed: %d", seed);
> +	tst_res(TINFO, "Number of tries: %d", num_tries);
>   
> -	return (long int)((r1 & 0xffffL) << 16) | (r2 & 0xffffL);
> +	tst_set_runtime((num_tries / 1000) + 1);
>   }
>   
> -void try_one_crash(int try_num)
> +static void cleanup(void)
>   {
> -	long int sysno, arg1, arg2, arg3, arg4, arg5, arg6, arg7;
> -
> -	do {
> -		sysno = rand() % sysno_max;
> -	} while (in_blacklist(sysno));
> -
> -	arg1 = rand_long();
> -	arg2 = rand_long();
> -	arg3 = rand_long();
> -	arg4 = rand_long();
> -	arg5 = rand_long();
> -	arg6 = rand_long();
> -	arg7 = rand_long();
> -
> -	if (x_opt || verbose_level >= 1)
> -		printf("%04d: syscall(%ld, %#lx, %#lx, %#lx, %#lx, %#lx, "
> -		       "%#lx, %#lx)\n", try_num, sysno, arg1, arg2, arg3,
> -		       arg4, arg5, arg6, arg7);
> -
> -	if (!x_opt) {
> -		syscall(sysno, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
> -		record_errno(errno);
> -	}
> +	if (num_errors)
> +		SAFE_MUNMAP(num_errors, sizeof(int));
>   }
>   
> -/* The following syscalls create new processes which may cause the test
> -	 unable to finish. */
> -int in_blacklist(int sysno)
> -{
> -	int i;
> -	const int list[] = {
> -#if defined(__ia64__)
> -		SYS_clone2,
> -#else
> -		/*
> -		 * No SYS_fork(vfork) on IA-64. Instead, it uses,
> -		 * clone(child_stack=0, flags=CLONE_VM|CLONE_VFORK|SIGCHLD)
> -		 * clone2()
> -		 */
> -
> -		/*
> -		 * NOTE (garrcoop):
> -		 * Could not find reference to SYS_fork(vfork) on mips32
> -		 * with the Montavista / Octeon toolchain. Need to develop an
> -		 * autoconf check for this item.
> -		 */
> -#if defined(__NR_vfork) && __NR_vfork
> -		SYS_vfork,
> -#endif
> -#if defined(__NR_fork) && __NR_fork
> -		SYS_fork,
> -#endif
> -#endif /* __ia64__ */
> -#if defined(__NR_clone) && __NR_clone
> -		SYS_clone,
> -#endif
> -#if defined(__NR_vhangup) && __NR_vhangup
> -		__NR_vhangup,	/* int vhangup(void); - terminal logout */
> -#endif
> -#if defined(__NR_pause) && __NR_pause
> -		__NR_pause,	/* int pause(void); - sleep indefinitely */
> -#endif
> -#if defined(__NR_read) && __NR_read
> -		/*
> -		 * ssize_t read(int fd, void *buf, size_t count); - will sleep
> -		 * indefinitely if the first argument is 0
> -		 */
> -		__NR_read,
> -#endif
> -		-1
> -	};
> -
> -	for (i = 0; list[i] != -1; i++) {
> -		if (sysno == list[i])
> -			return 1;
> -	}
> -
> -	return 0;
> -}
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +	.options = (struct tst_option []) {
> +		{"n:", &str_num_tries, "Number of retries (default: 1000)"},
> +		{"s:", &str_seed, "Initial seed for random generator"},
> +		{}
> +	},
> +};
> 
> ---
> base-commit: a908cff70f9389c2dd2bf535976cb179bfa8f340
> change-id: 20250611-crash02_rewrite-b84ec3d0d22a
> 
> Best regards,


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
