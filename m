From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 12 Nov 2020 14:31:12 +0800
Subject: [LTP] [PATCH 2/2] syscalls/ptrace02: Add another EPERM error
 test
In-Reply-To: <20201111150926.GA21539@yuki.lan>
References: <1604317409-22871-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20201111150926.GA21539@yuki.lan>
Message-ID: <5FACD6B0.8080908@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
> Hi!
>> +static void verify_ptrace(void)
>> +{
>> +	int child_pid;
>> +
>> +	tst_res(TINFO, "Trace a process that don't have CAP_SYS_PTRACE capability(nobody user) for it");
>
> I wouldn't be printing this verbose info here, anyone who will have to
> debug the test failures will look into the source code and at the test
> description in the top level comment.
Will remove it.
>
>> +	child_pid = SAFE_FORK();
>> +	if (!child_pid)
>> +		pause();
>> +
>> +	if (!SAFE_FORK()) {
>> +		SAFE_SETUID(uid);
>> +		TEST(ptrace(PTRACE_ATTACH, child_pid, NULL, NULL));
>> +		if (TST_RET == 0) {
>> +			tst_res(TFAIL, "ptrace() succeeded unexpectedly");
>> +			TST_CHECKPOINT_WAKE(0);
>> +			exit(0);
>> +		}
>> +		if (TST_ERR == EPERM)
>> +			tst_res(TPASS | TTERRNO, "ptrace() failed as expected");
>> +		else
>> +			tst_res(TFAIL | TTERRNO, "ptrace() expected EPERM, but got");
>> +		TST_CHECKPOINT_WAKE(0);
>> +		exit(0);
>> +	}
>> +	TST_CHECKPOINT_WAIT(0);
>> +	SAFE_KILL(child_pid, SIGKILL);
>> +	SAFE_WAITPID(child_pid, NULL, 0);
>
> We do not need the checkpoints here at all, we just need to waitpid for
> the second child before we kill the first one.
Yes, Will fix it in v2.
>
>> +	tst_reap_children();
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	struct passwd *pw;
>> +
>> +	pw = SAFE_GETPWNAM("nobody");
>> +	uid = pw->pw_uid;
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.test_all = verify_ptrace,
>> +	.forks_child = 1,
>> +	.needs_root = 1,
>> +	.needs_checkpoints = 1,
>> +};
>> --
>> 2.23.0
>>
>>
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>



