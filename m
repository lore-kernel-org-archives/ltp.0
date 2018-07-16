From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 16 Jul 2018 23:28:35 +0530
Subject: [LTP] [PATCH 4.17 00/67] 4.17.7-stable review
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
Message-ID: <CA+G9fYtVSorLiG5cZdqtipy4XO1zr1HUZ4gH7tf_07m-B4HS1w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On 16 July 2018 at 13:04, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.17.7 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jul 18 07:34:11 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
Regressions detected.

LTP syscalls failed test cases on all devices arm64, arm32 and x86_64,
 - creat08
 - open10

Reported this bug internally on upstream Linux mainline week back.
Now this bug happening on 4.17, 4.14, 4.9 and 4.4

creat08 and open10 failed with this error,
TFAIL  : testdir.B.3132/setgid: Incorrect modes, setgid bit should be set

Test case description:
/*
 * NAME
 * creat08.c - Verifies that the group ID and setgid bit are
 *    set correctly when a new file is created.
 *    (ported from SPIE, section2/iosuite/creat5.c,
 *     by Airong Zhang <zhanga@us.ibm.com>)
 * CALLS
 * creat
 *
 * ALGORITHM
 * Create two directories, one with the group ID of this process
 * and the setgid bit not set, and the other with a group ID
 * other than that of this process and with the setgid bit set.
 * In each directory, create a file with and without the setgid
 * bit set in the creation modes. Verify that the modes and group
 * ID are correct on each of the 4 files.
 * As root, create a file with the setgid bit on in the
 * directory with the setgid bit.
 * This tests the SVID3 create group semantics.
 */

Block2 testing:
/*--------------------------------------------------------------*/
/* Block2: Create two files in testdir.B, one with the setgid   */
/*         bit set in the creation modes and the other without. */
/*    Both should inherit the group ID of the parent       */
/*    directory, group2.                                   */
/*--------------------------------------------------------------*/


Test results comparison on mainline versions,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tes=
ts/creat08
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tes=
ts/open10

Test results comparison on 4.17 versions,
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/tests/ltp-syscal=
ls-tests/creat08
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/tests/ltp-syscal=
ls-tests/open10

Bug report link,
https://bugs.linaro.org/show_bug.cgi?id=3D3940

Summary
------------------------------------------------------------------------

kernel: 4.17.7-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: bc0bd9e05fa1e213c689620eb4cba825c03dcc4a
git describe: v4.17.6-68-gbc0bd9e05fa1
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17.6-68-gbc0bd9e05fa1

Regressions (compared to build v4.17.6-67-g3b02b1fd1975)
------------------------------------------------------------------------

LTP syscalls failed test cases on all devices,

 - creat08
 - open10

--=20
Linaro LKFT
https://lkft.linaro.org
