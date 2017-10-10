From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Oct 2017 14:55:00 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/setrlimit02.c: Add a test for
	EFAULT
In-Reply-To: <1507600371-29126-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20171009142304.GB25633@rei.lan>
 <1507600371-29126-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20171010125459.GD4970@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + * DESCRIPTION
> + *  1) Test for EINVAL when resource is invalid.
> + *  2) Test for EFAULT when rlim points outside the accessible address space.
> + *  3) Test for EPERM when an unprivileged process tries to increase the
> + *     hard limit.
>   */
>  #include <pwd.h>
>  #include <errno.h>
> @@ -33,6 +37,7 @@ static struct tcase {
>  	int exp_errno;
>  } tcases[] = {
>  	{-1, &rlim, EINVAL},
> +	{RLIMIT_NOFILE, (void *) -1, EFAULT},
>  	{RLIMIT_NOFILE, &rlim, EPERM}
>  };

I've rembered why there is no EFAULT test for the setrlimit:

commit 259db6fed55f88ab32a0875e66803eee44d298be
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Thu Aug 17 13:42:20 2017 +0200

    syscalls/setrlimit02: Remove the EFAULT test

    ...

https://github.com/linux-test-project/ltp/issues/193


So if we really want to add this one, we have to either run the test in
the child and produce PASS on SegFault or call the raw syscall for the
EFAULT test. Either way I think that we should put it in a seprate
testcase if the test is really needed.

-- 
Cyril Hrubis
chrubis@suse.cz
