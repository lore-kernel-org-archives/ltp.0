From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Aug 2020 20:18:42 +0800
Subject: [LTP] [PATCH 2/4] syscalls/kill03,
 04: Cleanup && Convert to new library
In-Reply-To: <1597919168-10702-2-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1597919168-10702-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1597919168-10702-2-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <CAEemH2eUd3yCuxt3iawHPXKUSryiJprud3HvneSr=JK_1wFhXg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Feiyu Zhu <zhufy.jy@cn.fujitsu.com> wrote:

...
> +#include <unistd.h>
> +#include "tst_test.h"
> +
> +static pid_t real_pid, fake_pid, int_min_pid;
> +static void cleanup(void);
> +
> +static struct tcase {
> +       int test_sig;
> +       int exp_errno;
> +       int child_flag;
>

The child_flag field is not necessary, we could prepare a real child in
setup()
and reclaim it after testing via check the real_pid value, that will be
more easily.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200820/2115494a/attachment.htm>
