From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 31 Aug 2018 13:14:36 +0200
Subject: [LTP] RFC: changed error code when binding unix socket twice
In-Reply-To: <20170630073448.GA9546@unicorn.suse.cz>
References: <20170630073448.GA9546@unicorn.suse.cz>
Message-ID: <20180831111436.GA23780@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> commit 0fb44559ffd6 ("af_unix: move unix_mknod() out of bindlock") moves
> the special file creation in unix_bind() before u->bindlock is taken in
> order to avoid an ABBA deadlock with do_splice(). As a side effect, it
> also moves the check for existence of the special file (which would
> result in -EADDRINUSE) before the check of u->addr (which would result
> in -EINVAL if socket is already bound). This means that the error
> returned for an attempt to bind a unix socket to the same path twice
> changed from -EINVAL to -EADDRINUSE with this commit.

> One way to restore the old error code is indicated below but before
> submitting it, I would like to ask if we need/want it.

> Pro:
>   - in general, we do not want to change return code for given testcase
>   - old error (-EINVAL) is consistent with AF_INET(6)
> Con:
>   - both POSIX and Linux man page only list error conditions without
>     stating which should take precedence if more of them apply so
>     neither of them seems wrong, strictly speaking

I'd be for restoring the original behavior (be conservative + looks like as not intended).

Any comment from netdev maintainers?


Kind regards,
Petr


> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 1a0c961f4ffe..509292bdf7ed 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -992,7 +992,7 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>  	struct unix_sock *u = unix_sk(sk);
>  	struct sockaddr_un *sunaddr = (struct sockaddr_un *)uaddr;
>  	char *sun_path = sunaddr->sun_path;
> -	int err;
> +	int err, mknod_err;
>  	unsigned int hash;
>  	struct unix_address *addr;
>  	struct hlist_head *list;
> @@ -1016,12 +1016,10 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>  	if (sun_path[0]) {
>  		umode_t mode = S_IFSOCK |
>  		       (SOCK_INODE(sock)->i_mode & ~current_umask());
> -		err = unix_mknod(sun_path, mode, &path);
> -		if (err) {
> -			if (err == -EEXIST)
> -				err = -EADDRINUSE;
> -			goto out;
> -		}
> +		mknod_err = unix_mknod(sun_path, mode, &path);
> +		/* do not exit on error until after u->addr check */
> +		if (mknod_err == -EEXIST)
> +			mknod_err = -EADDRINUSE;
>  	}

>  	err = mutex_lock_interruptible(&u->bindlock);
> @@ -1031,6 +1029,10 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>  	err = -EINVAL;
>  	if (u->addr)
>  		goto out_up;
> +	if (mknod_err) {
> +		err = mknod_err;
> +		goto out_up;
> +	}

>  	err = -ENOMEM;
>  	addr = kmalloc(sizeof(*addr)+addr_len, GFP_KERNEL);
