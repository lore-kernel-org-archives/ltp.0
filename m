From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 1 Apr 2021 13:15:00 +0200
Subject: [LTP] [PATCH] fs/iso9660: bugfix for iso9660/isofs.sh
In-Reply-To: <20210326014137.15718-1-zhanglianjie@uniontech.com>
References: <20210326014137.15718-1-zhanglianjie@uniontech.com>
Message-ID: <YGWrNBxxmVUgT72/@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Debian uses genisoimage to replace mkisofs, the prompt of genisoimage
> is the same as that of mkisofs.

...
> +++ b/testcases/kernel/fs/iso9660/isofs.sh
> @@ -12,6 +12,12 @@
>  TST_NEEDS_CMDS="mkisofs"
>  TST_NEEDS_TMPDIR=1
>  TST_TESTFUNC=do_test
> +which mkisofs >/dev/null 2>&1
> +if [ $? -ne 0 ]; then
> +       TST_NEEDS_CMDS="genisoimage"
> +fi

You can omit whole $? check:

if ! which mkisofs >/dev/null 2>&1; then
	TST_NEEDS_CMDS="genisoimage"
fi

Also IMHO mkisofs is not dead [1], it just moved to schilytools [2] and some
distros use it (at least openSUSE [3]).
Thus asking for genisoimage (from cdrkit) can be a bit misleading.

But, is it really needed? Both Debian [4] and Fedora [5] creates
mkisofs symlink to genisoimage, Debian installs automatically genisoimage when
installing mkisofs.

Kind regards,
Petr

[1] https://wiki.osdev.org/Mkisofs
[2] http://sf.net/projects/schilytools/files/
[3] https://build.opensuse.org/package/show/utilities/schily
[4] https://tracker.debian.org/media/packages/c/cdrkit/changelog-91.1.11-3.2
[5] https://src.fedoraproject.org/rpms/cdrkit/blob/rawhide/f/cdrkit.spec

> +MKISOFS_CMD=$TST_NEEDS_CMDS
...
