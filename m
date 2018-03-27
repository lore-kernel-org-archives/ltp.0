From: Xiong Zhou <xzhou@redhat.com>
Date: Tue, 27 Mar 2018 16:50:43 +0800
Subject: [LTP] [PATCH] fcntl37: test posix lock across execve
In-Reply-To: <20180326143313.GE27423@rei>
References: <1522070895-2289-1-git-send-email-xzhou@redhat.com>
 <20180326143313.GE27423@rei>
Message-ID: <20180327085043.e7hrrcho5xzkdh34@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Thanks for reviewing!

On Mon, Mar 26, 2018 at 04:33:33PM +0200, Cyril Hrubis wrote:
> Hi!
> > diff --git a/testcases/kernel/syscalls/fcntl/Makefile b/testcases/kernel/syscalls/fcntl/Makefile
> > index ae37214..7a06aa7 100644
> > --- a/testcases/kernel/syscalls/fcntl/Makefile
> > +++ b/testcases/kernel/syscalls/fcntl/Makefile
> > @@ -27,6 +27,9 @@ fcntl34_64: LDLIBS += -lpthread
> >  fcntl36: LDLIBS += -lpthread
> >  fcntl36_64: LDLIBS += -lpthread
> >  
> > +fcntl37: LDLIBS += -lpthread
> > +fcntl37_64: LDLIBS += -lpthread
> 
> This is wrong, we should use CFLAGS += -pthread instead, also the rest
				^ This is not working.

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -DTST_USE_NEWER64_SYSCALL=1 -pthread -D_FORTIFY_SOURCE=2 -I/home/xzhou/ltp/testcases/kernel/syscalls/fcntl -I/home/xzhou/ltp/testcases/kernel/syscalls/fcntl/../utils -D_GNU_SOURCE -I../../../../include -I../../../../include -I../../../../include/old/ -D_FILE_OFFSET_BITS=64  -c -o fcntl37_64.o fcntl37.c
gcc   -L../../../../lib  fcntl37_64.o   -lltp -o fcntl37_64
../../../../lib/libltp.a(safe_pthread.o): In function `safe_pthread_create':
/home/xzhou/ltp/lib/safe_pthread.c:30: undefined reference to `pthread_create'
../../../../lib/libltp.a(safe_pthread.o): In function `safe_pthread_join':
/home/xzhou/ltp/lib/safe_pthread.c:46: undefined reference to `pthread_join'
collect2: error: ld returned 1 exit status


> of the Makefile should be fixed as well.
> 
> >  include $(top_srcdir)/include/mk/testcases.mk
> >  include $(abs_srcdir)/../utils/newer_64.mk
> 
> ...
> 
> > +#include "lapi/fcntl.h"
> > +#include "tst_safe_pthread.h"
> > +#include "tst_test.h"
> > +
> > +static const char fname[] = "tst_lock_execve";
> > +static const char flag_fname[] = "/tmp/execved";
>                                        ^
> 				     You must not create files in random
> 				     places. Once you set the
> 				     .needs_tmpdir in the test structure
> 				     the test is executed with unique temporary
> 				     directory as working directory so
> 				     all you need to do for temporary
> 				     files is to work with relative filenames.
> 
> > +static void cleanup(void);
> > +
> > +static void *thread_fn(void *arg)
> > +{
> > +	int fd = *(int *)arg;
>                    ^
> 		   This is broken, you have to use intptr_t
> 
> > +	tst_res(TINFO, "Thread running. fd %d", fd);
> > +	/* Just need to be alive when execve. */
> > +	sleep(5);
> > +	SAFE_CLOSE(fd);
> > +	return NULL;
> > +}
> > +
> > +static void checklock(int fd)
> > +{
> > +	pid_t pid = SAFE_FORK();
> > +	if (pid == 0) {
> > +		struct flock flck = {
> > +			.l_type = F_WRLCK,
> > +			.l_whence = SEEK_SET,
> > +			.l_start = 0,
> > +			.l_len = 1,
> > +		};
> > +		SAFE_FCNTL(fd, F_GETLK, &flck);
> > +		if (flck.l_type == F_UNLCK)
> > +			tst_res(TFAIL, "Record lock gets lost after execve");
> > +		else
> > +			tst_res(TPASS, "Record lock survives execve");
> > +		SAFE_CLOSE(fd);
> > +		_exit(0);
> 
> Why _exit() ?
> 
> > +	}
> > +	waitpid(pid, NULL, 0);
> 
> SAFE_WAITPID()
> 
> > +}
> 
> Also having the check in a separate function and calling it several
> times makes it kind of hard for debugging. if one of the assertions
> fails the error messages would be the same. Maybe we should pass a
> string with describes assertion type to the function and use it
> int the tst_res() messages.
> 
> > +static void test01(void)
> > +{
> > +	int fd, ret;
> > +	struct stat stat_buf;
> > +
> > +	/*
> > +	 * If tmp/tst_lock_execve exists, execve to run checklock.
> > +	 */
> > +	ret = stat(flag_fname, &stat_buf);
> > +	if (ret == 0) {
> > +		checklock(fd);
> > +		cleanup();
> 
> You must not call the cleanup from the test. Cleanup function is called
> from the test library.
> 
> > +		_exit(0);
> 
> Again why _exit() ?
> 
> > +	}
> 
> Don't do this.
> 
> You must not reexecute the testcase and put file flags into random
> places. If you need execve() a test helper, you have to write simple
> binary helper. See testcases/kernel/syscalls/creat/creat07_child.c

Thanks for the pointer. If I can define TST_NO_DEFAULT_MAIN and have
main() function in this testcase, file flag is not needed.
Passing args would do the trick, as Daniel's original reproducer.

Thanks,
Xiong
> 
> > +	/*
> > +	 * If tmp/tst_lock_execve does not exist, initialize it.
> > +	 */
> 
> Please no useless comments like this one.
> 
> > +	SAFE_OPEN(flag_fname, O_RDWR|O_CREAT, 0755);
> > +	fd = SAFE_OPEN(fname, O_RDWR|O_CREAT, 0755);
> > +	struct flock64 flck = {
> > +		.l_type = F_WRLCK,
> > +		.l_whence = SEEK_SET,
> > +		.l_start  = 0,
> > +		.l_len    = 1,
> > +	};
> > +	SAFE_FCNTL(fd, F_SETLK, &flck);
> > +
> > +	/*
> > +	 * Creat thread and keep it running after placing posix
> > +	 * write lock.
> > +	 */
> 
> Please no useless comments.
> 
> > +	pthread_t th;
> > +	SAFE_PTHREAD_CREATE(&th, NULL, thread_fn, (void *)&fd);
>                                                     ^
> 						    Here as well, we
> 						    have to cast the fd
> 						    to intptr_t first.
> > +	sleep(1);
> 
> Please no random sleeps() for thread synchronization, either use real
> thread synchronization primitives or LTP checkpoint synchronization
> library which is based on futexes.
> 
> See:
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#229-fork-and-parent-child-synchronization
> 
> > +	/*
> > +	 * Clear CLOEXEC
> > +	 */
> 
> Please no useless comments.
> 
> > +	int flags=SAFE_FCNTL(fd, F_GETFD);
> > +	flags &= ~FD_CLOEXEC;
> > +	SAFE_FCNTL(fd, F_SETFD, flags);
> > +
> > +	/*
> > +	 * Get full path name of running programm then execve.
> > +	 */
> 
> Please no useless comments.
> 
> 
> > +	char prog_name[PATH_MAX];
> > +	ret = readlink("/proc/self/exe", prog_name, PATH_MAX);
> > +	char * const newargv[] = { prog_name, NULL, NULL };
> 
> This is far to complicated for no reason. The path to LTP test binaries
> is in $PATH so you can execute any LTP binary just by it's name.
> Absolute path is absolutely unneeded.
> 
> > +	tst_res(TINFO, "execve %s with %s locked", prog_name, fname);
> > +	execve(prog_name, newargv, NULL);
> > +	/*
> > +	 * Failure info for debug
> > +	 */
> 
> Please no useless comments.
> 
> > +	perror("execve ");
> 
> No perror() please. Any error messages should be printed via tst_res()
> or tst_brk().
> 
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	SAFE_UNLINK(flag_fname);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.needs_tmpdir = 1,
> > +	.forks_child = 1,
> > +	.test_all = test01,
> > +	.cleanup = cleanup,
> > +};
> > -- 
> > 1.8.3.1
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
