From: Na Nha <minhnhan0801@gmail.com>
Date: Wed, 22 Nov 2017 00:18:22 +0700
Subject: [LTP]  [PROBLEM_WITH_CPUACCT.SH_100_100_LTP_TESTSUITE]
Message-ID: <CAPiF6ThOKV6egQ8nhxKoiUba1S8UzLP3h0LOB+HO8T9vc0vemg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello All,



My name is Le Minh Nhan from Vietnam. I am working on a Linux project which
is tested by LTP test suite.


I had run the test case “./cpuacct.sh 100 100” on my ARM board.

Afterward,  I have gotten a problem as bellow:



*1 TINFO: Creating 100 subgroups each with 100 processes*

*[69402.212655] imx2_wdt_interrupt: pretimer*

*[69402.212777] The following is the list of last 50 interrupts for each
CPU*

*[69402.212868] [69402.145532]: irqnumber 1023 cpuid 0*

*[69402.212960] [69402.145727]: irqnumber 99 cpuid 0*



And my ARM board restarted immediately.

I think the test case had made my board run out of CPU power(CPU
overloading ), so the watchdog timer has identified this problem and
restarted the board.

To resolve this problem, I have added a delay with 1 millisecond in
“do_test()” function of cpuacct.sh file as below, it will help to release
CPU resources

*for i in `seq 1 $max`; do*

*                        for j in `seq 1 $nbprocess`; do*

*                                    cpuacct_task
$testpath/subgroup_$i/tasks &*

*                                    sleep 0.001*

*                        done*

*            done*



But I worry that the solution makes the test case loss its meaning, whether
the test case is a type of stress test or not!



Could you please confirm that the solution (adding sleep function) is a
right way?

If not, could you please tell me the right way to resolve this problem!

Can I change its arguments from ./cpuacct.sh 100 100 to ./cpuacct.sh 50 50?



I look forward to your reply.



Thanks / Best regards,

*Le Minh Nhan*
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20171122/cdfa3cd0/attachment-0001.html>
