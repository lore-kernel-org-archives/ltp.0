From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 9 Aug 2021 16:53:15 +0800
Subject: [LTP] [PATCH 3/4] epoll_wait: Convert epoll_wait03 to the new
 API
In-Reply-To: <20210809083903.161596-4-xieziyao@huawei.com>
References: <20210809083903.161596-1-xieziyao@huawei.com>
 <20210809083903.161596-4-xieziyao@huawei.com>
Message-ID: <3241a2d2-af9b-8eca-51d6-cf134d29aa78@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Cyril,

> +/*\
> + * [Description]
> + *
> + * Basic test for epoll_wait:
>    *
> - * Expected Result:
> - *  1) epoll_wait(2) should return -1 and set errno to EBADF
> - *  2) epoll_wait(2) should return -1 and set errno to EINVAL
> - *  3) epoll_wait(2) should return -1 and set errno to EINVAL
> - *  4) epoll_wait(2) should return -1 and set errno to EINVAL
> - *  5) epoll_wait(2) should return -1 and set errno to EFAULT
> + * 1. epoll_wait fails with EBADF if epfd is not a valid file descriptor.
> + * 2. epoll_wait fails with EINVAL if epfd is not an epoll file descriptor.
> + * 3. epoll_wait fails with EINVAL if maxevents is less than zero.
> + * 4. epoll_wait fails with EINVAL if maxevents is equal to zero.
> + * 5. epoll_wait fails with EFAULT if the memory area pointed to by events is
> + * not accessible with write permissions.
>    */

As I mentioned in #792, testcases/kernel/syscalls/epoll_wait has some 
test points that can also cover the epoll_pwait/epoll_pwait2 system call 
since their underlying implementations are similar.

Therefore, I suggest that we add tests for different parameters in 
syscalls/epoll_pwait, and implement basic tests in syscalls/epoll_wait.

The case where timeout set to 0 causes the call to return immediately is 
added to epoll_wait04, and new tests for epoll_pwait/epoll_pwait2 will 
be added in syscalls/epoll_pwait.

...
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = verify_epoll_wait,
> +	.tcnt = ARRAY_SIZE(tc),
> +};
> --
> 2.17.1
> 
> .
> 

Thank you for the suggestion.

Kind Regards,
Ziyao
