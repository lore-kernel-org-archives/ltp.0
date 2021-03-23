From: Heiko Carstens <hca@linux.ibm.com>
Date: Tue, 23 Mar 2021 14:48:31 +0100
Subject: [LTP] [s390x vDSO Bug?] clock_gettime(CLOCK_MONOTONIC_RAW,
 ...) gets abnormal ts value
In-Reply-To: <YFmUrVOyX4q+8Dy9@osiris>
References: <CAEemH2cELFSMzEYM-Gd1LxNuFzVE2PcG1chzyaVhW2YCJjjzdw@mail.gmail.com>
 <YFmUrVOyX4q+8Dy9@osiris>
Message-ID: <YFnxr1ZlMIOIqjfq@osiris>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 23, 2021 at 08:11:41AM +0100, Heiko Carstens wrote:
> On Tue, Mar 23, 2021 at 02:21:52PM +0800, Li Wang wrote:
> > Hi linux-s390 experts,
> > 
> > We observed that LTP/clock_gettime04 always FAIL on s390x with
> > kernel-v5.12-rc3.
> > To simply show the problem, I rewrite the LTP reproducer as a simple C
> > below.
> > Maybe it's a new bug introduced from the kernel-5.12 series branch?
> > 
> > PASS:
> > ------------
> > # uname -r
> > 5.11.0-*.s390x
> > 
> > # grep TIME_NS /boot/config-5.11.0-*.s390x
> > no TIME_NS enabled
> > 
> > ## ./test-timer
> > vdso_ts_nsec = 898169901815, vdso_ts.tv_sec = 898, vdso_ts.tv_nsec =
> > 169901815
> > sys_ts_nsec  = 898169904269, sys_ts.tv_sec  = 898, sys_ts.tv_nsec  =
> > 169904269
> > ===> PASS
> > 
> > FAIL:
> > ----------
> > # uname -r
> > 5.12.0-0.rc3.*.s390x
> > 
> > # grep TIME_NS /boot/config-5.12.0-0.rc3.s390x
> > CONFIG_TIME_NS=y
> > CONFIG_GENERIC_VDSO_TIME_NS=y
> > 
> > # ./test-timer
> > vdso_ts_nsec = 4484351380985507, vdso_ts.tv_sec = 4484351, vdso_ts.tv_nsec
> > = 380985507
> > sys_ts_nsec  = 1446923235377, sys_ts.tv_sec  = 1446, sys_ts.tv_nsec  =
> > 923235377
> > ===> FAIL
> 
> Thanks for reporting!
> 
> I'll look later today into this. I would nearly bet that I broke it
> with commit f8d8977a3d97 ("s390/time: convert tod_clock_base to
> union")

So, I broke it with commit 1ba2d6c0fd4e ("s390/vdso: simplify
__arch_get_hw_counter()"). Reverting that patch will fix it for non
time namespace processes only.

The problem is that the vdso data page contains an array of struct
vdso_data's for each clock source. However only the first member of
that array contains a/the valid struct arch_vdso_data, which is
required for __arch_get_hw_counter(). Which alone is a bit odd...

However for a process which is within a time namespace there is no
(easy) way to access that page (the time namespace specific vdso data
page does not contain valid arch_vdso_data). I guess the real fix is
to simply map yet another page into the vvar mapping and put the
arch_data there. What a mess... :/
