From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Sat, 3 Apr 2021 12:07:37 +0530
Subject: [LTP] TBROK: Test killed by SIGSEGV" with adjtimex02.c
Message-ID: <CANUMPcXNUv6gBeguaX+rDjr=1uUXs2kuCcZYYuyzufgLn=dbcg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Team,

Below list of tests are failing with error message "BROK: Test killed by
SIGSEGV"


   1.     adjtimex02
   2.     getitimer02
   3.     getrusage02
   4.     msgctl04
   5.     setitimer02
   6.     shmctl02



Further analysis found that the root cause of failures are due to
"Cannot access memory at address 0xffffffff".

$cat getitimer02.c
/* call with a bad address */
TEST(getitimer(ITIMER_REAL, (struct itimerval *)-1));

#Debugging on image gives

Breakpoint 2, __getitimer (which=ITIMER_REAL, curr_value=0xffffffff) at
../sysdeps/unix/sysv/linux/getitimer.c:33
33 ../sysdeps/unix/sysv/linux/getitimer.c: No such file or directory.
(gdb) n
50 in ../sysdeps/unix/sysv/linux/getitimer.c
(gdb) p curr_value
$3 = (struct itimerval *) 0xffffffff
(gdb) p *curr_value
Cannot access memory at address 0xffffffff

Please let us know whether we need to handle SIGSEGV in above listed
testcases or we need to work on glibc for the fix.

This behavior is observed with glibc-2.32 version and above.

Regards,
Vinay
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210403/abf15538/attachment.htm>
