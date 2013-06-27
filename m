Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Us6mw-0004V8-9L
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 07:38:42 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Us6mu-0005Co-3r
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 07:38:42 +0000
Date: Thu, 27 Jun 2013 03:38:27 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1685865585.461109.1372318707448.JavaMail.root@redhat.com>
In-Reply-To: <51CBAFB7.8000508@cn.fujitsu.com>
References: <51CBAFB7.8000508@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] mmap/mmap14.c: new case to test MAP_LOCKED of mmap
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



----- Original Message -----
> From: "DAN LI" <li.dan@cn.fujitsu.com>
> To: "LTP list" <ltp-list@lists.sourceforge.net>
> Sent: Thursday, 27 June, 2013 5:21:27 AM
> Subject: [LTP]  [PATCH] mmap/mmap14.c: new case to test MAP_LOCKED of mmap
> 
> 
> 
> Create test case for MAP_LOCKED of mmap.
> 
> Verify pages are locked by checking section "VmLck" of /proc/<pid>/status.
> 
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>

Hi,

few small comments inline. Overall it looks good to me.


> ---
>  runtest/syscalls                        |   1 +
>  testcases/kernel/syscalls/mmap/mmap14.c | 133
>  ++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mmap/mmap14.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index eba0200..4865375 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -562,6 +562,7 @@ mmap07 mmap07
>  mmap08 mmap08
>  mmap09 mmap09
>  mmap13 mmap13
> +mmap14 mmap14
>  # test is broken, mask it for now.
>  #mmap11 mmap11 -i 30000
> 
> diff --git a/testcases/kernel/syscalls/mmap/mmap14.c
> b/testcases/kernel/syscalls/mmap/mmap14.c
> new file mode 100644
> index 0000000..d279df0
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mmap/mmap14.c
> @@ -0,0 +1,133 @@
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
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301
> USA
> + */
> +
> +/*
> + * Test Description:
> + *  Verify MAP_LOCKED works fine.
> + *  "Lock the pages of the mapped region into memory in the manner of
> mlock(2)."
> + *
> + * Expected Result:
> + *  mmap() should succeed returning the address of the mapped region,
> + *  and this region should be locked into memory.
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <stdint.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <sys/shm.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +
> +#define TEMPFILE        "mmapfile"
> +#define MMAPSIZE        (1UL<<20)
> +#define LINELEN         256
> +
> +char *TCID = "mmap14";
> +int TST_TOTAL = 1;
> +
> +static char *addr;
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	int ret;
> +	int lock_sz;
> +	char *msg;
> +	char line[LINELEN];
> +	FILE *fstatus = NULL;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +
> +		tst_count = 0;
> +
> +		addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
> +			    MAP_FILE | MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,

MAP_FILE doesn't seem to belong here.

> +			    -1, 0);
> +
> +		if (addr == MAP_FAILED) {
> +			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
> +			continue;
> +		}
> +
> +		if (STD_FUNCTIONAL_TEST) {
> +
> +			fstatus = fopen("/proc/self/status", "r");
> +			if (fstatus == NULL)
> +				tst_brkm(TFAIL | TERRNO, NULL, "Open dev "
> +							       "status failed");
> +
> +			while (fgets(line, LINELEN, fstatus) != NULL)
> +				if (strstr(line, "VmLck") != NULL)
> +					break;
> +
> +			ret = sscanf(line, "%*[^0-9]%d%*[^0-9]", &lock_sz);
> +			if (ret != 1)
> +				tst_brkm(TFAIL | TERRNO, NULL, "Get lock "
> +							       "size failed");
> +
> +			if (lock_sz == MMAPSIZE / 1024)

Can you also print lock_sz if this condition fails?

> +				tst_resm(TPASS, "Functionality of mmap() "
> +						"successful");
> +			else
> +				tst_resm(TFAIL, "Pages are not locked");
> +
> +		} else {
> +			tst_resm(TPASS, "call succeeded");
> +		}
> +
> +		fclose(fstatus);
> +		if (munmap(addr, MMAPSIZE) != 0)
> +			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();

Is tmp dir used for anything?

Regards,
Jan

> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +	tst_rmdir();
> +}
> --
> 1.8.1
> 
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by Windows:
> 
> Build for Windows Store.
> 
> http://p.sf.net/sfu/windows-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
