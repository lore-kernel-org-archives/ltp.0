From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 May 2021 21:03:35 +0200
Subject: [LTP] [PATCH 0/3] syscalls/aio: Convert libaio wrapper function
 to kernel syscall
In-Reply-To: <20210429115021.24128-1-xieziyao@huawei.com>
References: <20210429115021.24128-1-xieziyao@huawei.com>
Message-ID: <YJBJB/S1ThSsNvCk@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

> Instead of using the libaio wrapper function, the system call is changed to be invoked via syscall(2).
Generally LGTM. Major thing for me is to replace <libaio.h> with <linux/aio_abi.h>.
Do you plan to transform other tests which now still use <libaio.h>
(testcases/kernel/io/aio/ and testcases/kernel/io/ltp-aiodio/, which are BTW
problematic on mainline kernel)? I guess it'd be good to keep some test using <libaio.h>.

FYI if you don't prefer put your copyright, I'll update it with LTP copyright.

You also mix more things in single commit: using kernel API instead of libaio
API (that you mentioned) with both code and comments cleanup. But commits are
quite compact thus LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
For whole patchset.

Kind regards,
Petr

> Xie Ziyao (3):
>   syscalls/io_destroy: Convert libaio wrapper function to kernel syscall
>   syscalls/io_setup: Convert libaio wrapper function to kernel syscall
>   syscalls/io_submit: Convert libaio wrapper function to kernel syscall

>  .../kernel/syscalls/io_destroy/io_destroy01.c |  49 ++------
>  .../kernel/syscalls/io_setup/io_setup01.c     |  94 +++++----------
>  .../kernel/syscalls/io_submit/io_submit01.c   | 110 ++++++++----------
>  3 files changed, 86 insertions(+), 167 deletions(-)
