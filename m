From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 Feb 2020 14:57:09 +0100
Subject: [LTP] [PATCH V3 08/10] syscalls/move_mount: New tests
In-Reply-To: <e12560056ebc632918426194172a6cba48953d4e.1582612624.git.viresh.kumar@linaro.org>
References: <cover.1582612624.git.viresh.kumar@linaro.org>
 <e12560056ebc632918426194172a6cba48953d4e.1582612624.git.viresh.kumar@linaro.org>
Message-ID: <20200225135709.GC62318@gacrux.arch.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> +	TEST(fsopen(tst_device->fs_type, 0));
> +	fd = TST_RET;
Again:
TEST(fd = fsopen(tst_device->fs_type, 0));

> +
> +	if (fd == -1) {
> +		tst_res(TBROK | TERRNO, "fsopen() failed");
> +		return;
> +	}
> +
> +	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
> +	if (TST_RET == -1) {
> +		SAFE_CLOSE(fd);
> +		tst_res(TBROK | TERRNO, "fsconfig() failed");
These should be TFAIL otherwise it 1) breaks all tests 2) does not report any
result:

move_mount02.c:37: BROK: fsopen() failed: SUCCESS (0)
tst_test.c:1051: BROK: Test 0 haven't reported results!

I'll send diff with these small fixes and if anybody complains, we could merge
whole patchset.

Kind regards,
Petr
