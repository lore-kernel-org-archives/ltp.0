From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 7 Apr 2016 10:46:18 +0300
Subject: [LTP] [PATCH] syscalls/fcntl: add new test for open file
 description locks
In-Reply-To: <20160406160733.GC10599@rei.suse.cz>
References: <1458033988-15881-1-git-send-email-alexey.kodanev@oracle.com>
 <20160406160733.GC10599@rei.suse.cz>
Message-ID: <5706104A.70307@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
On 04/06/2016 07:07 PM, Cyril Hrubis wrote:
> Hi!
>> +#ifndef F_OFD_GETLK
>> +	intptr_t i;
>> +
>> +	tst_resm(TINFO, "spawning '%d' threads", size);
>> +	for (i = 0; i < size; ++i) {
>> +		if (pthread_create(id + i, NULL, thread_fn, (void *)i)) {
>> +			tst_brkm(TBROK | TERRNO, cleanup,
>> +				 "pthread_create() failed");
> Using TERRNO is wrong here. The error value is returned by the
> pthread_create() instead.
>
> You should do:
>
> 	ret = pthread_create(...);
> 	if (ret) {
> 		tst_brkm(TBROK, cleanup, "pthread_create(): %s",
> 		         tst_strerrno(ret));
> 	}

Oh, that wasn't obvious, I should have read man-page more carefully. Thanks.

>> +		++res[(int)buf[0]];
>                           ^
> 			Do we really need to cast it to int here?


Otherwise gcc would complain  "warning: array subscript has type ‘char’"

>> +
>> +	cleanup();
>> +	tst_exit();
>> +}
> Otherwise it looks good.
>
> I would be happier if the code would get converted to the new test
> library but given that I've managed to ignore it for quite some time I'm
> in no position to force it.

I'll send a new patch with new API usage and the one for safe_pthread.

Thanks,
Alexey


