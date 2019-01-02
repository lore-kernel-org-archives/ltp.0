From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Jan 2019 14:19:13 +0100
Subject: [LTP] lib: tst_device.c - /dev/loop0 in use
In-Reply-To: <de5fb563-4273-7132-f94d-887e6e211672@linaro.org>
References: <de5fb563-4273-7132-f94d-887e6e211672@linaro.org>
Message-ID: <20190102131913.GA26215@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Apparently, when having "all_filesystems" flag set for one test, there
> is a room of opportunity for the subsequent filesystems tests to find
> the device, acquired by "tst_acquire_device()", busy.
> 
> I suppose, in the case bellow, fsync() caused async work in some kernel
> thread to cause the "/dev/loop0 is apparently in use by the system"
> error when trying a new mkfs.XXXX call - for the subsequent filesystem -
> using the same acquired device.
> 
> With the "all_filesystems" logic, the acquired device is not detached,
> nor find_free_loopdev() is called again, which *could* mitigate this.

Right, we expect that the device is free to be reused once the umount()
returns to the userspace, which apparently is not true in your case.

Looking into the mkfs code it tries to open() the device RDONLY and we
get this error if the attempt has failed with EBUSY, which likely means
that the umount() is still running in background in kernel.

I guess that we may as well patch the tst_umount() function in
lib/tst_device.c to loop until open() fails with EBUSY in the similar
manner we attempt to retry umount() there.

-- 
Cyril Hrubis
chrubis@suse.cz
