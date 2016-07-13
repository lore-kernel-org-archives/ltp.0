From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Jul 2016 14:28:14 +0200
Subject: [LTP] [PATCH 2/2] lgetxattr/lgetxattr02.c: add new testcase
In-Reply-To: <1466149404-22555-2-git-send-email-huangjb.jy@cn.fujitsu.com>
References: <1466149404-22555-1-git-send-email-huangjb.jy@cn.fujitsu.com>
 <1466149404-22555-2-git-send-email-huangjb.jy@cn.fujitsu.com>
Message-ID: <20160713122814.GB2232@rei.scz.novell.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +* Description:
> +* 1) lgetxattr(2) fails if the named attribute does not exist
> +*    or the process has no access to this attribute.
> +* 2) lgetxattr(2) fails if the size of the value buffer is too small
> +*    to hold the result.
> +* 3) lgetxattr(2) fails when attemptes to read from a invalid address.
> +*
> +* Expected Result:
> +* 1) lgetxattr(2) should return -1 and set errno to ENOATTR.
> +* 2) lgetxattr(2) should return -1 and set errno to ERANGE.
> +* 3) lgetxattr(2) should return -1 and set errno to EFAULT.
> +*/
> +
> +#include "config.h"
> +#include <errno.h>
> +#include <sys/types.h>
> +
> +#ifdef HAVE_ATTR_XATTR_H
> +#include <attr/xattr.h>
> +#endif
> +
> +#include "tst_test.h"
> +
> +#ifdef HAVE_ATTR_XATTR_H
> +
> +#define SECURITY_KEY	"security.ltptest"
> +#define VALUE	"this is a test value"
> +#define VALUE_SIZE	20

Here again, define the VALUE_SIZE to sizeof(VALUE) or (sizeof(VALUE)-1)
if you want to avoid the terminating null character.

> +static struct test_case {
> +	const char *path;
> +	size_t size;
> +	int exp_err;
> +} tc[] = {
> +	{"testfile", 19, ENOATTR},
                      ^
		      Shouldn't this be VALUE_SIZE?
> +	{"symlink", 1, ERANGE},
> +	{(char *)-1, 20, EFAULT}
                     ^
                     And this as well?
> +};
> +
> +static void verify_lgetxattr(unsigned int n)
> +{
> +	struct test_case *t = tc + n;
> +	char buf[t->size];
> +
> +	TEST(lgetxattr(t->path, SECURITY_KEY, buf, tc->size));
                                                   ^
						   t->size ?

						   or even better
						   sizeof(buf)
> +	if (TEST_RETURN != -1) {
> +		tst_res(TFAIL, "lgetxattr() succeeded unexpectedly");

Ff you do return here would be no need for else branch and the code
below would be intended only by one tab.

> +	} else {
> +		if (TEST_ERRNO != t->exp_err) {
> +			tst_res(TFAIL | TTERRNO, "lgetxattr() failed "
> +				"unexpectedlly, expected %s",
> +				tst_strerrno(t->exp_err));
> +		} else {
> +			tst_res(TPASS | TTERRNO,
> +				"lgetxattr() failed as expected");
> +		}
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	int n;
> +
> +	SAFE_TOUCH("testfile", 0644, NULL);
> +
> +	SAFE_SYMLINK("testfile", "symlink");
> +
> +	n = lsetxattr("symlink", SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
> +	if (n == -1) {
> +		if (errno == ENOTSUP) {
> +			tst_brk(TCONF, "no xattr support in fs or "
> +				"mounted without user_xattr option");
> +		} else {
> +			tst_brk(TBROK | TERRNO, "lsetxattr() failed");
> +		}
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.tid = "lgetxattr02",
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.test = verify_lgetxattr,
> +	.tcnt = ARRAY_SIZE(tc),
> +	.setup = setup,
> +};
> +
> +#else /* HAVE_ATTR_XATTR_H */
> +	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
> +#endif

Otherwise this looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
