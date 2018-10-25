From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 25 Oct 2018 12:40:21 +0530
Subject: [LTP] mainline 4.19.0/a978a5b8d83f: LTP syscalls keyctl05 failed
In-Reply-To: <01000166a88efd1a-9d85efc5-f72f-42de-bf0f-bfd637aff1d1-000000@email.amazonses.com>
References: <01000166a88efd1a-9d85efc5-f72f-42de-bf0f-bfd637aff1d1-000000@email.amazonses.com>
Message-ID: <CA+G9fYtKcgedA=S1QdwaLK8PTO958aeqXM7jdpqFTOcj1Qm68w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP syscalls keyctl05 failure was detected on -next (
4.19.0-rc6-next-20181005) and
reported to LTP mailing list.
Now we have seen this issues on -mainline kernel.

keyctl05 failure not a kernel bug instead test case "keyctl05" needs
to be updated according to the latest upstream changes.

Please find below discussion for more details.

On Thu, 25 Oct 2018 at 05:40, Linaro QA <qa-reports@linaro.org> wrote:
>
> Summary
> ------------------------------------------------------------------------
>
> kernel: 4.19.0
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git branch: master
> git commit: a978a5b8d83f795e107a2ff759b28643739be70e
> git describe: v4.19-4243-ga978a5b8d83f
> Test details: https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v4.19-4243-ga978a5b8d83f
>
> Regressions (compared to build v4.19-1898-g44786880df19)
> ------------------------------------------------------------------------
>
> dragonboard-410c - arm64:
>
>   ltp-syscalls-tests:
>     * keyctl05

"
> Hi!
> > tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
> > keyctl05.c:135: INFO: Try to update the 'asymmetric' key...
> > keyctl05.c:148: PASS: updating 'asymmetric' key expectedly failed with
> > EOPNOTSUPP
> > keyctl05.c:119: BROK: unexpected error adding 'dns_resolver' key: EINVAL
> > tst_test.c:884: BROK: Test 1 haven't reported results!
>
> Looks like kernel does not know 'dns_resolver' key type and as this type
> is registered by the dns_resolver code I suppose that you are missing
> some CONFIG_DNS_RESOLVER, if that is the case the test should handle
> EINVAL and return with TCONF.

I'm guessing it's
  dns: Allow the dns resolver to retrieve a server set
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/net/dns_resolver?id=bbb4c4323a4d9cb5ca04db904aa3050a7586839a
which added some additional checks.

Test currently uses 2 zeroes:

+        const struct dns_payload_header *bin;
...
+               if (datalen <= sizeof(*bin))
+                       return -EINVAL;

+struct dns_payload_header {
+       __u8            zero;           /* Zero byte: marks this as
not being text */
+       __u8            content;        /* enum dns_payload_content_type */
+       __u8            version;        /* Encoding version */
+} __packed;

and commit above appears to need 0x00 0x00 0x01 or 0xFF 0x00 to not
return EINVAL.

Regards,
Jan
"
>
>     * test src: git://github.com/linux-test-project/ltp.git
>
> hi6220-hikey - arm64:
>   ltp-syscalls-tests:
>     * keyctl05
>
>     * test src: git://github.com/linux-test-project/ltp.git
>
> i386:
>   ltp-syscalls-tests:
>     * keyctl05
>
>     * test src: git://github.com/linux-test-project/ltp.git
>
> juno-r2 - arm64:
>   ltp-syscalls-tests:
>     * keyctl05
>
>     * test src: git://github.com/linux-test-project/ltp.git
>
> qemu_arm:
>   ltp-syscalls-tests:
>     * keyctl05
>
>     * test src: git://github.com/linux-test-project/ltp.git
>
> qemu_i386:
>   ltp-syscalls-tests:
>     * keyctl05
>
>     * test src: git://github.com/linux-test-project/ltp.git
>
> qemu_x86_64:
>   ltp-syscalls-tests:
>     * keyctl05
>
>     * test src: git://github.com/linux-test-project/ltp.git
>
> x15 - arm:
>   ltp-syscalls-tests:
>     * keyctl05
>
>     * test src: git://github.com/linux-test-project/ltp.git
>
> x86_64:
>   ltp-syscalls-tests:
>     * keyctl05
>
>     * test src: git://github.com/linux-test-project/ltp.git
>
>
>
> Boards, architectures and test suites:
> -------------------------------------
>
> dragonboard-410c - arm64
> * boot - pass: 20,
> * kselftest - pass: 76, xfail: 16, skip: 37, fail: 4
> * libhugetlbfs - pass: 89, xfail: 1, skip: 1,
> * ltp-containers-tests - pass: 80,
> * ltp-cve-tests - pass: 25, skip: 9,
> * ltp-fcntl-locktests-tests - pass: 1,
> * ltp-filecaps-tests - pass: 1,
> * ltp-fs-tests - pass: 59, skip: 6,
> * ltp-fs_bind-tests - pass: 1,
> * ltp-fs_perms_simple-tests - pass: 18,
> * ltp-fsx-tests - pass: 1,
> * ltp-hugetlb-tests - pass: 19, skip: 2,
> * ltp-io-tests - pass: 2,
> * ltp-ipc-tests - pass: 8,
> * ltp-math-tests - pass: 10,
> * ltp-nptl-tests - pass: 1,
> * ltp-pty-tests - pass: 3,
> * ltp-sched-tests - pass: 13,
> * ltp-securebits-tests - pass: 3,
> * ltp-syscalls-tests - pass: 1014, skip: 133, fail: 1
> * ltp-timers-tests - pass: 12,
>
> hi6220-hikey - arm64
> * boot - pass: 21,
> * kselftest - pass: 16, xfail: 6, skip: 11, fail: 4
> * libhugetlbfs - pass: 90, skip: 1,
> * ltp-cap_bounds-tests - pass: 1,
> * ltp-containers-tests - pass: 80,
> * ltp-cve-tests - pass: 26, skip: 8,
> * ltp-fcntl-locktests-tests - pass: 1,
> * ltp-filecaps-tests - pass: 1,
> * ltp-fs-tests - pass: 59, skip: 6,
> * ltp-fs_bind-tests - pass: 1,
> * ltp-fs_perms_simple-tests - pass: 18,
> * ltp-fsx-tests - pass: 1,
> * ltp-hugetlb-tests - pass: 20, skip: 1,
> * ltp-io-tests - pass: 2,
> * ltp-ipc-tests - pass: 8,
> * ltp-math-tests - pass: 10,
> * ltp-nptl-tests - pass: 1,
> * ltp-pty-tests - pass: 3,
> * ltp-sched-tests - pass: 9, skip: 4,
> * ltp-securebits-tests - pass: 3,
> * ltp-syscalls-tests - pass: 1013, skip: 134, fail: 1
> * ltp-timers-tests - pass: 12,
>
> i386
> * boot - pass: 22,
> * kselftest - pass: 104, xfail: 18, skip: 31, fail: 4
> * libhugetlbfs - pass: 1,
> * ltp-cap_bounds-tests - pass: 1,
> * ltp-containers-tests - pass: 80,
> * ltp-cve-tests - pass: 28, xfail: 1, skip: 4, fail: 1
> * ltp-filecaps-tests - pass: 1,
> * ltp-fs-tests - pass: 59, skip: 6,
> * ltp-fs_bind-tests - pass: 1,
> * ltp-fs_perms_simple-tests - pass: 18,
> * ltp-hugetlb-tests - pass: 19, skip: 1,
> * ltp-io-tests - pass: 2,
> * ltp-ipc-tests - pass: 8,
> * ltp-math-tests - pass: 10,
> * ltp-nptl-tests - pass: 1,
> * ltp-open-posix-tests - pass: 1689, xfail: 5, skip: 40,
> * ltp-pty-tests - pass: 2,
> * ltp-sched-tests - pass: 9, skip: 4,
> * ltp-securebits-tests - pass: 3,
> * ltp-syscalls-tests - pass: 1087, skip: 59, fail: 1
> * ltp-timers-tests - pass: 12,
>
> juno-r2 - arm64
> * boot - pass: 22,
> * kselftest - pass: 78, xfail: 15, skip: 34, fail: 4
> * libhugetlbfs - pass: 90, skip: 1,
> * ltp-cap_bounds-tests - pass: 1,
> * ltp-containers-tests - pass: 80,
> * ltp-cve-tests - pass: 25, skip: 9,
> * ltp-fcntl-locktests-tests - pass: 1,
> * ltp-filecaps-tests - pass: 1,
> * ltp-fs-tests - pass: 59, skip: 6,
> * ltp-fs_bind-tests - pass: 1,
> * ltp-fs_perms_simple-tests - pass: 18,
> * ltp-fsx-tests - pass: 1,
> * ltp-hugetlb-tests - pass: 21,
> * ltp-io-tests - pass: 2,
> * ltp-ipc-tests - pass: 8,
> * ltp-math-tests - pass: 10,
> * ltp-nptl-tests - pass: 1,
> * ltp-open-posix-tests - pass: 1689, xfail: 5, skip: 41,
> * ltp-pty-tests - pass: 3,
> * ltp-sched-tests - pass: 9, skip: 4,
> * ltp-securebits-tests - pass: 3,
> * ltp-syscalls-tests - pass: 1014, skip: 133, fail: 1
> * ltp-timers-tests - pass: 12,
>
> qemu_arm
> * boot - pass: 21,
> * kselftest - pass: 68, xfail: 18, skip: 42, fail: 3
> * libhugetlbfs - pass: 87, skip: 1,
> * ltp-cap_bounds-tests - pass: 1,
> * ltp-containers-tests - pass: 79, skip: 1,
> * ltp-cve-tests - pass: 22, skip: 12,
> * ltp-fcntl-locktests-tests - pass: 1,
> * ltp-filecaps-tests - pass: 1,
> * ltp-fs-tests - pass: 60, skip: 5,
> * ltp-fs_bind-tests - pass: 1,
> * ltp-fs_perms_simple-tests - pass: 18,
> * ltp-fsx-tests - pass: 1,
> * ltp-hugetlb-tests - pass: 20, skip: 1,
> * ltp-io-tests - pass: 2,
> * ltp-ipc-tests - pass: 8,
> * ltp-math-tests - pass: 10,
> * ltp-nptl-tests - pass: 1,
> * ltp-pty-tests - pass: 3,
> * ltp-sched-tests - pass: 7, skip: 6,
> * ltp-securebits-tests - pass: 3,
> * ltp-syscalls-tests - pass: 1048, skip: 99, fail: 1
> * ltp-timers-tests - pass: 12,
>
> qemu_arm64
> * boot - pass: 21,
> * kselftest - pass: 54, xfail: 16, skip: 28, fail: 4
> * libhugetlbfs - pass: 68,
> * ltp-cap_bounds-tests - pass: 1,
> * ltp-containers-tests - pass: 80,
> * ltp-cve-tests - pass: 24, skip: 10,
> * ltp-fcntl-locktests-tests - pass: 1,
> * ltp-filecaps-tests - pass: 1,
> * ltp-fs-tests - pass: 59, skip: 6,
> * ltp-fs_bind-tests - pass: 1,
> * ltp-fs_perms_simple-tests - pass: 18,
> * ltp-fsx-tests - pass: 1,
> * ltp-hugetlb-tests - pass: 21,
> * ltp-io-tests - pass: 2,
> * ltp-ipc-tests - pass: 8,
> * ltp-math-tests - pass: 10,
> * ltp-nptl-tests - pass: 1,
> * ltp-pty-tests - pass: 3,
> * ltp-sched-tests - pass: 7, skip: 6,
> * ltp-securebits-tests - pass: 3,
> * ltp-syscalls-tests - pass: 990, skip: 157, fail: 1
> * ltp-timers-tests - pass: 12,
>
> qemu_i386
> * boot - pass: 21,
> * kselftest - pass: 93, xfail: 16, skip: 36, fail: 4
> * libhugetlbfs - pass: 87, skip: 1,
> * ltp-cap_bounds-tests - pass: 1,
> * ltp-containers-tests - pass: 80,
> * ltp-cve-tests - pass: 29, xfail: 1, skip: 4,
> * ltp-fcntl-locktests-tests - pass: 1,
> * ltp-filecaps-tests - pass: 1,
> * ltp-fs-tests - pass: 59, skip: 6,
> * ltp-fs_bind-tests - pass: 1,
> * ltp-fs_perms_simple-tests - pass: 18,
> * ltp-fsx-tests - pass: 1,
> * ltp-hugetlb-tests - pass: 20, skip: 1,
> * ltp-io-tests - pass: 2,
> * ltp-ipc-tests - pass: 8,
> * ltp-math-tests - pass: 10,
> * ltp-nptl-tests - pass: 1,
> * ltp-pty-tests - pass: 3,
> * ltp-sched-tests - pass: 13,
> * ltp-securebits-tests - pass: 3,
> * ltp-syscalls-tests - pass: 1056, skip: 91, fail: 1
> * ltp-timers-tests - pass: 12,
>
> qemu_x86_64
> * boot - pass: 21,
> * kselftest - pass: 73, xfail: 10, skip: 39, fail: 5
> * libhugetlbfs - pass: 90, skip: 1,
> * ltp-cap_bounds-tests - pass: 1,
> * ltp-containers-tests - pass: 80,
> * ltp-cve-tests - pass: 29, skip: 5,
> * ltp-fcntl-locktests-tests - pass: 1,
> * ltp-filecaps-tests - pass: 1,
> * ltp-fs-tests - pass: 59, skip: 6,
> * ltp-fs_bind-tests - pass: 1,
> * ltp-fs_perms_simple-tests - pass: 18,
> * ltp-fsx-tests - pass: 1,
> * ltp-hugetlb-tests - pass: 21,
> * ltp-io-tests - pass: 2,
> * ltp-ipc-tests - pass: 8,
> * ltp-math-tests - pass: 10,
> * ltp-nptl-tests - pass: 1,
> * ltp-pty-tests - pass: 3,
> * ltp-sched-tests - pass: 13,
> * ltp-securebits-tests - pass: 3,
> * ltp-syscalls-tests - pass: 992, skip: 155, fail: 1
> * ltp-timers-tests - pass: 12,
>
> x15 - arm
> * boot - pass: 21,
> * kselftest - pass: 71, xfail: 18, skip: 37, fail: 3
> * libhugetlbfs - pass: 87, skip: 1,
> * ltp-cap_bounds-tests - pass: 1,
> * ltp-containers-tests - pass: 79, skip: 1,
> * ltp-cve-tests - pass: 24, skip: 10,
> * ltp-fcntl-locktests-tests - pass: 1,
> * ltp-filecaps-tests - pass: 1,
> * ltp-fs-tests - pass: 60, skip: 5,
> * ltp-fs_bind-tests - pass: 1,
> * ltp-fs_perms_simple-tests - pass: 18,
> * ltp-hugetlb-tests - pass: 19, skip: 2,
> * ltp-io-tests - pass: 2,
> * ltp-ipc-tests - pass: 8,
> * ltp-math-tests - pass: 10,
> * ltp-nptl-tests - pass: 1,
> * ltp-open-posix-tests - pass: 1690, xfail: 5, skip: 40,
> * ltp-pty-tests - pass: 3,
> * ltp-sched-tests - pass: 13,
> * ltp-securebits-tests - pass: 3,
> * ltp-syscalls-tests - pass: 1069, skip: 78, fail: 1
> * ltp-timers-tests - pass: 12,
>
> x86_64
> * boot - pass: 24,
> * kselftest - pass: 95, xfail: 10, skip: 36, fail: 5
> * kselftest-vsyscall-mode-native - pass: 97, skip: 36, fail: 15
> * kselftest-vsyscall-mode-none - pass: 97, skip: 36, fail: 14
> * libhugetlbfs - pass: 90, skip: 1,
> * ltp-cap_bounds-tests - pass: 1,
> * ltp-containers-tests - pass: 80,
> * ltp-cve-tests - pass: 29, skip: 5,
> * ltp-fcntl-locktests-tests - pass: 1,
> * ltp-filecaps-tests - pass: 1,
> * ltp-fs-tests - pass: 60, skip: 5,
> * ltp-fs_bind-tests - pass: 1,
> * ltp-fs_perms_simple-tests - pass: 18,
> * ltp-fsx-tests - pass: 1,
> * ltp-hugetlb-tests - pass: 20,
> * ltp-io-tests - pass: 2,
> * ltp-ipc-tests - pass: 8,
> * ltp-math-tests - pass: 10,
> * ltp-nptl-tests - pass: 1,
> * ltp-open-posix-tests - pass: 1689, xfail: 5, skip: 41,
> * ltp-pty-tests - pass: 3,
> * ltp-sched-tests - pass: 9, skip: 4,
> * ltp-securebits-tests - pass: 3,
> * ltp-syscalls-tests - pass: 1029, skip: 118, fail: 1
> * ltp-timers-tests - pass: 12,
>
> --
> Linaro QA (BETA)
> https://qa-reports.linaro.org
