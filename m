Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwan@redhat.com>) id 1Z9Vmo-0007hi-Gr
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2015 09:55:34 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z9Vmm-0004vB-Kl
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2015 09:55:34 +0000
Received: from zmail22.collab.prod.int.phx2.redhat.com
	(zmail22.collab.prod.int.phx2.redhat.com [10.5.83.26])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id t5T9tQD6005035
	for <ltp-list@lists.sourceforge.net>; Mon, 29 Jun 2015 05:55:26 -0400
Date: Mon, 29 Jun 2015 05:55:26 -0400 (EDT)
From: Li Wang <liwang@redhat.com>
Message-ID: <1750983670.20645133.1435571726272.JavaMail.zimbra@redhat.com>
In-Reply-To: <1434610097-15874-1-git-send-email-liwang@redhat.com>
References: <1434610097-15874-1-git-send-email-liwang@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] futex: regression test for take hugepages
	into	account when generating futex_key
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
To: ltp-list@lists.sourceforge.net

Hi, 

Ping~
Any comments?

-- 
Regards, 
Li Wang 
Email: liwang@redhat.com 


----- Original Message -----
> v1 ---> v2:
> 
> 	* Macro HUGE_SISE replaced by read_hugepagesise().
> 
> 	* futex_wait() get a timeout parameter
> 
> 	* SAFE_MMAP SAFE_MUNMAP() and pthread_join() been used.
> 
> 	* Semaphore been added to do synchronization.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  runtest/syscalls                               |   1 +
>  testcases/kernel/syscalls/futex/Makefile       |   1 +
>  testcases/kernel/syscalls/futex/futex_wake04.c | 193
>  +++++++++++++++++++++++++
>  3 files changed, 195 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/futex/futex_wake04.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 07bfc1e..1308536 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1382,5 +1382,6 @@ futex_wait05 futex_wait05
>  futex_wake01 futex_wake01
>  futex_wake02 futex_wake02
>  futex_wake03 futex_wake03
> +futex_wake04 futex_wake04
>  futex_wait_bitset01 futex_wait_bitset01
>  futex_wait_bitset02 futex_wait_bitset02
> diff --git a/testcases/kernel/syscalls/futex/Makefile
> b/testcases/kernel/syscalls/futex/Makefile
> index d888734..6e72daf 100644
> --- a/testcases/kernel/syscalls/futex/Makefile
> +++ b/testcases/kernel/syscalls/futex/Makefile
> @@ -22,6 +22,7 @@ futex_wait02: LDLIBS+=-lrt
>  futex_wake03: LDLIBS+=-lrt
>  futex_wait03: CFLAGS+=-pthread
>  futex_wake02: CFLAGS+=-pthread
> +futex_wake04: CFLAGS+=-pthread
>  futex_wait05: LDLIBS+=-lrt
>  futex_wait_bitset01: LDLIBS+=-lrt
>  futex_wait_bitset02: LDLIBS+=-lrt
> diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c
> b/testcases/kernel/syscalls/futex/futex_wake04.c
> new file mode 100644
> index 0000000..78a52ff
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_wake04.c
> @@ -0,0 +1,193 @@
> +/*
> + * Copyright (C) 2015  Yi Zhang <wetpzy@gmail.com>
> + *                     Li Wang <liwang@redhat.com>
> + *
> + * Licensed under the GNU GPLv2 or later.
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
> + /* DESCRIPTION:
> + *
> + *   It is a regression test for commit:
> + *   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
> + *   commit/?id=13d60f4
> + *
> + *   The implementation of futex doesn't produce unique keys for futexes
> + *   in shared huge pages, so threads waiting on different futexes may
> + *   end up on the same wait list. This results in incorrect threads being
> + *   woken by FUTEX_WAKE.
> + *
> + *   Needs to be run as root unless there are already enough huge pages
> available.
> + *   In the fail case, which happens in the CentOS-6.6 kernel
> (2.6.32-504.8.1),
> + *   the tests hangs until it times out after a 30-second wait.
> + *
> + */
> +
> +#include <stdio.h>
> +#include <sys/mman.h>
> +#include <fcntl.h>
> +#include <pthread.h>
> +#include <errno.h>
> +#include <sys/time.h>
> +#include <string.h>
> +#include <semaphore.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "futextest.h"
> +
> +#define PATH_MEMINFO "/proc/meminfo"
> +#define PATH_NR_HUGEPAGES "/proc/sys/vm/nr_hugepages"
> +
> +const char *TCID = "futex_wake04";
> +const int TST_TOTAL = 1;
> +
> +static futex_t *futex1, *futex2;
> +
> +static struct timespec to = {.tv_sec = 30, .tv_nsec = 0};
> +
> +static long orig_hugepages;
> +
> +static sem_t bin_sem;
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +	tst_tmpdir();
> +
> +	SAFE_FILE_SCANF(NULL, PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
> +	SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%d", 1);
> +
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
> +
> +	tst_rmdir();
> +}
> +
> +static int read_hugepagesize(void)
> +{
> +	FILE *fp;
> +	char line[BUFSIZ], buf[BUFSIZ];
> +	int val;
> +
> +	fp = SAFE_FOPEN(cleanup, PATH_MEMINFO, "r");
> +	while (fgets(line, BUFSIZ, fp) != NULL) {
> +		if (sscanf(line, "%64s %d", buf, &val) == 2)
> +			if (strcmp(buf, "Hugepagesize:") == 0) {
> +				SAFE_FCLOSE(cleanup, fp);
> +				return 1024 * val;
> +			}
> +	}
> +
> +	SAFE_FCLOSE(cleanup, fp);
> +	tst_brkm(TBROK, NULL, "can't find \"%s\" in %s",
> +			"Hugepagesize:", PATH_MEMINFO);
> +}
> +
> +static void *wait_thread1(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	sem_post(&bin_sem);
> +
> +	futex_wait(futex1, *futex1, &to, 0);
> +
> +	return NULL;
> +}
> +
> +static void *wait_thread2(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	int res;
> +
> +	sem_post(&bin_sem);
> +
> +	res = futex_wait(futex2, *futex2, &to, 0);
> +	if (!res)
> +		tst_resm(TPASS, "Hi hydra, thread2 awake!");
> +	else
> +		tst_resm(TFAIL, "Bug: wait_thread2 did not wake after 30 secs.");
> +
> +	return NULL;
> +}
> +
> +static void wakeup_thread2(void)
> +{
> +	void *addr;
> +	int hpsz, pgsz, res;
> +	pthread_t th1, th2;
> +
> +	res = sem_init(&bin_sem, 0, 0);
> +	if (res)
> +		tst_brkm(TBROK, NULL, "Semaphore initialization failed.");
> +
> +	hpsz = read_hugepagesize();
> +
> +	/*allocate some shared memory*/
> +	addr = SAFE_MMAP(NULL, NULL, hpsz, PROT_WRITE | PROT_READ,
> +			MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
> +
> +	pgsz = getpagesize();
> +
> +	/*apply the first subpage to futex1*/
> +	futex1 = addr;
> +	*futex1 = 0;
> +	/*apply the second subpage to futex2*/
> +	futex2 = (futex_t *)((char *)addr + pgsz);
> +	*futex2 = 0;
> +
> +	/*thread1 block on futex1 first,then thread2 block on futex2*/
> +	res = pthread_create(&th1, NULL, wait_thread1, NULL);
> +	if (res) {
> +		tst_brkm(TBROK, NULL, "pthread_create(): %s",
> +				tst_strerrno(res));
> +	}
> +	sem_wait(&bin_sem);
> +
> +	res = pthread_create(&th2, NULL, wait_thread2, NULL);
> +	if (res) {
> +		tst_brkm(TBROK, NULL, "pthread_create(): %s",
> +				tst_strerrno(res));
> +	}
> +	sem_wait(&bin_sem);
> +
> +	futex_wake(futex2, 1, 0);
> +
> +	res = pthread_join(th2, NULL);
> +	if (res)
> +		tst_brkm(TBROK, NULL, "pthread_join(): %s", tst_strerrno(res));
> +
> +	res = pthread_join(th1, NULL);
> +	if (res)
> +		tst_brkm(TBROK, NULL, "pthread_join(): %s", tst_strerrno(res));
> +
> +	sem_destroy(&bin_sem);
> +	SAFE_MUNMAP(NULL, addr, hpsz);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +
> +	tst_parse_opts(argc, argv, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++)
> +		wakeup_thread2();
> +
> +	cleanup();
> +	tst_exit();
> +}
> --
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
