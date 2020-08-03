From: Li Wang <liwang@redhat.com>
Date: Mon, 3 Aug 2020 16:55:19 +0800
Subject: [LTP] [PATCH] syscalls/timer_settime01: Use correct linux git
 tag
In-Reply-To: <1596424914-3762-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1596424914-3762-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2cw8LPZOAypOwde22PuHAFv4mUb=QCRUyPCL+t+ZuK1OA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>
>  #include <stdlib.h>
> @@ -188,7 +188,7 @@ static struct tst_test test = {
>         .setup = setup,
>         .tags = (const struct tst_tag[]) {
>                 {"linux-git", "f18ddc13af98"},
> -               {"linux-git", "d78c9300c51d"},
> +               {"linux-git", "e86fea764991"},
>
>
Confirmed and pushed.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200803/aa07d889/attachment.htm>
