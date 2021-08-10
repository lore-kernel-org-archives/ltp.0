From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Aug 2021 11:42:20 +0200
Subject: [LTP] [PATCH 3/4] syscalls/chmod03: Convert to new API
In-Reply-To: <20210810015250.21315-1-zhanglianjie@uniontech.com>
References: <20210810015250.21315-1-zhanglianjie@uniontech.com>
Message-ID: <YRJJ/Dsw3ubuzMdO@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor changes, thanks.

> +} tcases[] = {
> +	{bad_dir, ENAMETOOLONG, "chroot(pathname more than VFS_MAXNAMELEN)"},
> +	{fname, ENOTDIR, "chroot(not a directory)"},
> +	{nonexistent_dir, ENOENT, "chroot(path does not exists)"},
> +	{(char *)-1, EFAULT, "chroot(a path pointing to an invalid address)"},
> +	{symbolic_dir, ELOOP, "chroot(two symbolic directory who point to each other)"}
>  };

I've shortened the descriptions here a bit.

>  	/*
>  	 * create two symbolic directory who point to each other to
>  	 * test ELOOP.
>  	 */

And also remove this comment that have been commenting the obvious.

-- 
Cyril Hrubis
chrubis@suse.cz
