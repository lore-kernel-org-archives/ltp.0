Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UpZ2x-0008Ea-7C
	for ltp-list@lists.sourceforge.net; Thu, 20 Jun 2013 07:12:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UpZ2v-00087v-0Z
	for ltp-list@lists.sourceforge.net; Thu, 20 Jun 2013 07:12:43 +0000
Message-ID: <51C2AB29.8030207@cn.fujitsu.com>
Date: Thu, 20 Jun 2013 15:11:37 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51C1553B.7090600@cn.fujitsu.com>
	<22953735.4884030.1371643217523.JavaMail.root@redhat.com>
In-Reply-To: <22953735.4884030.1371643217523.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] mmap/mmap12.c: new case to test MAP_POPULATE of
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
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 06/19/2013 08:00 PM, Jan Stancek wrote:
> 
> 
> 
> ----- Original Message -----
>> From: "DAN LI" <li.dan@cn.fujitsu.com>
>> To: "LTP list" <ltp-list@lists.sourceforge.net>
>> Sent: Wednesday, 19 June, 2013 8:52:43 AM
>> Subject: [LTP] [PATCH] mmap/mmap12.c: new case to test MAP_POPULATE of mmap
>>
>>
>> Create test case for MAP_POPULATE of mmap.
>>
>> Verify the following statement
>> "For a file mapping,this causes read-ahead on the file.
>>  Later accesses to the mapping will not be blocked by page faults."
>> by mmap-ing a file with specified size and checking change of memory size.
>>
>>
>> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> 
> Hi,
> 
> I think this isn't very reliable when you are low on free memory.
> I could get it to fail easily just by reading random data to fill cache:
> # free -m
>              total       used       free     shared    buffers     cached
> Mem:           994        704        289          0          0        525
> -/+ buffers/cache:        179        814
> Swap:         2015          0       2015
> 
> # ./mmap12 
> mmap12      1  TFAIL  :  Seems read-ahead do not work
> 
> 
> Dropping caches after you create test file might not be bad idea:
>   system("echo 1 > /proc/sys/vm/drop_caches");
> because I think sysinfo() sees that as used memory.
> And also making sure there is enough free mem (say 2x of testfile)

Maybe i could cut the length of the mapping, and as you suggested,
drop caches, check if there is enough free mem before testing,
to make it more reliable.

> 
> It's still approximate, but I'm not sure if there's better way,
> considering other options:
> reading /proc/pid/io for read_bytes
> reading /proc/pid/pagemap and checking that those pages are present

I'll try this first. :)

Regards,
DAN LI

> 
> Regards,
> Jan
> 
>> ---
>>  testcases/kernel/syscalls/mmap/mmap12.c | 163
>>  ++++++++++++++++++++++++++++++++
>>  1 file changed, 163 insertions(+)
>>  create mode 100644 testcases/kernel/syscalls/mmap/mmap12.c
>>
>> diff --git a/testcases/kernel/syscalls/mmap/mmap12.c
>> b/testcases/kernel/syscalls/mmap/mmap12.c
>> new file mode 100644
>> index 0000000..4092806
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/mmap/mmap12.c
>> @@ -0,0 +1,163 @@
>> +/*
>> + * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
>> + *
>> + * This program is free software;  you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> + * the GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program;  if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301
>> USA
>> + */
>> +
>> +/*
>> + * Test Description:
>> + *  Verify MAP_POPULATE works fine.
>> + *  "For a file mapping, this causes read-ahead on the file.
>> + *   Later accesses to the mapping will not be blocked by page faults"
>> + *
>> + * Expected Result:
>> + *  mmap() with MAP_POPULATE should succeed returning the address of the
>> + *  mapped region and this file has been read into RAM, so RAM should
>> + *  is reduced by at least size of file.
>> + */
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <sys/types.h>
>> +#include <errno.h>
>> +#include <unistd.h>
>> +#include <fcntl.h>
>> +#include <string.h>
>> +#include <signal.h>
>> +#include <stdint.h>
>> +#include <sys/stat.h>
>> +#include <sys/mman.h>
>> +#include <sys/shm.h>
>> +#include <sys/sysinfo.h>
>> +
>> +#include "test.h"
>> +#include "usctest.h"
>> +
>> +#define TEMPFILE	"mmapfile"
>> +#define MMAPSIZE	(400UL<<20)
>> +#define FLUCTUATION	(50UL<<20)
>> +
>> +char *TCID = "mmap12";
>> +int TST_TOTAL = 1;
>> +
>> +static char *addr;
>> +static int fildes;
>> +static struct sysinfo info;
>> +static unsigned long long freeram_before;
>> +static unsigned long long freeram_after;
>> +
>> +static void loop_setup(void);
>> +static void loop_cleanup(void);
>> +static void setup(void);
>> +static void cleanup(void);
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	int lc;
>> +	int ret = 0;
>> +	char *msg;
>> +
>> +	msg = parse_opts(argc, argv, NULL, NULL);
>> +	if (msg != NULL)
>> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>> +
>> +	setup();
>> +
>> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> +
>> +		tst_count = 0;
>> +
>> +		loop_setup();
>> +
>> +		errno = 0;
>> +		addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
>> +			    MAP_FILE | MAP_PRIVATE | MAP_POPULATE, fildes, 0);
>> +
>> +		if (addr == MAP_FAILED) {
>> +			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
>> +			continue;
>> +		}
>> +
>> +		if (STD_FUNCTIONAL_TEST) {
>> +			ret = sysinfo(&info);
>> +			if (ret != 0)
>> +				tst_brkm(TFAIL, cleanup, "sysinfo failed");
>> +			freeram_after =
>> +				(unsigned long long)info.freeram *
>> +				(unsigned long long)info.mem_unit;
>> +
>> +			if ((freeram_before - freeram_after) >=
>> +			    (MMAPSIZE - FLUCTUATION))
>> +				tst_resm(TPASS,
>> +					 "Functionality of mmap() successful");
>> +			else
>> +				tst_resm(TFAIL,
>> +					 "Seems read-ahead do not work");
>> +		}
>> +		loop_cleanup();
>> +	}
>> +
>> +	cleanup();
>> +	tst_exit();
>> +
>> +}
>> +
>> +static void loop_setup(void)
>> +{
>> +	int ret;
>> +
>> +	fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666);
>> +	if (fildes < 0)
>> +		tst_brkm(TFAIL, cleanup, "opening %s failed", TEMPFILE);
>> +
>> +
>> +	if (ftruncate(fildes, MMAPSIZE) < 0)
>> +		tst_brkm(TFAIL | TERRNO, cleanup, "ftruncate file failed");
>> +
>> +	ret = sysinfo(&info);
>> +	if (ret != 0)
>> +		tst_brkm(TFAIL, cleanup, "sysinfo failed");
>> +
>> +	freeram_before =
>> +		(unsigned long long)info.freeram *
>> +		(unsigned long long)info.mem_unit;
>> +}
>> +
>> +static void loop_cleanup(void)
>> +{
>> +	if (munmap(addr, MMAPSIZE) != 0)
>> +		tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
>> +
>> +	close(fildes);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	tst_sig(FORK, DEF_HANDLER, cleanup);
>> +
>> +	if ((tst_kvercmp(2, 6, 23)) < 0)
>> +		tst_brkm(TCONF, NULL,
>> +			"This test can only run on kernels that are 2.6.23 and "
>> +			"higher");
>> +
>> +	TEST_PAUSE;
>> +
>> +	tst_tmpdir();
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	TEST_CLEANUP;
>> +	tst_rmdir();
>> +}
>> --
>> 1.8.1
>>
>> ------------------------------------------------------------------------------
>> This SF.net email is sponsored by Windows:
>>
>> Build for Windows Store.
>>
>> http://p.sf.net/sfu/windows-dev2dev
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
> 



------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
