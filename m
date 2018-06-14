From: Rafael Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 14 Jun 2018 07:54:45 -0300
Subject: [LTP] [PATCH 4.4 00/24] 4.4.137-stable review
In-Reply-To: <602443463.26544751.1528972563608.JavaMail.zimbra@redhat.com>
References: <20180612164816.587001852@linuxfoundation.org>
 <CABdQkv9uNjf7ARKBJ-sE_RVruMA5U9bTNo-EL_+7Rv8ZVJGY3w@mail.gmail.com>
 <CADtBP2DZ0ceTtwaG7AdXV3xa16mQ6nu=gaqUYj7JSOLBdVD8cg@mail.gmail.com>
 <20180614063448.GB6021@kroah.com>
 <CA+G9fYut-A0L9iWJbzbSfmc=gjmQ17iabcPfXxqDKocwpYYTOQ@mail.gmail.com>
 <20180614090151.GA24997@kroah.com>
 <2072095076.26539556.1528969792388.JavaMail.zimbra@redhat.com>
 <20180614102119.GA19094@kroah.com>
 <602443463.26544751.1528972563608.JavaMail.zimbra@redhat.com>
Message-ID: <CADtBP2AeL8PtsnBOQdaC=JJbTStdQH+XLrjyKg3L8gYRRrc8zQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Jan, Naresh,

Patch has been queued to 4.4 (for the next review round, yet to be
merged to stable-rc branch):

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-4.4

as "clarify-and-fix-max_lfs_filesize-macros.patch"

Thank you!

On 14 June 2018 at 07:36, Jan Stancek <jstancek@redhat.com> wrote:
>
> ----- Original Message -----
>> On Thu, Jun 14, 2018 at 05:49:52AM -0400, Jan Stancek wrote:
>> >
>> > ----- Original Message -----
>> > > On Thu, Jun 14, 2018 at 02:24:25PM +0530, Naresh Kamboju wrote:
>> > > > On 14 June 2018 at 12:04, Greg Kroah-Hartman
>> > > > <gregkh@linuxfoundation.org>
>> > > > wrote:
>> > > > > On Wed, Jun 13, 2018 at 10:48:50PM -0300, Rafael Tinoco wrote:
>> > > > >> On 13 June 2018 at 18:08, Rafael David Tinoco
>> > > > >> <rafaeldtinoco@kernelpath.com> wrote:
>> > > > >> > On Wed, Jun 13, 2018 at 6:00 PM, Greg Kroah-Hartman
>> > > > >> > <gregkh@linuxfoundation.org> wrote:
>> > > > >> >> On Wed, Jun 13, 2018 at 05:47:49PM -0300, Rafael Tinoco wrot=
e:
>> > > > >> >>> Results from Linaro=E2=80=99s test farm.
>> > > > >> >>> Regressions detected.
>> > > > >> >>>
>> > > > >> >>> NOTE:
>> > > > >> >>>
>> > > > >> >>> 1) LTP vma03 test (cve-2011-2496) broken on v4.4-137-rc1 be=
cause
>> > > > >> >>> of:
>> > > > >> >>>
>> > > > >> >>>      6ea1dc96a03a mmap: relax file size limit for regular f=
iles
>> > > > >> >>>      bd2f9ce5bacb mmap: introduce sane default mmap limits
>> > > > >> >>>
>> > > > >> >>>    discussion:
>> > > > >> >>>
>> > > > >> >>>      https://github.com/linux-test-project/ltp/issues/341
>> > > > >> >>>
>> > > > >> >>>    mainline commit (v4.13-rc7):
>> > > > >> >>>
>> > > > >> >>>      0cc3b0ec23ce Clarify (and fix) MAX_LFS_FILESIZE macros
>> > > > >> >>>
>> > > > >> >>>    should be backported to 4.4.138-rc2 and fixes the issue.
>> > > > >> >>
>> > > > >> >> Really?  That commit says it fixes c2a9737f45e2 ("vfs,mm: fi=
x a
>> > > > >> >> dead
>> > > > >> >> loop in truncate_inode_pages_range()") which is not in 4.4.y=
 at
>> > > > >> >> all.
>> > > > >> >>
>> > > > >> >> Did you test this out?
>> > > > >> >
>> > > > >> > Yes, the LTP contains the tests (last comment is the final te=
st
>> > > > >> > for
>> > > > >> > arm32, right before Jan tests i686).
>> > > > >> >
>> > > > >> > Fixing MAX_LFS_FILESIZE fixes the new limit for mmap() brough=
t by
>> > > > >> > those 2 commits (file_mmap_size_max()).
>> > > > >> > offset tested by the LTP test is 0xfffffffe000.
>> > > > >> > file_mmap_size_max gives: 0xFFFFFFFF000 as max value, but only
>> > > > >> > after
>> > > > >> > the mentioned patch.
>> > > > >> >
>> > > > >> > Original intent for this fix was other though.
>> > > > >>
>> > > > >> To clarify this a bit further.
>> > > > >>
>> > > > >> The LTP CVE test is breaking in the first call to mmap(), even
>> > > > >> before
>> > > > >> trying to remap and test the security issue. That start happeni=
ng in
>> > > > >> this round because of those mmap() changes and the offset used =
in
>> > > > >> the
>> > > > >> LTP test. Linus changed limit checks and made them to be relate=
d to
>> > > > >> MAX_LFS_FILESIZE. Unfortunately, in 4.4 stable, we were missing=
 the
>> > > > >> fix for MAX_LFS_FILESIZE (which before commit 0cc3b0ec23ce was =
less
>> > > > >> than the REAL 32 bit limit).
>> > > > >>
>> > > > >> Commit 0cc3b0ec23ce was made because an user noticed the FS lim=
it
>> > > > >> not
>> > > > >> being what it should be. In our case, the 4.4 stable kernel, we=
 are
>> > > > >> facing this 32 bit lower limit (than the real 32 bit real limit=
),
>> > > > >> because of the LTP CVE test, so we need this fix to have the re=
al 32
>> > > > >> bit limit set for that macro (mmap limits did not use that macro
>> > > > >> before).
>> > > > >>
>> > > > >> I have tested in arm32 and Jan Stancek, who first responded to =
LTP
>> > > > >> issue, has tested this in i686 and both worked after that patch=
 was
>> > > > >> included to v4.4-137-rc1 (my last test was even with 4.4.138-rc=
1).
>> > > > >>
>> > > > >> Hope that helps a bit.
>> > > > >
>> > > > > Ok, thanks, it didn't apply cleanly but I've fixed it up now.
>> > > >
>> > > > On the latest 4.4.138-rc1,
>> > > > LTP "cve-2011-2496" test still fails on arm32 beagleboard x15 and
>> > > > qemu_arm.
>> > > >
>> > > > Summary
>> > > > ------------------------------------------------------------------=
------
>> > > > kernel: 4.4.138-rc1
>> > > > git repo:
>> > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
>> > > > git branch: linux-4.4.y
>> > > > git commit: 7d690c56754ef7be647fbcf7bcdceebd59926b3f
>> > > > git describe: v4.4.137-15-g7d690c56754e
>> > > > Test details:
>> > > > https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4=
.4.137-15-g7d690c56754e
>> > >
>> > > Ok, but what does this mean?  Is there a commit somewhere that I nee=
d to
>> > > pick up for 4.4.y that is already in newer kernels?
>> >
>> > Hi Greg,
>> >
>> > I think the expectations was that:
>> >   0cc3b0ec23ce Clarify (and fix) MAX_LFS_FILESIZE macros
>> > has been included to linux-4.4.y HEAD, so they re-ran the tests.
>> >
>> > Report from Naresh above looks like original report: LTP vma03 is
>> > cve-2011-2496 test.
>>
>> And the test fails now?
>>
>> Still confused.
>
> I don't see the patch (0cc3b0ec23ce) applied to linux-stable-rc.git,
> branch linux-4.4.y:
>   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3Dlinux-4.4.y
>   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/tree/include/linux/fs.h?h=3Dlinux-4.4.y&id=3D7d690c56754ef7be647fbcf7bc=
dceebd59926b3f#n929
>
> That is what has been tested above - is that the correct place
> to get your backport of 0cc3b0ec23ce?
>
> Regards,
> Jan
