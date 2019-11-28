From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 28 Nov 2019 09:12:48 +0100
Subject: [LTP] cpuacct tests: Rational behind test
Message-ID: <0aac6253-f3dc-f2e5-effb-397e9a5487e9@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I am looking at the cpuacct tests. These tests create n cgroups and
start m processes within each of these cgroups. The process runs until
it used 10 ms of cpu time and terminates.

The test is run with different values for n and m up to 100 and 100.
This creates 10000 processes, which CAN exist at the same time, because
the process can already terminate, while they are still started.
I wonder what the rational behind this is.

I question the the numbers used (up to 100/100) and more important the
spawn/kill timings.

If it is required, that all processes run in parallel, synchronization
is required. If it is not required, test processes should be started
and terminated in batches. This would probably reduce test runtime,
because the system is not permanently switching contexts.

Is it really required to run it with 100/100? Shouldn't it be enough
to run the test with 10/10 1/100 and 100/1? Sadly there is no rational
for the test at all in the sources.

J?rg
