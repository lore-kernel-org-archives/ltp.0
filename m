From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 20:22:48 +0200
Subject: [LTP] [PATCH 3/3] syscalls/io_submit: Convert libaio wrapper
 function to kernel syscall
In-Reply-To: <YJP2IDZIEOltnTiq@yuki>
References: <20210429115021.24128-1-xieziyao@huawei.com>
 <20210429115021.24128-4-xieziyao@huawei.com>
 <YJE5bkB8+PFBMWwD@yuki>
 <f47c4ec5-2d4a-76c8-5ef4-f8cfb12961e9@huawei.com>
 <YJPnpfByh/C5kXbr@pevik> <YJP2IDZIEOltnTiq@yuki>
Message-ID: <YJQz+MgeKcflG+Zn@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > > If we should test _both_ syscall() and the library, I would prefer to split
> > > libaio and native aio into two testcases in this testsuite, since <libaio.h>
> > > conflicts with <linux/aio_abi.h> during actual modification.

> > > Excuse me, is there any other good way to solve this problem?
> > NOTE: if most of the test the same, with little help of #ifdef and maybe 1-2
> > macros we can have single source for both variants (compiling 2 binaries).
> > See setdomainname and sethostname tests (setdomainname.h).

> Not sure that it's that easy here, since we cannot include libaio.h and
> aio_abi.h in a single file without getting conflicts, they define
> structures with the same name with possibly different layout, which
> makes this very tricky.

> I guess that having separate tests for different interface would
> probably be easiest solution in this case.

Sounds reasonable, thanks for info.

Kind regards,
Petr
