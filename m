From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 21 Nov 2019 17:01:32 +0800
Subject: [LTP] [PATCH v4 1/5] syscalls/quotactl01: Add Q_GETNEXTQUOTA
 test
In-Reply-To: <20191121082118.GA14920@dell5510>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1574241216-15168-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191120151244.GA28197@dell5510> <20191120151610.GB28197@dell5510>
 <efb495a4-1071-68fd-d5a2-7597646228e1@cn.fujitsu.com>
 <20191121051022.GA59487@x230>
 <46954cdf-042b-fffd-583d-b1494d7747dd@cn.fujitsu.com>
 <20191121082118.GA14920@dell5510>
Message-ID: <af8b09de-63e9-be0f-f891-8bc24502e084@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/11/21 16:21, Petr Vorel wrote:

> Hi Xu,
>
>> Yes. I check <sys/quota.h> and <sys/prctl.h> on musl libc[1] and they don't include linux header files.
>> So I think checking both kernel and libc headers on other libc(musl,bionic) is meaningful.
> But in single C file we decide only on one of these two.
> It's a similar problem as testing raw syscall or libc wrapper (which we already
> solved with .test_variants).
> NOTE: Bionic has generate it's headers from linux headers.

I see.

Thanks again for reminding Bionic like glibc uses linux headers.

>
>> ps: If our travis-ci has a target with musl, I think it will be better. I don't know whether possible.
> It's here. But it requires some more fixes (in a meantime files are deleted),
> so I'll post it once it's everything fixed
> https://github.com/pevik/ltp/commits/travis/musl
> https://travis-ci.org/pevik/ltp/builds/614575796
>
> There is also CI on LTP on all glibc/uclibc-ng/musl in Buildroot
> http://autobuild.buildroot.net/index.php?reason=ltp-testsuite-20190930
>
> + There are other CI based on yocto/openembedded on glibc/uclibc-ng/musl

It is so cool.? And I think I? can move your musl patches to my ltp fork, so that I can also test them on musl
when I contribute my patches to ltp.

ps: I also think we should not block this patchset.

>
>> [1]http://git.musl-libc.org/cgit/musl/tree/include/sys/quota.h
> Kind regards,
> Petr
>
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191121/c86c4866/attachment.htm>
