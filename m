From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 20 Mar 2020 10:05:48 +0530
Subject: [LTP] [PATCH V7 10/10] syscalls/open_tree: New tests
In-Reply-To: <20200313124920.GC6597@rei.lan>
References: <6648a9106e367d370012c8ee1d0d81c369779ba8.1584014172.git.viresh.kumar@linaro.org>
 <928553e5fd3518fccb363fb8b6ad079ac3c75fd2.1584090119.git.viresh.kumar@linaro.org>
 <20200313124920.GC6597@rei.lan>
Message-ID: <20200320043548.66orcumbq57wqyzt@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13-03-20, 13:49, Cyril Hrubis wrote:
> > +static void run(unsigned int n)
> > +{
> > +	struct tcase *tc = &tcases[n];
> > +	int fd, fsmfd, otfd;
> > +
> > +	TEST(fd = fsopen(tst_device->fs_type, 0));
> > +	if (fd == -1) {
> > +		tst_res(TFAIL | TERRNO, "fsopen() failed");
> > +		return;
> > +	}
> > +
> > +	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
> > +	if (TST_RET == -1) {
> > +		SAFE_CLOSE(fd);
> > +		tst_res(TFAIL | TERRNO, "fsconfig() failed");
> > +		return;
> > +	}
> > +
> > +	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> > +	if (TST_RET == -1) {
> > +		SAFE_CLOSE(fd);
> > +		tst_res(TFAIL | TERRNO, "fsconfig() failed");
> > +		return;
> > +	}
> > +
> > +	TEST(fsmfd = fsmount(fd, 0, 0));
> > +	SAFE_CLOSE(fd);
> > +
> > +	if (fsmfd == -1) {
> > +		tst_res(TFAIL | TERRNO, "fsmount() failed");
> > +		return;
> > +	}
> > +
> > +	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> > +			MOVE_MOUNT_F_EMPTY_PATH));
> > +	SAFE_CLOSE(fsmfd);
> 
> Here as well, shouldn't we just set the .mount_device flag instead?

Hi,

Sorry but I am not sure what will happen by .mount_device here. From
what I see from tst_test.c, that flag will end up calling SAFE_MOUNT()
automatically, but what we are calling here is fsmount() and
move_mount() instead.

Can you please elaborate a bit on that ? Thanks.

-- 
viresh
