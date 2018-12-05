From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 Dec 2018 23:07:47 +0100
Subject: [LTP] [PATCH v2 2/2] lapi/syscalls: Add syscall numbers for
 process_vm_readv/_writev
In-Reply-To: <1544017426-10669-2-git-send-email-kerneljasonxing@linux.alibaba.com>
References: <1514394255.82007574.1543913641122.JavaMail.zimbra@redhat.com>
 <1544017426-10669-1-git-send-email-kerneljasonxing@linux.alibaba.com>
 <1544017426-10669-2-git-send-email-kerneljasonxing@linux.alibaba.com>
Message-ID: <20181205220747.GD21236@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jason,

> Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
> Signed-off-by: Caspar Zhang <caspar@linux.alibaba.com>
> ---

...
> diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
> index c7ed2fe..bf04895 100644
> --- a/include/lapi/syscalls/aarch64.in
> +++ b/include/lapi/syscalls/aarch64.in
> --- a/include/lapi/syscalls/arm.in
> +++ b/include/lapi/syscalls/arm.in
> @@ -334,6 +334,8 @@ accept4 (__NR_SYSCALL_BASE+366)
>  fanotify_init (__NR_SYSCALL_BASE+367)
>  fanotify_mark (__NR_SYSCALL_BASE+368)
>  prlimit64 (__NR_SYSCALL_BASE+369)
> +process_vm_readv(__NR_SYSCALL_BASE+376)
> +process_vm_writev(__NR_SYSCALL_BASE+377)
This triggered error during generation headers:
invalid line found: process_vm_readv(__NR_SYSCALL_BASE+376)
(reproducible by: cd $l/include/lapi/syscalls; ./regen.sh)

and thus build error:
../../../../include/lapi/syscalls.h:13: error: unterminated #ifndef
 #ifndef __LAPI_SYSCALLS_H__

I fixed it by adding space:

-process_vm_readv(__NR_SYSCALL_BASE+376)
-process_vm_writev(__NR_SYSCALL_BASE+377)
+process_vm_readv (__NR_SYSCALL_BASE+376)
+process_vm_writev (__NR_SYSCALL_BASE+377)

+ put this commit first and pushed.

Thanks for your patches.

Kind regards,
Petr
