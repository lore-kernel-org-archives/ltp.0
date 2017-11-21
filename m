From: Na Nha <minhnhan0801@gmail.com>
Date: Wed, 22 Nov 2017 00:10:10 +0700
Subject: [LTP] <Failling_on_memcg_usage_in_bytes_test.sh>
Message-ID: <CAPiF6Th1sDgRJH2bFb3jX-cBJNVO0s4zmMSH3ezifK7Y9nQCWw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello LTP team,



There is an issue as below when I ran “./memcg_usage_in_bytes_test.sh” on
my ARM board



*mx6q:/opt/ltp/testcases/bin# ./memcg_usage_in_bytes_test.sh*

*memcg_usage_in_bytes_test 1 TINFO: Starting test 1*

*memcg_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s
4194304*

*memcg_usage_in_bytes_test 1 TINFO: Warming up pid: 19889*

*memcg_usage_in_bytes_test 1 TINFO: Process is still here after warm up:
19889*

*memcg_usage_in_bytes_test 1 TPASS: memory.usage_in_bytes is 4194304 as
expected*

*memcg_usage_in_bytes_test 2 TINFO: Starting test 2*

*memcg_usage_in_bytes_test 2 TINFO: Running memcg_process --mmap-anon -s
4194304*

*memcg_usage_in_bytes_test 2 TINFO: Warming up pid: 19909*

*memcg_usage_in_bytes_test 2 TINFO: Process is still here after warm up:
19909*

*memcg_usage_in_bytes_test 2 TFAIL: memory.memsw.usage_in_bytes is 4325376,
4194304 expected*



It is a dangling falling, sometimes the test result is pass and sometimes
is fail



My kernel is

*root@mx6q:/dev/shm# uname -a*

*Linux mx6q 3.14.79-01214-g76b5fd377784 #1 SMP PREEMPT Wed Nov 15 17:06:37
CET 2017 armv7l GNU/Linux*



Could you please help me to resolve the problem?



I look forward any reply.



Thanks / Best regards,


*Nhan Le Minh*
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20171122/e80f345f/attachment.html>
