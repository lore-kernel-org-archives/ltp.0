From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 7 Apr 2016 19:42:53 +0300
Subject: [LTP] [PATCH v2 1/2] lib: add safe_pthread_create() &
 safe_pthread_join()
In-Reply-To: <20160407113531.GA16682@rei>
References: <1460016651-24181-1-git-send-email-alexey.kodanev@oracle.com>
 <20160407113531.GA16682@rei>
Message-ID: <57068E0D.4090809@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 04/07/2016 02:35 PM, Cyril Hrubis wrote:
> Hi!
>> +int safe_pthread_join(const char *file, const int lineno,
>> +		      pthread_t thread_id, void **retval)
>> +{
>> +	int rval;
>> +
>> +	rval = pthread_join(thread_id, retval);
>> +
>> +	if (rval) {
>> +		tst_brk_(file, lineno, TBROK,
>> +			 "pthread_join(%lu,%p) failed: %s", thread_id, retval,
>> +			 tst_strerrno(rval));
> Technically the thread_id does not need to be numeric type, POSIX
> defines it as a opaque, may be structure as well.

We could print in hex like this:

if (rval) {
     unsigned int i;
     unsigned char *ptr = (unsigned char *)&thread_id;
     size_t tid_size = sizeof(thread_id);
     char buf[tid_size * 2 + 1];

     for (i = 0; i < tid_size; ++i)
         sprintf(buf + i * 2, "%02x", ptr[i]);

     tst_brk_(file, lineno, TBROK,
              "pthread_join(%s,%p) failed: %s", buf, retval, ...);
}

But bytes might be in different order due to endianness,
supposing we compare this value with "%lx", e.g. on x86_64

00971fe3257f0000 vs 7f25e31f9700 (%lx)

What do you think?

Thanks,
Alexey

>
> But on the other hand I doubt that there is a Linux libc implementation
> that actually defines it to be anything else than long int.
>> +	}
>> +
>> +	return rval;
>> +}
> Otherwise this looks fine.
>

