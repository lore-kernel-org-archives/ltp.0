From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 29 Oct 2019 12:45:53 +0530
Subject: [LTP] [PATCH 4.14 000/119] 4.14.151-stable review
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
Message-ID: <CA+G9fYvGEEjnf0paJLS7UDJt0hJg8G+MOD+7hPdyyORVnGkoDw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 28 Oct 2019 at 02:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.151 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue 29 Oct 2019 08:27:02 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.151-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro?s test farm.
No regressions on arm64, arm, x86_64, and i386.

Note:
The new test case  from LTP version upgrade syscalls sync_file_range02 is an
intermittent failure. We are investigating this case.
The listed fixes in the below section are due to LTP upgrade to v20190930.

Summary
------------------------------------------------------------------------

kernel: 4.14.151-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 80117985de0635c8d7fa58fa198b7bbbd465542d
git describe: v4.14.150-118-g80117985de06
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.150-118-g80117985de06

No regressions (compared to build v4.14.149-66-g66f69184d722)


Fixes (compared to build v4.14.149-66-g66f69184d722)
------------------------------------------------------------------------

ltp-syscalls-tests:
    * ustat02
    * ioctl_ns05
    * ioctl_ns06

Ran 17364 total tests in the following environments and test suites.

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
* build
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-dio-tests
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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* network-basic-tests
* ltp-open-posix-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* kvm-unit-tests

-- 
Linaro LKFT
https://lkft.linaro.org
