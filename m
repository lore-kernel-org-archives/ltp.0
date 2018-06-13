From: Rafael Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 13 Jun 2018 18:36:09 -0300
Subject: [LTP] [PATCH 4.4 00/24] 4.4.137-stable review
In-Reply-To: <CADtBP2BaavgU7=sHUZYYiuFHya9m7KK-+gu_v6BHkO1bX1eSkA@mail.gmail.com>
References: <20180612164816.587001852@linuxfoundation.org>
 <CADtBP2D4a2OdLsAgZ8sRFBhkh2jArviaYNzYrS7wqdmogyc=Mg@mail.gmail.com>
 <CADtBP2BaavgU7=sHUZYYiuFHya9m7KK-+gu_v6BHkO1bX1eSkA@mail.gmail.com>
Message-ID: <CADtBP2BQn+76Av8j87kzDs3R4V=+aj9+E9xyAz2yEjATk6MJcA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

I forgot to cc LTP mailing list in the thread. Here is the thread url at le=
ast:

https://lkml.org/lkml/2018/6/13/714

Thank you
-Rafael

On 13 June 2018 at 17:52, Rafael Tinoco <rafael.tinoco@linaro.org> wrote:
> FYI on issue #341
>
> Thanks Jan for pointing out commit 0cc3b0ec23ce right after I opened the =
issue.
>
> Best,
> -Rafael
>
> ---------- Forwarded message ----------
> From: Rafael Tinoco <rafael.tinoco@linaro.org>
> Date: 13 June 2018 at 17:47
> Subject: Re: [PATCH 4.4 00/24] 4.4.137-stable review
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org, shuah@kernel.org,
> patches@kernelci.org, lkft-triage@lists.linaro.org,
> ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
> akpm@linux-foundation.org, torvalds@linux-foundation.org,
> linux@roeck-us.net
>
>
> Results from Linaro=E2=80=99s test farm.
> Regressions detected.
>
> NOTE:
>
> 1) LTP vma03 test (cve-2011-2496) broken on v4.4-137-rc1 because of:
>
>      6ea1dc96a03a mmap: relax file size limit for regular files
>      bd2f9ce5bacb mmap: introduce sane default mmap limits
>
>    discussion:
>
>      https://github.com/linux-test-project/ltp/issues/341
>
>    mainline commit (v4.13-rc7):
>
>      0cc3b0ec23ce Clarify (and fix) MAX_LFS_FILESIZE macros
>
>    should be backported to 4.4.138-rc2 and fixes the issue.
>
> 2) select04 failure on x15 board will be investigated in:
>
>      https://bugs.linaro.org/show_bug.cgi?id=3D3852
>
>    and seems to be a timing issue (HW related).
>
> Summary
> ------------------------------------------------------------------------
>
> kernel: 4.4.137-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
> git branch: linux-4.4.y
> git commit: 678437d36d4e14a029309f1c282802ce47fda36a
> git describe: v4.4.136-25-g678437d36d4e
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/b=
uild/v4.4.136-25-g678437d36d4e
>
> Regressions (compared to build v4.4.136)
> ------------------------------------------------------------------------
>
> qemu_arm:
>   ltp-cve-tests:
>     * cve-2011-2496
>     * runltp_cve
>
>     * test src: git://github.com/linux-test-project/ltp.git
>
> x15 - arm:
>   ltp-cve-tests:
>     * cve-2011-2496
>     * runltp_cve
>
>     * test src: git://github.com/linux-test-project/ltp.git
>   ltp-syscalls-tests:
>     * runltp_syscalls
>     * select04
>
>     * test src: git://github.com/linux-test-project/ltp.git
>
> Ran 7100 total tests in the following environments and test suites.
>
> Environments
> --------------
> - juno-r2 - arm64
> - qemu_arm
> - qemu_x86_64
> - x15 - arm
> - x86_64
>
> Test Suites
> -----------
> * boot
> * kselftest
> * libhugetlbfs
> * ltp-cap_bounds-tests
> * ltp-containers-tests
> * ltp-cve-tests
> * ltp-fcntl-locktests-tests
> * ltp-filecaps-tests
> * ltp-fs-tests
> * ltp-fs_bind-tests
> * ltp-fs_perms_simple-tests
> * ltp-fsx-tests
> * ltp-hugetlb-tests
> * ltp-io-tests
> * ltp-ipc-tests
> * ltp-math-tests
> * ltp-nptl-tests
> * ltp-pty-tests
> * ltp-sched-tests
> * ltp-securebits-tests
> * ltp-syscalls-tests
> * ltp-timers-tests
> * kselftest-vsyscall-mode-native
> * kselftest-vsyscall-mode-none
>
> Summary
> ------------------------------------------------------------------------
>
> kernel: 4.4.137-rc1
> git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
> git branch: 4.4.137-rc1-hikey-20180612-214
> git commit: e5d5cb57472f9f98a68f872664de3d70610019e1
> git describe: 4.4.137-rc1-hikey-20180612-214
> Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4=
.4-oe/build/4.4.137-rc1-hikey-20180612-214
>
> No regressions (compared to build 4.4.136-rc2-hikey-20180606-212)
>
> Ran 2611 total tests in the following environments and test suites.
>
> Environments
> --------------
> - hi6220-hikey - arm64
> - qemu_arm64
>
> Test Suites
> -----------
> * boot
> * kselftest
> * libhugetlbfs
> * ltp-cap_bounds-tests
> * ltp-containers-tests
> * ltp-cve-tests
> * ltp-fcntl-locktests-tests
> * ltp-filecaps-tests
> * ltp-fs_bind-tests
> * ltp-fs_perms_simple-tests
> * ltp-fsx-tests
> * ltp-hugetlb-tests
> * ltp-io-tests
> * ltp-ipc-tests
> * ltp-math-tests
> * ltp-nptl-tests
> * ltp-pty-tests
> * ltp-sched-tests
> * ltp-securebits-tests
> * ltp-syscalls-tests
> * ltp-timers-tests
> * ltp-fs-tests
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>
> On 12 June 2018 at 13:51, Greg Kroah-Hartman <gregkh@linuxfoundation.org>=
 wrote:
>> This is the start of the stable review cycle for the 4.4.137 release.
>> There are 24 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu Jun 14 16:48:07 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch=
-4.4.137-rc1.gz
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git linux-4.4.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
