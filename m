From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Oct 2017 16:46:25 +0200
Subject: [LTP] [PATCH v3 11/18] m4: Fix libaio detection on 32-bit cross
 build
In-Reply-To: <20171012183335.24568-12-pvorel@suse.cz>
References: <20171012183335.24568-1-pvorel@suse.cz>
 <20171012183335.24568-12-pvorel@suse.cz>
Message-ID: <20171013144625.GA5379@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/m4/ltp-eventfd.m4 b/m4/ltp-eventfd.m4
> index 923b9bde3..c62ff87ba 100644
> --- a/m4/ltp-eventfd.m4
> +++ b/m4/ltp-eventfd.m4
> @@ -22,13 +22,12 @@ dnl
>  dnl LTP_CHECK_SYSCALL_EVENTFD
>  dnl ----------------------------
>  dnl
> -AC_DEFUN([LTP_CHECK_SYSCALL_EVENTFD],
> -[dnl
> +AC_DEFUN([LTP_CHECK_SYSCALL_EVENTFD], [
>  AH_TEMPLATE(HAVE_IO_SET_EVENTFD,
>  [Define to 1 if you have the `io_set_eventfd' function.])
> -AC_CHECK_HEADERS(libaio.h,[
> -	AC_CHECK_LIB(aio,io_setup,[
> -		AIO_LIBS="-laio"
> +AC_CHECK_HEADERS(libaio.h, [
> +	AC_CHECK_LIB(aio,io_setup, [
> +		have_aio=yes
>  		AC_MSG_CHECKING([io_set_eventfd is defined in aio library or aio header])
>  		AC_TRY_LINK([#include <stdio.h>
>                               #include <libaio.h>
> @@ -38,6 +37,10 @@ AC_CHECK_HEADERS(libaio.h,[
>  			    [AC_DEFINE(HAVE_IO_SET_EVENTFD)
>  			     AC_MSG_RESULT(yes)],
>                              [AC_MSG_RESULT(no)])],
> -		AIO_LIBS="")])
> -AC_SUBST(AIO_LIBS)
> +		have_aio=no)])

I guess that it would be a bit easier to read if there was less nested
blocks in there.

What about we do the detection for AIO headers and numa libs
separately, then if these two are tro set the AIO_LIBS and try the
detection fro eventfd as well?

Something as:

	if test "x$have_libaio" = "xyes" -a "x$have_aio" = "xyes"; then
		AC_DEFINE(HAVE_LIBAIO, ...)
		AC_SUBSTS(AIO_LIBS, ...)
		AC_TRY_LINK(... AC_DEFINE(HAVE_IO_SET_EVENTFD) ...)
	fi

> +
> +if test "x$have_aio" = "xyes"; then
> +	AC_SUBST(AIO_LIBS, "-laio")
> +	AC_DEFINE(HAVE_LIBAIO, 1, [Define whether libaio and it's headers are installed])
> +fi
>  ])
> diff --git a/testcases/kernel/io/aio/aio01/aio01.c b/testcases/kernel/io/aio/aio01/aio01.c
> index 2829b2485..ba23e226c 100644
> --- a/testcases/kernel/io/aio/aio01/aio01.c
> +++ b/testcases/kernel/io/aio/aio01/aio01.c
> @@ -47,26 +47,26 @@
>  
>  #define _XOPEN_SOURCE 600
>  
> -#include "test.h"
> -#include "config.h"
> -
> -char *TCID = "aio01";
> -int TST_TOTAL = 6;
> -
> -#ifdef HAVE_LIBAIO_H
> -
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <fcntl.h>
>  #include <time.h>
>  #include <errno.h>
> -#include <libaio.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/time.h>
>  #include <sys/resource.h>
>  
> +#include "test.h"
> +#include "config.h"
> +
> +char *TCID = "aio01";
> +int TST_TOTAL = 6;
> +
> +#ifdef HAVE_LIBAIO
> +#include <libaio.h>
> +
>  static void help(void);
>  static void setup(void);
>  static void cleanup(void);
> @@ -413,14 +413,11 @@ static void cleanup(void)
>  	close(fd);
>  	io_queue_release(io_ctx);
>  	tst_rmdir();
> -
>  }
>  
>  #else
> -
>  int main(void)
>  {
> -	tst_brkm(TCONF, NULL, "libaio missing");
> +	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
>  }
> -
>  #endif
> diff --git a/testcases/kernel/io/aio/aio02/aio_tio.c b/testcases/kernel/io/aio/aio02/aio_tio.c
> index 34fa9ed51..08fb04162 100644
> --- a/testcases/kernel/io/aio/aio02/aio_tio.c
> +++ b/testcases/kernel/io/aio/aio02/aio_tio.c
> @@ -37,7 +37,7 @@
>  #include <string.h>
>  #include <errno.h>
>  
> -#if HAVE_LIBAIO_H
> +#ifdef HAVE_LIBAIO
>  
>  #define AIO_MAXIO 32
>  #define AIO_BLKSIZE (64*1024)
> @@ -237,5 +237,4 @@ int test_main(void)
>  
>  	return status;
>  }
> -
>  #endif
> diff --git a/testcases/kernel/io/aio/aio02/main.c b/testcases/kernel/io/aio/aio02/main.c
> index 24ec17181..7b157f31b 100644
> --- a/testcases/kernel/io/aio/aio02/main.c
> +++ b/testcases/kernel/io/aio/aio02/main.c
> @@ -6,16 +6,16 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <unistd.h>
> -#include "test.h"
> +
>  #include "config.h"
> +#include "test.h"
>  
>  #define TEST_NAME "aio_tio"
>  
>  char *TCID = "aio02/" TEST_NAME;
>  int TST_TOTAL = 0;
>  
> -#if HAVE_LIBAIO_H
> -
> +#ifdef HAVE_LIBAIO
>  #include <libaio.h>
>  
>  int test_main(void);
> @@ -32,6 +32,6 @@ int main(void)
>  #else
>  int main(void)
>  {
> -	tst_brkm(TCONF, NULL, "libaio missing");
> +	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
>  }
>  #endif
> diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
> index d6d7b0880..348f398db 100644
> --- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
> +++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
> @@ -50,19 +50,23 @@
>  #include <errno.h>
>  #include <assert.h>
>  #include <stdlib.h>
> -
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <sys/time.h>
> -#include <libaio.h>
>  #include <sys/ipc.h>
>  #include <sys/shm.h>
>  #include <sys/mman.h>
>  #include <string.h>
>  #include <pthread.h>
>  
> +#include "config.h"
> +#include "tst_res_flags.h"
> +
> +#ifdef HAVE_LIBAIO
> +#include <libaio.h>
> +
>  #define IO_FREE 0
>  #define IO_PENDING 1
>  #define RUN_FOREVER -1
> @@ -1557,3 +1561,10 @@ int main(int ac, char **av)
>  	}
>  	return status;
>  }
> +#else
> +int main(void)
> +{
> +	fprintf(stderr, "test requires libaio and it's development packages\n");
> +	return TCONF;
> +}
> +#endif
> diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
> index 93984bf28..d315353d0 100644
> --- a/testcases/kernel/io/ltp-aiodio/aiocp.c
> +++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
> @@ -38,8 +38,7 @@
>  #include "config.h"
>  #include "tst_res_flags.h"
>  
> -#if HAVE_LIBAIO_H
> -
> +#ifdef HAVE_LIBAIO
>  #include <libaio.h>
>  
>  #define AIO_BLKSIZE	(64*1024)
> @@ -600,11 +599,9 @@ int main(int argc, char *const *argv)
>   */
>  
>  #else
> -
>  int main(void)
>  {
> -	fprintf(stderr, "System doesn't have libaio support.\n");
> +	fprintf(stderr, "test requires libaio and it's development packages\n");
>  	return TCONF;
>  }
> -
>  #endif
> diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
> index 39a529fa3..5d97ed941 100644
> --- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
> +++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
> @@ -32,10 +32,14 @@
>  #include <fcntl.h>
>  #include <unistd.h>
>  
> -#include <libaio.h>
> -
> +#include "config.h"
>  #include "test.h"
>  
> +char *TCID = "aiodio_append";
> +
> +#ifdef HAVE_LIBAIO
> +#include <libaio.h>
> +
>  #define NUM_CHILDREN 8
>  
>  #include "common_checkzero.h"
> @@ -174,3 +178,9 @@ int main(int argc, char **argv)
>  
>  	return 0;
>  }
> +#else
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
> +}
> +#endif
> diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
> index d40e45b1b..4767f49d2 100644
> --- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
> +++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
> @@ -35,11 +35,17 @@
>  #include <limits.h>
>  #include <getopt.h>
>  
> -#include <libaio.h>
>  
> +#include "config.h"
>  #include "test.h"
>  #include "safe_macros.h"
>  
> +char *TCID = "aiodio_sparse";
> +int TST_TOTAL = 1;
> +
> +#ifdef HAVE_LIBAIO
> +#include <libaio.h>
> +
>  #define NUM_CHILDREN 1000
>  
>  int debug;
> @@ -49,9 +55,6 @@ static void setup(void);
>  static void cleanup(void);
>  static void usage(void);
>  
> -char *TCID = "aiodio_sparse";
> -int TST_TOTAL = 1;
> -
>  #include "common_sparse.h"
>  
>  /*
> @@ -325,3 +328,10 @@ static void cleanup(void)
>  
>  	tst_rmdir();
>  }
> +
> +#else
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
> +}
> +#endif
> diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
> index 37cca7d53..e4f9c804a 100644
> --- a/testcases/kernel/syscalls/eventfd/eventfd01.c
> +++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
> @@ -61,15 +61,14 @@
>  #define CLEANUP cleanup
>  #include "lapi/syscalls.h"
>  
> -#ifdef HAVE_LIBAIO_H
> +TCID_DEFINE(eventfd01);
> +int TST_TOTAL = 15;
> +
> +#ifdef HAVE_LIBAIO
>  #include <libaio.h>
> -#endif
>  
>  static void setup(void);
>  
> -TCID_DEFINE(eventfd01);
> -int TST_TOTAL = 15;
> -
>  static int myeventfd(unsigned int initval, int flags)
>  {
>  	/* eventfd2 uses FLAGS but eventfd doesn't take FLAGS. */
> @@ -727,3 +726,10 @@ static void cleanup(void)
>  {
>  	tst_rmdir();
>  }
> +
> +#else
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
> +}
> +#endif
> diff --git a/testcases/kernel/syscalls/io_cancel/io_cancel01.c b/testcases/kernel/syscalls/io_cancel/io_cancel01.c
> index 8d7ca2607..ed6af050b 100644
> --- a/testcases/kernel/syscalls/io_cancel/io_cancel01.c
> +++ b/testcases/kernel/syscalls/io_cancel/io_cancel01.c
> @@ -21,6 +21,9 @@
>  /* Porting from Crackerjack to LTP is done
>     by Masatake YAMATO <yamato@redhat.com> */
>  
> +#include <errno.h>
> +#include <string.h>
> +
>  #include "config.h"
>  #include "test.h"
>  
> @@ -28,10 +31,8 @@ char *TCID = "io_cancel01";
>  
>  int TST_TOTAL = 1;
>  
> -#ifdef HAVE_LIBAIO_H
> +#ifdef HAVE_LIBAIO
>  #include <libaio.h>
> -#include <errno.h>
> -#include <string.h>
>  
>  static void cleanup(void)
>  {
> @@ -105,9 +106,10 @@ int main(int argc, char *argv[])
>  	cleanup();
>  	tst_exit();
>  }
> +
>  #else
> -int main(int argc, char *argv[])
> +int main(void)
>  {
> -	tst_brkm(TCONF, NULL, "System doesn't have libaio support");
> +	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
>  }
>  #endif
> diff --git a/testcases/kernel/syscalls/io_destroy/io_destroy01.c b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
> index 9de4987f4..88bef7ecf 100644
> --- a/testcases/kernel/syscalls/io_destroy/io_destroy01.c
> +++ b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
> @@ -21,6 +21,9 @@
>  /* Porting from Crackerjack to LTP is done
>     by Masatake YAMATO <yamato@redhat.com> */
>  
> +#include <errno.h>
> +#include <string.h>
> +
>  #include "config.h"
>  #include "test.h"
>  
> @@ -28,10 +31,8 @@ char *TCID = "io_destroy01";
>  
>  int TST_TOTAL = 1;
>  
> -#ifdef HAVE_LIBAIO_H
> +#ifdef HAVE_LIBAIO
>  #include <libaio.h>
> -#include <errno.h>
> -#include <string.h>
>  
>  static void cleanup(void)
>  {
> @@ -99,9 +100,10 @@ int main(int argc, char *argv[])
>  	cleanup();
>  	tst_exit();
>  }
> +
>  #else
> -int main(int argc, char *argv[])
> +int main(void)
>  {
> -	tst_brkm(TCONF, NULL, "System doesn't support execution of the test");
> +	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
>  }
>  #endif
> diff --git a/testcases/kernel/syscalls/io_getevents/io_getevents01.c b/testcases/kernel/syscalls/io_getevents/io_getevents01.c
> index 0f31ece32..b34f17907 100644
> --- a/testcases/kernel/syscalls/io_getevents/io_getevents01.c
> +++ b/testcases/kernel/syscalls/io_getevents/io_getevents01.c
> @@ -21,17 +21,17 @@
>  /* Porting from Crackerjack to LTP is done
>     by Masatake YAMATO <yamato@redhat.com> */
>  
> +#include <errno.h>
> +#include <string.h>
> +
>  #include "config.h"
>  #include "test.h"
>  
>  char *TCID = "io_getevents01";
> -
>  int TST_TOTAL = 1;
>  
> -#ifdef HAVE_LIBAIO_H
> +#ifdef HAVE_LIBAIO
>  #include <libaio.h>
> -#include <errno.h>
> -#include <string.h>
>  
>  static void cleanup(void)
>  {
> @@ -104,9 +104,10 @@ int main(int argc, char *argv[])
>  	cleanup();
>  	tst_exit();
>  }
> +
>  #else
> -int main(int argc, char *argv[])
> +int main(void)
>  {
> -	tst_brkm(TCONF, NULL, "System doesn't support execution of the test");
> +	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
>  }
>  #endif
> diff --git a/testcases/kernel/syscalls/io_setup/io_setup01.c b/testcases/kernel/syscalls/io_setup/io_setup01.c
> index 829cef516..22b91bc17 100644
> --- a/testcases/kernel/syscalls/io_setup/io_setup01.c
> +++ b/testcases/kernel/syscalls/io_setup/io_setup01.c
> @@ -21,6 +21,9 @@
>  /* Porting from Crackerjack to LTP is done
>     by Masatake YAMATO <yamato@redhat.com> */
>  
> +#include <errno.h>
> +#include <string.h>
> +
>  #include "config.h"
>  #include "test.h"
>  
> @@ -28,10 +31,8 @@ char *TCID = "io_setup01";
>  
>  int TST_TOTAL = 4;
>  
> -#ifdef HAVE_LIBAIO_H
> +#ifdef HAVE_LIBAIO
>  #include <libaio.h>
> -#include <errno.h>
> -#include <string.h>
>  
>  static void cleanup(void)
>  {
> @@ -131,9 +132,10 @@ int main(int argc, char *argv[])
>  
>  	tst_exit();
>  }
> +
>  #else
> -int main(int argc, char *argv[])
> +int main(void)
>  {
> -	tst_brkm(TCONF, NULL, "System doesn't support execution of the test");
> +	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
>  }
>  #endif
> diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
> index 9baf520b8..f4f9933f6 100644
> --- a/testcases/kernel/syscalls/io_submit/io_submit01.c
> +++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
> @@ -20,14 +20,15 @@
>  /* Porting from Crackerjack to LTP is done
>     by Masatake YAMATO <yamato@redhat.com> */
>  
> +#include <errno.h>
> +#include <string.h>
> +#include <fcntl.h>
> +
>  #include "config.h"
>  #include "tst_test.h"
>  
> -#ifdef HAVE_LIBAIO_H
> +#ifdef HAVE_LIBAIO
>  #include <libaio.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <fcntl.h>
>  
>  static io_context_t ctx;
>  static io_context_t invalid_ctx;
> @@ -139,5 +140,5 @@ static struct tst_test test = {
>  };
>  
>  #else
> -	TST_TEST_TCONF("libaio.h was mission upon compilation");
> +	TST_TEST_TCONF("test requires libaio and it's development packages");
>  #endif
> -- 
> 2.14.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
