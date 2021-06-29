From: Li Wang <liwang@redhat.com>
Date: Tue, 29 Jun 2021 20:29:11 +0800
Subject: [LTP] [PATCH v2] lib/newlib_tests/test_macros*.c: Include more
 test macros
In-Reply-To: <1624965249-7087-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <CAEemH2dL=bZdP_X+YkZuOFK2dCV8RTq5CyZYPTrKh+_2yjHK5g@mail.gmail.com>
 <1624965249-7087-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <CAEemH2fcsimizmXWzQzavMWz4rOBVwznB9r7aPLgqasYcjfJqA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 29, 2021 at 7:13 PM Yang Xu <xuyang2018.jy@fujitsu.com> wrote:

> 1) test TST_EXP_FD_SILENT macro in test_macros01.c
> 2) test TST_EXP_FAIL2 macro in test_macros02.c
> 3) test TST_EXP_PASS_SILENT macro in test_macros03.c
> 4) add test_macros04.c to test TST_EXP_PID and TST_EXP_PID_SILENT macros
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
> v1->v2:
> 1.add more info for silent macro
> 2.replace scall string with function name
>

Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210629/93cc2a5d/attachment.htm>
