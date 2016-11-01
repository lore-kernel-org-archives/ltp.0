From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 1 Nov 2016 12:26:15 +0800
Subject: [LTP] [PATCH 3/3] syscalls/umask03: Cleanup && Convert to new
 API
In-Reply-To: <20161031114002.GI30590@rei.lan>
References: <1477882478-30693-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1477882478-30693-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20161031114002.GI30590@rei.lan>
Message-ID: <58181967.9070700@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Thanks for your review.

On 10/31/2016 07:40 PM, Cyril Hrubis wrote:
> On Mon, Oct 31, 2016 at 10:54:38AM +0800, Guangwen Feng wrote:
>> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
>> ---
>>  testcases/kernel/syscalls/umask/umask03.c | 172 +++++++++---------------------
>>  1 file changed, 48 insertions(+), 124 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/umask/umask03.c b/testcases/kernel/syscalls/umask/umask03.c
>> index e10009c..30c28ca 100644
>> --- a/testcases/kernel/syscalls/umask/umask03.c
>> +++ b/testcases/kernel/syscalls/umask/umask03.c
>> @@ -1,155 +1,79 @@
>>  /*
>> + * Copyright (c) International Business Machines  Corp., 2001
>> + *  07/2001 Ported by John George
>>   *
>> - *   Copyright (c) International Business Machines  Corp., 2001
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>>   *
>> - *   This program is free software;  you can redistribute it and/or modify
>> - *   it under the terms of the GNU General Public License as published by
>> - *   the Free Software Foundation; either version 2 of the License, or
>> - *   (at your option) any later version.
>> + * This program is distributed in the hope that it would be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> + * the GNU General Public License for more details.
>>   *
>> - *   This program is distributed in the hope that it will be useful,
>> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> - *   the GNU General Public License for more details.
>> - *
>> - *   You should have received a copy of the GNU General Public License
>> - *   along with this program;  if not, write to the Free Software
>> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write the Free Software Foundation,
>> + * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>   */
>>  
>>  /*
>> - * NAME
>> - *	umask03.c
>> - *
>> - * DESCRIPTION
>> - *	Check that umask changes the mask, and that the previous
>> - *	value of the mask is returned correctly for each value.
>> - *
>> - * ALGORITHM
>> - *	For each mask value (9 bits) set mask, and check that the return
>> - *	corresponds to the previous value set.
>> - *
>> - * USAGE:  <for command-line>
>> - *		umask03 [-c n] [-i n] [-I x] [-P x] [-t]
>> - *		where,  -c n : Run n copies concurrently.
>> - *			-i n : Execute test n times.
>> - *			-I x : Execute test for x seconds.
>> - *			-P x : Pause for x seconds between iterations.
>> - *			-t   : Turn on syscall timing.
>> - *
>> - * History
>> - *	07/2001 John George
>> - *		-Ported
>> - *
>> - * Restrictions
>> - *	None
>> + * umask(2) sets the mask from 0000 to 0777 while we create files,
>> + * then the file mode should be correct for each creation mask.
>>   */
>>  
>> -#include <sys/types.h>
>> -#include <sys/stat.h>
>> -#include <fcntl.h>
>> +#include <errno.h>
>>  #include <stdio.h>
>> -#include "test.h"
>>  #include <sys/types.h>
>>  #include <sys/stat.h>
>> +#include "tst_test.h"
>>  
>> -char *TCID = "umask03";
>> -int TST_TOTAL = 1;
>> -
>> -char filname[40];
>> -
>> -void setup(void);
>> -void cleanup(void);
>> +static char filename[40];
>>  
>> -int main(int argc, char **argv)
>> +static void verify_umask(void)
>>  {
>> -	int lc;
>> -
>>  	struct stat statbuf;
>> -	int mskval = 0000;
>> -	int failcnt = 0;
>> -	int fildes, i;
>> +	int mskval;
>> +	int fd;
>> +	int failflag = 0;
>>  	unsigned low9mode;
>>  
>> -	tst_parse_opts(argc, argv, NULL, NULL);
>> +	for (mskval = 0000; mskval < 01000; mskval++) {
>> +		TEST(umask(mskval));
>> +		if (TEST_RETURN < 0) {
>> +			tst_res(TFAIL | TTERRNO,
>> +				"umask(%o) failed unexpectedly", mskval);
>> +			return;
>> +		}
> 
> Here as well.
> 
>> -	setup();		/* global setup */
>> +		fd = SAFE_CREAT(filename, 0777);
>> +		SAFE_CLOSE(fd);
>>  
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> +		SAFE_STAT(filename, &statbuf);
>>  
>> -		/* reset tst_count in case we are looping */
>> -		tst_count = 0;
>> +		low9mode = statbuf.st_mode & 0777;
>>  
>> -		for (umask(mskval = 0077), i = 1; mskval < 01000;
>> -		     i++, umask(++mskval)) {
>> -			unlink(filname);
>> -			if ((fildes = creat(filname, 0777)) == -1) {
>> -				tst_resm(TBROK, "cannot create "
>> -					 "file with mskval 0%o %d",
>> -					 mskval, mskval);
>> -			} else {
>> -				if (fstat(fildes, &statbuf) != 0) {
>> -					tst_resm(TBROK, "cannot fstat file");
>> -				} else {
>> -					low9mode = statbuf.st_mode & 0777;
>> -					if (low9mode != (~mskval & 0777)) {
>> -						tst_resm(TFAIL,
>> -							 "got %o expected %o"
>> -							 "mask didnot take",
>> -							 low9mode,
>> -							 (~mskval & 0777));
>> -					}
>> -				}
> 
> Hmm, so this test is just the same as umask02 but tries to create the
> file as well.
> 
> What about we remove umask01.c and umask02.c and rename umask03.c to
> umask01.c?
> 
> It's not like umask01.c or umask02.c adds any more value since umask03.c
> is superset of these.
> 

I think it's a little bit different between umask02 and umask03, manual page
says that umask(2) returns the previous value of the mask, and this is only
checked in umask02.

So what about we just remove umask01.c and rename umask02.c and umask03.c to
umask01.c and umask02.c?

Best Regards,
Guangwen Feng

>>  
>> -/*
>> - * setup
>> - *	performs all ONE TIME setup for this test
>> - */
>>  void setup(void)
>>  {
>> -
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -
>> -	/* Pause if that option was specified
>> -	 * TEST_PAUSE contains the code to fork the test with the -i option.
>> -	 * You want to make sure you do this before you create your temporary
>> -	 * directory.
>> -	 */
>> -	TEST_PAUSE;
>> -
>> -	/* make temp dir and cd to it */
>> -	tst_tmpdir();
>> -
>> -	sprintf(filname, "umask2.%d", getpid());
>> +	sprintf(filename, "umask03.%d", getpid());
> 
> The test runs in unique temporary directory, there is no need for trying
> to create unique filename.
> 
>>  }
>>  
>> -/*
>> - * cleanup
>> - *	performs all ONE TIME cleanup for this test at completion or
>> - *	premature exit
>> - */
>> -void cleanup(void)
>> -{
>> -
>> -	/*
>> -	 * cleanup the temporary files and the temporary directory
>> -	 */
>> -	unlink(filname);
>> -	tst_rmdir();
>> -
>> -	/*
>> -	 * exit with return code appropriate for results
>> -	 */
>> -
>> -}
>> +static struct tst_test test = {
>> +	.tid = "umask03",
>> +	.needs_tmpdir = 1,
>> +	.setup = setup,
>> +	.test_all = verify_umask,
>> +};
>> -- 
>> 1.8.4.2
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 


