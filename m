From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Mar 2021 14:02:56 +0800
Subject: [LTP] [PATCH] open_posix: Remove hardcoded /tmp
In-Reply-To: <20210316130036.1838169-1-lkml@jv-coder.de>
References: <20210316130036.1838169-1-lkml@jv-coder.de>
Message-ID: <CAEemH2dxiFi_6VUOpyaufkOecE8TCi-m8bVT=xY9GREzOfKW-A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Joerg Vehlow <lkml@jv-coder.de> wrote:

...
>
>  int main(void)
>  {
> -       char tmpfname[256];
> +       char tmpfname[PATH_MAX];
>  #define BUF_SIZE 1024
>         char buf[BUF_SIZE];
>         struct timespec processing_completion_ts = {0, 10000000};
> @@ -46,8 +47,7 @@ int main(void)
>         if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
>                 return PTS_UNSUPPORTED;
>
> -       snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_cancel_1_1_%d",
> -                getpid());
> +       LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_1_1");
>

It'd be great if a passing string end with the suffix "_", be used to
clearly distinguish the PID number.

Something like:
    LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_1_1_");

This comment applies to all of the changing files in this patch, or we can
modify it in the macro prototype.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210317/c2bc4588/attachment.htm>
