From: TAKAHASHI Tetsuya <takahashi.tetsuya.cis@canon-is.co.jp>
Date: Mon, 16 Nov 2015 06:38:27 +0000
Subject: [LTP]  controllers/memcg_stress: Does not work correctly?
Message-ID: <330BE2030BD7834286495D8B7FCF1FB71D30473D@mbx02.itr.canon-is.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello.

About testcase "controllers/memcg_stress", I have a question.

This test calculates a memory size to use on a test as follows.
------
- testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh

  mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
  swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`

  mem=$(( $mem_free + $swap_free / 2 ))
  mem=$(( mem / 1024 ))
------

In the case of this calculation, Lack of memory occurs when this test runs in "swap off" systems.

As for the calculation of the memory size to use for a test, may the following be right?
------
- testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh

  mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
  swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`

  mem=$(( ($mem_free + $swap_free) / 2 ))
  mem=$(( mem / 1024 ))
------

Best regards.
