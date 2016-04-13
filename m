From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Apr 2016 16:15:51 +0200
Subject: [LTP] [PATCH 4/4] tst_atomic: add test for tst_atomic_inc
In-Reply-To: <c7a40e44c496051bedb3c8af46d16d42c50c49af.1460552890.git.jstancek@redhat.com>
References: <82bcc056edc64dee3a13275a2b4bdbec958f60eb.1460552890.git.jstancek@redhat.com>
 <c7a40e44c496051bedb3c8af46d16d42c50c49af.1460552890.git.jstancek@redhat.com>
Message-ID: <20160413141551.GD11529@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This is nice to have ;)

> +/*
> + * Copyright (c) 2016 Linux Test Project
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +/*
> + * Test that tst_atomic_inc works as expected.
> + */
> +
> +#include <pthread.h>
> +#include "tst_test.h"
> +
> +#define THREADS 64
> +#define ITERATIONS 100000
> +
> +static int atomic;
> +
> +static void *worker(void *id)
> +{
> +	int i;
> +
> +	(void) id;
> +	for (i = 0; i < ITERATIONS; i++)
> +		tst_atomic_inc(&atomic);
> +
> +	return NULL;
> +}
> +
> +static void do_test(void)
> +{
> +	long i;
> +	pthread_t threads[THREADS];
> +
> +	for (i = 0; i < THREADS; i++)
> +		pthread_create(threads+i, NULL, worker, (void *)i);
> +
> +	for (i = 0; i < THREADS; i++) {
> +		tst_res(TINFO, "Joining thread %li", i);
> +		pthread_join(threads[i], NULL);
> +	}
> +
> +	if (atomic == THREADS * ITERATIONS)
> +		tst_res(TPASS, "Atomic working as expected");
> +	else
> +		tst_res(TFAIL, "Atomic does not have expected value");
> +}
> +
> +static struct tst_test test = {
> +	.tid = "test09",
> +	.test_all = do_test,
> +	.forks_child = 1

Looks like the forks_child is copy&pasted from test08 which was
copy&pasted test07 which really forks a child. I will fix test08.c and
you should remove it from this one as well.
`
> +};

-- 
Cyril Hrubis
chrubis@suse.cz
