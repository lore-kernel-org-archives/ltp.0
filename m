From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Mar 2016 19:08:09 +0100
Subject: [LTP] [PATCH v2 1/2] removexattr/removexattr01.c: add new
 testcase
In-Reply-To: <1455722442-7301-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1455722442-7301-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160303180809.GA14084@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifdef HAVE_ATTR_XATTR_H
> +#define USER_KEY	"user.test"
> +#define VALUE	"test"
> +#define VALUE_SIZE	4
                        ^
			(sizeof(VALUE) - 1)

> +static void verify_removexattr(void);
> +static void setup(void);
> +static void cleanup(void);
> +
> +int TST_TOTAL = 1;
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		verify_removexattr();
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void verify_removexattr(void)
> +{
> +	int n;
> +	int size = 64;
> +	char buf[size];
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
> +
> +	TEST(removexattr("testfile", USER_KEY));
> +	if (TEST_RETURN != 0) {
> +		tst_resm(TFAIL, "removexattr() failed");
                            ^
			    TTERRNO
> +		return;
> +	}
> +
> +	n = getxattr("testfile", USER_KEY, buf, size);
> +	if (n != -1) {
> +		tst_resm(TFAIL, "getxattr() succeeded unexpectedly");

This is a bit misleading, since we do not say that it succeded for
deleted key. It shoud say something as:

"getxattr() succeded for deleted key"


> +		return;
> +	}
> +
> +	if (errno != ENOATTR)
> +		tst_resm(TFAIL | TERRNO, "removexattr() failed");

This message is misleading as well. It was getxattr() what has failed
unexpectedly.

> +	else
> +		tst_resm(TPASS, "removexattr() succeeded");
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	SAFE_TOUCH(cleanup, "testfile", 0644, NULL);
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
> +#else /* HAVE_ATTR_XATTR_H */
> +int main(int ac, char **av)
> +{
> +	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
> +}
> +#endif

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
