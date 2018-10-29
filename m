From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 29 Oct 2018 14:03:15 +0100
Subject: [LTP] RFC: changed error code when binding unix socket twice
In-Reply-To: <20180831111436.GA23780@dell5510>
References: <20170630073448.GA9546@unicorn.suse.cz>
 <20180831111436.GA23780@dell5510>
Message-ID: <CAK8P3a2yfZKMtE16DNCjZBOQ1R5=uXD16k43eJ=najJBh7H85Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Aug 31, 2018 at 1:17 PM Petr Vorel <pvorel@suse.cz> wrote:
> > commit 0fb44559ffd6 ("af_unix: move unix_mknod() out of bindlock") moves
> > the special file creation in unix_bind() before u->bindlock is taken in
> > order to avoid an ABBA deadlock with do_splice(). As a side effect, it
> > also moves the check for existence of the special file (which would
> > result in -EADDRINUSE) before the check of u->addr (which would result
> > in -EINVAL if socket is already bound). This means that the error
> > returned for an attempt to bind a unix socket to the same path twice
> > changed from -EINVAL to -EADDRINUSE with this commit.
>
> > One way to restore the old error code is indicated below but before
> > submitting it, I would like to ask if we need/want it.
>
> > Pro:
> >   - in general, we do not want to change return code for given testcase
> >   - old error (-EINVAL) is consistent with AF_INET(6)
> > Con:
> >   - both POSIX and Linux man page only list error conditions without
> >     stating which should take precedence if more of them apply so
> >     neither of them seems wrong, strictly speaking
>
> I'd be for restoring the original behavior (be conservative + looks like as not intended).
>
> Any comment from netdev maintainers?

Naresh noticed that LTP now has a version check to  detect linux-4.10+ and
expect a different return code from previous versions, but the 0fb44559ffd6
commit that changed the behavior got backported to stable linux-4.4 and 4.9,
so now LTP complains about those:

https://bugs.linaro.org/show_bug.cgi?id=4042

I don't care much which error code gets returned here, but I think we
should either handle this consistently in all kernel versions and check for
the one that is deemed the correct one on all versions, or change LTP
again to accept either return code.

        Arnd

> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 1a0c961f4ffe..509292bdf7ed 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -992,7 +992,7 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
> >       struct unix_sock *u = unix_sk(sk);
> >       struct sockaddr_un *sunaddr = (struct sockaddr_un *)uaddr;
> >       char *sun_path = sunaddr->sun_path;
> > -     int err;
> > +     int err, mknod_err;
> >       unsigned int hash;
> >       struct unix_address *addr;
> >       struct hlist_head *list;
> > @@ -1016,12 +1016,10 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
> >       if (sun_path[0]) {
> >               umode_t mode = S_IFSOCK |
> >                      (SOCK_INODE(sock)->i_mode & ~current_umask());
> > -             err = unix_mknod(sun_path, mode, &path);
> > -             if (err) {
> > -                     if (err == -EEXIST)
> > -                             err = -EADDRINUSE;
> > -                     goto out;
> > -             }
> > +             mknod_err = unix_mknod(sun_path, mode, &path);
> > +             /* do not exit on error until after u->addr check */
> > +             if (mknod_err == -EEXIST)
> > +                     mknod_err = -EADDRINUSE;
> >       }
>
> >       err = mutex_lock_interruptible(&u->bindlock);
> > @@ -1031,6 +1029,10 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
> >       err = -EINVAL;
> >       if (u->addr)
> >               goto out_up;
> > +     if (mknod_err) {
> > +             err = mknod_err;
> > +             goto out_up;
> > +     }
>
> >       err = -ENOMEM;
> >       addr = kmalloc(sizeof(*addr)+addr_len, GFP_KERNEL);
