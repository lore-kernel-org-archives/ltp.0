From: Heiko Carstens <hca@linux.ibm.com>
Date: Tue, 23 Mar 2021 08:11:41 +0100
Subject: [LTP] [s390x vDSO Bug?] clock_gettime(CLOCK_MONOTONIC_RAW,
 ...) gets abnormal ts value
In-Reply-To: <CAEemH2cELFSMzEYM-Gd1LxNuFzVE2PcG1chzyaVhW2YCJjjzdw@mail.gmail.com>
References: <CAEemH2cELFSMzEYM-Gd1LxNuFzVE2PcG1chzyaVhW2YCJjjzdw@mail.gmail.com>
Message-ID: <YFmUrVOyX4q+8Dy9@osiris>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 23, 2021 at 02:21:52PM +0800, Li Wang wrote:
> Hi linux-s390 experts,
> 
> We observed that LTP/clock_gettime04 always FAIL on s390x with
> kernel-v5.12-rc3.
> To simply show the problem, I rewrite the LTP reproducer as a simple C
> below.
> Maybe it's a new bug introduced from the kernel-5.12 series branch?
> 
> PASS:
> ------------
> # uname -r
> 5.11.0-*.s390x
> 
> # grep TIME_NS /boot/config-5.11.0-*.s390x
> no TIME_NS enabled
> 
> ## ./test-timer
> vdso_ts_nsec = 898169901815, vdso_ts.tv_sec = 898, vdso_ts.tv_nsec =
> 169901815
> sys_ts_nsec  = 898169904269, sys_ts.tv_sec  = 898, sys_ts.tv_nsec  =
> 169904269
> ===> PASS
> 
> FAIL:
> ----------
> # uname -r
> 5.12.0-0.rc3.*.s390x
> 
> # grep TIME_NS /boot/config-5.12.0-0.rc3.s390x
> CONFIG_TIME_NS=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> 
> # ./test-timer
> vdso_ts_nsec = 4484351380985507, vdso_ts.tv_sec = 4484351, vdso_ts.tv_nsec
> = 380985507
> sys_ts_nsec  = 1446923235377, sys_ts.tv_sec  = 1446, sys_ts.tv_nsec  =
> 923235377
> ===> FAIL

Thanks for reporting!

I'll look later today into this. I would nearly bet that I broke it
with commit f8d8977a3d97 ("s390/time: convert tod_clock_base to
union")
