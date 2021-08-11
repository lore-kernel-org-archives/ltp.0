From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Aug 2021 15:30:39 +0200
Subject: [LTP] [PATCH 3/4] epoll_wait: Convert epoll_wait03 to the new
 API
In-Reply-To: <20210809083903.161596-4-xieziyao@huawei.com>
References: <20210809083903.161596-1-xieziyao@huawei.com>
 <20210809083903.161596-4-xieziyao@huawei.com>
Message-ID: <YRPQ/zpKDGbc+9nz@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + * 1. epoll_wait fails with EBADF if epfd is not a valid file descriptor.
> + * 2. epoll_wait fails with EINVAL if epfd is not an epoll file descriptor.
> + * 3. epoll_wait fails with EINVAL if maxevents is less than zero.

I've changed this list to be use dashes instead of numbers, since that
is how the rest of the testcases documents subtests in lists.

And pushed the whole patchset, nice work, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
