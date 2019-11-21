From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 21 Nov 2019 16:38:20 +0800
Subject: [LTP] [PATCH v4 1/5] syscalls/quotactl01: Add Q_GETNEXTQUOTA
 test
In-Reply-To: <20191121083215.GC14920@dell5510>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1574241216-15168-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191120151244.GA28197@dell5510>
 <d1d72a63-fd3b-e670-4559-c0216176546c@cn.fujitsu.com>
 <20191121054507.GB59487@x230>
 <d346af6e-c037-7ac7-748a-a53c9b12046b@cn.fujitsu.com>
 <20191121083215.GC14920@dell5510>
Message-ID: <ef158248-aab5-74fb-fc1a-5bf9fbfeda79@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/11/21 16:32, Petr Vorel wrote:

> Hi Xu,
>
>> I see. Now, I think we should avoid to use <linux/types.h>?? because on musl? libc doesn't have it.
> IMHO <linux/types.h> are always installed from kernel, not from libc
> (packaged result of make headers_install run from kernel sources).

Oh, you are right. For this case, using <linux/types.h> is right that we don't have situation such as fanotify .

>
>> Also ,If we use uint64_t, they still failed on 2.6.32-754.el6.x86_64 with undefined  . Or, we should use TST_ABI to define uint64_t them
> Hm, that what I said: using kernel headers is imho easier that using libc
> headers (fewer problems with compatibility).
> Anyway, I don't want to block this patchset.
> We can always merge it as it is and sort/fix this problem later.

Yes. kernel header is more eaiser that libc. Thanks.

>
> Kind regards,
> Petr
>
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191121/9198e6fb/attachment.htm>
