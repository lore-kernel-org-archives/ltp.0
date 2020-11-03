From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 03 Nov 2020 16:34:04 +0000
Subject: [LTP] [PATCH] pty04: Limit the number of packets sent to avoid
 timeout
In-Reply-To: <20201103154247.GA10565@yuki.lan>
References: <20201028171056.2151-1-rpalethorpe@suse.com>
 <20201103154247.GA10565@yuki.lan>
Message-ID: <875z6m5rib.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> At the end of the test we transmit many packets while closing the PTY
>> to check for races in the kernel. However if the process which closes
>> the PTY is delayed this can result a very large number of packets
>> being transmitted. The kernel appears to handle this quite slowly
>> which can cause the test to timeout or even a softlockup.
>> 
>> This is not supposed to be a performance test, so this commit puts an
>> upper bound on the number of packets transmitted.
>> 
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>> 
>> Hopefully will solve: https://github.com/linux-test-project/ltp/issues/674
>> 
>>  testcases/kernel/pty/pty04.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
>> index 4adf2cbb7..a59de7830 100644
>> --- a/testcases/kernel/pty/pty04.c
>> +++ b/testcases/kernel/pty/pty04.c
>> @@ -136,7 +136,8 @@ static int open_pty(const struct ldisc_info *ldisc)
>>  static ssize_t try_write(int fd, const char *data,
>>  			 ssize_t size, ssize_t *written)
>>  {
>> -	ssize_t ret = write(fd, data, size);
>> +	ssize_t off = written ? *written : 0;
>> +	ssize_t ret = write(fd, data + off, size);
>
> This seems to be correct, but should be send in a seprate patch.

I suppose I can, but this is actually part of limiting the number of
packets otherwise we don't care that we try to resend the whole packet
each time.

>
>>  	if (ret < 0)
>>  		return -(errno != EAGAIN);
>> @@ -149,6 +150,7 @@ static void write_pty(const struct ldisc_info *ldisc)
>>  	char *data;
>>  	ssize_t written, ret;
>>  	size_t len = 0;
>> +	int max_writes = 1000;
>>  
>>  	switch (ldisc->n) {
>>  	case N_SLIP:
>> @@ -190,7 +192,8 @@ static void write_pty(const struct ldisc_info *ldisc)
>>  
>>  	tst_res(TPASS, "Wrote PTY %s %d (2)", ldisc->name, ptmx);
>>  
>> -	while (try_write(ptmx, data, len, NULL) >= 0)
>> +	TST_CHECKPOINT_WAIT2(0, 100000);
>> +	while (max_writes-- && try_write(ptmx, data, len, NULL) >= 0)
>>  		;
>
> I wonder if we should change this to be time based instead. I.e. try to
> write packets for 10 seconds or so, since hardcoding number of
> iterations usually does not scale from embedded to supercomputers.

Writing is most likely far quicker than reading on any computer, so
limiting it by time worries me more. On a system that is very fast, but
highly contended (e.g. OpenQA guests), one CPU may be able to fill the
TTY buffer before another gets chance to start converting that data to
CAN packets. This will most likely result in a softlockup/timeout which
is what we are trying to avoid. With an iteration limit the fast system
will simply exit the loop before we get chance to read (if contended).

On a slow system which is also highly contended we just have to hope the
iteration limit is low enough. If we set a time limit instead, we still
have the issue of how many seconds to set before the TTY buffers are
full enough to queue up too much work.

I guess we could do two-way communication instead of just writing to the
PTY...

>
>>  	tst_res(TPASS, "Writing to PTY interrupted by hangup");
>
> And this should be true only if we do not run out of tries meanwhile,
> right?

Yes, I suppose we should not print that if the while loop finishes

>
>> @@ -331,7 +334,7 @@ static void read_netdev(const struct ldisc_info *ldisc)
>>  	check_data(ldisc, data, plen);
>>  	tst_res(TPASS, "Read netdev %s %d (2)", ldisc->name, sk);
>>  
>> -	TST_CHECKPOINT_WAKE(0);
>> +	TST_CHECKPOINT_WAKE2(0, 2);
>>  	while ((rlen = read(sk, data, plen)) > 0)
>>  		check_data(ldisc, data, rlen);
>>  
>> -- 
>> 2.28.0
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Thank you,
Richard.
