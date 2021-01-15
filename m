From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 15 Jan 2021 13:57:57 +0530
Subject: [LTP] Holidays and LTP release
In-Reply-To: <YABW1ZcnfFbjUoBq@yuki.lan>
References: <X9tMlNxJbwCWIRnO@yuki.lan> <X/Wq28noppvB5MGw@yuki.lan>
 <20210113095724.214c904a@kmaincent-XPS-13-7390>
 <CA+G9fYv1UFr+7ePC7tLjCY4JPsoQdBdf-6Jpr40zmsoYRWVrdQ@mail.gmail.com>
 <YABW1ZcnfFbjUoBq@yuki.lan>
Message-ID: <CA+G9fYs2bv98uFgrH+WEYzDagFPy0PWruk=Em9GdMXmnQQUTCw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 14 Jan 2021 at 20:05, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > I have a similar problem for semctl09 failed on arm, arm64, i386 and x86_64.
> >
> > semctl09.c:67: TINFO: Test SYS_semc[ 1067.769270] audit: type=1701
> > audit(1610604534.411:38): auid=4294967295 uid=0 gid=0 ses=4294967295
> > pid=6275 comm=\"semctl09\" exe=\"/opt/ltp/testcases/bin/semctl09\"
> > sig=11 res=1
> > tl syscall
> > semctl09.c:132: TINFO: Test SEM_STAT_ANY with nobody user
> > semctl09.c:155: TPASS: SEM_INFO returned valid index 10 to semid 10
> > semctl09.c:164: TPASS: Counted used = 1
> > semctl09.c:112: TPASS: semset_cnt = 1
> > semctl09.c:119: TPASS: sen_cnt = 2
> > tst_test.c:1313: TBROK: Test killed by SIGSEGV!
>
> There seems to be a part of the log missing here, if it's segfaulting in
> the libc semctl() there used to be glibc bug for SEM_STAT_ANY which may
> cause SIGSEGV:
>
> https://sourceware.org/bugzilla/show_bug.cgi?id=26637
>
> > And on i386,
> >
> > tst_test.c:1263: TINFO: Timeout per run is 0h 15m 00s
> > semctl09.c:67: TINFO: Test SYS_semctl syscall
> > semctl09.c:132: TINFO: Test SEM_STAT_ANY with nobody user
> > semctl09.c:155: TPASS: SEM_INFO returned valid index 11 to semid 11
> > semctl09.c:164: TPASS: Counted used = 1
> > semctl09.c:112: TPASS: semset_cnt = 1
> > semctl09.c:119: TPASS: sen_cnt = 2
> > semctl09.c:132: TINFO: Test SEM_STAT_ANY with root user
> > semctl09.c:155: TPASS: SEM_INFO returned valid index 11 to semid 11
> > semctl09.c:164: TPASS: Counted used = 1
> > semctl09.c:112: TPASS: semset_cnt = 1
> > semctl09.c:119: TPASS: sen_cnt = 2
> > tst_test.c:1263: TINFO: Timeout per run is 0h 15m 00s
> > semctl09.c:70: TINFO: Test libc semctl()
> > semctl09.c:132: TINFO: Test SEM_STAT_ANY with nobody user
> > semctl09.c:149: TFAIL: SEM_STAT_ANY doesn't pass the buffer specified
> > by the caller to kernel
> > semctl09.c:132: TINFO: Test SEM_STAT_ANY with root user
> > semctl09.c:149: TFAIL: SEM_STAT_ANY doesn't pass the buffer specified
> > by the caller to kernel
>
> This just says that the glibc bug is present so it's likely that the
> same bug is causing segfaults on the rest of the architectures.
>
> > only fails on the arm beagleboard-x15 device.
> >
> > accept02.c:55: TBROK: setsockopt(3, 0, 42, 0xb6f4cf7c, 132) failed: ENODEV (19)
>
> Looks like muticast groups is not compiled in kernel here.

True.
We have not enabled multicast groups.
# CONFIG_IP_MULTICAST is not set


>
> We should handle this and report TCONF instead, however this is not a
> regression, the test has been like this for three years.

Reporting TCONF would be right here.

>
> > clock_gettime04.c:143: TFAIL: CLOCK_REALTIME: Time travelled backwards
> > (5): -1610153174499293029 ns
> > clock_gettime04.c:151: TFAIL: CLOCK_REALTIME_COARSE: Difference
> > between successive readings greater than 5 ms (4): 9
> > clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC: Difference between
> > successive readings is reasonable
> > clock_gettime04.c:151: TFAIL: CLOCK_MONOTONIC_COARSE: Difference
> > between successive readings greater than 5 ms (2): 9
> > clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC_RAW: Difference between
> > successive readings is reasonable
> > clock_gettime04.c:158: TPASS: CLOCK_BOOTTIME: Difference between
> > successive readings is reasonable
>
> This shouldn't really happen, what this says is that time jumped 51
> years back. That is really absurd.

This is always reproduced on arm beagleboard-x15, i386 32-bit qemu_i386
and qemu_arm.

clock_gettime04.c:143: TFAIL: CLOCK_REALTIME: Time travelled backwards
(5): -1610599851098100352 ns

https://lkft.validation.linaro.org/scheduler/job/2142122#L3885
https://lkft.validation.linaro.org/scheduler/job/2144548#L2534


>
> > getrlimit03.c:168: TPASS: __NR_prlimit64(0) and __NR_ugetrlimit(0)
> > gave consistent results
> > tst_test.c:1313: TBROK: Test killed by SIGILL!
>
> Can we have a backtrace here? It's impossible to say what happened here
> without further debugging.

I do not have backtrace log for this now.
Let me share strace output log in this link,
# strace -f ./getrlimit03
https://lkft.validation.linaro.org/scheduler/job/2145166#L2569

>
> > on x86_64:
> > The ioctl_sg01 test killed and reported failed.
> >
> > tst_test.c:1263: TINFO: Timeout per run is 0h 15m 00s
> > ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg1
> > [  332.383394] ioctl_sg01 invoked oom-killer:
>
> That's likely due to tst_pollutte_memory().
>
> What are the overcommit settings on that machine?

overcommit_memory is 0.
After changing overcommit to 2 the test got PASS.

> This is probably worth fixing before the release if we manage to figure
> out the cause.

cat /proc/sys/vm/overcommit_memory
0
cat /proc/sys/vm/overcommit_ratio
50
./runltp -s ioctl_sg01 --> FAILED

echo 2 > /proc/sys/vm/overcommit_memory
cat /proc/sys/vm/overcommit_memory
2
./runltp -s ioctl_sg01 --> PASS

Full test run  link,
https://lkft.validation.linaro.org/scheduler/job/2142340#L8823

- Naresh
