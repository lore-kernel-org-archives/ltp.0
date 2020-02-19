From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 Feb 2020 09:50:18 +0100
Subject: [LTP] [PATCH 2/7] syscalls/fsopen: New tests
In-Reply-To: <CAEemH2caDii5LcOX7fbOcrJNY9=TL6RfEi6Y0ajybxMKNgw7ag@mail.gmail.com>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <e4955c8edfb29c1d0f74a8cd24b1dcc68f3b6814.1581680021.git.viresh.kumar@linaro.org>
 <CAEemH2emOw=Abnvk-3EOVFyCoY=c6HtC_1o0gih5n+aL-WfXLw@mail.gmail.com>
 <20200217133638.GB14410@rei>
 <CAEemH2caDii5LcOX7fbOcrJNY9=TL6RfEi6Y0ajybxMKNgw7ag@mail.gmail.com>
Message-ID: <20200219085018.GB21099@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On Mon, Feb 17, 2020 at 9:36 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> > ...
> > > > +static struct tst_test test = {
> > > > +       .min_kver = "5.2",


> > > I suggest removing .min_kver check in all of the tests to let they can be
> > > running on many distributions(which backport the features).

> > If we do that we have to explicitely check for ENOSYS errno in each
> > test, quite possibly with a dummy call to the tested syscall in test
> > setup, because once these calls gets libc wrappers we will no longer
> > call the tst_syscall() that checks for it.


> +1 add dummy call to the tested syscall in the setup.
> Agree, thanks for point out this.
Could anybody add it to fsmount/fsmount01.c instead?


If anybody don't mind, I'll rename fsopen02.c to fsopen01.c,
remove .min_kver = "5.2" and replace tst_brk with tst_res + return, and merge it:

// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
 *
 * Description:
 * Basic fsopen() failure tests.
 */

#include "tst_test.h"
#include "lapi/fsmount.h"

const char *invalid_fs = "invalid";
const char *valid_fs;

static struct tcase {
	char *name;
	const char **fs;
	unsigned int flags;
	int exp_errno;
} tcases[] = {
	{"invalid-fs", &invalid_fs, 0, ENODEV},
	{"invalid-flags", &valid_fs, 0x10, EINVAL},
};

static void setup(void)
{
	valid_fs = tst_device->fs_type;
}

static void run(unsigned int n)
{
	struct tcase *tc = &tcases[n];

	TEST(fsopen(*tc->fs, tc->flags));

	if (TST_RET != -1) {
		SAFE_CLOSE(TST_RET);
		tst_res(TFAIL, "%s: fsopen() succeeded unexpectedly (index: %d)",
			tc->name, n);
		return;
	}

	if (tc->exp_errno != TST_ERR) {
		tst_res(TFAIL | TTERRNO, "%s: fsopen() should fail with %s",
			tc->name, tst_strerrno(tc->exp_errno));
		return;
	}

	tst_res(TPASS | TTERRNO, "%s: fsopen() failed as expected", tc->name);
}

static struct tst_test test = {
	.tcnt = ARRAY_SIZE(tcases),
	.test = run,
	.setup = setup,
	.needs_root = 1,
	.needs_device = 1,
};
