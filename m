From: Li Wang <liwang@redhat.com>
Date: Tue, 29 Jun 2021 18:20:19 +0800
Subject: [LTP] [PATCH 2/2] lib/newlib_tests/test_macros*.c: Include more
 test macros
In-Reply-To: <1624958759-5562-2-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1624958759-5562-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1624958759-5562-2-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <CAEemH2dL=bZdP_X+YkZuOFK2dCV8RTq5CyZYPTrKh+_2yjHK5g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

On Tue, Jun 29, 2021 at 5:27 PM Yang Xu <xuyang2018.jy@fujitsu.com> wrote:

> 1) test TST_EXP_FD_SILENT macro in test_macros01.c
>

I'm thinking maybe we should add more info to indicate the TST_PASS result
from which TST_EXP_FD_SILENT? Because as TST_EXP_FD_SILENT will
keep silent, the only returned looks strange to us.

e.g.

        TST_EXP_FD_SILENT(pass_fd(), "%s", "SCALL");
-       tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+       tst_res(TINFO, "TST_PASS = %i from TST_EXP_FD_SILENT(pass_fd,
...)", TST_PASS);



> 2) test TST_EXP_FAIL2 macro in test_macros02.c
>


> 3) test TST_EXP_PASS_SILENT macro in test_macros03.c
>

here as well.

> 4) add test_macros04.c to test TST_EXP_PID and TST_EXP_PID_SILENT macros
>

and here.

Btw, the remaining part looks good to me.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210629/b591f5d2/attachment.htm>
