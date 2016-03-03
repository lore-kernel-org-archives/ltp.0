From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Mar 2016 19:12:30 +0100
Subject: [LTP] [PATCH v2 2/2] removexattr/removexattr02.c: add new
 testcase
In-Reply-To: <1455722442-7301-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1455722442-7301-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1455722442-7301-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160303181230.GB14084@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifdef HAVE_ATTR_XATTR_H
> +#include <attr/xattr.h>
> +#endif
> +
> +#include "test.h"
> +#include "safe_file_ops.h"
> +
> +char *TCID = "removexattr02";
> +
> +#ifdef HAVE_ATTR_XATTR_H
> +#define USER_KEY	"user.test"
> +#define VALUE	"test"
> +#define VALUE_SIZE	4
> +
> +static struct test_case {
> +	const char *path;
> +	char *name;
> +	int exp_err;
> +} tc[] = {
> +	/* test1 */
> +	{"testfile", "user.test1", ENOATTR},
> +	/* test2 */
> +	{"", USER_KEY, ENOENT},
> +	/* test3 */
> +	{(char *)-1, USER_KEY, EFAULT}
> +};
> +
> +static void verify_removexattr(struct test_case *tc);
> +static void setup(void);
> +static void cleanup(void);
> +
> +int TST_TOTAL = ARRAY_SIZE(tc);
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int i;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +		for (i = 0; i < TST_TOTAL; i++)
> +			verify_removexattr(&tc[i]);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void verify_removexattr(struct test_case *tc)
> +{
> +
> +	TEST(removexattr(tc->path, tc->name));
> +	if (TEST_RETURN != -1) {
> +		tst_resm(TFAIL, "removexattr() succeeded unexpectedly");

If you place return here there is no need for the else branch and the
code will end up a bit simpler.

> +	} else {
> +		if (TEST_ERRNO != tc->exp_err) {
> +			tst_resm(TFAIL | TTERRNO, "removexattr() failed "
> +				 "unexpectedly, expected %s",
> +				 tst_strerrno(tc->exp_err));
> +		} else {
> +			tst_resm(TPASS | TTERRNO,
> +				 "removexattr() failed as expected");
> +		}
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	int n;
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	SAFE_TOUCH(cleanup, "testfile", 0644, NULL);
> +
> +	n = setxattr("testfile", USER_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
> +	if (n == -1) {
> +		if (errno == ENOTSUP) {
> +			tst_brkm(TCONF, cleanup, "no xattr support in fs or "
> +				 "mounted without user_xattr option");
> +		} else {
> +			tst_brkm(TFAIL | TERRNO, cleanup, "setxattr() failed");
> +		}
> +	}

I doubt that we have to set any attribute for the file in the setup, do
we?

> +}
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
