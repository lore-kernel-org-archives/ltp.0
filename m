From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Feb 2016 15:26:41 +0100
Subject: [LTP] [PATCH 1/2] removexattr/removexattr01.c: add new testcase
In-Reply-To: <1454058535-25666-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1454058535-25666-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160210142640.GB12894@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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
> +	TEST(removexattr("testfile", USER_KEY));
> +	if (TEST_RETURN != 0) {
> +		tst_resm(TFAIL, "removexattr() failed");
> +		return;
> +	}
> +
> +	n = getxattr("testfile", USER_KEY, buf, size);
> +	if (n != -1) {
> +		tst_resm(TFAIL, "getxattr() succeeded unexpectedly");
> +		return;
> +	}
> +
> +	if (errno != ENOATTR)
> +		tst_resm(TFAIL, "removexattr() failed");
                          ^
			  TFAIL | TERRNO
> +	else
> +		tst_resm(TPASS, "removexattr() succeeded");


You should add the attribute here otherwise the test would break on
second iteration with -i N parameter.

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
> -- 
> 1.8.3.1
> 
> 
> 
> 
> -- 
> Mailing list info: http://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
