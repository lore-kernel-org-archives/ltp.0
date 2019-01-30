From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 30 Jan 2019 18:31:26 +0530
Subject: [LTP] [PATCH 4.9 00/44] 4.9.154-stable review
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
Message-ID: <CA+G9fYt3ULoisteyhtZw=C8w_1kFquU0ucEzt-YzT2fGYACVYw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Tue, 29 Jan 2019 at 17:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.154 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jan 31 11:31:22 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.154-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

RC2 report.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE:
-----
LTP upgrade to 20190115 and found fanotify01 test failed
and LTP syscall test case  bind03 getting pass now on 4.9 and 4.4
version kernel.

fanotify01 failed on hikey and dragonboard410c arm64 boards all kernel vers=
ions
fanotify01.c:256: FAIL: got event: mask=3D2 (expected 20) pid=3D2756 fd=3D9
https://bugs.linaro.org/show_bug.cgi?id=3D4261

Summary
------------------------------------------------------------------------

kernel: 4.9.154-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 6674590d15d227f4096f193f8e6fb737ef41e89f
git describe: v4.9.153-43-g6674590d15d2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.153-43-g6674590d15d2

No regressions (compared to build v4.9.153)


Fixes (compared to build v4.9.153)
------------------------------------------------------------------------
LTP syscalls test case "bind03" fixed and getting pass on all devices.


Ran 21980 total tests in the following environments and test suites.

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
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-cve-tests
* ltp-open-posix-tests
* spectre-meltdown-checker-test
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
