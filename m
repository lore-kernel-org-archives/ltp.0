From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 29 Nov 2017 13:25:42 +0000
Subject: [LTP] [PATCH v2 08/13] sigwaitinfo01: catch SEGV and report
	success for bad_address2 testcase
In-Reply-To: <20171129102959.GA18489@rei> (Cyril Hrubis's message of "Wed, 29
 Nov 2017 11:29:59 +0100")
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-9-punit.agrawal@arm.com>
 <20171129102959.GA18489@rei>
Message-ID: <87fu8x1ajt.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>>  void test_bad_address2(swi_func sigwaitinfo, int signo)
>>  {
>> -	TEST(sigwaitinfo((void *)1, NULL, NULL));
>> -	REPORT_SUCCESS(-1, EFAULT);
>> +	pid_t pid;
>> +	int status;
>> +
>> +	switch (pid = FORK_OR_VFORK()) {
>> +	case -1:
>> +		tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
>> +	case 0:
>> +		signal(SIGSEGV, segv_handler);
>> +		TEST(sigwaitinfo((void *)1, NULL, NULL));
>> +
>> +		_exit(0);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	SUCCEED_OR_DIE(waitpid, "waitpid failed", pid, &status, 0);
>> +	if (WIFEXITED(status) && WEXITSTATUS(status) == 0xff)
>> +		tst_resm(TPASS, "Test passed");
>
> Why don't we just check for WIFSIGNALED() and WTERMSIG() instead?
>
> We do not have to install any handler that way...

I think that is what I tried initially but for the tst_sig() call in
setup() that installs a default handler and catches the SIGSEGV.

>
>> +	else
>> +		tst_resm(TFAIL, "Unrecognised child exit code");
>>  }
>>  
>>  void test_bad_address3(swi_func sigwaitinfo, int signo)
>> -- 
>> 2.14.2
>> 
