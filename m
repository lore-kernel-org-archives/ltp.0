From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 25 Nov 2020 12:32:38 +0100
Subject: [LTP] [PATCH 1/2] syscalls: avoid time() using
 __cvdso_gettimeofday in use-level's VDSO
In-Reply-To: <20201124153837.GA24470@yuki.lan>
References: <20201123083137.11575-1-liwang@redhat.com>
 <20201124153837.GA24470@yuki.lan>
Message-ID: <875z5tllih.fsf@nanos.tec.linutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril,

On Tue, Nov 24 2020 at 16:38, Cyril Hrubis wrote:
> Thomas can you please have a look? It looks like we can get the SysV IPC
> ctime to be one second off compared to what we get from realtime clock.
>
> Do we care to get this fixed in kernel or should we fix the tests?

See below.

>> This shmctl01 test detect the time as the number of seconds twice
>> (before and after) the shmget() instruction, then it verifies
>> whether the 'struct shmid_ds ds' gets data correctly. But here it
>> shows 'ds->ctime' out of the seconds range (1604298586, 1604298586),
>> 
>> The reason is that shmget()/msgsnd() always use ktime_get_real_second
>> to get real seconds, but time() on aarch64 via gettimeofday() or (it
>> depends on different kernel versions) clock_gettime() in use-level's
>> VDSO to return tv_sec.
>> 
>> time()
>>   __cvdso_gettimeofday
>>    ...
>>      do_gettimeofday
>>        ktime_get_real_ts64
>>         timespc64_add_ns
>> 
>> Situation can be simplify as difference between ktime_get_real_second
>> and ktime_get_real_ts64. As we can see ktime_get_real_second return
>> tk->xtime_sec directly, however
>> 
>> timespc64_add_ns more easily add 1 more second via "a->tv_sec +=..."
>> on a virtual machine, that's why we got occasional errors like:
>> 
>> shmctl01.c:183: TFAIL: SHM_STAT: shm_ctime=1604298585, expected <1604298586,1604298586>
>> ...
>> msgsnd01.c:59: TFAIL: msg_stime = 1605730573 out of [1605730574, 1605730574]
>> 
>> Here we propose to use '__NR_time' to invoke syscall directly that makes
>> test all get real seconds via ktime_get_real_second.

This is a general problem and not really just for this particular test
case.

Due to the internal implementation of ktime_get_real_seconds(), which is
a 2038 safe replacement for the former get_seconds() function, this
accumulation issue can be observed. (time(2) via syscall and newer
versions of VDSO use the same mechanism).

     clock_gettime(CLOCK_REALTIME, &ts);
     sec = time();
     assert(sec >= ts.tv_sec);

That assert can trigger for two reasons:

 1) Clock was set between the clock_gettime() and time().

 2) The clock has advanced far enough that:

    timekeeper.tv_nsec + (clock_now_ns() - last_update_ns) > NSEC_PER_SEC

#1 is just a property of clock REALTIME. There is nothing we can do
   about that.

#2 is due to the optimized get_seconds()/time() access which avoids to
   read the clock. This can happen on bare metal as well, but is far
   more likely to be exposed on virt.

The same problem exists for CLOCK_XXX vs. CLOCK_XXX_COARSE

     clock_gettime(CLOCK_XXX, &ts);
     clock_gettime(CLOCK_XXX_COARSE, &tc);
     assert(tc.tv_sec >= ts.tv_sec);

The _COARSE variants return their associated timekeeper.tv_sec,tv_nsec
pair without reading the clock. Same as #2 above just extended to clock
MONOTONIC.

There is no way to fix this except giving up on the fast accessors and
make everything take the slow path and read the clock, which might make
a lot of people unhappy.

For clock REALTIME #1 is anyway an issue, so I think documenting this
proper is the right thing to do.

Thoughts?

Thanks,

        tglx
