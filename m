From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 17 Aug 2017 14:43:27 +0800
Subject: [LTP] [PATCH] hugemmap/hugemmap05.c: cleanup && fix warnings
	and failures
In-Reply-To: <1502779256-13518-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1502779256-13518-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <59953B0F.6040501@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I find there is something wrong with this patch, please ignore it, i
will send v2 patch.

Thanks,
Xiao Yang.
On 2017/08/15 14:40, Xiao Yang wrote:
> 1) take use of safe macros
> 2) add missing check_hugepage()
> 3) fix warnings on system which doesn't support hugepages
> 4) fix failures caused by hugemmap05 -m -i n
>
> We can get the following warnings on RHEL5.11GA:
>    hugemmap05.c:263: CONF: file /proc/sys/vm/nr_overcommit_hugepages does not exist in the system
>    hugemmap05.c:209: INFO: restore nr_hugepages to .
>    hugemmap05.c:217: WARN: open: ENOENT
>    hugemmap05.c:219: INFO: restore nr_overcommit_hugepages to .
>    hugemmap05.c:222: WARN: write: EBADF
>    hugemmap05.c:228: WARN: umount: ENOENT
>
> We can get the following failures when running hugemmap05 -m -i n:
>    hugemmap05.c:191: PASS: hugepages overcommit test pass
>    hugemmap05.c:118: INFO: check sysfs before allocation.
>    hugemmap05.c:378: INFO: HugePages_Total is 192.
>    hugemmap05.c:378: INFO: HugePages_Free is 0.
>    hugemmap05.c:381: FAIL: HugePages_Free is not 192 but 0.
>    hugemmap05.c:118: INFO: check sysfs before allocation.
>    hugemmap05.c:378: INFO: HugePages_Total is 192.
>    hugemmap05.c:378: INFO: HugePages_Free is 0.
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c | 364 ++++++++-------------
>  1 file changed, 134 insertions(+), 230 deletions(-)
>
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> index 7be7efb..2764106 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> @@ -26,20 +26,23 @@
>   * them by mmap or shmget.
>   */
>  
> -#include <sys/mount.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdio.h>
>  #include "mem.h"
>  #include "hugetlb.h"
> -#include "tst_safe_stdio.h"
> +#include "tst_safe_sysv_ipc.h"
> +#include "tst_test.h"
>  
>  #define PROTECTION		(PROT_READ | PROT_WRITE)
>  #define PATH_MEMINFO		"/proc/meminfo"
>  
> -char path_sys_sz[BUFSIZ];
> -char path_sys_sz_over[BUFSIZ];
> -char path_sys_sz_free[BUFSIZ];
> -char path_sys_sz_resv[BUFSIZ];
> -char path_sys_sz_surp[BUFSIZ];
> -char path_sys_sz_huge[BUFSIZ];
> +static char path_sys_sz[BUFSIZ];
> +static char path_sys_sz_over[BUFSIZ];
> +static char path_sys_sz_free[BUFSIZ];
> +static char path_sys_sz_resv[BUFSIZ];
> +static char path_sys_sz_surp[BUFSIZ];
> +static char path_sys_sz_huge[BUFSIZ];
>  
>  #define PATH_PROC_VM		"/proc/sys/vm/"
>  #define PATH_PROC_OVER		PATH_PROC_VM "nr_overcommit_hugepages"
> @@ -61,12 +64,10 @@ char path_sys_sz_huge[BUFSIZ];
>  #define SHM_HUGETLB 04000
>  #endif
>  
> -static char nr_hugepages[BUFSIZ], nr_overcommit_hugepages[BUFSIZ];
> -static char buf[BUFSIZ], line[BUFSIZ], path[BUFSIZ], pathover[BUFSIZ];
> -static char shmmax[BUFSIZ];
> -static int hugepagesize;	/* in Bytes */
> -static int shmid = -1;
> -static int restore_shmmax;
> +static long shmmax, hugepagesize, nr_hugepages, nr_overcommit_hugepages;
> +static char mount_dir[BUFSIZ], tst_file[BUFSIZ], path[BUFSIZ], pathover[BUFSIZ];
> +static int key = -1, shmid = -1, fd = -1;
> +static int mounted, restore_shmmax, restore_nr_hgpgs, restore_overcomm_hgpgs;
>  static size_t size = 128, length = 384;
>  
>  char *opt_sysfs;
> @@ -79,113 +80,93 @@ static struct tst_option options[] = {
>  	{NULL, NULL, NULL}
>  };
>  
> -static void write_bytes(void *addr);
> -static void read_bytes(void *addr);
> -static int lookup(char *line, char *pattern);
> -static int checkproc(FILE * fp, char *string, int value);
> -static int checksys(char *path, char *pattern, int value);
> +static void check_wr_bytes(void *addr);
> +static int checkproc(long act_val, char *string, long exp_val);
> +static int checksys(char *path, char *pattern, long exp_val);
>  static void init_sys_sz_paths(void);
>  
>  static void test_overcommit(void)
>  {
>  	void *addr = NULL, *shmaddr = NULL;
> -	int fd = -1, key = -1;
> -	char s[BUFSIZ];
> -	FILE *fp;
>  
> -	if (shmid != -1) {
> -		/* Use /proc/meminfo to generate an IPC key. */
> -		key = ftok(PATH_MEMINFO, strlen(PATH_MEMINFO));
> -		if (key == -1)
> -			tst_brk(TBROK | TERRNO, "ftok");
> -		shmid = shmget(key, (long)(length / 2 * hugepagesize),
> -			       SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
> -		if (shmid == -1)
> -			tst_brk(TBROK | TERRNO, "shmget");
> +	if (opt_shmid) {
> +		shmid = SAFE_SHMGET(key, (long)(length / 2 * hugepagesize),
> +				    SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
>  	} else {
> -		/* XXX (garrcoop): memory leak. */
> -		snprintf(s, BUFSIZ, "%s/hugemmap05/file", tst_get_tmpdir());
> -		fd = SAFE_OPEN(s, O_CREAT | O_RDWR, 0755);
> -		addr = mmap(ADDR, (long)(length / 2 * hugepagesize), PROTECTION,
> -			    FLAGS, fd, 0);
> -		if (addr == MAP_FAILED) {
> -			close(fd);
> -			tst_brk(TBROK | TERRNO, "mmap");
> -		}
> +		fd = SAFE_OPEN(tst_file, O_CREAT | O_RDWR, 0755);
> +		addr = SAFE_MMAP(ADDR, (long)(length / 2 * hugepagesize),
> +				 PROTECTION, FLAGS, fd, 0);
>  	}
>  
>  	if (opt_sysfs) {
>  		tst_res(TINFO, "check sysfs before allocation.");
> -		if (checksys(path_sys_sz_huge, "HugePages_Total",
> -			     length / 2) != 0)
> +		if (checksys(path_sys_sz_huge, "HugePages_Total", length / 2))
>  			return;
> -		if (checksys(path_sys_sz_free, "HugePages_Free",
> -			     length / 2) != 0)
> +		if (checksys(path_sys_sz_free, "HugePages_Free", length / 2))
>  			return;
>  		if (checksys(path_sys_sz_surp, "HugePages_Surp",
> -			     length / 2 - size) != 0)
> +			     length / 2 - size))
>  			return;
> -		if (checksys(path_sys_sz_resv, "HugePages_Rsvd",
> -			     length / 2) != 0)
> +		if (checksys(path_sys_sz_resv, "HugePages_Rsvd", length / 2))
>  			return;
>  	} else {
>  		tst_res(TINFO, "check /proc/meminfo before allocation.");
> -		fp = SAFE_FOPEN(PATH_MEMINFO, "r");
> -		if (checkproc(fp, "HugePages_Total", length / 2) != 0)
> +		if (checkproc(SAFE_READ_MEMINFO("HugePages_Total:"),
> +			      "HugePages_Total", length / 2))
>  			return;
> -		if (checkproc(fp, "HugePages_Free", length / 2) != 0)
> +		if (checkproc(SAFE_READ_MEMINFO("HugePages_Free:"),
> +			      "HugePages_Free", length / 2))
>  			return;
> -		if (checkproc(fp, "HugePages_Surp", length / 2 - size) != 0)
> +		if (checkproc(SAFE_READ_MEMINFO("HugePages_Surp:"),
> +			      "HugePages_Surp", length / 2 - size))
>  			return;
> -		if (checkproc(fp, "HugePages_Rsvd", length / 2) != 0)
> +		if (checkproc(SAFE_READ_MEMINFO("HugePages_Rsvd:"),
> +			      "HugePages_Rsvd", length / 2))
>  			return;
> -		fclose(fp);
>  	}
> -	if (shmid != -1) {
> +
> +	if (opt_shmid) {
>  		tst_res(TINFO, "shmid: 0x%x", shmid);
> -		shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
> -		if (shmaddr == (void *)-1)
> -			tst_brk(TBROK | TERRNO, "shmat");
> -		write_bytes(shmaddr);
> -		read_bytes(shmaddr);
> +		shmaddr = SAFE_SHMAT(shmid, ADDR, SHMAT_FLAGS);
> +		check_wr_bytes(shmaddr);
>  	} else {
> -		write_bytes(addr);
> -		read_bytes(addr);
> +		check_wr_bytes(addr);
>  	}
> +
>  	if (opt_sysfs) {
>  		tst_res(TINFO, "check sysfs.");
> -		if (checksys(path_sys_sz_huge, "HugePages_Total",
> -			     length / 2) != 0)
> +		if (checksys(path_sys_sz_huge, "HugePages_Total", length / 2))
>  			return;
> -		if (checksys(path_sys_sz_free, "HugePages_Free", 0)
> -		    != 0)
> +		if (checksys(path_sys_sz_free, "HugePages_Free", 0))
>  			return;
>  		if (checksys(path_sys_sz_surp, "HugePages_Surp",
> -			     length / 2 - size) != 0)
> +			     length / 2 - size))
>  			return;
> -		if (checksys(path_sys_sz_resv, "HugePages_Rsvd", 0)
> -		    != 0)
> +		if (checksys(path_sys_sz_resv, "HugePages_Rsvd", 0))
>  			return;
>  	} else {
>  		tst_res(TINFO, "check /proc/meminfo.");
> -		fp = SAFE_FOPEN(PATH_MEMINFO, "r");
> -		if (checkproc(fp, "HugePages_Total", length / 2) != 0)
> +		if (checkproc(SAFE_READ_MEMINFO("HugePages_Total:"),
> +			      "HugePages_Total", length / 2))
>  			return;
> -		if (checkproc(fp, "HugePages_Free", 0) != 0)
> +		if (checkproc(SAFE_READ_MEMINFO("HugePages_Free:"),
> +			      "HugePages_Free", 0))
>  			return;
> -		if (checkproc(fp, "HugePages_Surp", length / 2 - size) != 0)
> +		if (checkproc(SAFE_READ_MEMINFO("HugePages_Surp:"),
> +			      "HugePages_Surp", length / 2 - size))
>  			return;
> -		if (checkproc(fp, "HugePages_Rsvd", 0) != 0)
> +		if (checkproc(SAFE_READ_MEMINFO("HugePages_Rsvd:"),
> +			      "HugePages_Rsvd", 0))
>  			return;
> -		fclose(fp);
>  	}
> -	if (shmid != -1) {
> -		if (shmdt(shmaddr) != 0)
> -			tst_brk(TBROK | TERRNO, "shmdt");
> +
> +	if (opt_shmid) {
> +		SAFE_SHMDT(shmaddr);
> +		SAFE_SHMCTL(shmid, IPC_RMID, NULL);
>  	} else {
> -		munmap(addr, (long)(length / 2 * hugepagesize));
> -		close(fd);
> -		unlink(s);
> +		SAFE_MUNMAP(addr, (long)(length / 2 * hugepagesize));
> +		SAFE_CLOSE(fd);
> +		SAFE_UNLINK(tst_file);
>  	}
>  
>  	tst_res(TPASS, "hugepages overcommit test pass");
> @@ -193,57 +174,38 @@ static void test_overcommit(void)
>  
>  static void cleanup(void)
>  {
> -	int fd;
> -
> -	if (restore_shmmax) {
> -		fd = open(PATH_SHMMAX, O_WRONLY);
> -		if (fd == -1)
> -			tst_res(TWARN | TERRNO, "open");
> -		if (write(fd, shmmax, strlen(shmmax)) != (ssize_t)strlen(shmmax))
> -			tst_res(TWARN | TERRNO, "write");
> +	if (opt_shmid) {
> +		shmctl(shmid, IPC_RMID, NULL);
> +	} else {
>  		close(fd);
> +		unlink(tst_file);
>  	}
> -	fd = open(path, O_WRONLY);
> -	if (fd == -1)
> -		tst_res(TWARN | TERRNO, "open");
> -	tst_res(TINFO, "restore nr_hugepages to %s.", nr_hugepages);
> -	if (write(fd, nr_hugepages,
> -		  strlen(nr_hugepages)) != (ssize_t)strlen(nr_hugepages))
> -		tst_res(TWARN | TERRNO, "write");
> -	close(fd);
> -
> -	fd = open(pathover, O_WRONLY);
> -	if (fd == -1)
> -		tst_res(TWARN | TERRNO, "open");
> -	tst_res(TINFO, "restore nr_overcommit_hugepages to %s.",
> -		 nr_overcommit_hugepages);
> -	if (write(fd, nr_overcommit_hugepages, strlen(nr_overcommit_hugepages))
> -	    != (ssize_t)strlen(nr_overcommit_hugepages))
> -		tst_res(TWARN | TERRNO, "write");
> -	close(fd);
>  
>  	/* XXX (garrcoop): memory leak. */
> -	snprintf(buf, BUFSIZ, "%s/hugemmap05", tst_get_tmpdir());
> -	if (umount(buf) == -1)
> -		tst_res(TWARN | TERRNO, "umount");
> -	if (shmid != -1) {
> -		tst_res(TINFO, "shmdt cleaning");
> -		shmctl(shmid, IPC_RMID, NULL);
> +	if (mounted)
> +		tst_umount(mount_dir);
> +
> +	if (restore_nr_hgpgs) {
> +		tst_res(TINFO, "restore nr_hugepages to %ld.", nr_hugepages);
> +		SAFE_FILE_PRINTF(path, "%ld", nr_hugepages);
> +	}
> +
> +	if (restore_shmmax)
> +		SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", shmmax);
> +
> +	if (restore_overcomm_hgpgs) {
> +		tst_res(TINFO, "restore nr_overcommit_hugepages to %ld.",
> +			nr_overcommit_hugepages);
> +		SAFE_FILE_PRINTF(pathover, "%ld", nr_overcommit_hugepages);
>  	}
>  }
>  
>  static void setup(void)
>  {
> -	FILE *fp;
> -	int fd;
> -	struct stat stat_buf;
> -
>  	hugepagesize = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
> +	check_hugepage();
>  	init_sys_sz_paths();
>  
> -	if (opt_shmid)
> -		shmid = 0;
> -
>  	if (opt_sysfs) {
>  		strncpy(path, path_sys_sz_huge, strlen(path_sys_sz_huge) + 1);
>  		strncpy(pathover, path_sys_sz_over,
> @@ -252,97 +214,64 @@ static void setup(void)
>  		strncpy(path, PATH_PROC_HUGE, strlen(PATH_PROC_HUGE) + 1);
>  		strncpy(pathover, PATH_PROC_OVER, strlen(PATH_PROC_OVER) + 1);
>  	}
> +
>  	if (opt_alloc) {
>  		size = atoi(opt_alloc);
>  		length = (int)(size + size * 0.5) * 2;
>  	}
> -	if (stat(pathover, &stat_buf) == -1) {
> -		if (errno == ENOENT || errno == ENOTDIR)
> -			tst_brk(TCONF,
> -				 "file %s does not exist in the system",
> -				 pathover);
> -	}
>  
> -	if (shmid != -1) {
> -		fp = fopen(PATH_SHMMAX, "r");
> -		if (fp == NULL)
> -			tst_brk(TBROK | TERRNO, "fopen");
> -		if (fgets(shmmax, BUFSIZ, fp) == NULL)
> -			tst_brk(TBROK | TERRNO, "fgets");
> -		fclose(fp);
> -
> -		if (atol(shmmax) < (long)(length / 2 * hugepagesize)) {
> +	if (opt_shmid) {
> +		SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &shmmax);
> +		if (shmmax < (long)(length / 2 * hugepagesize)) {
>  			restore_shmmax = 1;
> -			fd = open(PATH_SHMMAX, O_RDWR);
> -			if (fd == -1)
> -				tst_brk(TBROK | TERRNO, "open");
> -			snprintf(buf, BUFSIZ, "%ld",
> -				 (long)(length / 2 * hugepagesize));
> -			if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
> -				tst_brk(TBROK | TERRNO,
> -					 "failed to change shmmax.");
> +			SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld",
> +					(length / 2 * hugepagesize));
>  		}
>  	}
> -	fp = SAFE_FOPEN(path, "r+");
> -	if (fgets(nr_hugepages, BUFSIZ, fp) == NULL)
> -		tst_brk(TBROK | TERRNO, "fgets");
> -	fclose(fp);
> -	/* Remove trailing newline. */
> -	nr_hugepages[strlen(nr_hugepages) - 1] = '\0';
> -	tst_res(TINFO, "original nr_hugepages is %s", nr_hugepages);
> -
> -	fd = SAFE_OPEN(path, O_RDWR);
> +
> +	SAFE_FILE_SCANF(path, "%ld", &nr_hugepages);
> +	tst_res(TINFO, "original nr_hugepages is %ld", nr_hugepages);
> +
>  	/* Reset. */
> -	SAFE_WRITE(1, fd, "0", 1);
> -	SAFE_LSEEK(fd, 0, SEEK_SET);
> -	snprintf(buf, BUFSIZ, "%zd", size);
> -	if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
> -		tst_brk(TBROK | TERRNO,
> -			"failed to change nr_hugepages.");
> -	close(fd);
> -
> -	fp = SAFE_FOPEN(pathover, "r+");
> -	if (fgets(nr_overcommit_hugepages, BUFSIZ, fp) == NULL)
> -		tst_brk(TBROK | TERRNO, "fgets");
> -	fclose(fp);
> -	nr_overcommit_hugepages[strlen(nr_overcommit_hugepages) - 1] = '\0';
> -	tst_res(TINFO, "original nr_overcommit_hugepages is %s",
> -		 nr_overcommit_hugepages);
> -
> -	fd = open(pathover, O_RDWR);
> -	if (fd == -1)
> -		tst_brk(TBROK | TERRNO, "open");
> +	SAFE_FILE_PRINTF(path, "%ld", size);
> +	restore_nr_hgpgs = 1;
> +
> +	if (access(pathover, F_OK)) {
> +		tst_brk(TCONF, "file %s does not exist in the system",
> +			pathover);
> +	}
> +
> +	SAFE_FILE_SCANF(pathover, "%ld", &nr_overcommit_hugepages);
> +	tst_res(TINFO, "original nr_overcommit_hugepages is %ld",
> +		nr_overcommit_hugepages);
> +
>  	/* Reset. */
> -	if (write(fd, "0", 1) != 1)
> -		tst_brk(TBROK | TERRNO, "write");
> -	if (lseek(fd, 0, SEEK_SET) == -1)
> -		tst_brk(TBROK | TERRNO, "lseek");
> -	snprintf(buf, BUFSIZ, "%zd", size);
> -	if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
> -		tst_brk(TBROK | TERRNO,
> -			 "failed to change nr_hugepages.");
> -	close(fd);
> +	SAFE_FILE_PRINTF(pathover, "%ld", size);
> +	restore_overcomm_hgpgs = 1;
>  
>  	/* XXX (garrcoop): memory leak. */
> -	snprintf(buf, BUFSIZ, "%s/hugemmap05", tst_get_tmpdir());
> -	if (mkdir(buf, 0700) == -1)
> -		tst_brk(TBROK | TERRNO, "mkdir");
> -	if (mount(NULL, buf, "hugetlbfs", 0, NULL) == -1)
> -		tst_brk(TBROK | TERRNO, "mount");
> -}
> +	sprintf(mount_dir, "%s/hugemmap05", tst_get_tmpdir());
> +	SAFE_MKDIR(mount_dir, 0700);
> +	SAFE_MOUNT(NULL, mount_dir, "hugetlbfs", 0, NULL);
> +	mounted = 1;
>  
> -static void write_bytes(void *addr)
> -{
> -	long i;
> -
> -	for (i = 0; i < (long)(length / 2 * hugepagesize); i++)
> -		((char *)addr)[i] = '\a';
> +	if (opt_shmid) {
> +		/* Use /proc/meminfo to generate an IPC key. */
> +		key = ftok(PATH_MEMINFO, strlen(PATH_MEMINFO));
> +		if (key == -1)
> +			tst_brk(TBROK | TERRNO, "ftok");
> +	} else {
> +		/* XXX (garrcoop): memory leak. */
> +		sprintf(tst_file, "%s/hugemmap05/file", tst_get_tmpdir());
> +	}
>  }
>  
> -static void read_bytes(void *addr)
> +static void check_wr_bytes(void *addr)
>  {
>  	long i;
>  
> +	memset((char *)addr, '\a', (long)(length / 2 * hugepagesize));
> +
>  	tst_res(TINFO, "First hex is %x", *((unsigned int *)addr));
>  	for (i = 0; i < (long)(length / 2 * hugepagesize); i++) {
>  		if (((char *)addr)[i] != '\a') {
> @@ -352,52 +281,27 @@ static void read_bytes(void *addr)
>  	}
>  }
>  
> -/* Lookup a pattern and get the value from file */
> -static int lookup(char *line, char *pattern)
> +static int checksys(char *path, char *string, long exp_val)
>  {
> -	char buf2[BUFSIZ];
> -
> -	/* empty line */
> -	if (line[0] == '\0')
> -		return 0;
> +	long act_val;
>  
> -	snprintf(buf2, BUFSIZ, "%s: %%s", pattern);
> -	if (sscanf(line, buf2, buf) != 1)
> -		return 0;
> -
> -	return 1;
> -}
> -
> -static int checksys(char *path, char *string, int value)
> -{
> -	FILE *fp;
> -
> -	fp = SAFE_FOPEN(path, "r");
> -	if (fgets(buf, BUFSIZ, fp) == NULL)
> -		tst_brk(TBROK | TERRNO, "fgets");
> -	tst_res(TINFO, "%s is %d.", string, atoi(buf));
> -	if (atoi(buf) != value) {
> -		tst_res(TFAIL, "%s is not %d but %d.", string, value,
> -			 atoi(buf));
> -		fclose(fp);
> +	SAFE_FILE_SCANF(path, "%ld", &act_val);
> +	tst_res(TINFO, "%s is %ld.", string, act_val);
> +	if (act_val != exp_val) {
> +		tst_res(TFAIL, "%s is not %ld but %ld.", string, exp_val,
> +			act_val);
>  		return 1;
>  	}
> -	fclose(fp);
>  	return 0;
>  }
>  
> -static int checkproc(FILE * fp, char *pattern, int value)
> +static int checkproc(long act_val, char *pattern, long exp_val)
>  {
> -	memset(buf, -1, BUFSIZ);
> -	rewind(fp);
> -	while (fgets(line, BUFSIZ, fp) != NULL)
> -		if (lookup(line, pattern))
> -			break;
>  
> -	tst_res(TINFO, "%s is %d.", pattern, atoi(buf));
> -	if (atoi(buf) != value) {
> -		tst_res(TFAIL, "%s is not %d but %d.", pattern, value,
> -			 atoi(buf));
> +	tst_res(TINFO, "%s is %ld.", pattern, act_val);
> +	if (act_val != exp_val) {
> +		tst_res(TFAIL, "%s is not %ld but %ld.",
> +			pattern, exp_val, act_val);
>  		return 1;
>  	}
>  	return 0;
> @@ -405,7 +309,7 @@ static int checkproc(FILE * fp, char *pattern, int value)
>  
>  static void init_sys_sz_paths(void)
>  {
> -	sprintf(path_sys_sz, "/sys/kernel/mm/hugepages/hugepages-%dkB",
> +	sprintf(path_sys_sz, "/sys/kernel/mm/hugepages/hugepages-%ldkB",
>  		hugepagesize / 1024);
>  	sprintf(path_sys_sz_over, "%s/nr_overcommit_hugepages", path_sys_sz);
>  	sprintf(path_sys_sz_free, "%s/free_hugepages", path_sys_sz);



