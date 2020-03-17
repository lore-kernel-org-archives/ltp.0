From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Mar 2020 15:55:03 +0800
Subject: [LTP] [PATCH] open_posix_testsuite: Enable the testsuite
In-Reply-To: <1584430400-47359-1-git-send-email-zou_wei@huawei.com>
References: <1584430400-47359-1-git-send-email-zou_wei@huawei.com>
Message-ID: <CAEemH2f5sMfOX5XjEOr8cmLRwu+YzMziEwRFPAegG+FAURi90A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zou & Xiao,

Do we really need to enable the open_posix_testsuite explicitly? By
default, LTP uses "--with-open-posix-testsuite" as the configure parameter
to enabling it, is that work for you?

i.e you can include the open_posix_testsuite build by perform `./build.sh`

On Tue, Mar 17, 2020 at 3:27 PM Zou Wei <zou_wei@huawei.com> wrote:

> Enable open posix testsuite compilation by default
>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  testcases/Makefile | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/testcases/Makefile b/testcases/Makefile
> index b04e630..ae1cafc 100644
> --- a/testcases/Makefile
> +++ b/testcases/Makefile
> @@ -30,10 +30,6 @@ include $(top_srcdir)/include/mk/env_pre.mk
>  #    run).
>  FILTER_OUT_DIRS                := kdump
>
> -ifneq ($(WITH_OPEN_POSIX_TESTSUITE),yes)
> -FILTER_OUT_DIRS                += open_posix_testsuite
> -endif
> -
>  ifneq ($(WITH_REALTIME_TESTSUITE),yes)
>  FILTER_OUT_DIRS                += realtime
>  endif
> --
> 2.6.2
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200317/6a1ba799/attachment-0001.htm>
