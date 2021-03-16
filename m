From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Mar 2021 15:26:54 +0100
Subject: [LTP] [PATCH] runtest/syscalls: Add testcases to test list
In-Reply-To: <20210316090646.10061-1-zhaogongyi@huawei.com>
References: <20210316090646.10061-1-zhaogongyi@huawei.com>
Message-ID: <YFDALvacpAU5/fdF@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Add syscall test cases to test list.

I've looked at the tests the brk02 and get_mempolicy02 should have been
added to syscalls, this was a mistake that needs to be fixed ASAP.

As for the mem03.c the test is in a wrong place and should be moved and
reviewed first. It looks like it should be, at least, moved to the
syscalls/mmap/ directory and renamed to mmapXX.c

And similarily mmap10.c needs review and cleanup, it does not even print
pass/fail report at the end.

-- 
Cyril Hrubis
chrubis@suse.cz
