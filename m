From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 21 Nov 2019 11:37:46 +0800
Subject: [LTP] [PATCH v4 1/5] syscalls/quotactl01: Add Q_GETNEXTQUOTA
 test
In-Reply-To: <20191120151610.GB28197@dell5510>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1574241216-15168-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191120151244.GA28197@dell5510> <20191120151610.GB28197@dell5510>
Message-ID: <efb495a4-1071-68fd-d5a2-7597646228e1@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/11/20 23:16, Petr Vorel wrote:

> Hi Jan, Cyril, Xu,
>
>>> +#ifdef HAVE_STRUCT_IF_NEXTDQBLK
>>> +# include <linux/quota.h>
>>> +#else
>>> +# ifdef HAVE_LINUX_TYPES_H
>>> +# include <linux/types.h>
>> @Jan, @Cyril: Do we want to generally avoid loading <linux/types.h> if not really needed?
>> __u64 can be uint64_t etc (as it's also visible in struct dqblk in <sys/quota.h>
>> in various libc headers).
>> We used this approach for /usr/include/linux/bpf.h and for fanotify fixes for
>> musl (testcases/kernel/syscalls/fanotify/fanotify.h).
>> So unless you're against this approach here I'll change it before merge
>> (and add this info to next version of library API writing guidelines patch
>> https://patchwork.ozlabs.org/patch/1166786/).
> + general question: do we want always test against kernel headers or libc
> headers? Libc is often outdated, so mostly it'd be our fallback to be tested.
> Ideally both kernel and libc header should be tested, but that's not easily
> achievable.

IMHO, We often test libc and it usually includes kernel headers ie. 
<sys/quota.h> <sys/prctl.h>. I perfet to check one except that glibc and 
kernel they have themselves implementation . If the struct or variable 
is not defined, we can define it in ltp lapi headers. Then we can avoid 
build error and increase coverage(because kernel may implement it).   

>
> Kind regards,
> Petr
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191121/6c82d301/attachment.htm>
