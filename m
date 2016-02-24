From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Feb 2016 17:11:18 +0100
Subject: [LTP] [PATCH v2 1/3] epoll_wait/epoll_wait01.c: add new testcase
In-Reply-To: <1455706286-4090-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <56AEECEC.8090305@cn.fujitsu.com>
 <1455706286-4090-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160224161118.GF8292@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes. Thanks.

> +static int get_writesize(void)
> +{
> +	int nfd, write_size;
> +	char buf[4096];
> +
> +	memset(buf, 'a', sizeof(buf));
> +
> +	struct pollfd pfd[] = {
> +		{.fd = fds[0], .events = POLLIN},
> +		{.fd = fds[1], .events = POLLOUT},
> +	};
> +
> +	write_size = 0;
> +	do {
> +		write_size += SAFE_WRITE(cleanup, 0, fds[1], buf, sizeof(buf));
> +		nfd = poll(pfd, 2, -1);
> +		if (nfd == -1)
> +			tst_brkm(TBROK | TERRNO, cleanup, "poll failed");
> +	} while (nfd == 2);

I've removed the fds[0] from the pollfd structure and instead of that
changed the poll() to have 1 ms timeout. Since making sure that it
returns on timeout is less confusing than making sure the poll returns
because we passed another file descriptor that has some data to be
read...

> +	char read_buf[write_size];
> +
> +	SAFE_READ(cleanup, 1, fds[0], read_buf, sizeof(read_buf));
> +
> +	return write_size;
> +}

...

> +static int has_event(struct epoll_event *epevs, int epevs_len,
> +	int fd, uint32_t events)
> +{
> +	int i, result;
> +
> +	result = 0;
> +	for (i = 0; i < epevs_len; i++) {
> +		if ((epevs[i].data.fd == fd) && (epevs[i].events == events)) {
> +			result = 1;
> +			break;
> +		}
> +	}
> +
> +	return result;
> +}

And simplified this part to:

...
{
        int i;

        for (i = 0; i < epevs_len; i++) {
                if ((epevs[i].data.fd == fd) && (epevs[i].events == events))
                        return 1;
        }

        return 0;
}

-- 
Cyril Hrubis
chrubis@suse.cz
