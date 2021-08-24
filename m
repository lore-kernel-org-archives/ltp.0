From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Aug 2021 17:24:49 +0200
Subject: [LTP] [PATCH 2/7] epoll_ctl: Add docparse formatting and
 cleanup for epoll_ctl02
In-Reply-To: <20210817064924.127970-3-xieziyao@huawei.com>
References: <20210817064924.127970-1-xieziyao@huawei.com>
 <20210817064924.127970-3-xieziyao@huawei.com>
Message-ID: <YSUPQSOB6pYOG4nj@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change to the documentation comment, thanks.

> +/*\
> + * [Description]
>   *
> + * Verify that,
> + * - epoll_ctl fails with EBADF if epfd is an invalid fd.
> + * - epoll_ctl fails with EBADF if fd is an invalid fd.
> + * - epoll_ctl fails with EINVAL if op is not supported.
> + * - epoll_ctl fails with EINVAL if fd is the same as epfd.
> + * - epoll_ctl fails with EINVAL if events is NULL.
> + * - epoll_ctl fails with ENOENT if fd is not registered with EPOLL_CTL_DEL.
> + * - epoll_ctl fails with ENOENT if fd is not registered with EPOLL_CTL_MOD.
> + * - epoll_ctl fails with EEXIST if fd is already registered with EPOLL_CTL_ADD.

There is no reason to repeat the 'epoll_ctl fails with' so I've moved it
to the "Verify that," part and also there has to be empty line after the
"Verify that..." so that the list renders as a list in asciidoc.

-- 
Cyril Hrubis
chrubis@suse.cz
