From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 4 May 2021 14:09:18 +0200
Subject: [LTP] [PATCH 3/3] syscalls/io_submit: Convert libaio wrapper
 function to kernel syscall
In-Reply-To: <20210429115021.24128-4-xieziyao@huawei.com>
References: <20210429115021.24128-1-xieziyao@huawei.com>
 <20210429115021.24128-4-xieziyao@huawei.com>
Message-ID: <YJE5bkB8+PFBMWwD@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Instead of using the libaio wrapper function, the system call is
> changed to be invoked via syscall(2).

Ideally we should test _both_ syscall() and the library to maximize the
coverage. We can easily do that with .test_variants, have a look at
stime tests and testcases/kernel/syscalls/stime/stime_var.h how this is
done.

-- 
Cyril Hrubis
chrubis@suse.cz
