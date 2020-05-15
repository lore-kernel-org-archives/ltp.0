From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 15 May 2020 09:38:49 +0530
Subject: [LTP] [PATCH V4 1/1] syscall: Add io_uring test
In-Reply-To: <20200514172831.27854-2-vikas.kumar2@arm.com>
References: <20200514172831.27854-1-vikas.kumar2@arm.com>
 <20200514172831.27854-2-vikas.kumar2@arm.com>
Message-ID: <20200515040849.yu27rdihdih5wxc3@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14-05-20, 22:58, Vikas Kumar wrote:
> Added Linux asynchronous I/O API Test for io_uring_setup(),
> io_uring_register() and io_uring_enter().
> This test will check io_uring api basic operation.
> 
> Signed-off-by: Vikas Kumar <vikas.kumar2@arm.com>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Please don't do this unless someone gave you this explicitly.

> diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
> +int setup_io_uring_test(struct submitter *s)
> +{
> +	struct io_sq_ring *sring = &s->sq_ring;
> +	struct io_cq_ring *cring = &s->cq_ring;
> +	struct io_uring_params p;
> +	void *ptr;
> +
> +	memset(&p, 0, sizeof(p));
> +	s->ring_fd = io_uring_setup(QUEUE_DEPTH, &p);
> +	if (s->ring_fd == -1) {
> +		tst_res(TFAIL | TTERRNO, "io_uring setup return error");
> +		return 1;
> +	}
> +
> +	//submission queue ring buffer mapping

You need to follow kernel coding guidelines everywhere in the code
here and so no such comments. Try to run checkpatch on this file with
--strict option and you will see the problems..

This API is new and you also need to implement something like
fsopen_supported_by_kernel().

I didn't do in depth reviews though..

-- 
viresh
