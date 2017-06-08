From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 8 Jun 2017 12:36:37 +0300
Subject: [LTP] [PATCH 1/3] clone08: convert to new LTP API
In-Reply-To: <20170607154631.GB30168@rei.suse.de>
References: <1492443894-3127-1-git-send-email-alexey.kodanev@oracle.com>
 <20170607154631.GB30168@rei.suse.de>
Message-ID: <8fe5e403-bbf8-59a6-c692-c914bf97ff3c@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 06/07/2017 06:46 PM, Cyril Hrubis wrote:
> Hi!
>>  static long clone_child(const struct test_case *t, int use_tst)
>> @@ -121,16 +97,16 @@ static long clone_child(const struct test_case *t, int use_tst)
>>  		child_stack, &ptid, NULL, &ctid));
>>  
>>  	if (TEST_RETURN == -1 && TTERRNO == ENOSYS)
>> -		tst_brkm(TCONF, cleanup, "clone does not support 7 args");
>> +		tst_brk(TCONF, "clone does not support 7 args");
>>  
>>  	if (TEST_RETURN == -1) {
>>  		if (use_tst) {
>> -			tst_brkm(TBROK | TTERRNO, cleanup, "%s clone() failed",
>> +			tst_brk(TBROK | TTERRNO, "%s clone() failed",
>>  				 t->name);
>>  		} else {
>>  			printf("%s clone() failed, errno: %d",
>>  			       t->name, TEST_ERRNO);
>> -			exit(1);
>> +			_exit(1);
>>  		}
>>  	}
> Do we still need the use_tst flag here? Calling tst_* functions in child
> works fine with the new library.

Great, this simplifies things.

>
>>  	return TEST_RETURN;
>> @@ -140,8 +116,8 @@ static int wait4child(pid_t child)
>>  {
>>  	int status;
>>  
>> -	if (waitpid(child, &status, 0) == -1)
>> -		tst_resm(TBROK|TERRNO, "waitpid");
>> +	SAFE_WAITPID(child, &status, 0);
>> +
>>  	if (WIFEXITED(status))
>>  		return WEXITSTATUS(status);
>>  	else
>> @@ -150,77 +126,55 @@ static int wait4child(pid_t child)
>>  
>>  static void test_clone_parent(int t)
>>  {
>> -	int status;
>>  	pid_t child;
>>  
>> -	fflush(stdout);
>> -	child = FORK_OR_VFORK();
>> -	switch (child) {
>> -	case 0:
>> +	child = SAFE_FORK();
>> +	if (!child) {
>>  		parent_ppid = getppid();
>>  		clone_child(&test_cases[t], 0);
>> -		exit(0);
>> -	case -1:
>> -		tst_brkm(TBROK | TERRNO, NULL, "test_clone_parent fork");
>> -	default:
>> -		status = wait4child(child);
>> -		if (status == 0) {
>> -			/* wait for CLONE_PARENT child */
>> -			status = wait4child(-1);
>> -			if (status == 0) {
>> -				tst_resm(TPASS, "test %s", test_cases[t].name);
>> -			} else {
>> -				tst_resm(TFAIL, "test %s, status: %d",
>> -					 test_cases[t].name, status);
>> -			}
>> -		} else {
>> -			tst_resm(TFAIL, "test %s, status: %d",
>> -				 test_cases[t].name, status);
>> -		}
>> -	};
>> +		_exit(0);
>> +	}
>> +	tst_reap_children();
>> +	tst_res(TPASS, "clone and forked child has the same parent");
> Hmm, so supposedly we produce TBROK in the tst_reap_childer() if the
> child_clone_parent() has failed, right?
>
> The test failures are accounted for in the structure stored in the
> shared memory. Only exit statuses that are propagated correctly are
> these that should exit the test immediately which are TBROK and TCONF.
>
> So if a test child fails it should call the tst_res(TFAIL, ...) function
> and then exit with 0. Or exit with non-zero value while the parent waits
> for it and calls the tst_res() function accordingly. At least this is
> how the code in tst_test.c is structured now.
>
> Moreover even if the code in tst_test was able to cope with tests
> exitting with TFAIL this would still produce TPASS message even if the
> child reported a failure.

Agree, I'll move tst_res() to a child function and make it exit with 0.

Thanks,
Alexey
