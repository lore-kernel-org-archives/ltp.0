From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 May 2016 14:39:28 +0200
Subject: [LTP] Fwd: pwrite04 ltp bug?
In-Reply-To: <CAOg9mSScVopGsoQeoESWAnD2YFrsr2qzQksC8A8T8m8dncFdAg@mail.gmail.com>
References: <CAOg9mSSjfxiZ960tpADgVmndxXQpC7ag9QZSz68NbdeGn+yW9g@mail.gmail.com>
 <CADVQ27oBdCxfuVmknYa16RTXpnYgncn94VnutMgn2+9VD-9bcg@mail.gmail.com>
 <CADVQ27q119e2Oqg0tVGDjc_8yjoXvQHbg=Tqd9n4jxu8tedRVg@mail.gmail.com>
 <CAOg9mSScVopGsoQeoESWAnD2YFrsr2qzQksC8A8T8m8dncFdAg@mail.gmail.com>
Message-ID: <20160523123928.GE22559@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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

This is obvious typo fix.

> -
> +                       cleanup();

This does not look right. Looking at the test source the rest of the ifs
has the cleanup right after tst_resm() but the cleanup() fuction is
supposed to be called exactly once at the end of the test at the end of
the main.

If it's called in the testing loop the test will fail when cleanup() is
invoked second time at the test exit since it will attempt to remove
allready deleted test temporary directory. So the correct solution to
this problem would rather be to remove the cleanup() from the test loop.

>                 }
>                 tst_resm(TPASS, "O_APPEND test passed.");

-- 
Cyril Hrubis
chrubis@suse.cz
