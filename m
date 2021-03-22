From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Mar 2021 13:31:31 +0800
Subject: [LTP] [PATCH v2] cleanup: Replace libc function with safe_macros
In-Reply-To: <20210322032630.21094-1-zhaogongyi@huawei.com>
References: <20210322032630.21094-1-zhaogongyi@huawei.com>
Message-ID: <CAEemH2d5NFhuh6aVukJ0z4VtU6APMVLTBWGR8_2WAT6yZquRgw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 22, 2021 at 11:27 AM Zhao Gongyi <zhaogongyi@huawei.com> wrote:

> For those:
>         testcases/kernel/syscalls/fanotify/fanotify01.c
>         testcases/kernel/syscalls/fanotify/fanotify03.c
>         testcases/kernel/syscalls/fanotify/fanotify07.c
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
> v1->v2: correct compile error.
>

Pushed, thanks!


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210322/3f730e4f/attachment-0001.htm>
