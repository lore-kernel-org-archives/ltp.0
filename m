Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UphS9-0005r0-HY
	for ltp-list@lists.sourceforge.net; Thu, 20 Jun 2013 16:11:17 +0000
Date: Thu, 20 Jun 2013 18:12:42 +0200
From: chrubis@suse.cz
Message-ID: <20130620161242.GA3781@rei>
References: <51C2D643.1040807@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51C2D643.1040807@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] mmap/mmap13.c: new case to test SIGBUS error of
 mmap
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> Test SIGBUS error by accessing to a portion of the buffer that does not
> correspond to the file.
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  runtest/syscalls                        |   1 +
>  testcases/kernel/syscalls/mmap/mmap13.c | 155 ++++++++++++++++++++++++++++++++
>  2 files changed, 156 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mmap/mmap13.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index e6ce29c..eba0200 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -561,6 +561,7 @@ mmap06 mmap06
>  mmap07 mmap07
>  mmap08 mmap08
>  mmap09 mmap09
> +mmap13 mmap13
>  # test is broken, mask it for now.
>  #mmap11 mmap11 -i 30000
> 
> diff --git a/testcases/kernel/syscalls/mmap/mmap13.c b/testcases/kernel/syscalls/mmap/mmap13.c
> new file mode 100644
> index 0000000..6aaa8ad
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mmap/mmap13.c
> @@ -0,0 +1,155 @@
> +/*
> + * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
> + *
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program;  if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +/*
> + * Test Description:
> + *  Verify error signal SIGBUS.
> + *  "Attempted access to a portion of the buffer that does not correspond
> + *   to the file."
> + *
> + * Expected Result:
> + *  mmap() should succeed returning the address of the mapped region,
> + *  and an attempt to access the memory which does not correspond to the file
> + *  should rise the signal SIGBUS.
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <setjmp.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +
> +#define TEMPFILE	"mmapfile"
> +
> +char *TCID = "mmap13";
> +int TST_TOTAL = 1;
> +
> +static size_t page_sz;
> +static char *addr;
> +static int fildes;
> +static int pass;

This should really be volatile or even better
'static volatile sig_atomic_t pass' because otherwise
the compiler may optimize out the if (pass) in the main loop.

> +static sigjmp_buf env;
> +
> +static void setup(void);
> +static void cleanup(void);
> +static void sig_handler(int sig);
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *ch;
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		addr = mmap(0, page_sz * 2, PROT_READ | PROT_WRITE,
> +			    MAP_FILE | MAP_SHARED, fildes, 0);
> +
> +		if (addr == MAP_FAILED) {
> +			tst_resm(TFAIL | TERRNO, "mmap() failed on %s",
> +				 TEMPFILE);
> +			continue;
> +		}
> +
> +		if (STD_FUNCTIONAL_TEST) {
> +
> +			if (sigsetjmp(env, 1) == 0) {
> +				ch = addr + page_sz + 1;
> +				*ch = 0;
> +
> +				if (pass)
> +					tst_resm(TPASS, "Got SIGSEGV"
> +							"as expected");
> +				else
> +					tst_resm(TFAIL, "Invalid access not"
> +							"rise SIGSEGV");
> +			}
> +
> +		} else {
> +			tst_resm(TPASS, "call succeeded");
> +		}
> +
> +		if (munmap(addr, page_sz * 2) != 0)
> +			tst_brkm(TFAIL | TERRNO, cleanup,
> +				 "failed to unmap the mmapped pages");
> +
> +		pass = 0;
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(NOFORK, sig_handler, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	page_sz = getpagesize();
> +
> +	tst_tmpdir();
> +
> +	fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0766);
> +	if (fildes < 0)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "opening %s failed",
> +			 TEMPFILE);
> +
> +	if (ftruncate(fildes, page_sz / 2) == -1)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "ftruncate %s failed",
> +			 TEMPFILE);
> +}
> +
> +/*
> + *   This function gets executed when the test process receives
> + *   the signal SIGBUS while trying to access the memory which
> + *   does not correspond to the file.
> + */
> +static void sig_handler(int sig)
> +{
> +	if (sig == SIGBUS) {
> +		pass = 1;
> +		tst_resm(TPASS, "Got SIGBUS as expected");

Calling the tst_resm() interface may not be save from signal context. We
should rather resort only to setting the variable here.

> +		siglongjmp(env, 1);
> +	} else {
> +		tst_brkm(TBROK, cleanup, "received an unexpected signal");
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	close(fildes);
> +	TEST_CLEANUP;
> +	tst_rmdir();
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
