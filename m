From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Mar 2016 15:53:31 +0100
Subject: [LTP] [PATCH 2/2] request_key/request_key02.c: add new testcase
In-Reply-To: <1456732418-10557-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1456732418-10557-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1456732418-10557-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160309145331.GG28171@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifdef HAVE_LINUX_KEYCTL_H
> +
> +static struct test_case {
> +	const char *des;
> +	int exp_err;
> +} tc[] = {
> +	/* test1 */
> +	{"ltp1", ENOKEY},
> +	/* test2 */
> +	{"ltp", EKEYREVOKED},
> +	/* test3 */
> +	{"ltp", EKEYEXPIRED}
> +};
> +
> +static void verify_request_key(struct test_case *);
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
> +
> +		for (i = 0; i < TST_TOTAL; i++)
> +			verify_request_key(&tc[i]);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void verify_request_key(struct test_case *tc)
> +{
> +	int sec = 1;
> +	int res;
> +	int n;
> +
> +	res = ltp_syscall(__NR_add_key, "keyring", "ltp", NULL, 0, KEY_SPEC_THREAD_KEYRING);
> +	if (res == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "add_key() failed");

Here as well, do not call the raw syscalls here.

> +	if (tc->exp_err == EKEYREVOKED) {
> +		n = ltp_syscall(__NR_keyctl, KEYCTL_REVOKE, res);
> +		if (n == -1) {
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				 "fail to revoke a key");
> +		}
> +	}
> +
> +	if (tc->exp_err == EKEYEXPIRED) {
> +		n = ltp_syscall(__NR_keyctl, KEYCTL_SET_TIMEOUT, res, sec);
> +		if (n == -1) {
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				 "fail to set timeout for a key");
> +		}
> +		sleep(sec + 1);
> +	}

This part should be done in setup as well, especially since the the
expiration takes at least second to expire. As it is ten iteration of
this test would take 20 seconds compared with 2 seconds if this was done
in setup.

> +	TEST(ltp_syscall(__NR_request_key, "keyring", tc->des, NULL, res));
> +	if (TEST_RETURN != -1) {
> +		tst_resm(TFAIL, "request_key() succeed unexpectly");
> +		return;
> +	}
> +	if (TEST_ERRNO == tc->exp_err)
> +		tst_resm(TPASS | TTERRNO, "request_key() failed expectly");
> +	else
> +		tst_resm(TFAIL | TTERRNO, "request_key() failed unexpectly");
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root();
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
> +#else
> +int main(int ac, char **av)
> +{
> +	tst_brkm(TCONF, NULL, "linux/keyctl.h was missing upon compilation.");
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
