Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VnWOu-0002Mw-3s
	for ltp-list@lists.sourceforge.net; Mon, 02 Dec 2013 16:31:12 +0000
Date: Mon, 2 Dec 2013 17:30:40 +0100
From: chrubis@suse.cz
Message-ID: <20131202163040.GB13145@rei.suse.cz>
References: <1385638941.1520.6.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385638941.1520.6.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH 2/2] fallocate/fallocate02.c: add EFBIG
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> add error with EFBIG for fallocate(2)
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  runtest/syscalls                                  |  2 +-
>  testcases/kernel/syscalls/fallocate/fallocate02.c | 56 ++++++++++++++++++++++-
>  2 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 12bae10..5f112d3 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -150,7 +150,7 @@ faccessat01 faccessat01
>  
>  #fallocate test cases
>  fallocate01 fallocate01
> -fallocate02 fallocate02
> +fallocate02 fallocate02 -D DEVICE -T ext4

If ext4 filesystem is needed for the testt to run, the test should only
take the -D DEVICE argument and the fs type should be hardwired into the
test sources.

>  fallocate03 fallocate03
>  
>  #posix_fadvise test cases
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
> index f73ba8a..3e5fce9 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate02.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
> @@ -45,7 +45,7 @@
>   *	(Tests fallocate() for different test cases as reported in map page)
>   *
>   *	INPUT SPECIFICATIONS
> - *		No input needs to be specified
> + *		Need ext4 while run test with EFBIG
>   *		  fallocate() in-puts are specified through test_data
>   *
>   *	OUTPUT SPECIFICATIONS
> @@ -76,6 +76,7 @@
>  #include <fcntl.h>
>  #include <inttypes.h>
>  #include <sys/utsname.h>
> +#include <sys/mount.h>
>  
>  #include "test.h"
>  #include "usctest.h"
> @@ -91,16 +92,35 @@
>  #endif
>  
>  #define OFFSET			12
> +/*
> + * block_size is 1024, then the maximum file size is MAX_FILE * block_size: 4T
> + * block_size is 4096, then the maximum file size is MAX_FILE * block_size: 16T
> + */
> +#define MAX_FILE		(4L*1024*1024*1024)
> +#define DIR_MODE		(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
> +				 S_IXGRP|S_IROTH|S_IXOTH)
>  
>  static void setup(void);
>  static void cleanup(void);
>  static inline long fallocate(int, int, loff_t, loff_t);
> +static void help(void);
>  
>  static char fnamew[255];
>  static char fnamer[255];
>  static int fdw;
>  static int fdr;
>  static int block_size;
> +/* Use ext4 default to test EFBIG */
> +static char *fstype = "ext4";
> +static char *device;
> +static int dflag;
> +static int mount_flag;
> +
> +static option_t options[] = {
> +	{"T:", NULL, &fstype},
> +	{"D:", &dflag, &device},
> +	{NULL, NULL, NULL}
> +};
>  
>  static struct test_data_t {
>  	int *fd;
> @@ -117,6 +137,8 @@ static struct test_data_t {
>  	{&fdw, fnamew, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, -1, EINVAL},
>  	{&fdw, fnamew, DEFAULT_TEST_MODE, -(BLOCKS_WRITTEN+OFFSET), 1, EINVAL},
>  	{&fdw, fnamew, DEFAULT_TEST_MODE, BLOCKS_WRITTEN-OFFSET, 1, 0},
> +	{&fdw, fnamew, DEFAULT_TEST_MODE, MAX_FILE, 1, EFBIG},
> +	{&fdw, fnamew, DEFAULT_TEST_MODE, 0, MAX_FILE, EFBIG},
>  };
>  
>  char *TCID = "fallocate02";
> @@ -128,10 +150,17 @@ int main(int ac, char **av)
>  	int i;
>  	char *msg;
>  
> -	msg = parse_opts(ac, av, NULL, NULL);
> +	msg = parse_opts(ac, av, options, help);
>  	if (msg != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
> +
> +	/* Check for mandatory option of the testcase */
> +	if (!dflag) {
> +		tst_brkm(TBROK, NULL,
> +			 "you must specify the device used for mounting with "
> +			 "-D option");
> +	}
>  	setup();
>  
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
> @@ -190,6 +219,17 @@ static void setup(void)
>  
>  	sprintf(fnamew, "tfile_write_%d", getpid());
>  
> +	tst_mkfs(NULL, device, fstype, NULL);
> +	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
> +	if (mount(device, "mntpoint", fstype, 0, NULL) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "mount device:%s failed", device);
> +	}
> +	mount_flag = 1;
> +
> +	sprintf(fnamer, "mntpoint/tfile_read_%d", getpid());
> +	sprintf(fnamew, "mntpoint/tfile_write_%d", getpid());
> +
>  	fdr = SAFE_OPEN(cleanup, fnamer, O_RDONLY | O_CREAT, S_IRUSR);
>  
>  	fdw = SAFE_OPEN(cleanup, fnamew, O_RDWR | O_CREAT, S_IRWXU);

So all the tests are run on the loopback ext4 fs?

Were they running fine on other filesystems before?

> @@ -221,5 +261,17 @@ static void cleanup(void)
>  
>  	SAFE_CLOSE(NULL, fdr);
>  
> +	if (mount_flag && umount("mntpoint") < 0) {
> +		tst_brkm(TBROK | TERRNO, NULL,
> +			 "umount device:%s failed", device);
> +	}
> +
>  	tst_rmdir();
>  }
> +
> +static void help(void)
> +{
> +	printf("-T type : specifies the type of filesystem to be mounted. "
> +	       "Default ext4.\n");
> +	printf("-D device : device used for mounting.\n");
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
