From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Tue, 30 Jun 2020 13:06:37 +0000
Subject: [LTP] Memcg testcase failure
Message-ID: <BMXPR01MB2344F43177589233AA67FF27EE6F0@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
I am trying to run ltp with kernel 5.5.6 and i found that the few tests from the memcg groups are failing i didnt understood the exact reason of failure am listing the test cases along with error log of few test can you help me on this??

1) memcg_max_usage_in_bytes
2) memcg_stat
3) memcg_use_hierarchy

when i am trying to run memcg_max_usage_in_bytes

$#cmdline="memcg_usage_in_bytes_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
memcg_usage_in_bytes_test 1 TINFO: Starting test 1
/opt/ltp/testcases/bin/memcg_lib.sh: line 522: echo: write error: Device or resource busy
memcg_usage_in_bytes_test 1 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
memcg_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s 4194304
memcg_usage_in_bytes_test 1 TINFO: Warming up pid: 98968
memcg_usage_in_bytes_test 1 TINFO: Process is still here after warm up: 98968
memcg_usage_in_bytes_test 1 TFAIL: memory.usage_in_bytes is 4202496, 4194304 expected
memcg_usage_in_bytes_test 2 TINFO: Starting test 2
/opt/ltp/testcases/bin/memcg_lib.sh: line 522: echo: write error: Device or resource busy
memcg_usage_in_bytes_test 2 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
memcg_usage_in_bytes_test 2 TINFO: Running memcg_process --mmap-anon -s 4194304
memcg_usage_in_bytes_test 2 TINFO: Warming up pid: 98988
memcg_usage_in_bytes_test 2 TINFO: Process is still here after warm up: 98988
memcg_usage_in_bytes_test 2 TFAIL: memory.memsw.usage_in_bytes is 4325376, 4194304 expected
<<<execution_status>>>

 i would like to mention that memory resource controller is not available on my arch because of this can they fail ??Can you help me on this?? I am stuck with this from long back

Thanks!

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200630/82db6429/attachment.htm>
