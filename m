From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 30 Jan 2019 18:25:20 +0530
Subject: [LTP] [PATCH 4.14 00/68] 4.14.97-stable review
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
Message-ID: <CA+G9fYvh6axRDLWpR3_ozw46JUknsYgEjvYOZfQEUbhroHPVTA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Tue, 29 Jan 2019 at 17:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.97 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jan 31 11:31:10 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.97-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE:
-----
LTP upgrade to 20190115 and fanotify01, fanotify09 and readahead02 tests fa=
iled

fanotify01 failed on hikey and dragonboard410c arm64 boards all kernel vers=
ions
fanotify01.c:256: FAIL: got event: mask=3D2 (expected 20) pid=3D2756 fd=3D9
https://bugs.linaro.org/show_bug.cgi?id=3D4261

fanotify09 failed on arm64 devices running 4.14 version kernel
fanotify09.c:202: FAIL: first group got more than 2 events (72 > 48)
https://bugs.linaro.org/show_bug.cgi?id=3D4271

readahead02 failed on arm32 x15 device.
Need to enable CONFIG_TASKSTATS and CONFIG_TASK_IO_ACCOUNTING on arm32 devi=
ce

Summary
------------------------------------------------------------------------

kernel: 4.14.97-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 958f665be23ee580aed7e445d3dc4700a0d31a48
git describe: v4.14.96-69-g958f665be23e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.96-69-g958f665be23e

No regressions (compared to build v4.14.96)

No fixes (compared to build v4.14.96)


Ran 22094 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-math-tests
* ltp-open-posix-tests
* prep-tmp-disk
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
