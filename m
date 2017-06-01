From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 1 Jun 2017 19:53:58 +0800
Subject: [LTP] [PATCH 3/3] syscalls/shmat03.c: add new regression test
In-Reply-To: <20170529145709.GC6618@rei.lan>
References: <1492164917-9329-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1492164917-9329-3-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170529145709.GC6618@rei.lan>
Message-ID: <59300056.1020107@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/05/29 22:57, Cyril Hrubis wrote:
> Hi!
>> +	addr = shmat(shm_id, LOCATION, SHM_RND);
>> +	if (addr != (void *)-1)
>> +		tst_res(TINFO, "shmat() attached a nil-page unexpectedly");
>> +	else
>> +		tst_res(TINFO, "shmat() didn't attach a nil-page");
>> +
>> +	((char *)addr)[0] = 'A';
>
> So if shmat() fails we try to write to (char*)-1 address, that does not
> sound right. Why don't we exit the test with TPASS in that case and skip
> the part that tries to write to invalid address?
>
> Or at least dereference NULL here instead of the address returned from
> shmat() since that is guaranteed to SEGFAULT.
Hi Cyril

I failed to call shmat() as root and returned EACCES if selinux is 
Enforcing.
Do you know how to fix this problem?

Thanks,
Xiao Yang.
>> +	tst_res(TINFO, "shmat() wrote data to shmaddr:%p unexpectedly", addr);
>> +
>> +	SAFE_SHMDT(addr);
>> +
>> +	exit(0);
>> +}
>> +
>> +static void do_shmat(unsigned int n)
>> +{
>> +	pid_t pid;
>> +	int status;
>> +	struct tcase *tc =&tcases[n];
>> +
>> +	pid = SAFE_FORK();
>> +	if (!pid)
>> +		verify_shmat(tc->exp_usr);
>> +
>> +	SAFE_WAITPID(pid,&status, 0);
>> +
>> +	if (WIFEXITED(status)) {
>> +		tst_res(TFAIL, "%s mapped nil-page in shmat() unexpectedly",
>> +			tc->des);
>> +		return;
>> +	}
>> +
>> +	if (WIFSIGNALED(status)&&  WTERMSIG(status) == SIGSEGV) {
>> +		tst_res(TPASS, "%s didn't map nil-page in shmat(), and was "
>> +			"killed by %s as expected", tc->des,
>> +			tst_strsig(WTERMSIG(status)));
>> +	} else {
>> +		tst_res(TFAIL, "%s didn't map nil-page in shmat(), and was "
>> +			"killed by %s unexpectedly", tc->des,
>> +			tst_strsig(WTERMSIG(status)));
>> +	}
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	key_t shm_key;
>> +
>> +	shm_key = GETIPCKEY();
>> +	shm_id = SAFE_SHMGET(shm_key, 4096, 0777 | IPC_CREAT);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (shm_id != -1)
>> +		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.tid = "shmat03",
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.test = do_shmat,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.setup = setup,
>> +	.cleanup = cleanup
>> +};
>> -- 
>> 1.8.3.1
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp



