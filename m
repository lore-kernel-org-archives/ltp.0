From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 4 Oct 2018 09:15:40 +0300
Subject: [LTP] [PATCH 2/4] syscalls/readahead02: Convert to newlib and
	cleanup
In-Reply-To: <701041971.55976403.1538583426048.JavaMail.zimbra@redhat.com>
References: <20180928130621.28932-1-amir73il@gmail.com>
 <20180928130621.28932-3-amir73il@gmail.com>
 <1801488452.55763249.1538570871657.JavaMail.zimbra@redhat.com>
 <CAOQ4uxjCgVYeG1eGUF1whFmMnorzaCk_d0KjXYni1=zpSwRHfQ@mail.gmail.com>
 <701041971.55976403.1538583426048.JavaMail.zimbra@redhat.com>
Message-ID: <CAOQ4uxioCbWRyWDAdrsK6bT2YMpUzuxLNAXS3+_p7x6ZMHv5Vw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Oct 3, 2018 at 7:17 PM Jan Stancek <jstancek@redhat.com> wrote:
>
[...]
> > > Would it make sense to enable this for 'all_filesystems = 1'?
> >
> > I don't know. Not sure which tests are good candidates for that.
> > But anyway it's a different change.
> >
[...]
>
> Isn't the reason for your series to test on different fs as well? :-)
>

Well, yes and no.

Yes, overlayfs is a filesystem driver.

No, I don't think overlayfs was what the author of all_filesystems had in mind,
because setting .dev_fs_type = "overlay" is not enough to describe the setup.
That sort of setup would need to be described something like this:
.dev_fs_type = "foo",
.mntpoint = MNTPOINT,
.overlay_mount = OVL_MNT,

So overlayfs does not belong on the all_filesystems axis IMO, it belongs
on a tangent axis of the test matrix, e.g.:
.all_filesystems = 1,
.needs_overlay = 1,
.mntpoint = MNTPOINT,
.overlay_mount = OVL_MNT,

I personally question the value of such feature, but putting something like
setup_overlay() in a library is probably not a bad idea.
A similar pattern already exists in inotify07/inotify08, however in
those tests as
well as in readahead02, a feature of .need_overlay = 1 if existed would not
have been sufficient.

Thanks,
Amir.
