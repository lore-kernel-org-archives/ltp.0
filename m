From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Mar 2018 17:05:23 +0100
Subject: [LTP] [PATCH v3] Add read_all file systems test
In-Reply-To: <20180213133942.11883-1-rpalethorpe@suse.com>
References: <20180213133942.11883-1-rpalethorpe@suse.com>
Message-ID: <20180306160523.GE16934@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +CFLAGS			+= -D_GNU_SOURCE
> +LDFLAGS 		+= -lpthread

The only supported way how to compile and link with pthreads is by
adding -pthread to CFLAGS (it's written in each pthread related manual
page).

...

> +static void stop_workers(void)
> +{
> +	const char stop_code[1] = { '\0' };
> +	int i;
> +
> +	if (!workers)
> +		return;
> +
> +	for (i = 0; i < worker_count; i++) {
> +		if (workers[i].q)
> +			queue_push(workers[i].q, stop_code);
> +	}

So here we are relying on fact that there was enough space to store
empty string in the queue, which will be likely true, but shouldn't we
rather do something as while (!queue_push(workers[i].q, stop_code));
instead just to be sure?

I suppose that if we fail this the test will hang in tst_reap_children()
because the reading threads will end up stuck in the semaphores, which
is not that big deal anyways.

> +	for (i = 0; i < worker_count; i++) {
> +		if (workers[i].q) {
> +			queue_destroy(workers[i].q, 0);
> +			workers[i].q = 0;
> +		}
> +	}
> +}

Other than that this looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
