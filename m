From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 16 Jul 2018 17:31:44 -0400 (EDT)
Subject: [LTP] [PATCH 4.17 00/67] 4.17.7-stable review
In-Reply-To: <CA+G9fYtVSorLiG5cZdqtipy4XO1zr1HUZ4gH7tf_07m-B4HS1w@mail.gmail.com>
References: <20180716073443.294323458@linuxfoundation.org>
 <CA+G9fYtVSorLiG5cZdqtipy4XO1zr1HUZ4gH7tf_07m-B4HS1w@mail.gmail.com>
Message-ID: <2078122506.33400530.1531776704409.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it



----- Original Message -----
> On 16 July 2018 at 13:04, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> wrote:
> > This is the start of the stable review cycle for the 4.17.7 release.
> > There are 67 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Jul 18 07:34:11 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patc=
h-4.17.7-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
> >         linux-4.17.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>=20
>=20
> Results from Linaro=E2=80=99s test farm.
> Regressions detected.
>=20
> LTP syscalls failed test cases on all devices arm64, arm32 and x86_64,
>  - creat08
>  - open10

This is consequence of:
  0fa3ecd87848 ("Fix up non-directory creation in SGID directories")

So likely cause of action here will be modifying both tests to not
expect S_ISGID in scenario described in commit above.

[adding Dave Chinner]

@Dave: Does XFS need separate patch for problem described in commit
0fa3ecd87848? XFS doesn't appear to use inode_init_owner() function,
both tests currently PASS the check for S_ISGID on file created by
non-group member as of v4.18-rc5.

Regards,
Jan

>=20
> Reported this bug internally on upstream Linux mainline week back.
> Now this bug happening on 4.17, 4.14, 4.9 and 4.4
>=20
> creat08 and open10 failed with this error,
> TFAIL  : testdir.B.3132/setgid: Incorrect modes, setgid bit should be set
>=20
> Test case description:
> /*
>  * NAME
>  * creat08.c - Verifies that the group ID and setgid bit are
>  *    set correctly when a new file is created.
>  *    (ported from SPIE, section2/iosuite/creat5.c,
>  *     by Airong Zhang <zhanga@us.ibm.com>)
>  * CALLS
>  * creat
>  *
>  * ALGORITHM
>  * Create two directories, one with the group ID of this process
>  * and the setgid bit not set, and the other with a group ID
>  * other than that of this process and with the setgid bit set.
>  * In each directory, create a file with and without the setgid
>  * bit set in the creation modes. Verify that the modes and group
>  * ID are correct on each of the 4 files.
>  * As root, create a file with the setgid bit on in the
>  * directory with the setgid bit.
>  * This tests the SVID3 create group semantics.
>  */
>=20
> Block2 testing:
> /*--------------------------------------------------------------*/
> /* Block2: Create two files in testdir.B, one with the setgid   */
> /*         bit set in the creation modes and the other without. */
> /*    Both should inherit the group ID of the parent       */
> /*    directory, group2.                                   */
> /*--------------------------------------------------------------*/
>=20
>=20
> Test results comparison on mainline versions,
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-t=
ests/creat08
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-t=
ests/open10
>=20
> Test results comparison on 4.17 versions,
> https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/tests/ltp-sysc=
alls-tests/creat08
> https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/tests/ltp-sysc=
alls-tests/open10
>=20
> Bug report link,
> https://bugs.linaro.org/show_bug.cgi?id=3D3940
>=20
> Summary
> ------------------------------------------------------------------------
>=20
> kernel: 4.17.7-rc1
> git repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.17.y
> git commit: bc0bd9e05fa1e213c689620eb4cba825c03dcc4a
> git describe: v4.17.6-68-gbc0bd9e05fa1
> Test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/build/v4.17.6-=
68-gbc0bd9e05fa1
>=20
> Regressions (compared to build v4.17.6-67-g3b02b1fd1975)
> ------------------------------------------------------------------------
>=20
> LTP syscalls failed test cases on all devices,
>=20
>  - creat08
>  - open10
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org
>=20
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>=20
