From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Oct 2019 16:24:52 +0800
Subject: [LTP] [PATCH v2] read_all: retry to queue work for any worker
In-Reply-To: <8c5d507fd19bc3110561ed1c666b7ac47442e09e.1570632125.git.jstancek@redhat.com>
References: <26d555b1d9deddb5a6f0a93a7c7d3b00e8abc1ff.1570616598.git.jstancek@redhat.com>
 <8c5d507fd19bc3110561ed1c666b7ac47442e09e.1570632125.git.jstancek@redhat.com>
Message-ID: <CAEemH2d82pP2mwHnw42h-17HipGsVeYesfzg7o4axvCiRKU0=Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Oct 9, 2019 at 10:43 PM Jan Stancek <jstancek@redhat.com> wrote:

> read_all is currently retrying only for short time period and it's
> retrying to queue for same worker. If that worker is busy, it easily
> hits timeout.
>
> For example 'kernel_page_tables' on aarch64 can take long time to
> open/read:
>   # time dd if=/sys/kernel/debug/kernel_page_tables of=/dev/null count=1
> bs=1024
>   1+0 records in
>   1+0 records out
>   1024 bytes (1.0 kB, 1.0 KiB) copied, 13.0531 s, 0.1 kB/s
>
>   real    0m13.066s
>   user    0m0.000s
>   sys     0m13.059s
>
> Rather than retrying to queue for specific worker, pick any that can accept
> the work and keep trying until we succeed or hit test timeout.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/fs/read_all/read_all.c | 33
> +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> v2: Increase sleep gradually.
>
> diff --git a/testcases/kernel/fs/read_all/read_all.c
> b/testcases/kernel/fs/read_all/read_all.c
> index 3dac20e02638..7beb08ccf712 100644
> --- a/testcases/kernel/fs/read_all/read_all.c
> +++ b/testcases/kernel/fs/read_all/read_all.c
> @@ -282,6 +282,35 @@ static void spawn_workers(void)
>         }
>  }
>
> +static void work_push_retry(int worker, const char *buf)
> +{
> +       int i, ret, worker_min, worker_max, usleep_time = 100;
> +
> +       if (worker < 0) {
> +               /* pick any, try -worker first */
> +               worker_min = worker * (-1);
> +               worker_max = worker_count;
> +       } else {
> +               /* keep trying worker */
> +               worker_min = worker;
> +               worker_max = worker + 1;
> +       }
> +       i = worker_min;
> +
> +       for (;;) {
> +               ret = queue_push(workers[i].q, buf);
> +               if (ret == 1)
> +                       break;
> +
> +               if (++i >= worker_max) {
> +                       i = worker_min;
> +                       if (usleep_time < 100000)
> +                               usleep_time *= 2;
> +                       usleep(usleep_time);
>

At first, I thought of TST_RETRY_FN_EXP_BACKOFF, but it seems not easy to
find the proper value of MAX_DELAY, so you method looks more stable to
read_all.

   Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191011/aae2d179/attachment.htm>
