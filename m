Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WuMz6-0005P6-0x
	for ltp-list@lists.sourceforge.net; Tue, 10 Jun 2014 14:25:08 +0000
Date: Tue, 10 Jun 2014 16:24:58 +0200
From: chrubis@suse.cz
Message-ID: <20140610142457.GA18940@rei.Home>
References: <1402040858-5701-1-git-send-email-shuang.qiu@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1402040858-5701-1-git-send-email-shuang.qiu@oracle.com>
Subject: Re: [LTP] [PATCH] syscalls/fstatfs02: Using temporary file
 description to test the syscall
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
To: shuang.qiu@oracle.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> It is not expected to use stdout as the file description to test the
> system call fstatfs().Using ltp temporary file instead.
> 
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
> ---
>  testcases/kernel/syscalls/fstatfs/fstatfs02.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
> index f851c97..9e00a67 100644
> --- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
> +++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
> @@ -27,6 +27,7 @@
>  #include <errno.h>
>  #include "test.h"
>  #include "usctest.h"
> +#include "safe_macros.h"
>  
>  static void setup(void);
>  static void cleanup(void);
> @@ -48,6 +49,7 @@ static struct test_case_t {
>  #ifndef UCLINUX
>  	    /* Skip since uClinux does not implement memory protection */
>  	    /* EFAULT - address for buf is invalid */
> +	    /* Using the init "1" as fd is not actually expected,will assign a tmp file later */
>  	{
>  	1, (void *)-1, EFAULT}
>  #endif
> @@ -107,11 +109,19 @@ static void setup(void)
>  	TEST_PAUSE;
>  
>  	tst_tmpdir();
> +#ifndef UCLINUX
> +	TC[1].fd = SAFE_OPEN(cleanup, "tempfile", O_RDWR | O_CREAT, 0700);
> +#endif
>  }
>  
>  static void cleanup(void)
>  {
>  	TEST_CLEANUP;
>  
> +#ifndef UCLINUX
> +	if (TC[1].fd > 0 && close(TC[1].fd))

             ^
	     This does not work as expected because the fd is
	     initialized to 1. If we get here after the open() has
	     failed it will close stdout at this point.

	     You should change the initial value in the test strucure to
	     -1 (you don't have to add the comment in this case too).

> +		tst_resm(TWARN | TERRNO, "Failed to close fd");
> +#endif
> +
>  	tst_rmdir();
>  }

The rest is Ok.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
