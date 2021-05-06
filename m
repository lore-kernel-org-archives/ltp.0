From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 6 May 2021 20:27:57 +0800
Subject: [LTP] [PATCH 3/3] syscalls/io_submit: Convert libaio wrapper
 function to kernel syscall
In-Reply-To: <YJE5bkB8+PFBMWwD@yuki>
References: <20210429115021.24128-1-xieziyao@huawei.com>
 <20210429115021.24128-4-xieziyao@huawei.com> <YJE5bkB8+PFBMWwD@yuki>
Message-ID: <f47c4ec5-2d4a-76c8-5ef4-f8cfb12961e9@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Cyril,

If we should test _both_ syscall() and the library, I would prefer to 
split libaio and native aio into two testcases in this testsuite, since 
<libaio.h> conflicts with <linux/aio_abi.h> during actual modification.

Excuse me, is there any other good way to solve this problem?

Thanks very much!

Kind Regards,
Ziyao

On 2021/5/4 20:09, Cyril Hrubis wrote:
> Hi!
>> Instead of using the libaio wrapper function, the system call is
>> changed to be invoked via syscall(2).
> 
> Ideally we should test _both_ syscall() and the library to maximize the
> coverage. We can easily do that with .test_variants, have a look at
> stime tests and testcases/kernel/syscalls/stime/stime_var.h how this is
> done.
> 
