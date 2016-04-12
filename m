From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 12 Apr 2016 12:21:41 +0300
Subject: [LTP] [PATCH v2 1/2] lib: add safe_pthread_create() &
 safe_pthread_join()
In-Reply-To: <20160411144657.GA1243@rei>
References: <1460016651-24181-1-git-send-email-alexey.kodanev@oracle.com>
 <20160407113531.GA16682@rei> <57068E0D.4090809@oracle.com>
 <20160411144657.GA1243@rei>
Message-ID: <570CBE25.8000004@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 04/11/2016 05:46 PM, Cyril Hrubis wrote:
> Hi!
>>> Technically the thread_id does not need to be numeric type, POSIX
>>> defines it as a opaque, may be structure as well.
>> We could print in hex like this:
>>
>> if (rval) {
>>       unsigned int i;
>>       unsigned char *ptr = (unsigned char *)&thread_id;
>>       size_t tid_size = sizeof(thread_id);
>>       char buf[tid_size * 2 + 1];
>>
>>       for (i = 0; i < tid_size; ++i)
>>           sprintf(buf + i * 2, "%02x", ptr[i]);
>>
>>       tst_brk_(file, lineno, TBROK,
>>                "pthread_join(%s,%p) failed: %s", buf, retval, ...);
>> }
>>
>> But bytes might be in different order due to endianness,
>> supposing we compare this value with "%lx", e.g. on x86_64
>>
>> 00971fe3257f0000 vs 7f25e31f9700 (%lx)
>>
>> What do you think?
> I'm starting to consider not printing the value at all, since it's not
> that important as gdb and strace pthread ids are not related to the
> value of pthread_t. We can just print "pthread_join(..., %p)" instead.

Agree.

> Or we can add a configure check if pthread_t is actually numeric.
> Something as:
>
> 	pthread_t *t = (unsigned long*)NULL;
>
> Should fail with -Werror unless pthread_t is defined as unsigned long.
>
> Then we can proceed with printing it with "%ul" if the check was OK, but
> I'm not sure that it's worth of the work.

OK. For now, we can add it into TODO list.

Thanks,
Alexey
