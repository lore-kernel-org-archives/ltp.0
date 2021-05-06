From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 14:57:09 +0200
Subject: [LTP] [PATCH 3/3] syscalls/io_submit: Convert libaio wrapper
 function to kernel syscall
In-Reply-To: <f47c4ec5-2d4a-76c8-5ef4-f8cfb12961e9@huawei.com>
References: <20210429115021.24128-1-xieziyao@huawei.com>
 <20210429115021.24128-4-xieziyao@huawei.com>
 <YJE5bkB8+PFBMWwD@yuki>
 <f47c4ec5-2d4a-76c8-5ef4-f8cfb12961e9@huawei.com>
Message-ID: <YJPnpfByh/C5kXbr@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

> Hi, Cyril,

> If we should test _both_ syscall() and the library, I would prefer to split
> libaio and native aio into two testcases in this testsuite, since <libaio.h>
> conflicts with <linux/aio_abi.h> during actual modification.

> Excuse me, is there any other good way to solve this problem?
NOTE: if most of the test the same, with little help of #ifdef and maybe 1-2
macros we can have single source for both variants (compiling 2 binaries).
See setdomainname and sethostname tests (setdomainname.h).

Kind regards,
Petr

> Thanks very much!

> Kind Regards,
> Ziyao

> On 2021/5/4 20:09, Cyril Hrubis wrote:
> > Hi!
> > > Instead of using the libaio wrapper function, the system call is
> > > changed to be invoked via syscall(2).

> > Ideally we should test _both_ syscall() and the library to maximize the
> > coverage. We can easily do that with .test_variants, have a look at
> > stime tests and testcases/kernel/syscalls/stime/stime_var.h how this is
> > done.

