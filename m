From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 25 Feb 2020 17:07:37 +0800
Subject: [LTP] [PATCH] syscalls/pipe13: Add regression test for pipe to
 wake up all readers
In-Reply-To: <20200224125802.GA30073@rei.lan>
References: <1582537946-22098-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200224125802.GA30073@rei.lan>
Message-ID: <0bfca454-8c44-6435-81fb-a243172ef96f@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

> Hi!
>> +static void verify_pipe(void)
>> +{
>> +	int fds[2];
>> +	int status1, status2;
>> +	pid_t p1, p2;
>> +	int ret;
>> +
>> +	SAFE_PIPE(fds);
>> +
>> +	p1 = SAFE_FORK();
>> +	if (p1 == 0) {
>> +		SAFE_CLOSE(fds[1]);
>> +		SAFE_READ(0, fds[0], &status1, sizeof(status1));
>                                          ^
> 					Why status1 here?
> 
> 					can't we just pass a dummy
> 					char buf; and size 1 here?
> 
> 					It's not being written to
> 					anyways.
>> +		exit(0);
>> +	}
>> +	p2 = SAFE_FORK();
>> +	if (p2 == 0) {
>> +		SAFE_CLOSE(fds[1]);
>> +		SAFE_READ(0, fds[0], &status2, sizeof(status2));
>                                        ^
> 				      Here as well.
>> +		exit(0);
>> +	}
>> +
>> +	sleep(1);
> 
> This sleep here has to be replaced by a proper synchronization given
> that it's here to make sure both of the readers sleep on the pipe we
> should:
> 
> * Use checkpoints to make sure both of the children have managed
>    to get before the SAFE_READ().
> 
> * The the parent should use the TST_PROCESS_STATE_WAIT() to make sure
>    both of the chidlren are sleeping
OK, I will use wait and wakeup api as below:


static void do_child(int i)
{
         char buf;
         SAFE_CLOSE(fds[1]);
         TST_CHECKPOINT_WAKE(i);
         SAFE_READ(0, fds[0], &buf, 1);
         exit(0);
}

staic void verify_pipe(void)
....
for (i = 0; i < 2; i++) {
                 pid[i] = SAFE_FORK();
                 if (pid[i] == 0)
                         do_child(i);
                 TST_CHECKPOINT_WAIT(i);
                 TST_PROCESS_STATE_WAIT(pid[i], 'S', 0);
         }
....
> 
>> +	SAFE_CLOSE(fds[1]);
>> +
>> +	SAFE_WAITPID(p1, &status1, 0);
>> +	ret = waitpid(p2, &status2, WNOHANG);
> 
> We should just use waitpid with -1 as a pid here and WNOHANG twice,
> because if one of the children hangs it's not guaranteed in any way
> which one would that be.
> 
On my environment, kernel wakes up the first read and the remaining read 
doesn't be waked up. (I add three childs, 2,3 doesn't wake up)
>> +	if (ret == p2) {
>> +		tst_res(TPASS, "pipe wakes up everybody when last write closes");
>> +	} else {
>> +		tst_res(TFAIL, "pipe doesn't wake up every body when last write closes");
>> +		SAFE_KILL(p2, SIGKILL);
>> +		SAFE_WAIT(&status2);
>> +	}
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = verify_pipe,
>> +	.forks_child = 1,
>> +	.tags = (const struct tst_tag[]) {
>> +		{"linux-git", "6551d5c56eb"},
>> +		{}
>> +	}
>> +};
>> -- 
>> 2.18.0
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 


