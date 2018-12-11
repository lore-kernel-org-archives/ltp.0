From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Dec 2018 08:33:18 +0200
Subject: [LTP] [PATCH] syscalls/fanotify09.c: Fix wrong group number
In-Reply-To: <1544435921-17431-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1544435921-17431-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <CAOQ4uxjJ3Nhy0Gu0+jOyjgdgddmmVfH_DqBdR3O_iE62mLOCeQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Dec 10, 2018 at 11:58 AM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  testcases/kernel/syscalls/fanotify/fanotify09.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
> index 625634a..0f926c4 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify09.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
> @@ -216,7 +216,7 @@ static void test_fanotify(unsigned int n)
>                 ret = read(fd_notify[i], event_buf, FAN_EVENT_METADATA_LEN);
>                 if (ret > 0) {
>                         tst_res(TFAIL, "group %d got event", i);
> -                       verify_event(0, event, FAN_CLOSE_NOWRITE);
> +                       verify_event(i, event, FAN_CLOSE_NOWRITE);
>                         if (event->fd != FAN_NOFD)
>                                 SAFE_CLOSE(event->fd);
>                         continue;
> --
> 1.8.3.1
>
>
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
