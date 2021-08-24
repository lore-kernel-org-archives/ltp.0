From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Aug 2021 17:38:55 +0200
Subject: [LTP] [PATCH 3/7] epoll_ctl: Add test for epoll_ctl03
In-Reply-To: <20210817064924.127970-4-xieziyao@huawei.com>
References: <20210817064924.127970-1-xieziyao@huawei.com>
 <20210817064924.127970-4-xieziyao@huawei.com>
Message-ID: <YSUSj8qaWPfMF1/w@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> +static void run_all(void)
> +{
> +	unsigned int index, events_bitmap;
> +
> +	for (index = 0; index < WIDTH_EPOLL_EVENTS; index++) {
> +		events_bitmap = ((EPOLLIN * ((index & 0x01) >> 0)) |
> +				(EPOLLOUT * ((index & 0x02) >> 1)) |
> +				(EPOLLPRI * ((index & 0x04) >> 2)) |
> +				(EPOLLERR * ((index & 0x08) >> 3)) |
> +				(EPOLLHUP * ((index & 0x10) >> 4)) |
> +				(EPOLLET * ((index & 0x20) >> 5)) |
> +				(EPOLLONESHOT * ((index & 0x40) >> 6)) |
> +				(EPOLLRDHUP * ((index & 0x80) >> 7)));

I guess that we can as well add a IS_BIT_SET() macro that would do:

#define IS_BIT_SET(val, bit) (((val) & (1<<(bit))) >> (bit))

And use that here instead.

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
