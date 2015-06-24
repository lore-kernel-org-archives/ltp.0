Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z7nOq-0005bz-9T
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2015 16:19:44 +0000
Date: Wed, 24 Jun 2015 18:18:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150624161827.GF28574@rei.suse.de>
References: <733c7e1c72774ad7adf4f7db59b02d86a98925a3.1435157005.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <733c7e1c72774ad7adf4f7db59b02d86a98925a3.1435157005.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] checkpoints: support for propagating value from
 wake to wait
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +typedef volatile int32_t chp_value_t;

Everything that is exported from the library as an API should be
prefixed with tst_. I would vote for tst_chp_val_t or something similar.

And do we really need the volatile here?

When we return from wait function the pointer was passed to the
function, so the compiler should know that it may have been changed.

>  /*
>   * Checkpoint initializaton, must be done first.
>   *
> @@ -55,8 +57,10 @@ void tst_checkpoint_init(const char *file, const int lineno,
>   *
>   * @id: Checkpoint id, possitive number
>   * @msec_timeout: Timeout in miliseconds, 0 == no timeout
> + * @pval: store propagated value to pval, ignored if pval == NULL
>   */
> -int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout);
> +int tst_checkpoint_wait(unsigned int id, chp_value_t *pval,
> +			unsigned int msec_timeout);
>  
>  /*
>   * Wakes up sleeping process(es)/thread(s).
> @@ -64,28 +68,53 @@ int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout);
>   * @id: Checkpoint id, possitive number
>   * @nr_wake: Number of processes/threads to wake up
>   * @msec_timeout: Timeout in miliseconds, 0 == no timeout
> + * @pval: propagate value of *pval, ignored if pval == NULL
>   */
>  int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
> -                        unsigned int msec_timeout);
> +			chp_value_t *pval,
> +			unsigned int msec_timeout);

Why do we pass the value as a pointer instead of value here?

We may pass any particular value (0 for example) if we do not need to
propagate anything.

>  void tst_safe_checkpoint_wait(const char *file, const int lineno,
> -                              void (*cleanup_fn)(void), unsigned int id);
> +			      void (*cleanup_fn)(void), unsigned int id,
> +			      chp_value_t *pval);
>  
>  void tst_safe_checkpoint_wake(const char *file, const int lineno,
> -                              void (*cleanup_fn)(void), unsigned int id,
> -                              unsigned int nr_wake);
> +			      void (*cleanup_fn)(void), unsigned int id,
> +			      unsigned int nr_wake, chp_value_t *pval);

We may also change this function to return the value regardless instead
of passing the pointer which would simplify the macros below a bit.

> -#define TST_SAFE_CHECKPOINT_WAIT(cleanup_fn, id) \
> -        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id);
>  
> -#define TST_SAFE_CHECKPOINT_WAKE(cleanup_fn, id) \
> -        tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1);
> +#define SELECT_MACRO(_1, _2, _3, NAME, ...) NAME

Again, I would rather name this TST_SELECT_MACRO() to make sure we don't
collide with macros in testcases.

> +#define TST_SAFE_CHECKPOINT_WAKE(...) \
> +		SELECT_MACRO(__VA_ARGS__, \
> +			     TST_SAFE_CHECKPOINT_WAKE_3PARAM, \
> +			     TST_SAFE_CHECKPOINT_WAKE_2PARAM)(__VA_ARGS__)
> +
> +#define TST_SAFE_CHECKPOINT_WAKE_2PARAM(cleanup_fn, id) \
> +	tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1, NULL)
>  
> -#define TST_SAFE_CHECKPOINT_WAKE2(cleanup_fn, id, nr_wake) \
> -        tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, nr_wake);
> +#define TST_SAFE_CHECKPOINT_WAKE_3PARAM(cleanup_fn, id, val) \
> +{ \
> +	chp_value_t tmp = val; \
> +	tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1, &tmp); \
> +}
> +
> +#define TST_SAFE_CHECKPOINT_WAKE2(cleanup_fn, id, nr_wake, val) \
> +{ \
> +	chp_value_t tmp = val; \
> +	tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, \
> +				 nr_wake, &tmp); \
> +}
> +
> +#define TST_SAFE_CHECKPOINT_WAIT(cleanup_fn, id) \
> +({ \
> +	chp_value_t tmp; \
> +	tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id, &tmp); \
> +	tmp; \
> +})
>  
>  #define TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup_fn, id) \
> -        tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1); \
> -        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id);
> +	tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1, NULL); \
> +	tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id, NULL)

The rest of this looks nice ;)

>  #endif /* TST_CHECKPOINT */
> diff --git a/lib/tests/tst_checkpoint.c b/lib/tests/tst_checkpoint.c
> index 2cb17a5..f2c0019 100644
> --- a/lib/tests/tst_checkpoint.c
> +++ b/lib/tests/tst_checkpoint.c
> @@ -25,12 +25,14 @@
>  
>  #include "test.h"
>  
> +#define TEST_VALUE 0xCAFE
> +
>  char *TCID = "tst_checkpoint";
>  int TST_TOTAL = 1;
>  
>  int main(void)
>  {
> -	int pid;
> +	int pid, val;
>  
>  	tst_tmpdir();
>  
> @@ -44,12 +46,14 @@ int main(void)
>  	break;
>  	case 0:
>  		fprintf(stderr, "Child: checkpoint signaling\n");
> -		TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
> +		TST_SAFE_CHECKPOINT_WAKE(NULL, 0, TEST_VALUE);
>  		exit(0);
>  	break;
>  	default:
> -		TST_SAFE_CHECKPOINT_WAIT(tst_rmdir, 0);
> +		val = TST_SAFE_CHECKPOINT_WAIT(tst_rmdir, 0);
>  		fprintf(stderr, "Parent: checkpoint reached\n");
> +		fprintf(stderr, "Propagated value matches: %d\n",
> +				TEST_VALUE == val);
>  	break;
>  	}
>  
> diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
> index a2c9563..08ca944 100644
> --- a/lib/tst_checkpoint.c
> +++ b/lib/tst_checkpoint.c
> @@ -33,15 +33,50 @@
>  
>  #define DEFAULT_MSEC_TIMEOUT 10000
>  
> -futex_t *tst_futexes;
> -static int page_size;
> +#define MAX_CHECKPOINTS 256
> +
> +/*
> + * tst_checkpoints is mmapped file, that stores futexes and values
> + * propagated between checkpoint_wake and wait. The space allocated
> + * is for up to MAX_CHECKPOINTS checkpoints and is organized in
> + * following way:
> + *
> + * ----------------------------------------------------------------
> + * | FUTEX1 FUTEX2 FUTEX3 ... | VALUE1 VALUE2 VALUE3 ... | UNUSED |
> + * ---------------------------|------------------------------------
> + * ^                                                              ^
> + * |                                                              |
> + * +-- tst_checkpoints                     aligned to PAGE_SIZE --+
> + *
> + * Where FUTEXes are of type futex_t, and VALUEs of chp_value_t.
> + */
> +void *tst_checkpoints = NULL;
> +int tst_checkpoints_sz = 0;
> +
> +static inline futex_t *get_futex(unsigned int id)
> +{
> +	futex_t *futexes = tst_checkpoints;
> +	return &futexes[id];
> +}
> +
> +static inline chp_value_t *get_pval(unsigned int id)
> +{
> +	chp_value_t *values = tst_checkpoints
> +		+ sizeof(futex_t) * MAX_CHECKPOINTS;
> +	return &values[id];
> +}
> +
> +static inline int is_index_valid(unsigned int id)

I would name this valid_id() or similar, but that is very minor.

> +{
> +	return (id < MAX_CHECKPOINTS);
> +}
>  
>  void tst_checkpoint_init(const char *file, const int lineno,
> -                         void (*cleanup_fn)(void))
> +			 void (*cleanup_fn)(void))
>  {
> -	int fd;
> +	int fd, page_size;
>  
> -	if (tst_futexes) {
> +	if (tst_checkpoints) {
>  		tst_brkm(TBROK, cleanup_fn,
>  		         "%s: %d checkopoints allready initialized",
>  		         file, lineno);
> @@ -66,22 +101,31 @@ void tst_checkpoint_init(const char *file, const int lineno,
>  
>  	page_size = getpagesize();
>  
> +	/* we need at least this bytes */
> +	tst_checkpoints_sz = ((sizeof(futex_t) + sizeof(chp_value_t))
> +				* MAX_CHECKPOINTS);
> +	/* round up to whole pages */
> +	tst_checkpoints_sz = (((tst_checkpoints_sz + page_size - 1)
> +		/ page_size) * page_size);
d> +
>  	fd = SAFE_OPEN(cleanup_fn, "checkpoint_futex_base_file",
>  	               O_RDWR | O_CREAT, 0666);
>  
> -	SAFE_FTRUNCATE(cleanup_fn, fd, page_size);
> +	SAFE_FTRUNCATE(cleanup_fn, fd, tst_checkpoints_sz);
>  
> -	tst_futexes = SAFE_MMAP(cleanup_fn, NULL, page_size,
> +	tst_checkpoints = SAFE_MMAP(cleanup_fn, NULL, tst_checkpoints_sz,
>  	                    PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>  
>  	SAFE_CLOSE(cleanup_fn, fd);
>  }
>  
> -int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout)
> +int tst_checkpoint_wait(unsigned int id, chp_value_t *pval,
> +			unsigned int msec_timeout)
>  {
>  	struct timespec timeout;
> +	int ret;
>  
> -	if (id >= page_size / sizeof(uint32_t)) {
> +	if (!is_index_valid(id)) {
>  		errno = EOVERFLOW;
>  		return -1;
>  	}
> @@ -89,22 +133,31 @@ int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout)
>  	timeout.tv_sec = msec_timeout/1000;
>  	timeout.tv_nsec = (msec_timeout%1000) * 1000000;
>  
> -	return syscall(SYS_futex, &tst_futexes[id], FUTEX_WAIT,
> -		       tst_futexes[id], &timeout);
> +	ret = syscall(SYS_futex, get_futex(id), FUTEX_WAIT,
> +		      *(get_futex(id)), &timeout);
> +
> +	if (pval)
> +		*pval = *(get_pval(id));
> +
> +	return ret;
>  }
>  
>  int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
> -                        unsigned int msec_timeout)
> +			chp_value_t *pval,
> +			unsigned int msec_timeout)
>  {
>  	unsigned int msecs = 0, waked = 0;
>  
> -	if (id >= page_size / sizeof(uint32_t)) {
> +	if (!is_index_valid(id)) {
>  		errno = EOVERFLOW;
>  		return -1;
>  	}
>  
> +	if (pval)
> +		*(get_pval(id)) = *pval;
> +
>  	do {
> -		waked += syscall(SYS_futex, &tst_futexes[id], FUTEX_WAKE,
> +		waked += syscall(SYS_futex, get_futex(id), FUTEX_WAKE,
>  				 INT_MAX, NULL);
>  		usleep(1000);
>  		msecs++;
> @@ -120,9 +173,10 @@ int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
>  }
>  
>  void tst_safe_checkpoint_wait(const char *file, const int lineno,
> -                              void (*cleanup_fn)(void), unsigned int id)
> +			      void (*cleanup_fn)(void), unsigned int id,
> +			      chp_value_t *pval)
>  {
> -	int ret = tst_checkpoint_wait(id, DEFAULT_MSEC_TIMEOUT);
> +	int ret = tst_checkpoint_wait(id, pval, DEFAULT_MSEC_TIMEOUT);
>  
>  	if (ret) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
> @@ -132,10 +186,10 @@ void tst_safe_checkpoint_wait(const char *file, const int lineno,
>  }
>  
>  void tst_safe_checkpoint_wake(const char *file, const int lineno,
> -                              void (*cleanup_fn)(void), unsigned int id,
> -                              unsigned int nr_wake)
> +			      void (*cleanup_fn)(void), unsigned int id,
> +			      unsigned int nr_wake, chp_value_t *pval)
>  {
> -	int ret = tst_checkpoint_wake(id, nr_wake, DEFAULT_MSEC_TIMEOUT);
> +	int ret = tst_checkpoint_wake(id, nr_wake, pval, DEFAULT_MSEC_TIMEOUT);
>  
>  	if (ret) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index 3ea1a8b..08cba4a 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -100,7 +100,8 @@ static char *TESTDIR = NULL;	/* the directory created */
>  static char test_start_work_dir[PATH_MAX];
>  
>  /* lib/tst_checkpoint.c */
> -extern futex_t *tst_futexes;
> +extern futex_t *tst_checkpoints;
> +extern int tst_checkpoints_sz;
>  
>  int tst_tmpdir_created(void)
>  {
> @@ -206,9 +207,9 @@ void tst_rmdir(void)
>  	 * Unmap the backend file.
>  	 * This is needed to overcome the NFS "silly rename" feature.
>  	 */
> -	if (tst_futexes) {
> -		msync((void *)tst_futexes, getpagesize(), MS_SYNC);
> -		munmap((void *)tst_futexes, getpagesize());
> +	if (tst_checkpoints) {
> +		msync((void *)tst_checkpoints, tst_checkpoints_sz, MS_SYNC);
> +		munmap((void *)tst_checkpoints, tst_checkpoints_sz);

We can drop the void* casts now.


Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
