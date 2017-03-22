From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Wed, 22 Mar 2017 02:44:42 +0000 (UTC)
Subject: [LTP]  memcg_usage_in_bytes sometimes failed
References: <260795063.109541.1490150682697.ref@mail.yahoo.com>
Message-ID: <260795063.109541.1490150682697@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi all, 
I rarely meet this issue on embedded system, armv7l kernel 3.14, but not sure what's going wrong. It can pass on some boards, but fail sometimes on others with same config.
Is there any aditional preparation to make this case always pass? Have anyone experienced on this ?
Test: memcg_usage_in_bytes Testparm: memcg_usage_in_bytes_test.shmemcg_usage_in_bytes_test 1 TINFO: Starting test 1memcg_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s 4194304memcg_usage_in_bytes_test 1 TINFO: Warming up pid: 886memcg_usage_in_bytes_test 1 TINFO: Process is still here after warm up: 886memcg_usage_in_bytes_test 1 TPASS: memory.usage_in_bytes is 4194304 as expected/opt/ltp/testcases/bin/memcg_lib.sh: line 477: echo: write error: Device or resource busymemcg_usage_in_bytes_test 2 TINFO: restore  /dev/memcg/memory.use_hierarchy failedmemcg_usage_in_bytes_test 2 TINFO: Starting test 2memcg_usage_in_bytes_test 2 TINFO: Running memcg_process --mmap-anon -s 4194304memcg_usage_in_bytes_test 2 TINFO: Warming up pid: 906memcg_usage_in_bytes_test 2 TINFO: Process is still here after warm up: 906memcg_usage_in_bytes_test 2 TFAIL: memory.memsw.usage_in_bytes is 4325376, 4194304 expectedResult: 1

Thanks and regards 
Hoang


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170322/7180ff00/attachment.html>
