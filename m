From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 Jul 2020 00:01:05 +0530
Subject: [LTP] clone302.c:88: FAIL: invalid parenttid: clone3() should fail
 with EFAULT: EINVAL (22)
Message-ID: <CA+G9fYuiK95tkP1e2VogtbzGex4qJdpfCZ6bfM5S5sA_o+iRQw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP clone302 test case failed on linux next 20200706 tag.
This is a regression on arm64, arm, x86_64, and i386.

The expected error code is EFAULT but got EINVAL.
This is already addressed here in this email thread by Christian Brauner
https://lore.kernel.org/linux-m68k/20200627122332.ki2otaiw3v7wndbl@wittgenstein/T/#u


Test output log.
clone302.c:92: PASS: invalid args: clone3() failed as expected: EFAULT (14)
clone302.c:92: PASS: zero size: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: short size: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: extra size: clone3() failed as expected: EFAULT (14)
clone302.c:92: PASS: sighand-no-VM: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: thread-no-sighand: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: fs-newns: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: invalid pidfd: clone3() failed as expected: EFAULT (14)
clone302.c:92: PASS: invalid childtid: clone3() failed as expected: EFAULT (14)
clone302.c:88: FAIL: invalid parenttid: clone3() should fail with
EFAULT: EINVAL (22)
clone302.c:92: PASS: invalid signal: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: zero-stack-size: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: invalid-stack: clone3() failed as expected: EINVAL (22)

strace output:
[pid   519] getpid()                    = 519
[pid   519] wait4(-1, 0x7fff504b02ec, 0, NULL) = -1 ECHILD (No child processes)
[pid   519] syscall_435(0x7fcc0478bfc0, 0x40, 0x7fcc04278031, 0,
0x7fff504afb26, 0x360) = -1 (errno 22)
[pid   519] write(2, "clone302.c:88: FAIL: "..., 97clone302.c:88:
FAIL: invalid parenttid: clone3() should fail with EFAULT: EINVAL (22)

Test code:
{"invalid parenttid", &valid_args, sizeof(*valid_args),
CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, NULL, NULL,
&invalid_address, SIGCHLD, 0, 0, 0, EFAULT},

Test case link,
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/clone3/clone302.c#L41

ref:
https://lkft.validation.linaro.org/scheduler/job/1542127#L3243
https://lkft.validation.linaro.org/scheduler/job/1542828#L1412

--
Linaro LKFT
https://lkft.linaro.org
