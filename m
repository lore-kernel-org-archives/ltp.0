From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Mon, 26 Oct 2020 15:04:48 +0100
Subject: [LTP] syscalls/timer_settime01: adjust for rounding from nsec
 to usec
In-Reply-To: <20201006085309.32227-1-cascardo@canonical.com>
Message-ID: <87v9exf5hb.fsf@oc8242746057.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi all,

the patch from Chris fixes the below issue on s390x:

timer_settime01.c:96: TINFO: Testing for using absolute time:
timer_settime01.c:169: TPASS: timer_settime(CLOCK_REALTIME) passed
timer_settime01.c:169: TPASS: timer_settime(CLOCK_MONOTONIC) passed
timer_settime01.c:169: TPASS: timer_settime(CLOCK_PROCESS_CPUTIME_ID) passed
timer_settime01.c:169: TPASS: timer_settime(CLOCK_THREAD_CPUTIME_ID) passed
timer_settime01.c:169: TPASS: timer_settime(CLOCK_BOOTTIME) passed
timer_settime01.c:111: TCONF: CLOCK_BOOTTIME_ALARM unsupported: EOPNOTSUPP (95)
timer_settime01.c:111: TCONF: CLOCK_REALTIME_ALARM unsupported: EOPNOTSUPP (95)
timer_settime01.c:156: TFAIL: timer_gettime(CLOCK_TAI) reported bad values (0: 50000019): SUCCESS (0)
timer_settime01.c:169: TPASS: timer_settime(CLOCK_TAI) passed

and

timer_settime01.c:96: TINFO: Testing for using absolute time:
timer_settime01.c:169: TPASS: timer_settime(CLOCK_REALTIME) passed
timer_settime01.c:169: TPASS: timer_settime(CLOCK_MONOTONIC) passed
timer_settime01.c:169: TPASS: timer_settime(CLOCK_PROCESS_CPUTIME_ID) passed
timer_settime01.c:169: TPASS: timer_settime(CLOCK_THREAD_CPUTIME_ID) passed
timer_settime01.c:156: TFAIL: timer_gettime(CLOCK_BOOTTIME) reported bad values (0: 50000097): SUCCESS (0)
timer_settime01.c:169: TPASS: timer_settime(CLOCK_BOOTTIME) passed
timer_settime01.c:111: TCONF: CLOCK_BOOTTIME_ALARM unsupported: EOPNOTSUPP (95)
timer_settime01.c:111: TCONF: CLOCK_REALTIME_ALARM unsupported: EOPNOTSUPP (95)
timer_settime01.c:169: TPASS: timer_settime(CLOCK_TAI) passed



Regards
Alex
