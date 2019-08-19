From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 19 Aug 2019 11:44:40 +0200
Subject: [LTP] [PATCH v2 03/11] doc: Add guarded buffers documentation
In-Reply-To: <20190812143941.8119-4-chrubis@suse.cz>
References: <20190812143941.8119-1-chrubis@suse.cz>
 <20190812143941.8119-4-chrubis@suse.cz>
Message-ID: <875zmtwktz.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Just nitpicking...

Cyril Hrubis <chrubis@suse.cz> writes:

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  doc/test-writing-guidelines.txt | 68 +++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 573dd08d9..e5ee2fef0 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1699,6 +1699,74 @@ struct tst_test test = {
>  };
>  -------------------------------------------------------------------------------
>  
> +2.2.31 Guarded buffers
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> +The test library also supports guarded buffers, which are buffers allocated so
> +that:

Don't need 'also'

> +
> +* The end of the buffer is followed by PROT_NONE page
                                         ^ a
> +
> +* The rest of the page before the buffer is filled with random canary
         ^ remainder                                                     ^data

> +
> +Which means that the any access after the buffer with yield Segmentation
                                                    ^ will    ^ a
> +fault or EFAULT depending on if the access happened in userspace or kernel
                                                                      ^the
> +respectively. The canary before the buffer will also catch any write access
> +outside of the buffer.
> +
> +The purpose of the patch is to catch off-by-one bugs happening while buffers
                                                      ^ which happen
                                                      when buffers ...

> +and structures are passed to syscalls. New tests should allocate guarded
> +buffers for all data passed to the tested syscall which are passed by a
> +pointer.
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +static struct foo *foo_ptr;
> +static struct iovec *iov;
> +static void *buf_ptr;
> +static char *id;
> +...
> +
> +static void run(void)
> +{
> +	...
> +
> +	foo_ptr->bar = 1;
> +	foo_ptr->buf = buf_ptr;
> +
> +	...
> +}
> +
> +static void setup(void)
> +{
> +	...
> +
> +	id = tst_strdup(string);
> +
> +	...
> +}
> +
> +static struct tst_test test = {
> +	...
> +	.bufs = (struct tst_buffers []) {
> +		{&foo_ptr, .size = sizeof(*foo_ptr)},
> +		{&buf_ptr, .size = BUF_SIZE},
> +		{&iov, .iov_sizes = (int[]){128, 32, -1},
> +		{}
> +	}
> +};
> +-------------------------------------------------------------------------------
> +
> +Guarded buffers can be allocated on runtime in a test setup() by a
                                    ^ at                        ^ function
> +'tst_alloc()' or by 'tst_strdup()' as well as by filling up the .bufs array in
^ call to

> +the tst_test structure.
> +
> +So far the tst_test structure supports allocating either a plain buffer by
> +setting up the size or struct iovec, which is allocated recursively including
> +the individual buffers as described by an '-1' terminated array of buffer
> +sizes.
>  
>  2.3 Writing a testcase in shell
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -- 
> 2.21.0


-- 
Thank you,
Richard.
