From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 25 Aug 2020 14:57:46 +0800
Subject: [LTP] [PATCH] travis: Add centos7 build
In-Reply-To: <20200825064706.GA7135@x230>
References: <1598250984-5141-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200824151210.GA30969@dell5510>
 <4b7cb95c-fb39-6826-b229-723a1e8bb128@cn.fujitsu.com>
 <20200825064706.GA7135@x230>
Message-ID: <245c88aa-29aa-f9da-c308-24208f529371@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr


> Hi Xu,
> 
>>>> I have this idea when I meet ALG_SET_AEAD_ASSOCLEN undefined error on centos7.
>>>> Add centos7 travis target, it is more friendly for centos7 user and it is more
>>>> meaningful than centos6.
> 
>>> OK, how about replacing CentOS 6 with CentOS 7?
>> I have no objection about this because my kernel test team only uses
>> centos7/8 to test and doesn't use centos6 for a long time.
> OK. I don't have either, although I hesitated to sent this patch.
> 
>> But I think ltp community should reach a consensus that minimal
>> glibc/kernel/gcc(clang) version , so we can drop the corresponding code in
>> travis or m4.
> 
>> Also, we can raise "Define minimal supported kernel and (g)libc version"
>> topic again.
> Well, last time I remember we decide to drop CentOS 6 after the release. But I
> haven't done it. I also planned to create wiki pagge "Supported kernel and
> libc", but haven't done it. Feel free to send a patch for any of these two.
> But I'd prefer to do the replacement (7 instead of 6) instead of adding it,
> because travis already run for quite long.
OK. I will send a v2 patch to replace centos6 with centos7 in travis.

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
> 


