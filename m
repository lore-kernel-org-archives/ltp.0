From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 5 Feb 2021 15:44:45 +0800
Subject: [LTP] [PATCH v2 1/5] tst_mallinfo.c: Add a common print helper
 for mallinfo
In-Reply-To: <CAEemH2f_mvjt4couA++RcOf9bAMO8fnqapkgG59Qvs9Ud-2SHw@mail.gmail.com>
References: <CAEemH2eiTY7YgSYLr6_skK6PaRZb2_GchbmHUJKVuW7btA15rQ@mail.gmail.com>
 <1612440762-22389-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2f_mvjt4couA++RcOf9bAMO8fnqapkgG59Qvs9Ud-2SHw@mail.gmail.com>
Message-ID: <601CF76D.8020705@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li
> Hi Xu,
>
> Thanks for your work.
>
>     --- /dev/null
>     +++ b/include/tst_mallinfo.h
>
>
> Do we really need to export this function into the LTP library?
> (I assumed no other tests will using this lib function anymore)
Maybe we can add tst_print_mallinfo2 in the future and mallinfo2() case
can use this header.

>
> So I prefer to create a common header file as:
> ../syscalls/mallinfo/mallinfo_common.h,
> and just use it locally.
>
> If you're hoping mallopt01.c also benefits from it, only need to
> build something like mallinfo_commo.o via Makefile and include
> it in mallopt01.c by "../mallinfo/mallinfo_common.h".
Just want to avoid random makefile. I am not sure which way is better. 
Let's listen advise from other maintainers.
>
> --
> Regards,
> Li Wang



