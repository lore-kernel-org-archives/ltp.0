From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Jun 2021 14:58:30 +0200
Subject: [LTP] [PATCH 6/7] io_setup: Add docparse formatting and more
 detailed description
In-Reply-To: <20210618094210.183027-7-xieziyao@huawei.com>
References: <20210618094210.183027-1-xieziyao@huawei.com>
 <20210618094210.183027-7-xieziyao@huawei.com>
Message-ID: <YNCM9qwRXZE8Zz/y@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + * 1. io_setup succeeds if both nr_events and ctxp are valid.
> + * 2. io_setup fails and returns -EINVAL if ctxp is not initialized to 0.
> + * 3. io_setup fails and returns -EINVAL if nr_events is invalid.
> + * 4. io_setup fails and returns -EFAULT if ctxp is NULL.
> + * 5. io_setup fails and returns -EAGAIN if nr_events exceeds the limit
>   *    of available events.

I've changed the numbered list to a asciidoc list (items start with -)
so that it renders nicely and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
