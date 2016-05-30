From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 May 2016 13:39:23 +0200
Subject: [LTP] memcg_memsw_limit_in_bytes_test mlock failed: Resource
 temporarily unavailable
In-Reply-To: <CAAUgArDNuD89q3dFLxqwjMi-6opiggZhWo_oEL9qUNUxcxCkrA@mail.gmail.com>
References: <CAAUgArDNuD89q3dFLxqwjMi-6opiggZhWo_oEL9qUNUxcxCkrA@mail.gmail.com>
Message-ID: <20160530113923.GA6079@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I ran LTP test "memcg_memsw_limit_in_bytes_test" with kernel 3.10.0-327.el7
> always reported the below error:
> 
> memcg_memsw_limit_in_bytes_test 2 TFAIL : ltpapicmd.c:193: process 3769 is
> killed by error /opt/ltp/testcases/bin/memcg_lib.sh: line 210: 3784 Killed
> $TEST_PATH/memcg_process $2 -s $3
> 
> In function mmap_lock2() mlock failed just return 1, not the oom killer
> kill the process.
> And base on the this:
> http://marc.info/?l=linux-mm&m=142122902313315&w=2
> 
> I think mlock failed it is a expect behavior, so why mask the test as
> Failed ?

So the test fails in mlock() and the mlock() supposedly returns with
ENOMEM right? This is indeed valid outcome and the test should report
pass. I guess that we have to return something different from 1 from the
test process if some of the calls has failed with ENOMEM and change the
test library to report that as success as well.

-- 
Cyril Hrubis
chrubis@suse.cz
