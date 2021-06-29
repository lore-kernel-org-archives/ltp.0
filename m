From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Tue, 29 Jun 2021 10:33:42 +0000
Subject: [LTP] [PATCH 2/2] lib/newlib_tests/test_macros*.c: Include more
 test macros
In-Reply-To: <CAEemH2dL=bZdP_X+YkZuOFK2dCV8RTq5CyZYPTrKh+_2yjHK5g@mail.gmail.com>
References: <1624958759-5562-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1624958759-5562-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2dL=bZdP_X+YkZuOFK2dCV8RTq5CyZYPTrKh+_2yjHK5g@mail.gmail.com>
Message-ID: <60DAF735.1060401@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,
> Hi Xu,
>
> On Tue, Jun 29, 2021 at 5:27 PM Yang Xu <xuyang2018.jy@fujitsu.com
> <mailto:xuyang2018.jy@fujitsu.com>> wrote:
>
>     1) test TST_EXP_FD_SILENT macro in test_macros01.c
>
>
> I'm thinking maybe we should add more info to indicate the TST_PASS result
> from which TST_EXP_FD_SILENT? Because as TST_EXP_FD_SILENT will
> keep silent, the only returned looks strange to us.
Sound reasonable.  I will make these output more clear in v2.
Thanks for your review.

Best Regards
Yang Xu
>
> e.g.
>
> TST_EXP_FD_SILENT(pass_fd(), "%s", "SCALL");
> - tst_res(TINFO, "TST_PASS = %i", TST_PASS);
> + tst_res(TINFO, "TST_PASS = %i from TST_EXP_FD_SILENT(pass_fd, ...)",
> TST_PASS);
>
>     2) test TST_EXP_FAIL2 macro in test_macros02.c
>
>     3) test TST_EXP_PASS_SILENT macro in test_macros03.c
>
>
> here as well.
>
>     4) add test_macros04.c to test TST_EXP_PID and TST_EXP_PID_SILENT macros
>
>
> and here.
>
> Btw, the remaining part looks good to me.
>
> --
> Regards,
> Li Wang
