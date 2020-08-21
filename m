From: Li Wang <liwang@redhat.com>
Date: Fri, 21 Aug 2020 13:49:01 +0800
Subject: [LTP] [PATCH 3/4] syscalls/kill05:Cleanup && Convert to new
 library
In-Reply-To: <1597919168-10702-3-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1597919168-10702-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1597919168-10702-3-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <CAEemH2f2pSyYGSvd0cxNoufAWMQTpObkE+OU974AJQmaH-+9eQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Aug 20, 2020 at 6:27 PM Feiyu Zhu <zhufy.jy@cn.fujitsu.com> wrote:

> ...
>   *     Looping with the -i option does not work correctly.
>

This line should be removed since it works well with -i.

> +static void wait_for_flag(int value)
>  {
>         while (1) {
>                 if (*flag == value)
>

Sleep 1sec is too long here, we can use usleep(100) for a replacement.

+static struct tst_test test = {
> +       .setup = setup,
> +       .cleanup = cleanup,
> +       .test_all = verify_kill,
> +       .needs_tmpdir = 1,
>

'.needs_tmdir' is redundant.


> +       .needs_root = 1,
> +       .forks_child = 1,
> +};
>
The remaining part looks good.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200821/d8fb8c0e/attachment.htm>
