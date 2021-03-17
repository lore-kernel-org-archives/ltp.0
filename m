From: zhaogongyi <zhaogongyi@huawei.com>
Date: Wed, 17 Mar 2021 05:02:46 +0000
Subject: [LTP] [PATCH] runtest/syscalls: Add testcases to test list
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038927DB@dggeml511-mbs.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I have resubmit the patch according your review. The problem of test case mem03.c and mmap10.c may be fixed in later work.

Thanks so much!

Best Regards,
Gongyi

> 
> Hi!
> > Add syscall test cases to test list.
> 
> I've looked at the tests the brk02 and get_mempolicy02 should have been
> added to syscalls, this was a mistake that needs to be fixed ASAP.
> 
> As for the mem03.c the test is in a wrong place and should be moved and
> reviewed first. It looks like it should be, at least, moved to the
> syscalls/mmap/ directory and renamed to mmapXX.c
> 
> And similarily mmap10.c needs review and cleanup, it does not even print
> pass/fail report at the end.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
