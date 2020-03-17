From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Mar 2020 17:32:14 +0800
Subject: [LTP] [PATCH] open_posix_testsuite: Fix compilation issues
In-Reply-To: <0b85e10e-480f-f91a-0ce2-dc3a51cd2319@cn.fujitsu.com>
References: <1584430031-47227-1-git-send-email-zou_wei@huawei.com>
 <0b85e10e-480f-f91a-0ce2-dc3a51cd2319@cn.fujitsu.com>
Message-ID: <CAEemH2d7gEm+a91QbUVB2gccRf=dZaG_R1Uc7v_TQEVD7Q+StA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 17, 2020 at 5:08 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> Hi Zou
>
>
> > Fix compilation issues:
> > 1. Add the '-lpthread -lrt -lm' config into LDFLAGS
> See ltp/openposix/build[1] documention, as below:
>
> ----------------------------
> If you need to pass in any header locations, preprocessor definitions, etc,
>    set the value via CFLAGS.
> - If you need to pass in any libraries for linking, set the value via
> LDLIBS.
> - If you need to pass any other values to the linker, set the value via
> LDFLAGS.
> ----------------------------
>
> I guess we should use LDLIBS.
>

Xu is right, I misread these two words(LDLIBS vs LDFLAGS) during my
reviewing.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200317/25d997ac/attachment.htm>
