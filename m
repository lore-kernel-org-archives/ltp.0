From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 Sep 2016 16:04:17 +0530
Subject: [LTP] Number of testcases per releases - LTP
Message-ID: <CA+G9fYuF8y8Hr_RfnJUtbFVMnsMdJVr4dOugwmN=Mb0Yas_nmg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jonatas,

> I`m a PhD student interested in run some studies with the different LTP
> releases. I would like to know how can I identify tests inside LTP releases
> (i.e. number of testcases and module)
> Should I consider all .c files as tests in testcases folder?
No.

> Should I consider all .sh files in testcases folder?
No.

> If not, how should I identify a valid test case

All test cases listed in runtest/ directory. each file in side it
contains the list of test cases. those test cases divided logically
for full test suite execution, part of Linux sub system test cases and
long running stress tests.

Please walk through runtest directory. You may find repeated test
cases. you have to count it only once.

Example:
$ grep "shmget01 shmget01"  *
ltplite:shmget01 shmget01
stress.part3:shmget01 shmget01
syscalls:shmget01 shmget01
syscalls-ipc:shmget01 shmget01

Try to run each subset of test cases,
./runltp -f mm
./runltp -f math
./runltp -f syscalls
./runltp -f timers

- Naresh Kamboju

>
> --
> Jonatas Bastos
