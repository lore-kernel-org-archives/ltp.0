From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Apr 2016 18:03:02 +0200
Subject: [LTP] [PATCH v2 2/2] request_key/request_key02.c: add new
	testcase
In-Reply-To: <1458113314-29731-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160309145331.GG28171@rei.lan>
 <1458113314-29731-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1458113314-29731-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160413160302.GG11529@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> +* Test Name: request_key02
> +*
> +* Description:
> +* 1) request_key(2) fails if no matching key was found.
> +* 2) request_key(2) fails if A revoked key was found.
> +* 3) request_key(2) fails if An expired key was found.
> +*
> +* Expected Result:
> +* 1) request_key(2) should return -1 and set errno to ENOKEY.
> +* 2) request_key(2) should return -1 and set errno to EKEYREVOKED.
> +* 3) request_key(2) should return -1 and set errno to EKEYEXPIRED.
> +*
> +*/
> +
> +#include "config.h"
> +#include <errno.h>
> +#include <sys/types.h>
> +#ifdef HAVE_KEYUTILS_H
> +#include <keyutils.h>
> +#endif
> +#include "test.h"
> +
> +char *TCID = "request_key02";
> +
> +static struct test_case {
> +	const char *des;
> +	int exp_err;
> +	int id;
> +} tc[] = {
> +	/* test1 */
> +	{"ltp1", ENOKEY, 0},
> +	/* test2 */
> +	{"ltp2", EKEYREVOKED, 0},
> +	/* test3 */
> +	{"ltp3", EKEYEXPIRED, 0}
> +};
> +
> +static void verify_request_key(struct test_case *);
> +static void setup(void);
> +static int init_key(char *, int);
> +static void cleanup(void);
> +
> +int TST_TOTAL = ARRAY_SIZE(tc);
> +
> +#ifdef HAVE_KEYUTILS_H
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
> +	TEST(request_key("keyring", tc->des, NULL, tc->id));
> +	if (TEST_RETURN != -1) {
> +		tst_resm(TFAIL, "request_key() succeed unexpectly");
> +		return;
> +	}
> +
> +	if (TEST_ERRNO == tc->exp_err)
> +		tst_resm(TPASS | TTERRNO, "request_key() failed expectly");
> +	else
> +		tst_resm(TFAIL | TTERRNO, "request_key() failed unexpectly");

Ideally the error message should contain the expected errno as well.

> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();

Here as well.

> +	tc[0].id = KEY_REQKEY_DEFL_DEFAULT;
> +
> +	tc[1].id = init_key("ltp2", KEYCTL_REVOKE);
> +
> +	tc[2].id = init_key("ltp3", KEYCTL_SET_TIMEOUT);

This is ugly. What you should do instead is to declare the id in the
test structure as a pointer and initialize it to a pointer to a variable
that is initialized in the setup.

> +}
> +
> +static int init_key(char *name, int cmd)
> +{
> +	int n;
> +	int sec = 1;
> +
> +	n = add_key("keyring", name, NULL, 0, KEY_SPEC_THREAD_KEYRING);
> +	if (n == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "add_key() failed");
> +
> +	if (cmd == KEYCTL_REVOKE) {
> +		if (keyctl(cmd, n) == -1) {
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				 "failed to revoke a key");
> +		}
> +	}
> +
> +	if (cmd == KEYCTL_SET_TIMEOUT) {
> +		if (keyctl(cmd, n, sec) == -1) {
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				 "failed to set timeout for a key");
> +		}
> +
> +		sleep(sec + 1);
> +	}
> +
> +	return n;
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
> +#else
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "compilation failed without keyutils.h");


Here as well.

> +}
> +#endif /* HAVE_LINUX_KEYCTL_H */

-- 
Cyril Hrubis
chrubis@suse.cz
