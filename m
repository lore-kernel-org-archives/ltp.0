From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 May 2021 13:47:05 +0200
Subject: [LTP] [PATCH 2/4] syscalls/modify_ldt: Replace TINFO with TPASS
 or TFAIL
In-Reply-To: <YJPbxQikXPap5DHW@pevik>
References: <20210429125255.31510-1-zhaogongyi@huawei.com>
 <YJPImeHT9rVsVtON@pevik> <YJPNgGwlZBLMaJOd@yuki>
 <YJPbxQikXPap5DHW@pevik>
Message-ID: <YJPXOY8/Nl/XzPO/@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> $ ./modify_ldt02
> modify_ldt02    1  TPASS  :  value read as expected
> modify_ldt02    0  TINFO  :  received signal: 11
> modify_ldt02    2  TFAIL  :  modify_ldt02.c:136: Did not generate SEGV
> 
> (I wrote my report below affected line)
> 
> 11 is SIGSEGV, thus there must be a bug in a test, which probably has been there
> before (test just didn't check). It's strange that WTERMSIG(status) returns 0
> instead of 11.

Looking at the code the bug is obvious, we setup a handler for SIGSEGV
that does exit(0). And since this is old API test we have to reset the
signal handler in the child as well. I will push a fix ASAP.

-- 
Cyril Hrubis
chrubis@suse.cz
