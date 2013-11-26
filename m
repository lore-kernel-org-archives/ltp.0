Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VlKmE-0001lb-B1
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 15:42:14 +0000
Date: Tue, 26 Nov 2013 16:41:43 +0100
From: chrubis@suse.cz
Message-ID: <20131126154142.GA14089@rei.suse.cz>
References: <1384497891.12576.3.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384497891.12576.3.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] creat/creat06.c: cleanup
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
> cleanup of creat06.c
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/creat/creat06.c | 146 ++++++++++--------------------
>  1 file changed, 48 insertions(+), 98 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
> index 51e46ab..6247c11 100644
> --- a/testcases/kernel/syscalls/creat/creat06.c
> +++ b/testcases/kernel/syscalls/creat/creat06.c
> @@ -13,8 +13,8 @@
>   *   the GNU General Public License for more details.
>   *
>   *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + *   along with this program;  if not, write to the Free Software Foundation,
> + *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>   */
>  
>  /*
> @@ -70,84 +70,62 @@
>  #include <fcntl.h>
>  #include "test.h"
>  #include "usctest.h"
> -
> -void setup(void);
> -void cleanup(void);
> -
> -char user1name[] = "nobody";
> -
> -char *TCID = "creat06";
> -int fileHandle = 0;
> -
> -int exp_enos[] = { EISDIR, ENAMETOOLONG, ENOENT, ENOTDIR, EFAULT, EACCES, 0 };
> -
> -#define	MODE1	0444
> -#define	MODE2	0666
> -#define NSIZE	1000
> -
> -char long_name[] =
> -    "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
> -
> -char good_dir[NSIZE];
> -char no_dir[] = "testfile/testdir";
> -char not_dir[] = "file1/testdir";
> -char test6_file[] = "dir6/file6";
> -char nobody_uid[] = "nobody";
> -
> -struct passwd *ltpuser;
> -struct test_case_t {
> +#include "safe_macros.h"
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +#define	MODE1		0444
> +#define	MODE2		0666
> +#define NSIZE		1000
> +#define NO_DIR		"testfile/testdir"
> +#define NOT_DIR		"file1/testdir"
> +#define TEST6_FILE	"dir6/file6"
> +
> +static char long_name[PATH_MAX+2];
> +static char good_dir[NSIZE];
> +static int filehandle;
> +static char *bad_addr;
> +static struct passwd *ltpuser;

The ltpuser variable don't need to be a global one, it's used only in
the setup, the same goes for bad_addr.

> +static struct test_case_t {
>  	char *fname;
>  	int mode;
>  	int error;
> +	void (*setup)(void);
>  } TC[] = {
> -	/* The file name is an existing directory */
> -	{
> -	good_dir, MODE1, EISDIR},
> -	    /* The file name is too long - ENAMETOOLONG */
> -	{
> -	long_name, MODE1, ENAMETOOLONG},
> -	    /* Attempt to create a file in a directory that doesn't exist - ENOENT */
> -	{
> -	no_dir, MODE1, ENOENT},
> -	    /* a compent of the file's path is not a directory - ENOTDIR */
> -	{
> -	not_dir, MODE1, ENOTDIR},
> +	{good_dir, MODE1, EISDIR, NULL},
> +	{long_name, MODE1, ENAMETOOLONG, NULL},
> +	{NO_DIR, MODE1, ENOENT, NULL},
> +	{NOT_DIR, MODE1, ENOTDIR, NULL},
>  #if !defined(UCLINUX)
> -	    /* The file address is bad - EFAULT */
> -	{
> -	(char *)-1, MODE1, EFAULT},
> +	{(char *)-1, MODE1, EFAULT, NULL},
>  #endif
> -	    /* The directory lacks execute permission - EACCES */
> -	{
> -	test6_file, MODE1, EACCES}
> +	{TEST6_FILE, MODE1, EACCES, NULL},
>  };
>  
> -int TST_TOTAL = (sizeof(TC) / sizeof(*TC));
> -
> -char *bad_addr = 0;
> +char *TCID = "creat06";
> +int TST_TOTAL = ARRAY_SIZE(TC);
> +static int exp_enos[] = { EISDIR, ENAMETOOLONG, ENOENT, ENOTDIR,
> +			  EFAULT, EACCES, 0 };
>  
>  int main(int ac, char **av)
>  {
>  	int lc;
> -	char *msg;
>  	int i;
>  
> -	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> -		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> -
>  	setup();
>  
> -	/* set up the expected errnos */
>  	TEST_EXP_ENOS(exp_enos);
>  
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
>  
> -		/* reset tst_count in case we are looping */
>  		tst_count = 0;
>  
> -		/* loop through the test cases */
>  		for (i = 0; i < TST_TOTAL; i++) {
>  
> +			if (TC[i].setup)
> +				TC[i].setup();
> +
>  			TEST(creat(TC[i].fname, TC[i].mode));
>  
>  			if (TEST_RETURN != -1) {
> @@ -155,8 +133,6 @@ int main(int ac, char **av)
>  				continue;
>  			}
>  
> -			TEST_ERROR_LOG(TEST_ERRNO);
> -
>  			if (TEST_ERRNO == TC[i].error) {
>  				tst_resm(TPASS | TTERRNO,
>  					 "got expected failure");
> @@ -171,21 +147,15 @@ int main(int ac, char **av)
>  	tst_exit();
>  }
>  
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup()
> +static void setup(void)
>  {
>  	char *cur_dir = NULL;
>  
>  	tst_require_root(NULL);
>  
> -	ltpuser = getpwnam(nobody_uid);
> -	if (ltpuser == NULL)
> -		tst_brkm(TBROK | TERRNO, cleanup, "getpwnam failed");
> -	if (seteuid(ltpuser->pw_uid) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			 "seteuid(%d) failed", ltpuser->pw_uid);
> +	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
> +
> +	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
>  
>  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>  
> @@ -193,47 +163,27 @@ void setup()
>  
>  	tst_tmpdir();
>  
> -	/* get the current directory for the first test */
> -	if ((cur_dir = getcwd(cur_dir, 0)) == NULL) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "getcwd failed");
> -	}
> +	cur_dir = SAFE_GETCWD(cleanup, cur_dir, 0);
>  
>  	strncpy(good_dir, cur_dir, NSIZE);

What about doing one SAVE_MKDIR(cleanup, TEST_DIR, MODE) and passing the
TEST_DIR to the first testcase instead? That would save us time while
fidling with the absolute path...

> -	/* create a file that will be used in test #3 */
> -	if ((fileHandle = creat("file1", MODE1)) == -1) {
> -		tst_brkm(TBROK, cleanup, "couldn't create a test file");
> -	}
> +	if (memset(long_name, 'a', PATH_MAX+1) == NULL)
> +		tst_brkm(TBROK | TERRNO, cleanup, "getcwd failed");

This part is wrong, memset() can't fail.

> +
> +	filehandle = SAFE_CREAT(cleanup, "file1", MODE1);

This file descriptor is not used at all. You should use SAFE_TOUCH()
instead of the SAFE_CREAT() to just create the file.

>  #if !defined(UCLINUX)
> -	bad_addr = mmap(0, 1, PROT_NONE,
> -			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> -	if (bad_addr == MAP_FAILED) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
> -	}
> +	bad_addr = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
> +			     MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);

The MAP_PRIVATE_EXCEPT_UCLINUX is not usefull here because you are
inside of the #if !defined(UCLINUX), you can simply use MAP_PRIVATE
instead.

>  	TC[4].fname = bad_addr;

This is hacked up. You should use the per testcase setup function to
assign the value instead.

>  #endif
>  
> -	/* create a directory that will be used in test #6 */
> -	if (mkdir("dir6", MODE2) == -1) {
> -		tst_brkm(TBROK, cleanup, "couldn't creat a test directory");
> -	}
> +	SAFE_MKDIR(cleanup, "dir6", MODE2);
>  }

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
