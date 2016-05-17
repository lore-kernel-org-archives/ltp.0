From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 May 2016 17:21:48 +0200
Subject: [LTP] [PATCH 1/6] syscalls/madvise01: Convert to new test API
In-Reply-To: <1463042993-398-1-git-send-email-liwang@redhat.com>
References: <1463042993-398-1-git-send-email-liwang@redhat.com>
Message-ID: <20160517152148.GA13705@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -32,107 +32,79 @@
>  #include <string.h>
>  #include <unistd.h>
>  
> -#include "test.h"
> +#include "tst_test.h"
>  
> -static void setup(void);
> -static void cleanup(void);
> -static void check_and_print(char *advice);
> +static char filename[64];
>  
> -char *TCID = "madvise01";
> -int TST_TOTAL = 5;
> +static void setup(void)
> +{
> +	sprintf(filename, "madvise01.%d", getpid());
> +}
>  
> -int main(int argc, char *argv[])
> +static void check_and_print(char *advice)
> +{
> +	if (TEST_RETURN == -1)
> +		tst_res(TFAIL | TTERRNO, "madvise test for %s failed", advice);
> +	else
> +		tst_res(TPASS, "madvise test for %s PASSED", advice);
> +}
> +
> +static void verify_madvise(void)
>  {
> -	int lc, fd;
>  	int i = 0;
> +	int fd;
>  	char *file = NULL;
>  	struct stat stat;
> -	char filename[64];
> -	char *progname = NULL;
>  	char *str_for_file = "abcdefghijklmnopqrstuvwxyz12345\n";
>  
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
> +	fd = open(filename, O_RDWR | O_CREAT, 0664);
> +	if (fd < 0)
> +		tst_brk(TBROK | TERRNO, "open failed");

SAFE_OPEN()

>  #ifdef DEBUG
> -		tst_resm(TINFO, "filename = %s opened successfully", filename);
> +	tst_res(TINFO, "filename = %s opened successfully", filename);
>  #endif
>  
> -		/* Writing 40 KB of random data into this file
> -		   [32 * 1280 = 40960] */
> -		for (i = 0; i < 1280; i++)
> -			if (write(fd, str_for_file, strlen(str_for_file)) == -1)
> -				tst_brkm(TBROK | TERRNO, cleanup,
> -					 "write failed");
> -
> -		if (fstat(fd, &stat) == -1)
> -			tst_brkm(TBROK, cleanup, "fstat failed");
> -
> -		/* Map the input file into memory */
> -		file = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
> -		if (file == MAP_FAILED)
> -			tst_brkm(TBROK, cleanup, "mmap failed");
> +	/* Writing 40 KB of random data into this file
> +	   [32 * 1280 = 40960] */
> +	for (i = 0; i < 1280; i++)
> +		if (write(fd, str_for_file, strlen(str_for_file)) == -1)
> +			tst_brk(TBROK | TERRNO, "write failed");

SAFE_WRITE()

> -		/* (1) Test case for MADV_NORMAL */
> -		TEST(madvise(file, stat.st_size, MADV_NORMAL));
> -		check_and_print("MADV_NORMAL");
> +	if (fstat(fd, &stat) == -1)
> +		tst_brk(TBROK, "fstat failed");

SAFE_STAT()

> -		/* (2) Test case for MADV_RANDOM */
> -		TEST(madvise(file, stat.st_size, MADV_RANDOM));
> -		check_and_print("MADV_RANDOM");
> +	/* Map the input file into memory */
> +	file = SAFE_MMAP(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);

SAFE_MMAP()


Moreover the whole intialization up to this point should be done in
setup().

> -		/* (3) Test case for MADV_SEQUENTIAL */
> -		TEST(madvise(file, stat.st_size, MADV_SEQUENTIAL));
> -		check_and_print("MADV_SEQUENTIAL");
> +	/* (1) Test case for MADV_NORMAL */
> +	TEST(madvise(file, stat.st_size, MADV_NORMAL));
> +	check_and_print("MADV_NORMAL");
>  
> -		/* (4) Test case for MADV_WILLNEED */
> -		TEST(madvise(file, stat.st_size, MADV_WILLNEED));
> -		check_and_print("MADV_WILLNEED");
> +	/* (2) Test case for MADV_RANDOM */
> +	TEST(madvise(file, stat.st_size, MADV_RANDOM));
> +	check_and_print("MADV_RANDOM");
>  
> -		/* (5) Test case for MADV_DONTNEED */
> -		TEST(madvise(file, stat.st_size, MADV_DONTNEED));
> -		check_and_print("MADV_DONTNEED");
> +	/* (3) Test case for MADV_SEQUENTIAL */
> +	TEST(madvise(file, stat.st_size, MADV_SEQUENTIAL));
> +	check_and_print("MADV_SEQUENTIAL");
>  
> -		if (munmap(file, stat.st_size) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "munmap failed");
> +	/* (4) Test case for MADV_WILLNEED */
> +	TEST(madvise(file, stat.st_size, MADV_WILLNEED));
> +	check_and_print("MADV_WILLNEED");
>  
> -		close(fd);
> -	}
> +	/* (5) Test case for MADV_DONTNEED */
> +	TEST(madvise(file, stat.st_size, MADV_DONTNEED));
> +	check_and_print("MADV_DONTNEED");

This can be easily converted to an array of structures describing the
test and exported as separate tests in the struct tst_test

> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void setup(void)
> -{
> +	if (munmap(file, stat.st_size) == -1)
> +		tst_brk(TBROK | TERRNO, "munmap failed");

The munmap() should rather be done in cleanup but only if the file has
been mmaped().

> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> +	close(fd);

The fd can be closed right after the mmap().

>  }
>  
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -
> -}
> -
> -static void check_and_print(char *advice)
> -{
> -	if (TEST_RETURN == -1)
> -		tst_resm(TFAIL | TTERRNO, "madvise test for %s failed", advice);
> -	else
> -		tst_resm(TPASS, "madvise test for %s PASSED", advice);
> -}
> +static struct tst_test test = {
> +	.tid = "madvise01",
> +	.test_all = verify_madvise,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +};
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
