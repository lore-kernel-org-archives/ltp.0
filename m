From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 1 Nov 2020 12:34:42 +0530
Subject: [LTP] [PATCH 5.9 00/74] 5.9.3-rc1 review
In-Reply-To: <20201031113500.031279088@linuxfoundation.org>
References: <20201031113500.031279088@linuxfoundation.org>
Message-ID: <CA+G9fYshNJgQFZ_oxb4VgSbe2xWym9am6ajpr-SVH_bw4psa1Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, 31 Oct 2020 at 17:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.9.3 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 02 Nov 2020 11:34:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.9.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro?s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
LTP version upgrade to 20200930. Due to this change we have noticed few test
failures and fixes which are not related to kernel changes.

Summary
------------------------------------------------------------------------

kernel: 5.9.3-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-5.9.y
git commit: dae2c902d0480f9e51891768862f034ee97f4db1
git describe: v5.9.2-75-gdae2c902d048
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.9.y/build/v5.9.2-75-gdae2c902d048

No regressions (compared to build v5.9.2)

No fixes (compared to build v5.9.2)

Fixes (compared to LTP 20200515)
These fixes are coming from LTP upgrade 20200930.
  ltp-commands-tests:
    * logrotate_sh

  ltp-containers-tests:
    * netns_netlink

  ltp-controllers-tests:
    * cpuset_hotplug

  ltp-crypto-tests:
    * af_alg02

  ltp-cve-tests:
    * cve-2017-17805
    * cve-2018-1000199

  ltp-syscalls-tests:
    * clock_gettime03
    * clone302
    * copy_file_range02
    * mknod07
    * ptrace08
    * syslog01
    * syslog02
    * syslog03
    * syslog04
    * syslog05
    * syslog07
    * syslog08
    * syslog09
    * syslog10

  ltp-open-posix-tests:
    * clocks_invaliddates

-- 
Linaro LKFT
https://lkft.linaro.org
