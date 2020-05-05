From: Florian Weimer <fw@deneb.enyo.de>
Date: Tue, 05 May 2020 13:34:42 +0200
Subject: [LTP] [bug?] clone(CLONE_IO) failing after kernel commit commit
 ef2c41cf38a7
In-Reply-To: <20200505102154.2sxm7yt5v3up55v3@wittgenstein> (Christian
 Brauner's message of "Tue, 5 May 2020 12:21:54 +0200")
References: <1038674044.11248021.1588663714272.JavaMail.zimbra@redhat.com>
 <87pnbi4y8x.fsf@mid.deneb.enyo.de>
 <20200505083205.qwwdiotmmjl23aje@wittgenstein>
 <87a72m4uqm.fsf@mid.deneb.enyo.de>
 <20200505091554.eq7kzvb4twe2wgvl@wittgenstein>
 <871rny4taz.fsf@mid.deneb.enyo.de>
 <20200505095813.z7kakdbiwq7ewnmx@wittgenstein>
 <20200505102154.2sxm7yt5v3up55v3@wittgenstein>
Message-ID: <87h7wu399p.fsf@mid.deneb.enyo.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Christian Brauner:

> diff --git a/kernel/fork.c b/kernel/fork.c
> index 8c700f881d92..e192089f133e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2569,12 +2569,15 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
>                  unsigned long, tls)
>  #endif
>  {
> +       /* Ignore the upper 32 bits. */
> +       unsigned int flags = (clone_flags & 0xfffffff);
> +
>         struct kernel_clone_args args = {
> -               .flags          = (clone_flags & ~CSIGNAL),
> +               .flags          = (flags & ~CSIGNAL),
>                 .pidfd          = parent_tidptr,
>                 .child_tid      = child_tidptr,
>                 .parent_tid     = parent_tidptr,
> -               .exit_signal    = (clone_flags & CSIGNAL),
> +               .exit_signal    = (flags & CSIGNAL),
>                 .stack          = newsp,
>                 .tls            = tls,
>         }
>
> (Note that kernel_clone_args->flags is a 64 bit unsigned integer.)

This looks reasonable to me, but I have not tested it.  I think it
will restore the expected no-check behavior for clone flags.
