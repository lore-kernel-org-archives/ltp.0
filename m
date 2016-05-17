From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 May 2016 18:20:55 +0200
Subject: [LTP] [PATCH 3/6] syscalls/madvise03: Convert to new test API
In-Reply-To: <1463042993-398-3-git-send-email-liwang@redhat.com>
References: <1463042993-398-1-git-send-email-liwang@redhat.com>
 <1463042993-398-2-git-send-email-liwang@redhat.com>
 <1463042993-398-3-git-send-email-liwang@redhat.com>
Message-ID: <20160517162054.GC13705@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/madvise/madvise03.c b/testcases/kernel/syscalls/madvise/madvise03.c
> index 3da2bb2..b414e89 100644
> --- a/testcases/kernel/syscalls/madvise/madvise03.c
> +++ b/testcases/kernel/syscalls/madvise/madvise03.c
> @@ -32,151 +32,121 @@
>  #include <string.h>
>  #include <unistd.h>
>  
> -#include "test.h"
> -
> -char *TCID = "madvise03";
> +#include "tst_test.h"
>  
>  #ifdef MADV_REMOVE

Just remove this ifdef and add a fallback MADV_REMOVE definition
into the include/lapi/mmap.h instead.

> -int TST_TOTAL = 3;
> -
> -static void setup(void);
> -static void cleanup(void);
> -static void check_and_print(char *advice);
> -static long get_shmmax(void);
>  
> +static char filename[64];
>  static int shmid1;
>  
> -int main(int argc, char *argv[])
> +static void setup(void)
> +{
> +	sprintf(filename, "madvise03.%d", getpid());
> +}
> +
> +static void check_and_print(char *advice)
> +{
> +	if (TEST_RETURN == -1) {
> +		if (TEST_ERRNO == ENOTSUP && !strcmp(advice, "MADV_REMOVE")) {
> +			tst_res(TCONF, "madvise MADV_REMOVE returned ENOTSUP"
> +				 " CONFIG_TMPFS=y not in kernel .config?");
> +			return;
> +		}
> +		tst_res(TFAIL,
> +			 "madvise test for %s failed with "
> +			 "return = %ld, errno = %d : %s",
> +			 advice, TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
> +	} else {
> +		tst_res(TPASS, "madvise test for %s PASSED", advice);
> +	}
> +}
> +
> +static long get_shmmax(void)
> +{
> +	long maxsize;
> +
> +	SAFE_FILE_SCANF("/proc/sys/kernel/shmmax", "%ld", &maxsize);
> +
> +	return maxsize;
> +}
> +
> +static void verify_madvise(void)
>  {
> -	int lc, fd;
> -	int i;
> +	int i, fd;
>  	char *file = NULL;
>  	struct stat stat;
>  	void *addr1;
>  	long shm_size = 0;
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
> -			tst_brkm(TBROK, cleanup, "open failed");
> +	fd = open(filename, O_RDWR | O_CREAT, 0664);
> +	if (fd < 0)
> +		tst_brk(TBROK, "open failed");
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
> +	/* Writing 40 KB of random data into this file
> +	   [32 * 1280 = 40960] */
> +	for (i = 0; i < 1280; i++)
> +		if (write(fd, str_for_file, strlen(str_for_file)) == -1)
> +			tst_brk(TBROK | TERRNO, "write failed");
>  
> -		if (fstat(fd, &stat) == -1)
> -			tst_brkm(TBROK, cleanup, "fstat failed");
> +	if (fstat(fd, &stat) == -1)
> +		tst_brk(TBROK, "fstat failed");
>  
> -		file = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
> -		if (file == MAP_FAILED)
> -			tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
> +	file = SAFE_MMAP(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
>  
> -		/* Allocate shared memory segment */
> -		shm_size = get_shmmax();
> +	/* Allocate shared memory segment */
> +	shm_size = get_shmmax();
>  
>  #define min(a, b) ((a) < (b) ? @ : (b))
> -		shmid1 = shmget(IPC_PRIVATE, min(1024 * 1024, shm_size),
> -				IPC_CREAT | IPC_EXCL | 0701);
> -		if (shmid1 == -1)
> -			tst_brkm(TBROK, cleanup, "shmget failed");
> +	shmid1 = shmget(IPC_PRIVATE, min(1024 * 1024, shm_size),
> +			IPC_CREAT | IPC_EXCL | 0701);
> +	if (shmid1 == -1)
> +		tst_brk(TBROK, "shmget failed");
>  
> -		/* Attach shared memory segment to an address selected by the system */
> -		addr1 = shmat(shmid1, NULL, 0);
> -		if (addr1 == (void *)-1)
> -			tst_brkm(TBROK, cleanup, "shmat error");
> +	/* Attach shared memory segment to an address selected by the system */
> +	addr1 = shmat(shmid1, NULL, 0);
> +	if (addr1 == (void *)-1)
> +		tst_brk(TBROK, "shmat error");
>  
> -		/* (1) Test case for MADV_REMOVE */
> -		TEST(madvise(addr1, 4096, MADV_REMOVE));
> -		check_and_print("MADV_REMOVE");
> +	/* (1) Test case for MADV_REMOVE */
> +	TEST(madvise(addr1, 4096, MADV_REMOVE));
> +	check_and_print("MADV_REMOVE");

You don't need the shm memory for MADV_REMOVE, just mapping mapped
PROT_WRITE as well.

> -		/* (2) Test case for MADV_DONTFORK */
> -		TEST(madvise(file, (stat.st_size / 2), MADV_DONTFORK));
> -		check_and_print("MADV_DONTFORK");
> +	/* (2) Test case for MADV_DONTFORK */
> +	TEST(madvise(file, (stat.st_size / 2), MADV_DONTFORK));
> +	check_and_print("MADV_DONTFORK");
>  
> -		/* (3) Test case for MADV_DOFORK */
> -		TEST(madvise(file, (stat.st_size / 2), MADV_DOFORK));
> -		check_and_print("MADV_DOFORK");
> +	/* (3) Test case for MADV_DOFORK */
> +	TEST(madvise(file, (stat.st_size / 2), MADV_DOFORK));
> +	check_and_print("MADV_DOFORK");
>  
> -		/* Finally Unmapping the whole file */
> -		if (munmap(file, stat.st_size) < 0)
> -			tst_brkm(TBROK | TERRNO, cleanup, "munmap failed");
> +	/* Finally Unmapping the whole file */
> +	SAFE_MUNMAP(file, stat.st_size);
>  
> -		close(fd);
> -	}

I also wonder if these testcases could be moved to madvise01.

-- 
Cyril Hrubis
chrubis@suse.cz
