From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 21 Nov 2019 15:07:21 +0800
Subject: [LTP] [PATCH v4 1/5] syscalls/quotactl01: Add Q_GETNEXTQUOTA
 test
In-Reply-To: <20191121051022.GA59487@x230>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1574241216-15168-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191120151244.GA28197@dell5510> <20191120151610.GB28197@dell5510>
 <efb495a4-1071-68fd-d5a2-7597646228e1@cn.fujitsu.com>
 <20191121051022.GA59487@x230>
Message-ID: <46954cdf-042b-fffd-583d-b1494d7747dd@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/11/21 13:10, Petr Vorel wrote:

> Hi Xu,
>
>>> + general question: do we want always test against kernel headers or libc
>>> headers? Libc is often outdated, so mostly it'd be our fallback to be tested.
>>> Ideally both kernel and libc header should be tested, but that's not easily
>>> achievable.
>> IMHO, We often test libc and it usually includes kernel headers ie.
>> <sys/quota.h> <sys/prctl.h>. I perfet to check one except that glibc and
>> kernel they have themselves implementation . If the struct or variable is
>> not defined, we can define it in ltp lapi headers. Then we can avoid build
>> error and increase coverage(because kernel may implement it).
> Yep. I'm ok with using libc headers (increased coverage), but we need good
> checks anyway for other libc (at least for musl; bionic also like glibc uses
> internally kernel headers, uclibc-ng usually embeds kernel header parts and
> strives to be glibc compatible anyway).

Hi Petr

Yes. I check <sys/quota.h> and <sys/prctl.h> on musl libc[1] and they don't include linux header files.
So I think checking both kernel and libc headers on other libc(musl,bionic) is meaningful.

ps: If our travis-ci has a target with musl, I think it will be better. I don't know whether possible.

[1]http://git.musl-libc.org/cgit/musl/tree/include/sys/quota.h

Thanks
Yang Xu

>
> Kind regards,
> Petr
>
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191121/5943fa14/attachment.htm>
