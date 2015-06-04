Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z0UMm-0002iZ-Sz
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2015 12:35:24 +0000
Date: Thu, 4 Jun 2015 14:34:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150604123423.GA21846@rei.suse.de>
References: <6638881b90112812abf856192c16986eb73fb10a.1433420296.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6638881b90112812abf856192c16986eb73fb10a.1433420296.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] mem/oom: allocate memory using multiple threads
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
>  testcases/kernel/mem/include/libmem.mk |  2 +-
>  testcases/kernel/mem/lib/mem.c         | 59 +++++++++++++++++++++++++++-------
>  2 files changed, 49 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/kernel/mem/include/libmem.mk b/testcases/kernel/mem/include/libmem.mk
> index 4503e78..bb5a163 100644
> --- a/testcases/kernel/mem/include/libmem.mk
> +++ b/testcases/kernel/mem/include/libmem.mk
> @@ -24,7 +24,7 @@ LIBMEM_DIR		:= $(MEM_DIR)/lib
>  LIBMEM			:= $(LIBMEM_DIR)/libmem.a
>  FILTER_OUT_DIRS		:= $(LIBMEM_DIR)
>  CFLAGS			+= -I$(MEM_SRCDIR)/include
> -LDLIBS			+= $(NUMA_LIBS) -lmem -lltp
> +LDLIBS			+= $(NUMA_LIBS) -lmem -lltp -lpthread
>  LDFLAGS			+= -L$(LIBMEM_DIR)

You should add -pthread to CFLAGS instead, otherwise the code will fail
to compile on some distributions.

>  $(LIBMEM_DIR):
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 37cf18f..1862e26 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -12,6 +12,7 @@
>  #if HAVE_NUMAIF_H
>  #include <numaif.h>
>  #endif
> +#include <pthread.h>
>  #include <stdarg.h>
>  #include <stdio.h>
>  #include <string.h>
> @@ -30,7 +31,8 @@ static int alloc_mem(long int length, int testcase)
>  	char *s;
>  	long i, pagesz = getpagesize();
>  
> -	tst_resm(TINFO, "allocating %ld bytes.", length);
> +	tst_resm(TINFO, "thread (%lx), allocating %ld bytes.",
> +		(unsigned long) pthread_self(), length);
>  
>  	s = mmap(NULL, length, PROT_READ | PROT_WRITE,
>  		 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> @@ -49,18 +51,52 @@ static int alloc_mem(long int length, int testcase)
>  	return 0;
>  }
>  
> -static void test_alloc(int testcase, int lite)
> +static void *child_alloc_thread(void *args)
>  {
> -	int ret;
> +	int *testcase = args;
> +	int ret = 0;
> +
> +	/* keep allocating until there's an error */
> +	while (!ret)
> +		ret = alloc_mem(LENGTH, *testcase);

You can do

 ret = alloc_mem(LENGHT, (long)args)

here and

 TEST(pthread_create(&th[i], NULL, child_alloc_thread, (void*)((long)testcase)));

in the caller.

But given that the caller joins the threads before it exits the function
the pointer to testcase will be vaild at the time this function is
executed.

> +	exit(ret);

And and it's a bit confusing that the pthread_join() is likely not
reached because the first finishing thread exits the child here.

But at lest there is a comment below.

Maybe we can just wait in the caller thread indefinitely.

> +}
> +
> +static void child_alloc(int testcase, int lite, int threads)
> +{
> +	int i;
> +	pthread_t *th;
>  
>  	if (lite) {
> -		ret = alloc_mem(TESTMEM + MB, testcase);
> -	} else {
> -		ret = 0;
> -		while (!ret)
> -			ret = alloc_mem(LENGTH, testcase);
> +		int ret = alloc_mem(TESTMEM + MB, testcase);
> +		exit(ret);
>  	}
> -	exit(ret);
> +
> +	th = malloc(sizeof(pthread_t) * threads);
> +	if (!th) {
> +		tst_resm(TINFO | TERRNO, "malloc");
> +		goto out;
> +	}
> +
> +	for (i = 0; i < threads; i++) {
> +		TEST(pthread_create(&th[i], NULL, child_alloc_thread,
> +			&testcase));
> +		if (TEST_RETURN) {
> +			tst_resm(TINFO | TRERRNO, "pthread_create");
> +			goto out;
> +		}
> +	}
> +
> +	/* wait for one of threads to exit whole process */
> +	for (i = 0; i < threads; i++) {
> +		TEST(pthread_join(th[i], NULL));
> +		if (TEST_RETURN) {
> +			tst_resm(TINFO | TRERRNO, "pthread_join");
> +			goto out;
> +		}
> +	}
> +out:
> +	exit(1);
>  }
>  
>  /*
> @@ -81,13 +117,14 @@ static void test_alloc(int testcase, int lite)
>  void oom(int testcase, int lite, int retcode, int allow_sigkill)
>  {
>  	pid_t pid;
> -	int status;
> +	int status, threads;
>  
>  	switch (pid = fork()) {
>  	case -1:
>  		tst_brkm(TBROK | TERRNO, cleanup, "fork");
>  	case 0:
> -		test_alloc(testcase, lite);
> +		threads = MAX(1, tst_ncpus() - 1);
> +		child_alloc(testcase, lite, threads);
>  	default:
>  		break;
>  	}
> -- 
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
