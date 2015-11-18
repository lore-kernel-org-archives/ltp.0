From: Jiri Vohanka <jvohanka@redhat.com>
Date: Wed, 18 Nov 2015 17:51:59 +0100
Subject: [LTP] mtest01 parent/child process synchronization issue
Message-ID: <564CACAF.1080201@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

I discovered a problem in mtest01 which causes it to freeze on some occasions.
As I understand it, the mtest01:

Master process:
* the master process starts several child processes
   (each child process is tasked with allocating some amount of memory)
* it waits until all child processes send SIGRTMIN signal or
   until the amount of free memory is decreased by the amount
   that all child tasks together should allocate
* it kills all child processes and exits

Child process:
* allocates certain amount of memory and fills it with some data
   (the '-w' option) so the pages are actually allocated
* when the desired amount of memory is allocated then it sends
   SIGRTMIN signal to the parent process
* it waits in the infinite loop (until parent commits filicide)

The problem that I encountered is that the master process never observes
sufficient decrease in the free memory and one of the child processes is
killed by oom-killer before it sends SIGRTMIN to the master process.
Thus, the master process never terminates.

I added a debug code that:
* Prints 'signal: <child-pid>' when SIGRTMIN is sent from the child process.
* Prints 'sigchld' when the master process receives SIGCHLD.
   (This happens when oom-killer kills the child process.)

I got the following result:

# ./mtest01 -p90 -w
mtest01     0  TINFO  :  Total memory already used on system = 2234816 kbytes
mtest01     0  TINFO  :  Total memory used needed to reach maximum = 9337709 kbytes
mtest01     0  TINFO  :  Filling up 90% of ram which is 7102893 kbytes
mtest01     0  TINFO  :  ... 831520768 bytes allocated and used.
signal: 2318
mtest01     0  TINFO  :  ... 3221225472 bytes allocated and used.
signal: 2316
sigchld

at the same time
# ps -e | grep mtest01
  2315 pts/0    00:00:00 mtest01
  2316 pts/0    00:00:03 mtest01
  2317 pts/0    00:00:04 mtest01 <defunct>
  2318 pts/0    00:00:00 mtest01

and dmesg shows
[ 1482.432478] Out of memory: Kill process 2317 (mtest01) score 251 or sacrifice child

You can see that the master task 2315 receives SIGRTMIN signal from 2318 and 2316
but not from 2317 which is killed by oom-killer, from which it receives SIGCHLD signal.

I think that the oom-killer should not be invoked during mtest01 (there might be
a problem in our kernel), nevertheless the test should handle that situation more
gracefully.

I attached a patch that fixes this issue. It modifies the test such that the master
task also waits for SIGCHLD. The test fails if SIGCHLD is received (I hope that
this is a correct behavior).

The output of the patched test looks like:
<<<test_start>>>
tag=mtest01w stime=1447855660
cmdline="mtest01 -p80 -w"
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory already used on system = 672000 kbytes
mtest01     0  TINFO  :  Total memory used needed to reach maximum = 8300185 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 7628185 kbytes
mtest01     1  TFAIL  :  mtest01.c:292: the child process was killed
<<<execution_status>>>
initiation_status="ok"
duration=7 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>

Regards,
Jiri Vohanka

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Watch-for-SIGCHLD-in-mtest01-in-case-the-child-gets-.patch
Type: text/x-patch
Size: 2460 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151118/dfe42bf7/attachment.bin>
