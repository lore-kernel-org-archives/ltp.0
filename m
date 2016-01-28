From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jan 2016 15:01:09 +0100
Subject: [LTP] [PATCH v2 6/6] kernel/syscalls/open14: openat03: add new
 test-cases
In-Reply-To: <1453984132-6240-7-git-send-email-alexey.kodanev@oracle.com>
References: <1453984132-6240-1-git-send-email-alexey.kodanev@oracle.com>
 <1453984132-6240-7-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160128140109.GB16175@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> * create multiple directories and related temporary files;
> 
> * create multiple directories and link files into them. Check
>   that files permissions correspond to the ones specified with
>   open()/openat().

I would say that for newly added code it makes more sense to add new
files in one patch. It's kind of strange to add more code to files you
have added in previous one.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/kernel/syscalls/open/open14.c     |  163 ++++++++++++++++++++++++---
>  testcases/kernel/syscalls/openat/openat03.c |  160 ++++++++++++++++++++++++---
>  2 files changed, 294 insertions(+), 29 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/open/open14.c b/testcases/kernel/syscalls/open/open14.c
> index 3784cb3..37a900a 100644
> --- a/testcases/kernel/syscalls/open/open14.c
> +++ b/testcases/kernel/syscalls/open/open14.c
> @@ -21,6 +21,7 @@
>  #define _GNU_SOURCE
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <unistd.h>
>  #include <fcntl.h>
>  #include <errno.h>
>  
> @@ -29,7 +30,8 @@
>  #include "lapi/fcntl.h"
>  
>  char *TCID = "open14";
> -int TST_TOTAL = 1;
> +int TST_TOTAL = 3;
> +
>  static const char *test_dir = ".";
>  static const ssize_t size = 1024;
>  static char buf[1024];
> @@ -48,27 +50,36 @@ static void setup(void)
>  	memset(buf, 1, size);
>  }
>  
> -void test01(void)
> +static void create_file(const char *dir_name, int *fd, int mode)
>  {
> -	int fd, i;
> +	*fd = open(dir_name, O_TMPFILE | O_RDWR, mode);
> +	if (*fd != -1)
> +		return;
>  
> -	char path[PATH_MAX], tmp[PATH_MAX];
> +	if (errno == EISDIR)
> +		tst_brkm(TCONF, cleanup, "O_TMPFILE not supported");
>  
> -	tst_resm(TINFO, "creating a file with O_TMPFILE flag");
> +	tst_brkm(TFAIL | TERRNO, cleanup, "open() failed");
> +}

Maybe it would be easier to try to open dummy tmpfile in setup and check
for EISDIR there. Then we can just do SAFE_OPEN() in the rest of the
code.

> -	fd = open(test_dir, O_TMPFILE | O_WRONLY | O_SYNC);
> -	if (fd == -1) {
> -		if (errno == EISDIR) {
> -			tst_brkm(TCONF, cleanup,
> -				"O_TMPFILE not supported");
> -		}
> -		tst_resm(TFAIL | TERRNO, "open() failed");
> -		return;
> -	}
> +static void write_file(int fd)
> +{
> +	int i;
>  
> -	tst_resm(TINFO, "writing data to the file");
>  	for (i = 0; i < blocks_num; ++i)
>  		SAFE_WRITE(cleanup, 1, fd, buf, size);
> +}
> +
> +void test01(void)
> +{
> +	int fd;
> +	char path[PATH_MAX], tmp[PATH_MAX];
> +
> +	tst_resm(TINFO, "creating a file with O_TMPFILE flag");
> +	create_file(test_dir, &fd, 0600);
> +
> +	tst_resm(TINFO, "writing data to the file");
> +	write_file(fd);
>  
>  	SAFE_FSTAT(cleanup, fd, &st);
>  	tst_resm(TINFO, "file size is '%zu'", st.st_size);
> @@ -102,6 +113,126 @@ void test01(void)
>  	tst_resm(TPASS, "test succeeded");
>  }
>  
> +static void read_file(int fd)
> +{
> +	int i;
> +	char tmp[size];
> +
> +	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
> +
> +	for (i = 0; i < blocks_num; ++i) {
> +		SAFE_READ(cleanup, 0, fd, tmp, size);
> +		if (strncmp(buf, tmp, size))\

Using memcmp() here would be a bit cleaner solution.

> +			tst_brkm(TBROK, cleanup, "got unexepected data");

Here again, I would say that this should rather be TFAIL.

> +	}
> +}
> +
> +static void test02(void)
> +{
> +	const int files_num = 100;
> +	int i, fd[files_num];
> +	char path[PATH_MAX];
> +
> +	tst_resm(TINFO, "create files in multiple directories");
> +	for (i = 0; i < files_num; ++i) {
> +		snprintf(path, PATH_MAX, "tst02_%d", i);
> +		SAFE_MKDIR(cleanup, path, 0700);
> +		SAFE_CHDIR(cleanup, path);
> +		SAFE_GETCWD(cleanup, path, PATH_MAX);
> +		create_file(path, fd + i, 0600);

We can do just create_file(".", fd + 1, 0600) here as well.

> +		write_file(fd[i]);
> +	}
> +
> +	tst_resm(TINFO, "removing test directories");
> +	for (i = files_num - 1; i >= 0; --i) {
> +		SAFE_CHDIR(cleanup, "../");
> +		snprintf(path, PATH_MAX, "tst02_%d", i);
> +		SAFE_RMDIR(cleanup, path);
> +	}
> +
> +	tst_resm(TINFO, "writing/reading temporary files");
> +	for (i = 0; i < files_num; ++i) {
> +		write_file(fd[i]);
> +		read_file(fd[i]);
> +	}
> +
> +	tst_resm(TINFO, "closing temporary files");
> +	for (i = 0; i < files_num; ++i)
> +		SAFE_CLOSE(cleanup, fd[i]);
> +
> +	tst_resm(TPASS, "test succeeded");
> +}
>
> +static void link_tmp_file(int fd)
> +{
> +	char path1[PATH_MAX], path2[PATH_MAX];
> +
> +	snprintf(path1, PATH_MAX,  "/proc/self/fd/%d", fd);
> +	snprintf(path2, PATH_MAX,  "tmpfile_%d", fd);
> +
> +	SAFE_LINKAT(cleanup, AT_FDCWD, path1, AT_FDCWD, path2,
> +		    AT_SYMLINK_FOLLOW);
> +}
> +
> +static const int tst_perm[] = { 0, 07777, 001, 0755, 0644, 0440 };
> +
> +static void test03(void)
> +{
> +	const int files_num = 100;
> +	int i, fd[files_num];
> +	char path[PATH_MAX];
> +	struct stat st;
> +	unsigned int j;
> +	mode_t mask = umask(0);
> +
> +	umask(mask);
> +
> +	tst_resm(TINFO, "create multiple directories, link files into them");
> +	tst_resm(TINFO, "and check file permissions");
> +	for (i = 0, j = 0; i < files_num; ++i) {
> +
> +		snprintf(path, PATH_MAX, "tst03_%d", i);
> +		SAFE_MKDIR(cleanup, path, 0700);
> +		SAFE_CHDIR(cleanup, path);
> +		SAFE_GETCWD(cleanup, path, PATH_MAX);
> +
> +		create_file(path, fd + i, tst_perm[j]);

And here as well.

> +		write_file(fd[i]);
> +		read_file(fd[i]);
> +
> +		link_tmp_file(fd[i]);
> +
> +		snprintf(path, PATH_MAX, "tmpfile_%d", fd[i]);
> +
> +		SAFE_LSTAT(cleanup, path, &st);
> +
> +		mode_t exp_mode = tst_perm[j] & ~mask;
> +
> +		if ((st.st_mode & ~S_IFMT) != exp_mode) {
> +			tst_brkm(TFAIL, cleanup,
> +				"file mode read %o, but expected %o",
> +				st.st_mode & ~S_IFMT, exp_mode);
> +		}
> +
> +		if (++j >= ARRAY_SIZE(tst_perm))
> +			j = 0;
> +	}
> +
> +	tst_resm(TINFO, "remove files, directories");
> +	for (i = files_num - 1; i >= 0; --i) {
> +		snprintf(path, PATH_MAX, "tmpfile_%d", fd[i]);
> +		SAFE_UNLINK(cleanup, path);
> +		SAFE_CLOSE(cleanup, fd[i]);
> +
> +		SAFE_CHDIR(cleanup, "..");
> +
> +		snprintf(path, PATH_MAX, "tst03_%d", i);
> +		SAFE_RMDIR(cleanup, path);
> +	}
> +
> +	tst_resm(TPASS, "test passed");

We should be a bit more informative here.

What about "permission tests passed"

And for test02 we should say somethign as: "unlink tests passed"

> +}
> +
>  int main(int ac, char *av[])
>  {
>  	int lc;
> @@ -113,6 +244,8 @@ int main(int ac, char *av[])
>  	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>  		tst_count = 0;
>  		test01();
> +		test02();
> +		test03();
>  	}
>  
>  	cleanup();
> diff --git a/testcases/kernel/syscalls/openat/openat03.c b/testcases/kernel/syscalls/openat/openat03.c
> index 3a0c2f1..743442c 100644
> --- a/testcases/kernel/syscalls/openat/openat03.c
> +++ b/testcases/kernel/syscalls/openat/openat03.c

The same applies for openat03.

The rest of the patchset looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
