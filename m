From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Jul 2021 11:26:23 +0200
Subject: [LTP] [PATCH v2] squashfs: Add regression test for sanity check
 bug
In-Reply-To: <c4012edf-226b-ef55-8872-44d7398282da@jv-coder.de>
References: <20210714055253.1668374-1-lkml@jv-coder.de> <YO6hz+OQLThjUQA1@yuki>
 <c4012edf-226b-ef55-8872-44d7398282da@jv-coder.de>
Message-ID: <YO6tv6cboxnLOuL+@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Is there any guideline? I used regression suffix, because it 
> specifically is a regression test and there are several regression 
> tests, that use it.
> I dropped a number prefix, because there are several tests without a 
> number...
> I don't really care what the name is here. If you don't have a strong 
> opinion on the regression suffix, I will use squashfs_regression01.

Unfortunatelly apart from syscalls there is no clear rule how to name
tests and we are figuring out stuff as we go. Hoever most of the
regression tests do not have regression in name and generally tests are
named as "syscall/driver/filesystem/cve-nickname/etc" followed by a
number.

> > We do have tst_umount() in the test library that retries the umount if
> > it failed because the mount point was bussy. This is because certain
> > damons scan all newly mounted filesystems and prevent us from umounting
> > shortly after mount.
> >
> > Also we usually keep track if device was mounted in a global flag that
> > is set after succesful mount and unset after successful umount and the
> > cleanup does:
> >
> > 	if (device_mounted)
> > 		tst_umount("mnt");
> Ok, but this could leave the mount, if the test is aborted between 
> mounting and setting of the flag, but that should be a rare case.

As long as the flag is set/cleared right after the mount/umount it will
not happen.

Also looking at the code, we have to handle the return value from
tst_umount() in the run() function since it does not call tst_brk().

> > We do have tst_cmd() that can do all this easily in C including the
> > redirection, it will look like:
> >
> > 	const char *argv[] = {"mksquashfs", "data", "image.raw", "-noI", "-noD", "-noX", "-noF"};
> >
> > 	tst_cmd(argv, "/dev/null", "/dev/null", 0);
> >
> > And this will redirect stdout and stderr to "/dev/null" and also do all
> > the error checks and exit the test if mksquashfs has failed.
> Did not know about that, also it requires a NULL at the end.

We do have most of the library functions documented at:

https://github.com/linux-test-project/ltp/wiki/C-Test-API

And yes, the argv has to be NULL terminated, sorry for forgetting that
part.

> >> +	SAFE_MKDIR("mnt", 0777);
> > This preparatory part should be in the test setup otherwise the test
> > will fail with '-i 2'.
> Right, I'll move the whole setup part to setup.
> >
> >> +	TST_EXP_PASS(tst_system("mount -tsquashfs -oloop image.raw mnt"));
> > Can we please use the mount() syscall here instead? That should be as
> > easy as mount("image.raw", "mnt", "squashfs", 0, "-oloop")
> Nope, -oloop does not work, because this is interpreted by the mount 
> utility, not by the syscall.
> I guess I'll use the need_device stuff, to get rid of mount utility call 
> then.

Ah my bad, so the mount command discovers the device in userspace then,
it makes much more sense to use the library to allocate free device for
the test.

But I guess that it would probably be better to use the raw
tst_find_free_loopdev() because the .needs_device flag prepares a
backing file for the device and attaches it as well.

> >> +
> >> +	SAFE_UMOUNT("mnt");
> > Here as well, please use tst_umount();
> Ok
> 
> >
> >> +	tst_res(TPASS, "Test passed");
> > This is redundant, isn't it? Or is the umount part that fails?
> Since I cannot use TST_EXP_PASS further up, I will keep this and check 
> the return of mount manually like this:
> 
> static void run(void)
> {
>  ?????? tst_res(TINFO, "Test squashfs sanity check regressions");
> 
>  ?????? if (mount(tst_device->dev, MOUNT_DIR, "squashfs", 0, NULL) != 0) {
>  ?????? ?????? tst_brk(TFAIL | TERRNO, "Mount failed");
>  ?????? }
>  ?????? mounted = 1;
> 
>  ?????? tst_umount("mnt");
>  ?????? mounted = 0;
> 
>  ?????? tst_res(TPASS, "Test passed");
> }
> 
> Would that be ok for you or is there another variant of TST_EXP*, that 
> uses tst_brk?

I guess that we should check the return value from tst_umount() here as
well, so ti would be better as:

	if (tst_umount("mnt")) {
		tst_brk(TBROK, "Failed to unmount squashfs");
	} else {
		mounted = 0;
		tst_res(TPASS, "Squashfs unmounted");
	}

-- 
Cyril Hrubis
chrubis@suse.cz
