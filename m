From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 09 Jun 2021 15:44:45 +0100
Subject: [LTP] [PATCH 3/4] lib: Introduce concept of max_test_runtime
In-Reply-To: <20210609114659.2445-4-chrubis@suse.cz>
References: <20210609114659.2445-1-chrubis@suse.cz>
 <20210609114659.2445-4-chrubis@suse.cz>
Message-ID: <8735tr5c82.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Cyril,

Cyril Hrubis <chrubis@suse.cz> writes:

> This is an attempt on how to handle a cap on a test runtime correctly it
> consists of several pieces namely:
>
> * The idea of test maximal runtime is uncoupled from  test timeout
>
>   - the maximal runtime is simply a cap for how long should an instance
>     of a test run, it's mainly used by CVE reproducers that attempt to
>     trigger a race until they run out of time, such test may exit sooner
>     but must not run longer than the cap
>
>   - the tst_timeout_remaining() is replaced with tst_remaining_runtime()
>     which accounts correctly for .test_variants and .all_filesystems
>
> * The default value for a test max_runtime is computed from test timeout
>
>   - we scale the timeout down so that the there is some room for test to
>     properly exit once test runtime was exhausted, this is our base for
>     a test max_runtime
>
>   - the scaled value is then divided, if needed, so that we end up a
>     correct maximal runtime for an instance of a test, i.e. we have
>     max runtime for an instance fork_testrun() that is inside of
>     .test_variants and .all_filesystems loops
>
>   - this also allows us to controll the test max runtime by setting a
>     test timeout
>
> * The maximal runtime, per whole test, can be passed down to the test
>
>   - If LTP_MAX_TEST_RUNTIME is set in test environment it's used as a
>     base for max_runtime instead of the scaled down timeout, it's still
>     divided into pieces so that we have correct runtime cap for an
>     fork_testrun() instance
>
>   - We also make sure that test timeout is adjusted, if needed, to
>     accomodate for the new test runtime cap, i.e. if upscaled runtime is
>     greater than timeout, the test timeout is adjusted
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_fuzzy_sync.h                      |  4 +-
>  include/tst_test.h                            |  7 +-
>  lib/newlib_tests/.gitignore                   |  3 +-
>  .../{test18.c => test_runtime01.c}            |  7 +-
>  lib/newlib_tests/test_runtime02.c             | 31 +++++++++
>  lib/tst_test.c                                | 64 ++++++++++++++++++-
>  testcases/kernel/crypto/af_alg02.c            |  2 +-
>  testcases/kernel/crypto/pcrypt_aead01.c       |  2 +-
>  testcases/kernel/mem/mtest01/mtest01.c        |  6 +-
>  testcases/kernel/mem/mtest06/mmap1.c          | 13 ++--
>  .../kernel/syscalls/move_pages/move_pages12.c |  4 +-
>  11 files changed, 117 insertions(+), 26 deletions(-)
>  rename lib/newlib_tests/{test18.c => test_runtime01.c} (59%)
>  create mode 100644 lib/newlib_tests/test_runtime02.c
>
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index 8f97bb8f6..93adbb909 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -319,7 +319,7 @@ static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
>  		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, tst_fzsync_thread_wrapper, &wrap_run_b);
>  	}
>  
> -	pair->exec_time_start = (float)tst_timeout_remaining();
> +	pair->exec_time_start = (float)tst_remaining_runtime();
>  }
>  
>  /**
> @@ -663,7 +663,7 @@ static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
>  static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
>  {
>  	int exit = 0;
> -	float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;
> +	float rem_p = 1 - tst_remaining_runtime() / pair->exec_time_start;
>  
>  	if ((pair->exec_time_p * SAMPLING_SLICE < rem_p)
>  		&& (pair->sampling > 0)) {
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 6ad355506..491fedc3e 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -290,7 +290,12 @@ const char *tst_strsig(int sig);
>   */
>  const char *tst_strstatus(int status);
>  
> -unsigned int tst_timeout_remaining(void);
> +/*
> + * Returns remaining test runtime. Test that runs for more than a few seconds
> + * should check if they should exit by calling this function regularly.
> + */
> +unsigned int tst_remaining_runtime(void);
> +
>  unsigned int tst_multiply_timeout(unsigned int timeout);
>  void tst_set_timeout(int timeout);
>  
> diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
> index b95ead2c2..464d98aed 100644
> --- a/lib/newlib_tests/.gitignore
> +++ b/lib/newlib_tests/.gitignore
> @@ -23,7 +23,6 @@ tst_safe_fileops
>  tst_res_hexd
>  tst_strstatus
>  test17
> -test18
>  test19
>  test20
>  test22
> @@ -43,3 +42,5 @@ test_macros02
>  test_macros03
>  tst_fuzzy_sync01
>  tst_fuzzy_sync02
> +test_runtime01
> +test_runtime02
> diff --git a/lib/newlib_tests/test18.c b/lib/newlib_tests/test_runtime01.c
> similarity index 59%
> rename from lib/newlib_tests/test18.c
> rename to lib/newlib_tests/test_runtime01.c
> index 026435d7d..56f5ac44e 100644
> --- a/lib/newlib_tests/test18.c
> +++ b/lib/newlib_tests/test_runtime01.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (c) 2018, Linux Test Project
> + * Copyright (c) 2021, Linux Test Project
>   */
>  
>  #include <stdlib.h>
> @@ -9,11 +9,10 @@
>  
>  static void run(void)
>  {
> -	do {
> +	while (tst_remaining_runtime())
>  		sleep(1);
> -	} while (tst_timeout_remaining() >= 4);
>  
> -	tst_res(TPASS, "Timeout remaining: %d", tst_timeout_remaining());
> +	tst_res(TPASS, "Timeout remaining: %d", tst_remaining_runtime());
>  }
>  
>  static struct tst_test test = {
> diff --git a/lib/newlib_tests/test_runtime02.c b/lib/newlib_tests/test_runtime02.c
> new file mode 100644
> index 000000000..12e4813ef
> --- /dev/null
> +++ b/lib/newlib_tests/test_runtime02.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021, Linux Test Project
> + */
> +/*
> + * This test is set up so that the timeout is not long enough to guarantee
> + * enough runtime for two iterations, i.e. the timeout without offset and after
> + * scaling is too small and the tests ends up with TBROK.
> + *
> + * You can fix this by exporting LTP_MAX_TEST_RUNTIME=10 before executing the
> + * test, in that case the runtime would be divided between iterations and timeout
> + * adjusted so that it provides enough safeguards for the test to finish.
> + */
> +
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	while (tst_remaining_runtime())
> +		sleep(1);
> +
> +	tst_res(TPASS, "Timeout remaining: %d", tst_remaining_runtime());
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.timeout = 5,
> +	.test_variants = 2
> +};
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 7c9061d6d..23b52583a 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -62,6 +62,7 @@ struct results {
>  	int warnings;
>  	int broken;
>  	unsigned int timeout;
> +	unsigned int max_runtime;
>  };
>  
>  static struct results *results;
> @@ -1255,17 +1256,74 @@ static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
>  	}
>  }
>  
> -unsigned int tst_timeout_remaining(void)
> +#define RUNTIME_TIMEOUT_OFFSET 5
> +#define RUNTIME_TIMEOUT_SCALE  0.9
> +
> +static unsigned int timeout_to_runtime(void)
> +{
> +	if (results->timeout <= RUNTIME_TIMEOUT_OFFSET) {
> +		tst_res(TWARN, "Timeout too short for runtime offset %i!",
> +		        RUNTIME_TIMEOUT_OFFSET);
> +		return 1;
> +	}
> +
> +	return (results->timeout - RUNTIME_TIMEOUT_OFFSET) * RUNTIME_TIMEOUT_SCALE;
> +}
> +
> +static unsigned int runtime_to_timeout(unsigned int runtime)
> +{
> +	return runtime / RUNTIME_TIMEOUT_SCALE + RUNTIME_TIMEOUT_OFFSET;
> +}
> +
> +static unsigned int divide_runtime(unsigned int runtime)
> +{
> +	if (tst_test->test_variants)
> +		runtime = 1.00 * runtime / tst_test->test_variants;
> +
> +	if (tst_test->all_filesystems)
> +		runtime = 1.00 * runtime / tst_fs_max_types();
> +
> +	return runtime;
> +}
> +
> +unsigned int tst_remaining_runtime(void)
>  {
>  	static struct timespec now;
>  	unsigned int elapsed;
>  
> +	if (!results->max_runtime) {
> +		const char *runtime = getenv("LTP_MAX_TEST_RUNTIME");
> +
> +		if (runtime) {
> +			results->max_runtime = atoi(runtime);

POSIX says atoi is deprecated. It should probably be strtoul().

> +		} else {
> +			results->max_runtime = timeout_to_runtime();
> +		}
> +
> +		if (!results->max_runtime)
> +			tst_brk(TBROK, "Test runtime too small!");
> +
> +
> +		if (runtime_to_timeout(results->max_runtime) >
> results->timeout) {

Maybe should rename the "results" struct?

It is turning into general shared test state.

-- 
Thank you,
Richard.
