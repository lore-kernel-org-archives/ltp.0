From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 26 Feb 2020 08:47:29 +0100
Subject: [LTP] [PATCH V3 08/10] syscalls/move_mount: New tests
In-Reply-To: <20200226022758.ls35mblsetg4nk6f@vireshk-i7>
References: <cover.1582612624.git.viresh.kumar@linaro.org>
 <e12560056ebc632918426194172a6cba48953d4e.1582612624.git.viresh.kumar@linaro.org>
 <20200225135709.GC62318@gacrux.arch.suse.de>
 <20200226022758.ls35mblsetg4nk6f@vireshk-i7>
Message-ID: <20200226074729.GA15207@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> On 25-02-20, 14:57, Petr Vorel wrote:
> > > +	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
> > > +	if (TST_RET == -1) {
> > > +		SAFE_CLOSE(fd);
> > > +		tst_res(TBROK | TERRNO, "fsconfig() failed");
> > These should be TFAIL otherwise it 1) breaks all tests 2) does not report any
> > result:

> > move_mount02.c:37: BROK: fsopen() failed: SUCCESS (0)
> > tst_test.c:1051: BROK: Test 0 haven't reported results!

> I am a bit confused about TBROK and TFAIL to be honest. The test
> writing guideline says this:

> | 'TFAIL' | Test has failed.
> | 'TBROK' | Something has failed in test preparation phase.

> And so in my code I have been using TFAIL only for the failures for the
> actual syscalls that we are testing, like move_mount here. And I have
> been using TBROK for pretty much everything else.
Your idea is correct, but IMHO it's not good to skip all the tests, which is
done due
tst_test.c:1051: BROK: Test 0 haven't reported results!
if you use tst_res(TBROK ...).

You can use tst_brk(TBROK) to avoid no reported results, but that's obviously
exit the test either.

tst_brk(TBROK) is used for setup, where you create some resource, which is then
reused by all test runs, but this preparation fails.

NOTE: There are some tests which are using tst_res(TBROK). At least some of them are
wrong. IMHO in testcases/kernel/syscalls/request_key/request_key04.c
	TST_ERR = saved_errno;
	if (TST_ERR == EACCES) {
		tst_res(TPASS, "request_key() failed with EACCES as expected");
	} else {
		tst_res(TBROK | TTERRNO,
			"request_key() failed with unexpected error code");
	}

IMHO it should be
	TST_ERR = saved_errno;
	if (TST_ERR == EACCES) {
		tst_res(TPASS, "request_key() failed with EACCES as expected");
	} else {
		tst_res(TFAIL | TTERRNO,
			"request_key() failed with unexpected error code");
	}
Otherwise if it fails at unexpected error code, you get:
request_key04.c:68: BROK: request_key() failed with unexpected error code: EACCES (13)
tst_test.c:1036: BROK: Test haven't reported results!

Thus I'd try to avoid TBROK with tst_res().

> Would be good if you and Cyril can explain what's the correct usage
> model for these is.

Kind regards,
Petr
