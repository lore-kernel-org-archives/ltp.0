Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZFkaO-0001aP-L4
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 14:56:32 +0000
Date: Thu, 16 Jul 2015 16:54:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150716145458.GC24185@rei.suse.de>
References: <7392d2ee56d8b865a4edefc0e72bff60f54c8db0.1435648319.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7392d2ee56d8b865a4edefc0e72bff60f54c8db0.1435648319.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2] checkpoints: support for propagating value
 from wake to wait
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

On Tue, Jun 30, 2015 at 09:20:25AM +0200, Jan Stancek wrote:
> This patch changes name of tst_futexes array and is using it to
> store futexes as well as propagated values. The values are of newly
> defined type: tst_chp_value_t, which is initially defined as int32_t.
> 
> Patch is adding optional 3rd parameter to TST_SAFE_CHECKPOINT_WAKE,
> which can be used to propagate this integer.
> TST_SAFE_CHECKPOINT_WAIT has been changed to return it.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
> Changes in v2:
> - prefix types and macro with tst_
> - remove volatile from tst_chp_value_t
> - pass by value where possible
> - special value to not propagate anything defined as TST_CHP_IGN
> - is_index_valid renamed to valid_id
> - dropped casts in tst_rmdir
> 
>  doc/test-writing-guidelines.txt | 10 ++++-
>  include/tst_checkpoint.h        | 53 ++++++++++++++++-------
>  lib/tests/tst_checkpoint.c      | 10 +++--
>  lib/tst_checkpoint.c            | 95 ++++++++++++++++++++++++++++++++---------
>  lib/tst_tmpdir.c                |  9 ++--
>  5 files changed, 133 insertions(+), 44 deletions(-)
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 2c40e3d..ef2d185 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -670,8 +670,9 @@ IMPORTANT: As the init function creates a file the 'tst_tmpdir()' must be
>  TST_SAFE_CHECKPOINT_WAIT(cleanup_fn, id)
>  
>  TST_SAFE_CHECKPOINT_WAKE(cleanup_fn, id)
> +TST_SAFE_CHECKPOINT_WAKE(cleanup_fn, id, val)
>  
> -TST_SAFE_CHECKPOINT_WAKE2(cleanup_fn, id, nr_wake)
> +TST_SAFE_CHECKPOINT_WAKE2(cleanup_fn, id, nr_wake, val)
>  
>  TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup_fn, id)
>  -------------------------------------------------------------------------------
> @@ -689,9 +690,14 @@ timeout is reached.
>  If timeout has been reached process exits with appropriate error message (uses
>  'tst_brkm()').
>  
> +'TST_SAFE_CHECKPOINT_WAKE' can optionally propagate an integer value
> +(of type tst_chp_value_t, see include/tst_checkpoint.h) to matching
> +'TST_SAFE_CHECKPOINT_WAIT' call. This value can be passed as optional
> +3rd parameter and is then returned by 'TST_SAFE_CHECKPOINT_WAIT' call.
> +
>  The 'TST_SAFE_CHECKPOINT_WAKE2()' does the same as
>  'TST_SAFE_CHECKPOINT_WAKE()' but can be used to wake precisely 'nr_wake'
> -processes.
> +processes. 'val' is a value that will be propagated to WAIT calls.
>  
>  The 'TST_SAFE_CHECKPOINT_WAKE_AND_WAIT()' is a shorthand for doing wake and
>  then immediately waiting on the same checkpoint.
> diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
> index e6b8100..9c8da36 100644
> --- a/include/tst_checkpoint.h
> +++ b/include/tst_checkpoint.h
> @@ -37,6 +37,12 @@
>  
>  #include "test.h"
>  
> +/* type of value which is propagated from wake to wait */
> +typedef int32_t tst_chp_value_t;
> +
> +/* special constant to denote nothing needs/should be propagated */
> +#define TST_CHP_IGN INT32_MAX
> +
>  /*
>   * Checkpoint initializaton, must be done first.
>   *
> @@ -49,14 +55,15 @@ void tst_checkpoint_init(const char *file, const int lineno,
>  			 void (*cleanup_fn)(void));
>  
>  
> -
>  /*
>   * Waits for wakeup.
>   *
>   * @id: Checkpoint id, possitive number
>   * @msec_timeout: Timeout in miliseconds, 0 == no timeout
> + * @pval: store propagated value to pval, ignored if pval == NULL
>   */
> -int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout);
> +int tst_checkpoint_wait(unsigned int id, tst_chp_value_t *pval,
> +			unsigned int msec_timeout);
>  
>  /*
>   * Wakes up sleeping process(es)/thread(s).
> @@ -64,28 +71,44 @@ int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout);
>   * @id: Checkpoint id, possitive number
>   * @nr_wake: Number of processes/threads to wake up
>   * @msec_timeout: Timeout in miliseconds, 0 == no timeout
> + * @val: propagate value of val, ignored if val == TST_CHP_IGN
>   */
>  int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
> -                        unsigned int msec_timeout);
> +			tst_chp_value_t val,
> +			unsigned int msec_timeout);
>  
> -void tst_safe_checkpoint_wait(const char *file, const int lineno,
> -                              void (*cleanup_fn)(void), unsigned int id);
> +tst_chp_value_t tst_safe_checkpoint_wait(const char *file, const int lineno,
> +			      void (*cleanup_fn)(void), unsigned int id);
>  
>  void tst_safe_checkpoint_wake(const char *file, const int lineno,
> -                              void (*cleanup_fn)(void), unsigned int id,
> -                              unsigned int nr_wake);
> +			      void (*cleanup_fn)(void), unsigned int id,
> +			      unsigned int nr_wake, tst_chp_value_t val);
>  
> -#define TST_SAFE_CHECKPOINT_WAIT(cleanup_fn, id) \
> -        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id);
>  
> -#define TST_SAFE_CHECKPOINT_WAKE(cleanup_fn, id) \
> -        tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1);
> +#define TST_SELECT_MACRO(_1, _2, _3, NAME, ...) NAME
> +
> +#define TST_SAFE_CHECKPOINT_WAKE(...) \
> +		TST_SELECT_MACRO(__VA_ARGS__, \
> +			     TST_SAFE_CHECKPOINT_WAKE_3PARAM, \
> +			     TST_SAFE_CHECKPOINT_WAKE_2PARAM)(__VA_ARGS__)
>  
> -#define TST_SAFE_CHECKPOINT_WAKE2(cleanup_fn, id, nr_wake) \
> -        tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, nr_wake);
> +#define TST_SAFE_CHECKPOINT_WAKE_2PARAM(cleanup_fn, id) \
> +	tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1, \
> +		TST_CHP_IGN)
> +
> +#define TST_SAFE_CHECKPOINT_WAKE_3PARAM(cleanup_fn, id, val) \
> +	tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1, val)
> +
> +#define TST_SAFE_CHECKPOINT_WAKE2(cleanup_fn, id, nr_wake, val) \
> +	tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, \
> +		nr_wake, val)
> +
> +#define TST_SAFE_CHECKPOINT_WAIT(cleanup_fn, id) \
> +	tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id)
>  
>  #define TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup_fn, id) \
> -        tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1); \
> -        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id);
> +	tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1, \
> +		TST_CHP_IGN); \
> +	tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id)
>  
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
> index a2c9563..448b61f 100644
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
> +static inline tst_chp_value_t *get_pval(unsigned int id)
> +{
> +	tst_chp_value_t *values = tst_checkpoints
> +		+ sizeof(futex_t) * MAX_CHECKPOINTS;
> +	return &values[id];
> +}
> +
> +static inline int id_valid(unsigned int id)
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
> +	tst_checkpoints_sz = ((sizeof(futex_t) + sizeof(tst_chp_value_t))
> +				* MAX_CHECKPOINTS);
> +	/* round up to whole pages */
> +	tst_checkpoints_sz = (((tst_checkpoints_sz + page_size - 1)
> +		/ page_size) * page_size);
> +
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
> +int tst_checkpoint_wait(unsigned int id, tst_chp_value_t *pval,
> +			unsigned int msec_timeout)
>  {
>  	struct timespec timeout;
> +	int ret;
>  
> -	if (id >= page_size / sizeof(uint32_t)) {
> +	if (!id_valid(id)) {
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
> +			tst_chp_value_t val,
> +			unsigned int msec_timeout)
>  {
>  	unsigned int msecs = 0, waked = 0;
>  
> -	if (id >= page_size / sizeof(uint32_t)) {
> +	if (!id_valid(id)) {
>  		errno = EOVERFLOW;
>  		return -1;
>  	}
>  
> +	if (val != TST_CHP_IGN)
> +		*(get_pval(id)) = val;

Is there a harm in setting the value inconditionally?

Either we do that or we need a big fat warning in the docs that this
special value is not propagated.

>  	do {
> -		waked += syscall(SYS_futex, &tst_futexes[id], FUTEX_WAKE,
> +		waked += syscall(SYS_futex, get_futex(id), FUTEX_WAKE,
>  				 INT_MAX, NULL);
>  		usleep(1000);
>  		msecs++;
> @@ -119,23 +172,25 @@ int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
>  	return 0;
>  }
>  
> -void tst_safe_checkpoint_wait(const char *file, const int lineno,
> -                              void (*cleanup_fn)(void), unsigned int id)
> +tst_chp_value_t tst_safe_checkpoint_wait(const char *file, const int lineno,
> +			      void (*cleanup_fn)(void), unsigned int id)
>  {
> -	int ret = tst_checkpoint_wait(id, DEFAULT_MSEC_TIMEOUT);
> +	tst_chp_value_t tmp;
> +	int ret = tst_checkpoint_wait(id, &tmp, DEFAULT_MSEC_TIMEOUT);
>  
>  	if (ret) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
>  		         "%s:%d: tst_checkpoint_wait(%u, %i)",
>  		         file, lineno, id, DEFAULT_MSEC_TIMEOUT);
>  	}
> +	return tmp;
>  }
>  
>  void tst_safe_checkpoint_wake(const char *file, const int lineno,
> -                              void (*cleanup_fn)(void), unsigned int id,
> -                              unsigned int nr_wake)
> +			      void (*cleanup_fn)(void), unsigned int id,
> +			      unsigned int nr_wake, tst_chp_value_t val)
>  {
> -	int ret = tst_checkpoint_wake(id, nr_wake, DEFAULT_MSEC_TIMEOUT);
> +	int ret = tst_checkpoint_wake(id, nr_wake, val, DEFAULT_MSEC_TIMEOUT);
>  
>  	if (ret) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index 3ea1a8b..f5f95ec 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -100,7 +100,8 @@ static char *TESTDIR = NULL;	/* the directory created */
>  static char test_start_work_dir[PATH_MAX];
>  
>  /* lib/tst_checkpoint.c */
> -extern futex_t *tst_futexes;
> +extern void *tst_checkpoints;
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
> +		msync(tst_checkpoints, tst_checkpoints_sz, MS_SYNC);
> +		munmap(tst_checkpoints, tst_checkpoints_sz);
>  	}

Maybe it would be cleaner to add tst_checkpoint_cleanup() function to
the checkpoint library and to lib/ltp_priv.h and call it here, since we
need to extern more than one variable now.

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
