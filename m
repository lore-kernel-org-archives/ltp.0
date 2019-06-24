From: Li Wang <liwan@redhat.com>
Date: Mon, 24 Jun 2019 10:56:02 +0800
Subject: [LTP] [PATCH] syscalls/clock_adjtime: Fix unsupported WARN
In-Reply-To: <20190621095134.12604-1-pifang@redhat.com>
References: <20190621095134.12604-1-pifang@redhat.com>
Message-ID: <CAEemH2dJAqJRY4ZM_oJ+rjoYOkqGQm=At2boHRfJZ=RLfP_+yg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jun 21, 2019 at 5:51 PM Ping Fang <pifang@redhat.com> wrote:

> When clock_adjtime is not implemented, cleanup will
> still try this call, then enter tst_cvres WARN handler.
>
> tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
> ../../../../include/tst_safe_clocks.h:57: CONF: syscall(-1)
> __NR_clock_adjtime not supported
> ../../../../include/tst_safe_clocks.h:57: CONF: syscall(-1)
> __NR_clock_adjtime not supported
> ../../../../include/tst_safe_clocks.h:60: WARN: clock_adjtime02.c:211
> clock_adjtime() failed -1: ENOSYS
>
> Summary:
> passed   0
> failed   0
> skipped  1
> warnings 1
>
> Signed-off-by: Ping Fang <pifang@redhat.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190624/4e6e3ba5/attachment.html>
