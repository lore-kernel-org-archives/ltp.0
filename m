From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 16 Jun 2021 21:13:19 +0800
Subject: [LTP] [PATCH 2/3] syscalls/getrusage: Cleanup and bugfix for
 getrusage03
In-Reply-To: <YMnk5QUhwnOHrWLi@yuki>
References: <20210616093606.214856-1-xieziyao@huawei.com>
 <20210616093606.214856-3-xieziyao@huawei.com> <YMnk5QUhwnOHrWLi@yuki>
Message-ID: <8f8852e0-eed3-f7ae-744e-db48724e9b02@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Cyril,

>>
>> -int main(int argc, char *argv[])
>> +static void check_result(int result, char *msg)
>>   {
>> -	int lc;
>> -
>> -	tst_parse_opts(argc, argv, NULL, NULL);
>> -
>> -	setup();
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -		tst_count = 0;
>> -
>> -		tst_resm(TINFO, "allocate 100MB");
>> -		consume(100);
>> -
>> -		inherit_fork();
>> -		inherit_fork2();
>> -		fork_malloc();
>> -		grandchild_maxrss();
>> -		zombie();
>> -		sig_ign();
>> -		exec_without_fork();
>> -	}
>> -	cleanup();
>> -	tst_exit();
>> +	if (result == 1)
>> +		tst_res(TPASS, "%s", msg);
>> +	else if (result == 0)
>> +		tst_res(TFAIL, "%s", msg);
>> +	else
>> +		tst_res(TFAIL, "unexpected result???%d", result);
>>   }
> 
> The new test library allows you to report PASS/FAIL from child processes
> so we can get rid of this check result function here.
Thanks, I'll change this. The same modification will apply to all of the 
following ways of returning results via exit() in child process.

> 
>> -/* Testcase #01: fork inherit
>> - * expect: initial.self ~= child.self */
>> -static void inherit_fork(void)
>> +static void inherit_fork1(void)
>>   {
>> -	tst_resm(TINFO, "Testcase #01: fork inherit");
>> -
>> -	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
>> -	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
>> +	SAFE_GETRUSAGE(RUSAGE_SELF, &ru);
>> +	maxrss_init = ru.ru_maxrss;
>>
>> -	switch (pid = fork()) {
>> -	case -1:
>> -		tst_brkm(TBROK | TERRNO, cleanup, "fork #1");
>> -	case 0:
>> -		maxrss_init = ru.ru_maxrss;
>> -		SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
>> -		tst_resm(TINFO, "child.self = %ld", ru.ru_maxrss);
>> -		exit(is_in_delta(maxrss_init - ru.ru_maxrss));
>> -	default:
>> -		break;
>> +	if ((pid = SAFE_FORK()) == 0) {
> 
> We do not use the pid value for anything so this can be just:
> 
> 	if (!SAFE_FORK()) {
> 		...
Agreed.

>> -
>> -/* Testcase #03: fork + malloc
>> - * expect: initial.self + 50MB ~= child.self */
>> -static void fork_malloc(void)
>> -{
>> -	tst_resm(TINFO, "Testcase #03: fork + malloc");
>> -
>> -	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
>> -	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
>> +	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
>> +	check_result(is_in_delta(ru.ru_maxrss - 102400), "check that initial.children ~= 100MB");
> 
> Can we just do the check here instead? I.e.
> 
> 	if (is_in_delta(ru.ru_maxrss - 102400))
> 		tst_res(TPASS, "Initial ru.ru_maxrss ~= 100MB");
> 	else
> 		tst_res(TFAIL, "Initial ru.ru_maxrss = %liB", ru.ru_maxrss);
Fine, thanks.


>>
>> -/* Testcase #04: grandchild maxrss
>> - * expect: post_wait.children ~= 300MB */
>>   static void grandchild_maxrss(void)
>>   {
>> -	tst_resm(TINFO, "Testcase #04: grandchild maxrss");
>> -
>> -	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
>> -	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
>> -
>> -	switch (pid = fork()) {
>> -	case -1:
>> -		tst_brkm(TBROK | TERRNO, cleanup, "fork #4");
>> -	case 0:
>> -		retval = system("getrusage03_child -g 300");
>> +	if ((pid = SAFE_FORK()) == 0) {
> 
> 	Here as well.
> 
>> +		retval = tst_system("getrusage03_child grand_consume 300");
> 
> We have already forked so there is no point in using system(). All that
> we have to do here is execve() as:
> 
> 		const char *argv[] = {"getrusage03_child", "grand_consume", "300", NULL};
> 
> 		execve(argv[0], argv[], environ);
> 
> 		tst_brk(TBROK | TERRNO, "execve() failed");
Fine, I'll try this way.

>>
>> -/* Testcase #06: SIG_IGN
>> - * expect: initial ~= after_zombie */
>>   static void sig_ign(void)
>>   {
>> -	tst_resm(TINFO, "Testcase #06: SIG_IGN");
>> -
>> -	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
>> -	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
>> -	signal(SIGCHLD, SIG_IGN);
>> +	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
>>   	maxrss_init = ru.ru_maxrss;
>> +	SAFE_SIGNAL(SIGCHLD, SIG_IGN);
>>
>> -	switch (pid = fork()) {
>> -	case -1:
>> -		tst_brkm(TBROK, cleanup, "fork #6");
>> -	case 0:
>> -		retval = system("getrusage03_child -n 500");
>> +	if ((pid = SAFE_FORK()) == 0) {
>> +		retval = tst_system("getrusage03_child consume 500");
>>   		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
>> -			tst_brkm(TBROK | TERRNO, cleanup, "system");
>> +			tst_brk(TBROK, "system(\"getrusage03_child consume 500\")");
>>   		exit(0);
>> -	default:
>> -		break;
>>   	}
> 
> 
> And here as well.
> 
>> -	sleep(1);		/* children become zombie */
>> -	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
>> -	tst_resm(TINFO, "after_zombie.children = %ld", ru.ru_maxrss);
>> -	if (is_in_delta(ru.ru_maxrss - maxrss_init))
>> -		tst_resm(TPASS, "initial.children ~= after_zombie.children");
>> -	else
>> -		tst_resm(TFAIL, "initial.children !~= after_zombie.children");
>> -	signal(SIGCHLD, SIG_DFL);
>> +	TST_PROCESS_RELEASE_WAIT(pid, 0);
> 
> Why can't we use the TST_PROCESS_STATE_WAIT(pid, 'Z', 0) here as well? I
> fail to see how this is different from the previous test.
Same with lib: tst_process_state: Add tst_process_release_wait().

If we call the signal(SIGCHLD,SIG_IGN), the SIGCHLD signal is ignored by 
the system. Thus, no zombie is created before the child is terminated. 
The logs are as follows:

getrusage03.h:27: TINFO: allocate 400MB
getrusage03.c:39: TPASS: check that initial.children ~= pre_wait.children
getrusage03.c:39: TPASS: check that post_wait.children ~= 400MB
getrusage03.h:27: TINFO: allocate 500MB
getrusage03.c:123: TBROK: Failed to open FILE '/proc/84598/stat' for 
reading: ENOENT (2)

So I write TST_PROCESS_RELEASE_WAIT() here to check /proc/$PID.


>> -
>> -static void consume(int mega)
>> -{
>> -	size_t sz;
>> -	void *ptr;
>> -
>> -	sz = mega * 1024 * 1024;
>> -	ptr = SAFE_MALLOC(cleanup, sz);
>> -	memset(ptr, 0, sz);
>> +	inherit_fork1();
>> +	inherit_fork2();
>> +	grandchild_maxrss();
>> +	zombie();
>> +	sig_ign();
>> +	inherit_exec();
> 
> Can we split these into a several tests?
> 
> Have a look at snd_seq01.c and testfunc_list array how this is done.
I'll change this way, thanks.


>> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.h b/testcases/kernel/syscalls/getrusage/getrusage03.h
>> new file mode 100644
>> index 000000000..5fbf57272
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/getrusage/getrusage03.h
>> @@ -0,0 +1,35 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2011  Red Hat, Inc.
>> + * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
>> + */
>> +
>> +#ifndef LTP_GETRUSAGE03_H
>> +#define LTP_GETRUSAGE03_H
>> +
>> +#include "tst_test.h"
>> +
>> +#define DELTA_MAX 20480
>> +
>> +static void consume(int consume_nr)
>                 ^
> 	       This should be called consume_mb() so that it's clear
> 	       that the parameter is in megabytes.
Fine, thanks.

>> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03_child.c b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
>> index 972c38e4e..58da481cb 100644
>> --- a/testcases/kernel/syscalls/getrusage/getrusage03_child.c
>> +++ b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
>> @@ -1,168 +1,63 @@

>> -static void usage(void);
>> -static void consume(int mega);
>> -static void setup(void);
>> -static void cleanup(void);
>> +#include "tst_test.h"
>> +#include "getrusage03.h"
>>
>>   int main(int argc, char *argv[])
>>   {
>> -	int lc;
>> +	if (argc < 3)
>> +		tst_brk(TFAIL, "argc is %d, expected more", argc);
> 
> This is TBROK and also the message could be more clear such as:
> 
> 	"expected at least two parameters"
Fine, thanks.

> 
>> +	if (!strcmp(argv[1], "consume")) {
>> +		consume_nr = SAFE_STRTOL(argv[2], 0, LONG_MAX);
>> +		consume(consume_nr);
>> +	}
>> +	else if (!strcmp(argv[1], "grand_consume")) {
> 
> The else has to be on the same line as }
Sorry for the mistake, thanks.

> 
>> +		grand_consume_nr = SAFE_STRTOL(argv[2], 0, LONG_MAX);
>> +
>> +		pid = fork();
>> +		if (pid == -1)
>> +			tst_brk(TBROK, "fork failed");
>> +		else if (pid == 0) {
>> +			consume(grand_consume_nr);
>> +			exit(0);
>>   		}
> 
> Just use SAFE_FORK() here.
I noticed that some safe_ micro checks tst_test->forks_child or other 
tst_test->xx, while tst_test is not defined in some functions with 
#define TST_NO_DEFAULT_MAIN.

>> -static void setup(void)
>> -{
>> -	tst_sig(FORK, DEF_HANDLER, cleanup);
>> -
>> -	TEST_PAUSE;
>> -}
>> +		if (!is_in_delta(maxrss_self - self_nr) || !is_in_delta(maxrss_children - child_nr))
>> +			tst_brk(TBROK, "check that initial.self ~= exec.self, initial.children ~= exec.children");
> 
> This should produce TPASS/TFAIL messages and for each of them
> respectivelly as:
> 
> 		if (is_in_delta(maxrss_self - self_nr))
> 			tst_res(TPASS, ...);
> 		else
> 			tst_res(TFAIL, ...);
> 
> 		if (is_in_delta(maxrss_children - child_nr))
> 			tst_res(TPASS, ...);
> 		else
> 			tst_res(TFAIL, ...);
> 	}
I'll change it, thanks.

Thanks for your review.

Kind Regards,
Ziyao
