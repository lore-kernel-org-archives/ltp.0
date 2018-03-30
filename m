From: Xiong Zhou <xzhou@redhat.com>
Date: Fri, 30 Mar 2018 13:23:07 +0800
Subject: [LTP] [PATCH] fcntl37: test posix lock across execve
In-Reply-To: <20180326143313.GE27423@rei>
References: <1522070895-2289-1-git-send-email-xzhou@redhat.com>
 <20180326143313.GE27423@rei>
Message-ID: <20180330052307.b57csmyaqg74typ2@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

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

Finally get this helper working but does not reproduce the original
bug we are trying to cover. I guess the testcase re-exec is necessary
here.

If this rule is unshakeable, I'll try upstreaming it to other test
suite. Rule is rule, I respect rules.

THanks,
Xiong
