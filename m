From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Mar 2017 15:41:52 +0200
Subject: [LTP] memcg_usage_in_bytes sometimes failed
In-Reply-To: <260795063.109541.1490150682697@mail.yahoo.com>
References: <260795063.109541.1490150682697.ref@mail.yahoo.com>
 <260795063.109541.1490150682697@mail.yahoo.com>
Message-ID: <20170328134152.GG1045@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I rarely meet this issue on embedded system, armv7l kernel 3.14, but not sure what's going wrong. It can pass on some boards, but fail sometimes on others with same config.
> Is there any aditional preparation to make this case always pass? Have anyone experienced on this ?
> Test: memcg_usage_in_bytes Testparm: memcg_usage_in_bytes_test.shmemcg_usage_in_bytes_test 1 TINFO: Starting test 1memcg_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s 4194304memcg_usage_in_bytes_test 1 TINFO: Warming up pid: 886memcg_usage_in_bytes_test 1 TINFO: Process is still here after warm up: 886memcg_usage_in_bytes_test 1 TPASS: memory.usage_in_bytes is 4194304 as expected/opt/ltp/testcases/bin/memcg_lib.sh: line 477: echo: write error: Device or resource busymemcg_usage_in_bytes_test 2 TINFO: restore ??/dev/memcg/memory.use_hierarchy failedmemcg_usage_in_bytes_test 2 TINFO: Starting test 2memcg_usage_in_bytes_test 2 TINFO: Running memcg_process --mmap-anon -s 4194304memcg_usage_in_bytes_test 2 TINFO: Warming up pid: 906memcg_usage_in_bytes_test 2 TINFO: Process is still here after warm up: 906memcg_usage_in_bytes_test 2 TFAIL: memory.memsw.usage_in_bytes is 4325376, 4194304 expectedResult: 1

First of all, which LTP version are you using?

Also please resend the log so that the text is not on a single line.
It's nearly impossible to read it as it is.

-- 
Cyril Hrubis
chrubis@suse.cz
