From: Xu, Yanfei <yanfei.xu@windriver.com>
Date: Fri, 21 Feb 2020 22:04:31 +0800
Subject: [LTP] controller case cpuset_load_balance failed
Message-ID: <7885e4eb-42b0-8d4b-4bdd-85f3d37799de@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi ,

I am trying to run controller case cpuset_load_balance on my Linux 
version 5.5.0

with yocto. But I got many failures :

<<<test_start>>>
tag=cpuset_load_balance stime=1580819970
cmdline="cpuset_load_balance_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
cpuset_load_balance 1 TINFO: general group load balance test
cpuset_load_balance 1 TINFO: root group info:
cpuset_load_balance 1 TINFO: sched load balance: 0
cpuset_load_balance 1 TINFO: general group info:
cpuset_load_balance 1 TINFO: cpus: -
cpuset_load_balance 1 TINFO: sched load balance: 1
*cpuset_load_balance 1 TFAIL: load balance test failed.*
cpuset_load_balance 3 TINFO: general group load balance test
cpuset_load_balance 3 TINFO: root group info:
cpuset_load_balance 3 TINFO: sched load balance: 0
cpuset_load_balance 3 TINFO: general group info:
.......
cpuset_load_balance 25 TINFO: general group2 info:
cpuset_load_balance 25 TINFO: cpus: 1,3
cpuset_load_balance 25 TINFO: sched load balance: 1
cpuset_load_balance 25 TINFO: CPU hotplug: online
smpboot: CPU 1 is now offline
x86: Booting SMP configuration:
smpboot: Booting Node 0 Processor 1 APIC 0x2
c*puset_load_balance 25 TFAIL: load balance test failed.*
<<<execution_staLTP: starting cpuset_hotplug (cpuset_hotplug_test.sh)
tus>>>
initiation_status="ok"
duration=410 termination_type=exited termination_id=1 corefile=no
cutime=251 cstime=1188
<<<test_end>>>


And I tried to analyse the source code for the reason, but didn't get it.

That what I found with the file cpuset_load_balance_test.sh as below:

general_load_balance_test1()
{
........

 ??? # start to fork the child processes
*/****(line*:108) The fork works rightly */ *

 ??? /bin/kill -s SIGUSR1 $pid 2> $CPUSET_TMP/stderr **
 ??? if [ $? -ne 0 ]; then
 ??? ??? cpuset_log_error $CPUSET_TMP/stderr
 ??? ??? tst_resm TFAIL "send the signal to fork the child tasks " \
 ??? ??? ??? ?? "failed."
 ??? ??? /bin/kill -s SIGKILL $pid
 ??? ??? return 1
 ??? fi

 ??? read fifo < ./myfifo
 ??? if [ $fifo -ne 0 ]; then
 ??? ??? cpuset_log_error $CPUSET_TMP/cpu-hog_stderr
 ??? ??? tst_resm TFAIL "forking test tasks failed"
 ??? ??? return 1
 ??? fi

 ??? # start to run the child processes
*/*(line:135)Something is wrong here. After the signal sent out, the 
child processes all become zombies*/*
 ??? /bin/kill -s SIGUSR1 $pid 2> $CPUSET_TMP/stderr
 ??? if [ $? -ne 0 ]; then
 ??? ??? cpuset_log_error $CPUSET_TMP/stderr
 ??? ??? tst_resm TFAIL "send the signal to run the child tasks " \
 ??? ??? ??? ?? "failed."
 ??? ??? /bin/kill -s SIGUSR2 $pid
 ??? ??? return 1
 ??? fi
*/*(line:143) Something is wrong here. wait returns value 1*/*
wait $pid
...........
}

Then I saw the file cpuset_cpu_hog.c for the zombies proccess with gdb. 
It seems

cpuset_cpusetofpid func(line:190) failed. But I didn't konw more about 
these cpuset

func.

Have you met problems about cpuset_load_balance like this?


Thanks!

Yanfei,


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200221/b6453e3d/attachment-0001.htm>
