From: Mike Marshall <hubcap@omnibond.com>
Date: Fri, 20 May 2016 22:07:41 -0400
Subject: [LTP] Fwd: pwrite04 ltp bug?
In-Reply-To: <CADVQ27q119e2Oqg0tVGDjc_8yjoXvQHbg=Tqd9n4jxu8tedRVg@mail.gmail.com>
References: <CAOg9mSSjfxiZ960tpADgVmndxXQpC7ag9QZSz68NbdeGn+yW9g@mail.gmail.com>
 <CADVQ27oBdCxfuVmknYa16RTXpnYgncn94VnutMgn2+9VD-9bcg@mail.gmail.com>
 <CADVQ27q119e2Oqg0tVGDjc_8yjoXvQHbg=Tqd9n4jxu8tedRVg@mail.gmail.com>
Message-ID: <CAOg9mSScVopGsoQeoESWAnD2YFrsr2qzQksC8A8T8m8dncFdAg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi...

I think I found a bug in pwrite04.c. I mentioned it on the linux
filesystem mailing list and it was suggested that I mention it to
you...

-Mike

Forwarded conversation
Subject: pwrite04 ltp bug?
------------------------

From: *Mike Marshall* <hubcap@omnibond.com>
Date: Fri, May 20, 2016 at 4:51 PM
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <
hubcap@omnibond.com>


Hi everyone...

While fixing a couple of LTP regressions in the out-of-tree Orangefs
kernel module, I think I found a problem with the pwrite04 test,
here's what I think was meant:

# git diff testcases/kernel/syscalls/pwrite/pwrite04.c
diff --git a/testcases/kernel/syscalls/pwrite/pwrite04.c
b/testcases/kernel/syscalls/pwrite/pwrite04.c
index b297682..4ca7dc1 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite04.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite04.c
@@ -196,9 +196,9 @@ int main(int ac, char *av[])

                }
                if (statbuf.st_size != K5) {
-                       tst_resm(TFAIL, "file size is %ld != K4",
+                       tst_resm(TFAIL, "file size is %ld != K5",
                                 statbuf.st_size);
-
+                       cleanup();
                }
                tst_resm(TPASS, "O_APPEND test passed.");

Should I even be talking about this here, or should I go find
the github maintainers of LTP and ask them about it?

-Mike

----------
From: *Zorro Lang* <zorro.lang@gmail.com>
Date: Fri, May 20, 2016 at 8:56 PM
To: Mike Marshall <hubcap@omnibond.com>



2016年5月21日 04:52，"Mike Marshall" <hubcap@omnibond.com>写道：
>
> Hi everyone...
>
> While fixing a couple of LTP regressions in the out-of-tree Orangefs
> kernel module, I think I found a problem with the pwrite04 test,
> here's what I think was meant:
>
> # git diff testcases/kernel/syscalls/pwrite/pwrite04.c
> diff --git a/testcases/kernel/syscalls/pwrite/pwrite04.c
> b/testcases/kernel/syscalls/pwrite/pwrite04.c
> index b297682..4ca7dc1 100644
> --- a/testcases/kernel/syscalls/pwrite/pwrite04.c
> +++ b/testcases/kernel/syscalls/pwrite/pwrite04.c
> @@ -196,9 +196,9 @@ int main(int ac, char *av[])
>
>                 }
>                 if (statbuf.st_size != K5) {
> -                       tst_resm(TFAIL, "file size is %ld != K4",
> +                       tst_resm(TFAIL, "file size is %ld != K5",
>                                  statbuf.st_size);
> -
> +                       cleanup();
>                 }
>                 tst_resm(TPASS, "O_APPEND test passed.");
>
> Should I even be talking about this here, or should I go find
> the github maintainers of LTP and ask them about it?

Hi Mike,

Generally, we send LTP related patches to: ltp@lists.linux.it

Thanks,
Zorro

>
> -Mike
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160520/a1d8e5d4/attachment.html>
