From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Mar 2021 14:21:52 +0800
Subject: [LTP] [s390x vDSO Bug?] clock_gettime(CLOCK_MONOTONIC_RAW,
 ...) gets abnormal ts value
Message-ID: <CAEemH2cELFSMzEYM-Gd1LxNuFzVE2PcG1chzyaVhW2YCJjjzdw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi linux-s390 experts,

We observed that LTP/clock_gettime04 always FAIL on s390x with
kernel-v5.12-rc3.
To simply show the problem, I rewrite the LTP reproducer as a simple C
below.
Maybe it's a new bug introduced from the kernel-5.12 series branch?

PASS:
------------
# uname -r
5.11.0-*.s390x

# grep TIME_NS /boot/config-5.11.0-*.s390x
no TIME_NS enabled

## ./test-timer
vdso_ts_nsec = 898169901815, vdso_ts.tv_sec = 898, vdso_ts.tv_nsec =
169901815
sys_ts_nsec  = 898169904269, sys_ts.tv_sec  = 898, sys_ts.tv_nsec  =
169904269
===> PASS

FAIL:
----------
# uname -r
5.12.0-0.rc3.*.s390x

# grep TIME_NS /boot/config-5.12.0-0.rc3.s390x
CONFIG_TIME_NS=y
CONFIG_GENERIC_VDSO_TIME_NS=y

# ./test-timer
vdso_ts_nsec = 4484351380985507, vdso_ts.tv_sec = 4484351, vdso_ts.tv_nsec
= 380985507
sys_ts_nsec  = 1446923235377, sys_ts.tv_sec  = 1446, sys_ts.tv_nsec  =
923235377
===> FAIL


# cat test-timer.c

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <time.h>
#include <sys/time.h>
#include <asm/unistd_64.h>

long long ts_to_ns(struct timespec ts)
{
        return (ts.tv_sec * 1000000000 + ts.tv_nsec);
}

int main(void)
{
        long long vdso_ts_nsec, sys_ts_nsec;

        struct timespec vdso_ts, sys_ts;

        clock_gettime(CLOCK_MONOTONIC_RAW, &vdso_ts); //vdso way
        syscall(__NR_clock_gettime, CLOCK_MONOTONIC_RAW, &sys_ts);

        vdso_ts_nsec = ts_to_ns(vdso_ts);
        sys_ts_nsec  = ts_to_ns(sys_ts);


        printf("vdso_ts_nsec = %lld, vdso_ts.tv_sec = %ld, vdso_ts.tv_nsec
= %ld\n", vdso_ts_nsec, vdso_ts.tv_sec, vdso_ts.tv_nsec);
        printf("sys_ts_nsec  = %lld, sys_ts.tv_sec  = %ld, sys_ts.tv_nsec
 = %ld\n", sys_ts_nsec, sys_ts.tv_sec, sys_ts.tv_nsec);

        if ((vdso_ts_nsec - sys_ts_nsec) > 1000000)
                printf("===> FAIL\n");
        else
                printf("===> PASS\n");

        return 0;
}

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210323/05629b65/attachment.htm>
