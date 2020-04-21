From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 21 Apr 2020 13:07:13 +0530
Subject: [LTP] Purpose of clock_nanosleep2 tests ?
Message-ID: <CAKohponWBU_pSDk6sjsMFBkJzwPDz71DcyC1_X6x1=0bZMb=aQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

While working on the time64 variants I stumbled upon
testcases/kernel/syscalls/clock_nanosleep2/.

The commit  log says that we were trying to test clock_nanosleep2()
syscall, which I am unable to find, but still this ends up calling the kernel
variant directly for clock_nanosleep() only.

What am I missing ? Why is this stuff required ?

--
Viresh
