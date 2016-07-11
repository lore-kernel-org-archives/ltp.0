From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Jul 2016 08:35:05 -0400 (EDT)
Subject: [LTP] [PATCH v2 1/3] ltp-aiodio: report posix_memalign
	errors	properly
In-Reply-To: <1467903917-16064-1-git-send-email-eguan@redhat.com>
References: <1467903917-16064-1-git-send-email-eguan@redhat.com>
Message-ID: <1109254790.3643017.1468240505382.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Eryu Guan" <eguan@redhat.com>
> To: ltp@lists.linux.it
> Sent: Thursday, 7 July, 2016 5:05:15 PM
> Subject: [LTP] [PATCH v2 1/3] ltp-aiodio: report posix_memalign errors	properly
> 
> From posix_memalign(3) the value of errno is indeterminate after a call
> to posix_memalign(). So TERRNO doesn't work in this case.
> dio_sparse    1  TBROK  :  dio_sparse.c:75: posix_memalign():
> errno=SUCCESS(0): Success
> 
> Report posix_memalign() errors by calling strerror on the return value.
> dio_sparse    1  TBROK  :  dio_sparse.c:74: posix_memalign(): EINVAL
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> v2:
> - include "test.h" when needed to avoid compile error
> 
>  testcases/kernel/io/ltp-aiodio/aiodio_append.c |  9 +++++++--
>  testcases/kernel/io/ltp-aiodio/aiodio_sparse.c |  7 ++++---
>  testcases/kernel/io/ltp-aiodio/dio_append.c    | 10 ++++++++--
>  testcases/kernel/io/ltp-aiodio/dio_sparse.c    |  7 ++++---
>  testcases/kernel/io/ltp-aiodio/dio_truncate.c  | 17 +++++++++++++----
>  5 files changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
> b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
> index 56e9c09..77df02c 100644
> --- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
> +++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
> @@ -33,6 +33,8 @@
>  
>  #include <libaio.h>
>  
> +#include "test.h"
> +
>  #define NUM_CHILDREN 8
>  
>  char *check_zero(unsigned char *buf, int size)
> @@ -98,6 +100,7 @@ void aiodio_append(char *filename)
>  	void *bufptr;
>  	int i;
>  	int w;
> +	int ret;
>  	struct iocb iocb_array[NUM_AIO];
>  	struct iocb *iocbs[NUM_AIO];
>  	off_t offset = 0;
> @@ -115,8 +118,10 @@ void aiodio_append(char *filename)
>  	io_queue_init(NUM_AIO, &myctx);
>  
>  	for (i = 0; i < NUM_AIO; i++) {
> -		if (posix_memalign(&bufptr, 4096, AIO_SIZE)) {
> -			perror("cannot malloc aligned memory");
> +		ret = posix_memalign(&bufptr, 4096, AIO_SIZE);
> +		if (ret) {
> +			tst_resm(TBROK, "cannot malloc aligned memory: %s",
> +					tst_strerrno(ret));

Just fyi, if you want to safe few characters: we have TRERRNO, that works
as TERRNO, but instead of using value of TEST_ERRNO, it uses TEST_RETURN.
So code above would become:

TEST(posix_memalign(&bufptr, 4096, AIO_SIZE));
if (TEST_RETURN)
    tst_resm(TBROK|TRERRNO, "cannot malloc aligned memory");

Regards,
Jan

>  			return;
>  		}
>  		memset(bufptr, 0, AIO_SIZE);
