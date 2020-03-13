From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 13 Mar 2020 09:54:11 +0530
Subject: [LTP] [PATCH V2] syscalls/openat2: New tests
In-Reply-To: <20200311070845.wx5w7cxftzx5m2sx@vireshk-i7>
References: <6b3d4c2c92b4a4e6eeef708ac181b57cf7affda4.1583233870.git.viresh.kumar@linaro.org>
 <20200306144603.GA31015@rei.lan>
 <20200311070845.wx5w7cxftzx5m2sx@vireshk-i7>
Message-ID: <20200313042411.rfscl67p6lq3xve2@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11-03-20, 12:38, Viresh Kumar wrote:
> On 06-03-20, 15:46, Cyril Hrubis wrote:
> > > diff --git a/testcases/kernel/syscalls/openat2/openat202.c b/testcases/kernel/syscalls/openat2/openat202.c
> > > new file mode 100644
> > > index 000000000000..504878277f7e
> > > --- /dev/null
> > > +++ b/testcases/kernel/syscalls/openat2/openat202.c
> > > @@ -0,0 +1,86 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> > > + *
> > > + * openat2() tests with various resolve flags.
> > > + */
> > > +#include "tst_test.h"
> > > +#include "lapi/openat2.h"
> > > +
> > > +#define FOO_SYMLINK "foo_symlink"
> > > +
> > > +static struct open_how *how;
> > > +
> > > +static struct tcase {
> > > +	const char *name;
> > > +	const char *pathname;
> > > +	uint64_t resolve;
> > > +	int exp_errno;
> > > +} tcases[] = {
> > > +	/* Success cases */
> > > +	{"open /proc/version", "/proc/version", 0, 0},
> > > +	{"open magiclinks", "/proc/self/exe", 0, 0},
> > > +	{"open symlinks", FOO_SYMLINK, 0, 0},
> > 
> > Wouldn't it be easier if we added these to the first test and keep this
> > one failures only?
> 
> I thought about that earlier and kept it this way as this file is only
> for testing the resolve flags. Else the success cases could be added
> to openat201.c and failure to openat203.c itself.
> 
> This also helps in understanding (or noticing), that the test only
> changes the value of the resolve flag and we get an error. The first
> test plays with a lot of variables and so it may not be best to do it
> there as it would be a bit less readable.
> 
> > > +	/* Failure cases */
> > > +	{"resolve-no-xdev", "/proc/version", RESOLVE_NO_XDEV, EXDEV},
> > > +	{"resolve-no-magiclinks", "/proc/self/exe", RESOLVE_NO_MAGICLINKS, ELOOP},
> > > +	{"resolve-no-symlinks", FOO_SYMLINK, RESOLVE_NO_SYMLINKS, ELOOP},
> > > +	{"resolve-beneath", "/proc/version", RESOLVE_BENEATH, EXDEV},
> > > +	{"resolve-no-in-root", "/proc/version", RESOLVE_IN_ROOT, ENOENT},
> 
> > > +static struct tcase {
> > > +	const char *name;
> > > +	int dfd;
> > > +	const char *pathname;
> > > +	uint64_t flags;
> > > +	uint64_t mode;
> > > +	uint64_t resolve;
> > > +	struct open_how **how;
> > > +	size_t size;
> > > +	int exp_errno;
> > > +} tcases[] = {
> > > +	{"invalid-dfd", -1, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, &how, sizeof(*how), EBADF},
> > > +	{"invalid-pathname", AT_FDCWD, NULL, O_RDONLY | O_CREAT, S_IRUSR, 0, &how, sizeof(*how), EFAULT},
> > > +	{"invalid-flags", AT_FDCWD, TEST_FILE, O_RDONLY, S_IWUSR, 0, &how, sizeof(*how), EINVAL},
> > > +	{"invalid-mode", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, -1, 0, &how, sizeof(*how), EINVAL},
> > > +	{"invalid-resolve", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, -1, &how, sizeof(*how), EINVAL},
> > > +	{"invalid-size-zero", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, &how, 0, EINVAL},
> > > +	{"invalid-size-small", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, &how, sizeof(*how) - 1, EINVAL},
> > > +	{"invalid-size-big", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, &how, sizeof(*how) + 1, EFAULT},
> > > +	{"invalid-size-big-with-pad", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, (struct open_how **)&phow, sizeof(*how) + 1, E2BIG},
> > 
> > Here as well +8.
> 
> I kept this as 1 intentionally despite the fact that pad is 8 bytes
> long. The last 2 tests have size set to (sizeof(*how) + 1) now and the
> only difference is that we have provided pad of X number of bytes in
> one case and no pad in the other case. This gives us different error
> numbers based on difference in the pad available. If I use +8 here,
> then there are two factors which are different, the structure and the
> number of bytes we are sending in size and we can't be certain about
> why we got a different error number.

@Cyril: I am waiting for your response before sending the next version
here. Thanks.

-- 
viresh
