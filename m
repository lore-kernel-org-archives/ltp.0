From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 9 Sep 2016 15:31:12 +0800
Subject: [LTP] [PATCH 2/2] syscalls/access05: reconstruct and convert to
 new API
In-Reply-To: <1469698729-5860-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1469698729-5860-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1469698729-5860-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <57D26540.2070500@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Ping, thanks!


Regards,
Guangwen Feng

On 07/28/2016 05:38 PM, Guangwen Feng wrote:
> * remove duplicate test EACCES and EFAULT
> * do UCLINUX check in Makefile instead
> * add test as root and nobody respectively
> 
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/access/Makefile   |   2 +-
>  testcases/kernel/syscalls/access/access05.c | 219 +++++++++-------------------
>  2 files changed, 66 insertions(+), 155 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/access/Makefile b/testcases/kernel/syscalls/access/Makefile
> index 06aaf9f..52c1970 100644
> --- a/testcases/kernel/syscalls/access/Makefile
> +++ b/testcases/kernel/syscalls/access/Makefile
> @@ -19,7 +19,7 @@
>  top_srcdir		?= ../../../..
>  
>  ifeq ($(UCLINUX),1)
> -FILTER_OUT_MAKE_TARGETS += access02 access03
> +FILTER_OUT_MAKE_TARGETS += access02 access03 access05
>  endif
>  
>  include $(top_srcdir)/include/mk/testcases.mk
> diff --git a/testcases/kernel/syscalls/access/access05.c b/testcases/kernel/syscalls/access/access05.c
> index 3b88515..a645397 100644
> --- a/testcases/kernel/syscalls/access/access05.c
> +++ b/testcases/kernel/syscalls/access/access05.c
> @@ -20,197 +20,108 @@
>  /*
>   * Test Description:
>   *  Verify that,
> - *   1. access() fails with -1 return value and sets errno to EACCES
> - *      if the permission bits of the file mode do not permit the
> - *	 requested (Read/Write/Execute) access.
> - *   2. access() fails with -1 return value and sets errno to EINVAL
> + *   1. access() fails with -1 return value and sets errno to EINVAL
>   *	if the specified access mode argument is invalid.
> - *   3. access() fails with -1 return value and sets errno to EFAULT
> - *	if the pathname points outside allocate address space for the
> - *	process.
> - *   4. access() fails with -1 return value and sets errno to ENOENT
> + *   2. access() fails with -1 return value and sets errno to ENOENT
>   *	if the specified file doesn't exist (or pathname is NULL).
> - *   5. access() fails with -1 return value and sets errno to ENAMETOOLONG
> + *   3. access() fails with -1 return value and sets errno to ENAMETOOLONG
>   *      if the pathname size is > PATH_MAX characters.
> - *   6. access() fails with -1 return value and sets errno to ENOTDIR
> + *   4. access() fails with -1 return value and sets errno to ENOTDIR
>   *      if a component used as a directory in pathname is not a directory.
> - *   7. access() fails with -1 return value and sets errno to ELOOP
> + *   5. access() fails with -1 return value and sets errno to ELOOP
>   *      if too many symbolic links were encountered in resolving pathname.
>   *
>   *   07/2001 Ported by Wayne Boyer
> + *   07/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
>   */
>  
> -#include <stdio.h>
>  #include <errno.h>
> -#include <unistd.h>
> -#include <fcntl.h>
> +#include <pwd.h>
>  #include <string.h>
> -#include <signal.h>
>  #include <sys/types.h>
> -#include <sys/stat.h>
> -#include <sys/mman.h>
> -#include <pwd.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -#define INV_OK		-1
> -#define TEST_FILE1	"test_file1"
> -#define TEST_FILE2	"test_file2"
> -#define TEST_FILE3	"test_file3"
> -#define TEST_FILE4	"test_file4"
> -#define TEST_FILE5	"test_file5/test_file5"
> -#define TEST_FILE6	"test_file6"
> -
> +#include <unistd.h>
> +#include "tst_test.h"
>  
> -#if !defined(UCLINUX)
> -static char high_address_node[64];
> -#endif
> +#define	INV_OK	-1
> +#define FNAME1	"accessfile1"
> +#define FNAME2	"accessfile2/accessfile2"
> +#define DNAME	"accessfile2"
> +#define SNAME1	"symlink1"
> +#define SNAME2	"symlink2"
>  
> +static uid_t uid;
>  static char longpathname[PATH_MAX + 2];
>  
> -static struct test_case_t {
> -	char *pathname;
> -	int a_mode;
> +static struct tcase {
> +	const char *pathname;
> +	int mode;
>  	int exp_errno;
> -} test_cases[] = {
> -	{TEST_FILE1, R_OK, EACCES},
> -	{TEST_FILE2, W_OK, EACCES},
> -	{TEST_FILE3, X_OK, EACCES},
> -	{TEST_FILE4, INV_OK, EINVAL},
> -#if !defined(UCLINUX)
> -	{(char *)-1, R_OK, EFAULT},
> -	{high_address_node, R_OK, EFAULT},
> -#endif
> +} tcases[] = {
> +	{FNAME1, INV_OK, EINVAL},
>  	{"", W_OK, ENOENT},
>  	{longpathname, R_OK, ENAMETOOLONG},
> -	{TEST_FILE5, R_OK, ENOTDIR},
> -	{TEST_FILE6, R_OK, ELOOP},
> +	{FNAME2, R_OK, ENOTDIR},
> +	{SNAME1, R_OK, ELOOP}
>  };
>  
> -char *TCID = "access05";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -
> -static const char nobody_uid[] = "nobody";
> -static struct passwd *ltpuser;
> -
> -static void setup(void);
> -static void access_verify(int i);
> -static void cleanup(void);
> -
> -static char *bad_addr;
> -
> -int main(int ac, char **av)
> +static void access_test(struct tcase *tc, const char *user)
>  {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	TEST(access(tc->pathname, tc->mode));
>  
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> +	if (TEST_RETURN != -1) {
> +		tst_res(TFAIL, "access as %s succeeded unexpectedly", user);
> +		return;
> +	}
>  
> -		for (i = 0; i < TST_TOTAL; i++)
> -			access_verify(i);
> +	if (TEST_ERRNO != tc->exp_errno) {
> +		tst_res(TFAIL | TTERRNO,
> +			"access as %s should fail with %s",
> +			user, tst_strerrno(tc->exp_errno));
> +		return;
>  	}
>  
> -	cleanup();
> -	tst_exit();
> +	tst_res(TPASS | TTERRNO, "access as %s failed expectedly", user);
>  }
>  
> -static void setup(void)
> +static void verify_access(unsigned int n)
>  {
> -	int fd;
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -	tst_require_root();
> -
> -	ltpuser = SAFE_GETPWNAM(cleanup, nobody_uid);
> -	SAFE_SETUID(cleanup, ltpuser->pw_uid);
> -	TEST_PAUSE;
> -
> -#if !defined(UCLINUX)
> -	bad_addr = mmap(0, 1, PROT_NONE,
> -			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> -	if (bad_addr == MAP_FAILED)
> -		tst_brkm(TBROK | TERRNO, NULL, "mmap failed");
> -	test_cases[4].pathname = bad_addr;
> -
> -	test_cases[5].pathname = get_high_address();
> -#endif
> -
> -	tst_tmpdir();
> -
> -	/*
> -	 * create TEST_FILE1 to test R_OK EACCESS
> -	 */
> -	fd = SAFE_CREAT(cleanup, TEST_FILE1, 0333);
> -	SAFE_CLOSE(cleanup, fd);
> -
> -	/*
> -	 * create TEST_FILE2 to test W_OK EACCESS
> -	 */
> -	fd = SAFE_CREAT(cleanup, TEST_FILE2, 0555);
> -	SAFE_CLOSE(cleanup, fd);
> -
> -	/*
> -	 * create TEST_FILE3 to test X_OK EACCESS
> -	 */
> -	fd = SAFE_CREAT(cleanup, TEST_FILE3, 0666);
> -	SAFE_CLOSE(cleanup, fd);
> -
> -	/*
> -	 * create TEST_FILE4 to test EINVAL
> -	 */
> -	fd = SAFE_CREAT(cleanup, TEST_FILE4, 0333);
> -	SAFE_CLOSE(cleanup, fd);
> -
> -	/*
> -	 *setup to create a node with a name length exceeding
> -	 *the MAX length of PATH_MAX.
> -	 */
> -	memset(longpathname, 'a', sizeof(longpathname) - 1);
> +	struct tcase *tc = tcases + n;
> +	pid_t pid;
>  
> -	/* create test_file5 for test ENOTDIR. */
> -	SAFE_TOUCH(cleanup, "test_file5", 0644, NULL);
> +	access_test(tc, "root");
>  
> -	/*
> -	 * create two symbolic links who point to each other for
> -	 * test ELOOP.
> -	 */
> -	SAFE_SYMLINK(cleanup, "test_file6", "test_file7");
> -	SAFE_SYMLINK(cleanup, "test_file7", "test_file6");
> +	pid = SAFE_FORK();
> +	if (pid) {
> +		SAFE_WAITPID(pid, NULL, 0);
> +	} else {
> +		SAFE_SETUID(uid);
> +		access_test(tc, "nobody");
> +	}
>  }
>  
> -static void access_verify(int i)
> +static void setup(void)
>  {
> -	char *file_name;
> -	int access_mode;
> +	struct passwd *pw;
>  
> -	file_name = test_cases[i].pathname;
> -	access_mode = test_cases[i].a_mode;
> +	pw = SAFE_GETPWNAM("nobody");
>  
> -	TEST(access(file_name, access_mode));
> +	uid = pw->pw_uid;
>  
> -	if (TEST_RETURN != -1) {
> -		tst_resm(TFAIL, "access(%s, %#o) succeeded unexpectedly",
> -			 file_name, access_mode);
> -		return;
> -	}
> +	memset(longpathname, 'a', sizeof(longpathname) - 1);
>  
> -	if (TEST_ERRNO == test_cases[i].exp_errno) {
> -		tst_resm(TPASS | TTERRNO, "access failed as expected");
> -	} else {
> -		tst_resm(TFAIL | TTERRNO,
> -			 "access failed unexpectedly; expected: "
> -			 "%d - %s", test_cases[i].exp_errno,
> -			 strerror(test_cases[i].exp_errno));
> -	}
> -}
> +	SAFE_TOUCH(FNAME1, 0333, NULL);
> +	SAFE_TOUCH(DNAME, 0644, NULL);
>  
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> +	SAFE_SYMLINK(SNAME1, SNAME2);
> +	SAFE_SYMLINK(SNAME2, SNAME1);
>  }
> +
> +static struct tst_test test = {
> +	.tid = "access05",
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.test = verify_access,
> +	.tcnt = ARRAY_SIZE(tcases)
> +};
> 


