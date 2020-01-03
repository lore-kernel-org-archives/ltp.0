From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 3 Jan 2020 20:33:22 +0530
Subject: [LTP] [PATCH 5.4 000/191] 5.4.8-stable review
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
Message-ID: <CA+G9fYuPkOGKbeQ0FKKx4H0Bs-nRHALsFtwyRw0Rt5DoOCvRHg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 3 Jan 2020 at 03:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.8 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 04 Jan 2020 21:55:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

LTP syscalls memfd_create04 failed on arm64 devices.
Test PASS on arm, i386 and x86_64.

We are bisecting this failure on arm64.

Test case failed log,
memfd_create04.c:68: INFO: Attempt to create file using 64kB huge page size
memfd_create04.c:76: FAIL: memfd_create() failed unexpectedly: ENOENT (2)

Strace output:
memfd_create(\"tfile\", MFD_HUGETLB|0x40000000) = -1 ENOENT (No such
file or directory)

Test case Description,

/*
* Test: Validating memfd_create() with MFD_HUGETLB and MFD_HUGE_x flags.
*
* Test cases: Attempt to create files in the hugetlbfs filesystem using
* different huge page sizes.
*
* Test logic: memfd_create() should return non-negative value (fd)
* if the system supports that particular huge page size.
* On success, fd is returned.
* On failure, -1 is returned with ENODEV error.
*/

Test code snippet:
<>
check_hugepage_support(&tflag);
tst_res(TINFO,
"Attempt to create file using %s huge page size",
tflag.h_size);

fd = sys_memfd_create("tfile", MFD_HUGETLB | tflag.flag);
if (fd < 0) {
if (errno == tflag.exp_err)
tst_res(TPASS, "Test failed as expected\n");
else
tst_brk(TFAIL | TERRNO,
"memfd_create() failed unexpectedly");
return;
}
<>

Steps to reproduce:
          - cd /opt/ltp/testcases/bin/
          - ./memfd_create04

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/memfd_create/memfd_create04.c#L75

Test output log,
https://lkft.validation.linaro.org/scheduler/job/1081716

Test results comparison,
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/tests/ltp-syscalls-tests/memfd_create04


-- 
Linaro LKFT
https://lkft.linaro.org
