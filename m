From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 19 Aug 2019 11:06:01 +0200
Subject: [LTP] [PATCH v2 01/11] lib: Add support for guarded buffers
In-Reply-To: <20190812143941.8119-2-chrubis@suse.cz>
References: <20190812143941.8119-1-chrubis@suse.cz>
 <20190812143941.8119-2-chrubis@suse.cz>
Message-ID: <877e79wmme.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Cyril Hrubis <chrubis@suse.cz> writes:

> +
> +/*
> + * Buffer description consist of a pointer to a pointer and buffer type/size
> + * encoded as a different structure members.
> + *
> + * Only one of the size and iov_sizes can be set at a time.
> + */
> +struct tst_buffers {
> +	/*
> +	 * This pointer points to a buffer pointer.
> +	 */
> +	void *ptr;
> +	/*
> +	 * Buffer size.
> +	 */
> +	size_t size;
> +	/*
> +	 * Array of iov buffer sizes terminated by -1.
> +	 */
> +	int *iov_sizes;
> +};
> +
> +/*
> + * Allocates buffers based on the tst_buffers structure.
> + *
> + * @bufs NULL terminated array of test buffer descriptions.
> + *
> + * This is called from the test library if the tst_test->bufs pointer is set.
> + */
> +void tst_buffers_alloc(struct tst_buffers bufs[]);
> +
> +/*
> + * strdup() that callls tst_alloc().
> + */
> +char *tst_strdup(const char *str);
> +
> +/*
> + * Allocates size bytes, returns pointer to the allocated buffer.
> + */
> +void *tst_alloc(size_t size);
> +
> +/*
> + * Allocates iovec structure including the buffers.
> + *
> + * @sizes -1 terminated array of buffer sizes.
> + */
> +struct iovec *tst_iovec_alloc(int sizes[]);
> +
> +/*
> + * Frees all allocated buffers.
> + *
> + * This is called at the end of the test automatically.
> + */
> +void tst_free_all(void);

We could add guarded buffers to huge numbers of tests by wrapping the
user supplied buffer in various calls to SAFE_* macros and tst_*
functions. This could be configurable at compile time and it should be
detectable if a buffer is already guarded, so double wrapping should not
be an issue.

However I am not sure the current API makes this easy. We should
probably have a tst_free(void *buf) and/or tst_buffer_alloc(struct
tst_buffer *buf) and tst_buffer_free(struct tst_buffer *buf) (which
could just put the buffer on a free list for reuse).

I am not sure if this is something which needs to be addressed now or
can be left for another patch set. My main concern is that one of the
existing API functions will need to be changed.

--
Thank you,
Richard.
