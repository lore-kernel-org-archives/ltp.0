From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Sat, 3 Apr 2021 12:24:08 +0530
Subject: [LTP] TBROK: Test killed by SIGSEGV" with adjtimex02.c
Message-ID: <CANUMPcW1RN-xVSmJ-uyg5dLgMcmFaSMVSYuO7tptQ+Ka6cT_jA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Team,

(Resending as the previous post was not in plaintext)

Below list of tests are failing with error message "BROK: Test killed
by SIGSEGV"

    adjtimex02
    getitimer02
    getrusage02
    msgctl04
    setitimer02
    shmctl02


Further analysis found that the root cause of failures are due to
"Cannot access memory at address 0xffffffff".

$cat getitimer02.c
/* call with a bad address */
TEST(getitimer(ITIMER_REAL, (struct itimerval *)-1));

#Debugging on image gives

Breakpoint 2, __getitimer (which=ITIMER_REAL, curr_value=0xffffffff)
at ../sysdeps/unix/sysv/linux/getitimer.c:33
33 ../sysdeps/unix/sysv/linux/getitimer.c: No such file or directory.
(gdb) n
50 in ../sysdeps/unix/sysv/linux/getitimer.c
(gdb) p curr_value
$3 = (struct itimerval *) 0xffffffff
(gdb) p *curr_value
Cannot access memory at address 0xffffffff

Please let us know whether we need to handle SIGSEGV in above listed
testcases or we need to work on glibc for the fix.

This behavior is observed with glibc-2.32 version and above. And
tested on target ARM 32bit .

Regards,
Vinay
