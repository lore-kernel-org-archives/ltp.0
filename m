From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 May 2016 15:32:26 +0200
Subject: [LTP] [PATCH v2 2/3] syscalls/madvise01: reconstruct and
 convert to new API
In-Reply-To: <1463979548-21374-1-git-send-email-liwang@redhat.com>
References: <1463979548-21374-1-git-send-email-liwang@redhat.com>
Message-ID: <20160523133226.GA25488@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include "tst_test.h"
> +#include "tst_kvercmp.h"
> +#include "lapi/mmap.h"
> +
> +#define KSM_SYS_DIR "/sys/kernel/mm/ksm"
> +#define STR "abcdefghijklmnopqrstuvwxyz12345\n"
> +
> +static struct stat st;
> +static char *sfile;
> +static char *pfile;
> +static char  filename[64];
> +
> +static struct {
> +	int advice;
> +	char *name;
> +	char *addr;
> +	int   flag;
> +} advice_opt[] = {
> +	{MADV_NORMAL,      "MADV_NORMAL",      NULL, 1},
> +	{MADV_RANDOM,      "MADV_RANDOM",      NULL, 1},
> +	{MADV_SEQUENTIAL,  "MADV_SEQUENTIAL",  NULL, 1},
> +	{MADV_WILLNEED,    "MADV_WILLNEED",    NULL, 1},
> +	{MADV_DONTNEED,    "MADV_DONTNEED",    NULL, 1},
> +	{MADV_REMOVE,      "MADV_REMOVE",      NULL, 1}, /* since Linux 2.6.16 */
> +	{MADV_DONTFORK,    "MADV_DONTFORK",    NULL, 1}, /* since Linux 2.6.16 */
> +	{MADV_DOFORK,      "MADV_DOFORK",      NULL, 1}, /* since Linux 2.6.16 */
> +	{MADV_HWPOISON,    "MADV_HWPOISON",    NULL, 1}, /* since Linux 2.6.32 */
> +	{MADV_MERGEABLE,   "MADV_MERGEABLE",   NULL, 1}, /* since Linux 2.6.32 */
> +	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", NULL, 1}, /* since Linux 2.6.32 */
> +	{MADV_HUGEPAGE,    "MADV_HUGEPAGE",    NULL, 1}, /* since Linux 2.6.38 */
> +	{MADV_NOHUGEPAGE,  "MADV_NOHUGEPAGE",  NULL, 1}, /* since Linux 2.6.38 */
> +	{MADV_DONTDUMP,    "MADV_DONTDUMP",    NULL, 1}, /* since Linux 3.4 */
> +	{MADV_DODUMP,      "MADV_DODUMP",      NULL, 1}  /* since Linux 3.4 */
> +};
> +
> +static void advice_filter(void)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(advice_opt); i++) {
> +		advice_opt[i].addr = sfile;
> +
> +		switch (advice_opt[i].advice) {
> +		case MADV_REMOVE:
> +		case MADV_DONTFORK:
> +		case MADV_DOFORK:
> +			if ((tst_kvercmp(2, 6, 16)) < 0)
> +				advice_opt[i].flag = 0;
> +			break;
> +
> +		case MADV_HWPOISON:
> +			if ((tst_kvercmp(2, 6, 32)) < 0)
> +				advice_opt[i].flag = 0;
> +			break;
> +
> +		case MADV_MERGEABLE:
> +		case MADV_UNMERGEABLE:
> +			if ((tst_kvercmp(2, 6, 32)) < 0)
> +				advice_opt[i].flag = 0;
> +			/* kernel not configured with CONFIG_KSM, skip
> +			 * test for MADV_MERGEABLE, MADV_UNMERGEABLE */
> +			if (access(KSM_SYS_DIR, F_OK) != 0)
> +				advice_opt[i].flag = 0;
> +			break;
> +
> +		case MADV_HUGEPAGE:
> +		case MADV_NOHUGEPAGE:
> +			/* MADV_HUGEPAGE only works with private
> +			 * anonymous pages */
> +			advice_opt[i].addr = pfile;
> +			if ((tst_kvercmp(2, 6, 38)) < 0)
> +				advice_opt[i].flag = 0;
> +			break;
> +
> +		case MADV_DONTDUMP:
> +		case MADV_DODUMP:
> +			if ((tst_kvercmp(3, 4, 0)) < 0)
> +				advice_opt[i].flag = 0;
> +			break;
> +
> +		default:
> +			break;
> +		}
> +	}
> +}

We should get EINVAL in case that the particular madvice() flag is not
supported. It should be far easier to check for EINVAL in the test
function instead of having a filter function.

> -int main(int argc, char *argv[])
> +static void setup(void)
>  {
> -	int lc, fd;
>  	int i = 0;
> -	char *file = NULL;
> -	struct stat stat;
> -	char filename[64];
> -	char *progname = NULL;
> -	char *str_for_file = "abcdefghijklmnopqrstuvwxyz12345\n";
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	progname = *argv;
> -	sprintf(filename, "%s-out.%d", progname, getpid());
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		fd = open(filename, O_RDWR | O_CREAT, 0664);
> -		if (fd < 0)
> -			tst_brkm(TBROK | TERRNO, cleanup, "open failed");
> -#ifdef DEBUG
> -		tst_resm(TINFO, "filename = %s opened successfully", filename);
> -#endif
> -
> -		/* Writing 40 KB of random data into this file
> -		   [32 * 1280 = 40960] */
> -		for (i = 0; i < 1280; i++)
> -			if (write(fd, str_for_file, strlen(str_for_file)) == -1)
> -				tst_brkm(TBROK | TERRNO, cleanup,
> -					 "write failed");
> -
> -		if (fstat(fd, &stat) == -1)
> -			tst_brkm(TBROK, cleanup, "fstat failed");
> +	int fd;
>  
> -		/* Map the input file into memory */
> -		file = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
> -		if (file == MAP_FAILED)
> -			tst_brkm(TBROK, cleanup, "mmap failed");
> +	SAFE_MKDIR("/mnt/tmp_madvise", 0664);
> +	SAFE_MOUNT("tmp_madvise", "/mnt/tmp_madvise", "tmpfs", 0, NULL);

The test must not create files outside its test directory and so it
should mount the tmpfs with a relative path (so that it's mounted inside
of the test directory).

> -		/* (1) Test case for MADV_NORMAL */
> -		TEST(madvise(file, stat.st_size, MADV_NORMAL));
> -		check_and_print("MADV_NORMAL");
> +	sprintf(filename, "/mnt/tmp_madvise/madvise01.%d", getpid());
> +	fd = SAFE_OPEN(filename, O_RDWR | O_CREAT, 0664);

And once the test works with the files only in it's temporary directory
there is no need to create unique file names, the directory filename is
unique allready.

> -		/* (2) Test case for MADV_RANDOM */
> -		TEST(madvise(file, stat.st_size, MADV_RANDOM));
> -		check_and_print("MADV_RANDOM");
> +	/* Writing 40 KB of random data into this file [32 * 1280 = 40960] */
> +	for (i = 0; i < 1280; i++)
> +		SAFE_WRITE(1, fd, STR, strlen(STR));
>  
> -		/* (3) Test case for MADV_SEQUENTIAL */
> -		TEST(madvise(file, stat.st_size, MADV_SEQUENTIAL));
> -		check_and_print("MADV_SEQUENTIAL");
> +	SAFE_FSTAT(fd, &st);
>  
> -		/* (4) Test case for MADV_WILLNEED */
> -		TEST(madvise(file, stat.st_size, MADV_WILLNEED));
> -		check_and_print("MADV_WILLNEED");
> +	/* Map the input file into shared memory */
> +	sfile = SAFE_MMAP(NULL, st.st_size,
> +			PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>  
> -		/* (5) Test case for MADV_DONTNEED */
> -		TEST(madvise(file, stat.st_size, MADV_DONTNEED));
> -		check_and_print("MADV_DONTNEED");
> +	/* Map the input file into private memory */
> +	pfile = SAFE_MMAP(NULL, st.st_size,
> +			PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, fd, 0);
> +	close(fd);

SAFE_CLOSE(fd);

> -		if (munmap(file, stat.st_size) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "munmap failed");
> -
> -		close(fd);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	advice_filter();
>  }
>  
> -static void setup(void)
> +static void cleanup(void)
>  {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> +	SAFE_MUNMAP(sfile, st.st_size);
> +	SAFE_MUNMAP(pfile, st.st_size);
> +	SAFE_UMOUNT("/mnt/tmp_madvise");
> +	SAFE_RMDIR("/mnt/tmp_madvise");

You are using SAFE_MACROS in the setup therefore the cleanup may be
invoked at any point of the initialization and because of that the
cleanup should only cleanup what has been initalized (only if pointers
are non-NULL, etc.).

Also using SAFE_MACROS() in cleanup is not allowed since failure will
exit the cleanup prematurely.

>  }
>  
> -static void cleanup(void)
> +static void check_and_print(char *advice)
>  {
> -	tst_rmdir();
> -
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL, "madvise test for %s failed with "
> +				"return = %ld, errno = %d : %s",
> +				advice, TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));

No strerror() in the testcases, use tst_strerrno() instead. Also
TEST_ERRNO should be printed as TFAIL | TTERRNO.

> +	} else
> +		tst_res(TPASS, "madvise test for %s PASSED", advice);
>  }

Now that the test function is only one and only a few lines long there
is absolutely no reason to have separate check_and_print() function.
Just put this code into the madvise_test() function directly.

> -static void check_and_print(char *advice)
> +static void madvise_test(unsigned int nr)
>  {
> -	if (TEST_RETURN == -1)
> -		tst_resm(TFAIL | TTERRNO, "madvise test for %s failed", advice);
> -	else
> -		tst_resm(TPASS, "madvise test for %s PASSED", advice);
> +	if (advice_opt[nr].flag == 1) {
> +		TEST(madvise(advice_opt[nr].addr, st.st_size, advice_opt[nr].advice));
> +		check_and_print(advice_opt[nr].name);

It's much easier to get a pointer to the particular test structure
instead of using an index to the array all the time, i.e.:

struct tcase *tc = &tcases[i];

TEST(madvise(tc->addr, st.st_size, tc->advice));

> +	} else
> +		tst_res(TCONF, "%s is not supported", advice_opt[nr].name);
>  }
> +
> +static struct tst_test test = {
> +	.tid = "madvise01",
> +	.tcnt = ARRAY_SIZE(advice_opt),
> +	.test = madvise_test,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

-- 
Cyril Hrubis
chrubis@suse.cz
