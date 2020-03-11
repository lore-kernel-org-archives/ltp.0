From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 11 Mar 2020 12:55:02 +0530
Subject: [LTP] [PATCH V5 04/10] syscalls/fsopen: New tests
In-Reply-To: <20200306131046.GC3375@rei.lan>
References: <cover.1582779464.git.viresh.kumar@linaro.org>
 <495a95969c63d67868b82d2b15bd663f19780d0e.1582779464.git.viresh.kumar@linaro.org>
 <20200306131046.GC3375@rei.lan>
Message-ID: <20200311072502.hpj5bycslu6ygk74@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06-03-20, 14:10, Cyril Hrubis wrote:
> Hi!
> > +	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> > +			MOVE_MOUNT_F_EMPTY_PATH));
> > +
> > +	SAFE_CLOSE(fsmfd);
> > +
> > +	if (TST_RET == -1) {
> > +		tst_res(TFAIL | TERRNO, "move_mount() failed");
> > +		goto out;
> > +	}
> > +
> > +	if (tst_is_mounted(MNTPOINT))
> > +		tst_res(TPASS, "%s: fsopen() passed", tc->name);
> > +
> > +	SAFE_UMOUNT(MNTPOINT);
> 
> I gues sthat the SAFE_UMOUNT() should be inside of the if here and in
> the rest of the testcases.

Petr had a similar comment earlier and here is my explanation to it.

There should always be a unmount() in response to a successful call to
mount() APIs. What if, because of some other bugs in the kernel or
testsuite, tst_is_mounted() returns 0? We should still do the
unmount() part as the mount() API didn't return an error.

-- 
viresh
