From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Mar 2021 13:41:14 +0800
Subject: [LTP] [PATCH] cleanup: Replace libc functions with safe_macros
In-Reply-To: <20210318084117.5663-1-zhaogongyi@huawei.com>
References: <20210318084117.5663-1-zhaogongyi@huawei.com>
Message-ID: <CAEemH2evz-Y+vMYOkTU8hFF0qaM88BE-s2UzjV2Fuo8v683=_A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi,

Zhao Gongyi <zhaogongyi@huawei.com> wrote:


> --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> @@ -128,17 +128,13 @@ static void generate_events(void)
>         /*
>          * Generate sequence of events
>          */
> -       if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
> -               exit(1);
> -       if (write(fd, fname, 1) == -1)
> -               exit(2);
> +       fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
>
> -       lseek(fd, 0, SEEK_SET);
> -       if (read(fd, buf, BUF_SIZE) != -1)
> -               exit(3);
> +       SAFE_WRITE(fd, fname, 1);
>

SAFE_READ/SAFE_WRITE requires 4 arguments, but only 3 given,
it even builds fails after applying this patch. So it'd be better to compile
PASS at least locally before sending it to ML.



> --- a/testcases/kernel/syscalls/fanotify/fanotify07.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
> @@ -53,14 +53,12 @@ static void generate_events(void)
>         /*
>          * generate sequence of events
>          */
> -       if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
> -               exit(1);
> +       fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0700);
>

FNAME --> fname


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210319/b6457145/attachment.htm>
