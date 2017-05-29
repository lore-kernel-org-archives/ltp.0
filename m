From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Mon, 29 May 2017 07:29:15 +0000 (UTC)
Subject: [LTP] memcg_usage_in_bytes sometimes failed
In-Reply-To: <1081797821.5060375.1490749608376@mail.yahoo.com>
References: <260795063.109541.1490150682697.ref@mail.yahoo.com>
 <260795063.109541.1490150682697@mail.yahoo.com> <20170328134152.GG1045@rei>
 <1081797821.5060375.1490749608376@mail.yahoo.com>
Message-ID: <955246247.2480445.1496042955204@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi, 
Ping :-)
It still sometimes failed even with the latest LTP version. Sometimes it mismatched in memory.memsw.max_usage_in_bytes, sometimes in memory.max_usage_in_bytes.
20170516-22-gf36b3a8

Thanks an regards,
Hoang. 
 
  On Wed, Mar 29, 2017 at 8:06, Hoang Nguyen<the_hoang0709@yahoo.com> wrote:   Hi Cyril,
memcg_usage_in_bytes_test.sh is not changed for long time, so I think I almost used the latest version of LTP
I resend the log, some EOL issue when I send it with my phone. Sorry for inconvenience.
Test:memcg_usage_in_bytes Testparm:memcg_usage_in_bytes_test.sh
memcg_usage_in_bytes_test 1 TINFO: Starting test1
memcg_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s4194304
memcg_usage_in_bytes_test 1 TINFO: Warming up pid:886
memcg_usage_in_bytes_test 1 TINFO: Process is still here after warm up:886
memcg_usage_in_bytes_test 1 TPASS: memory.usage_in_bytes is 4194304 asexpected
/opt/ltp/testcases/bin/memcg_lib.sh: line 477: echo: write error: Device orresource busy
memcg_usage_in_bytes_test 2 TINFO: restore /dev/memcg/memory.use_hierarchy failed
memcg_usage_in_bytes_test 2 TINFO: Starting test2
memcg_usage_in_bytes_test 2 TINFO: Running memcg_process --mmap-anon -s4194304
memcg_usage_in_bytes_test 2 TINFO: Warming up pid:906
memcg_usage_in_bytes_test 2 TINFO: Process is still here after warm up:906
memcg_usage_in_bytes_test 2 TFAIL: memory.memsw.usage_in_bytes is 4325376, 4194304expected
Result: 1
Best regards,
Hoang

      From: Cyril Hrubis <chrubis@suse.cz>
 To: Hoang Nguyen <the_hoang0709@yahoo.com> 
Cc: LTP List <ltp@lists.linux.it>
 Sent: Tuesday, 28 March 2017, 20:44
 Subject: Re: [LTP] memcg_usage_in_bytes sometimes failed
  
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


     
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170529/16b66a39/attachment.html>
