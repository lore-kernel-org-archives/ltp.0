From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jan 2020 11:41:14 +0100
Subject: [LTP] [PATCH v4] syscalls/newmount: new test case for new mount
 API
In-Reply-To: <20200117110554.GG14282@dhcp-12-102.nay.redhat.com>
References: <20200116075633.29752-1-zlang@redhat.com>
 <20200116114900.GA4897@rei>
 <20200116150849.GF14282@dhcp-12-102.nay.redhat.com>
 <20200117074828.GA3979@dell5510>
 <20200117110554.GG14282@dhcp-12-102.nay.redhat.com>
Message-ID: <20200123104114.GD27845@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The only thing with bothers me is is that NTFS related failure
> > on CONFIG_NTFS_FS is not set and mkfs.ntfs installed.
> > I'd prefer at least to have a warning, but but better to fix it.
> > I guess it's LTP problem, see code at safe_mount() in lib/safe_macros.c
> > 
> > 	/*
> > 	 * Don't try using the kernel's NTFS driver when mounting NTFS, since
> > 	 * the kernel's NTFS driver doesn't have proper write support.
> > 	 */
> > 	if (!filesystemtype || strcmp(filesystemtype, "ntfs")) {
> > 		rval = mount(source, target, filesystemtype, mountflags, data);
> > 		if (!rval)
> > 			return 0;
> > 	}
> > 
> > But obviously we don't use it as we do mount in the test, not in the library.
> > So I propose (and can implement) to add flag TST_FS_SKIP_NTFS 0x02 into include/tst_fs.h
> > and use it in test.
> 
> Maybe LTP should do more check to decide a fs list will be tested, not only check
> mkfs.$FSTPE tools. For example, check:
> 1) mkfs.$FSTYPE is exist
> 2) ${FSTYPE}.ko is loaded, or can be loaded.

That obivously does not work for filesystems build into the kernel.

> Or check:
> 1) mkfs.$FSTYPE $tmpdev run passed
> 2) mount $tmpdev $tmpmnt passed
> 3) umount $tmpdev
> 4) remove $tmpdev and $tmpmnt

If you have a look at the lib/tst_supported_fs_types.c we actually do
this for filesystems implemented in the kernel. For FUSE we only check
that FUSE is enabled in the kernel and that mount.$fs_type is present,
which should be enough to tell if the filesystem is supported.

> For FUSE, I think we'd better to not test FUSE by default. Then let the case decide if
> it would like to support a FUSE fs test. Change the TST_FS_SKIP_FUSE to TST_FS_SUP_FUSE,
> if someone case wants to test a FUSE fs (likes ntfs), it should do special steps to mount
> it, or it'll test linux internal ntfs.ko.

It works fine for majority of testcases, the mount() and fsmount()
syscalls are kind of special here. I guess that all we need to do here
is to skip the fuse here.

-- 
Cyril Hrubis
chrubis@suse.cz
