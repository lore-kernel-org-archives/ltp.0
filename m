From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 14 Jun 2018 11:01:51 +0200
Subject: [LTP] [PATCH 4.4 00/24] 4.4.137-stable review
In-Reply-To: <CA+G9fYut-A0L9iWJbzbSfmc=gjmQ17iabcPfXxqDKocwpYYTOQ@mail.gmail.com>
References: <20180612164816.587001852@linuxfoundation.org>
 <CADtBP2D4a2OdLsAgZ8sRFBhkh2jArviaYNzYrS7wqdmogyc=Mg@mail.gmail.com>
 <20180613210044.GA15146@kroah.com>
 <CABdQkv9uNjf7ARKBJ-sE_RVruMA5U9bTNo-EL_+7Rv8ZVJGY3w@mail.gmail.com>
 <CADtBP2DZ0ceTtwaG7AdXV3xa16mQ6nu=gaqUYj7JSOLBdVD8cg@mail.gmail.com>
 <20180614063448.GB6021@kroah.com>
 <CA+G9fYut-A0L9iWJbzbSfmc=gjmQ17iabcPfXxqDKocwpYYTOQ@mail.gmail.com>
Message-ID: <20180614090151.GA24997@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Thu, Jun 14, 2018 at 02:24:25PM +0530, Naresh Kamboju wrote:
> On 14 June 2018 at 12:04, Greg Kroah-Hartman <gregkh@linuxfoundation.org>=
 wrote:
> > On Wed, Jun 13, 2018 at 10:48:50PM -0300, Rafael Tinoco wrote:
> >> On 13 June 2018 at 18:08, Rafael David Tinoco
> >> <rafaeldtinoco@kernelpath.com> wrote:
> >> > On Wed, Jun 13, 2018 at 6:00 PM, Greg Kroah-Hartman
> >> > <gregkh@linuxfoundation.org> wrote:
> >> >> On Wed, Jun 13, 2018 at 05:47:49PM -0300, Rafael Tinoco wrote:
> >> >>> Results from Linaro=E2=80=99s test farm.
> >> >>> Regressions detected.
> >> >>>
> >> >>> NOTE:
> >> >>>
> >> >>> 1) LTP vma03 test (cve-2011-2496) broken on v4.4-137-rc1 because o=
f:
> >> >>>
> >> >>>      6ea1dc96a03a mmap: relax file size limit for regular files
> >> >>>      bd2f9ce5bacb mmap: introduce sane default mmap limits
> >> >>>
> >> >>>    discussion:
> >> >>>
> >> >>>      https://github.com/linux-test-project/ltp/issues/341
> >> >>>
> >> >>>    mainline commit (v4.13-rc7):
> >> >>>
> >> >>>      0cc3b0ec23ce Clarify (and fix) MAX_LFS_FILESIZE macros
> >> >>>
> >> >>>    should be backported to 4.4.138-rc2 and fixes the issue.
> >> >>
> >> >> Really?  That commit says it fixes c2a9737f45e2 ("vfs,mm: fix a dead
> >> >> loop in truncate_inode_pages_range()") which is not in 4.4.y at all.
> >> >>
> >> >> Did you test this out?
> >> >
> >> > Yes, the LTP contains the tests (last comment is the final test for
> >> > arm32, right before Jan tests i686).
> >> >
> >> > Fixing MAX_LFS_FILESIZE fixes the new limit for mmap() brought by
> >> > those 2 commits (file_mmap_size_max()).
> >> > offset tested by the LTP test is 0xfffffffe000.
> >> > file_mmap_size_max gives: 0xFFFFFFFF000 as max value, but only after
> >> > the mentioned patch.
> >> >
> >> > Original intent for this fix was other though.
> >>
> >> To clarify this a bit further.
> >>
> >> The LTP CVE test is breaking in the first call to mmap(), even before
> >> trying to remap and test the security issue. That start happening in
> >> this round because of those mmap() changes and the offset used in the
> >> LTP test. Linus changed limit checks and made them to be related to
> >> MAX_LFS_FILESIZE. Unfortunately, in 4.4 stable, we were missing the
> >> fix for MAX_LFS_FILESIZE (which before commit 0cc3b0ec23ce was less
> >> than the REAL 32 bit limit).
> >>
> >> Commit 0cc3b0ec23ce was made because an user noticed the FS limit not
> >> being what it should be. In our case, the 4.4 stable kernel, we are
> >> facing this 32 bit lower limit (than the real 32 bit real limit),
> >> because of the LTP CVE test, so we need this fix to have the real 32
> >> bit limit set for that macro (mmap limits did not use that macro
> >> before).
> >>
> >> I have tested in arm32 and Jan Stancek, who first responded to LTP
> >> issue, has tested this in i686 and both worked after that patch was
> >> included to v4.4-137-rc1 (my last test was even with 4.4.138-rc1).
> >>
> >> Hope that helps a bit.
> >
> > Ok, thanks, it didn't apply cleanly but I've fixed it up now.
>=20
> On the latest 4.4.138-rc1,
> LTP "cve-2011-2496" test still fails on arm32 beagleboard x15 and qemu_ar=
m.
>=20
> Summary
> ------------------------------------------------------------------------
> kernel: 4.4.138-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
> git branch: linux-4.4.y
> git commit: 7d690c56754ef7be647fbcf7bcdceebd59926b3f
> git describe: v4.4.137-15-g7d690c56754e
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/b=
uild/v4.4.137-15-g7d690c56754e

Ok, but what does this mean?  Is there a commit somewhere that I need to
pick up for 4.4.y that is already in newer kernels?

I have no idea what that cve is, as I never track them, and it's
something that was reported to predate the 4.4 kernel release :)

thanks,

greg k-h
