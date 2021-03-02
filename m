From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Mar 2021 11:43:59 +0100
Subject: [LTP] [PATCH] lib/tst_supported_fs_types.c: Add tmpfs to
 filesystem whitelist
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB40387BFA9@dggeml511-mbs.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB40387BFA9@dggeml511-mbs.china.huawei.com>
Message-ID: <YD4W7+BRQsnspQcj@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > But there is another problem there, since the code still mounts tmpfs on
> > tmpdir for a short while, which is temporary directory used by all LTP tests,
> > which may potentially break tests that runs in parallel.
> 
> 	In general, when all_filesystems has been set to 1,  the needs_tmpdir would be set to 1 and the mntpoint must has been set to some path, so the test run in /tmp/tmpxxxxxx/mntpoint and
> 	other LTP tests would run in another tmpdir. So it has no problem for running in parallel.
> 
> 	I don't know if I understand it right.

The has_kernel_support() uses TMPDIR as the mount point, which is the
parent directory for all LTP tests, moreover it often points to just
"/tmp". If you mount anything over that directory, even for a short
while, the whole system will get different and empty "/tmp" which will
possibly break many things.

We may get over this with using "." instead, in a case that testcase has
created temporary directory and changed the PWD to it, but it's not that
simple either, since tst_test.c is not the only place that calls
has_kernel_support().

We have testcases/lib/tst_supported_fs.c helper as well that is used by
shell tests. This is a standalone binary that does not create a
temporary directory and should work even without TMPDIR being set, which
is the reason we have the if (!tmpdir) tmpdir = "/tmp"; check in the
has_kernel_support() function to begin with.

So all in all I guess that safest option would be to create a unique
temporary directory under TMPDIR and use it as a mount point in the
has_kernel_support() function.

-- 
Cyril Hrubis
chrubis@suse.cz
