From: Cixi Geng <gengcixi@gmail.com>
Date: Mon, 9 Mar 2020 18:00:44 +0800
Subject: [LTP] =?utf-8?q?=E2=9D=8C_FAIL=3A_mkdtemp_failed_for_EACCES_when?=
	=?utf-8?q?_setresuid_nobody?=
Message-ID: <CAF12kFtx6wqUhN4z5uHHW51trstgMsSzRbQHU44rGrVO3-v5AA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello everyone:

While testing some syscalls tests on our device,based on debian
rootfs, I got an error on many tests (running as "root" user).

Here is one of log:

<<<test_start>>>
tag=fchown03 stime=1478195083
cmdline="fchown03"
contacts=""
analysis=exit
<<<test_output>>>
fchown03    1  TBROK  :  tst_tmpdir.c:264: tst_tmpdir:
mkdtemp(/tmp/ltp-cawz3S2QlX/fchNeMx77) failed: errno=EACCES(13):
Permission denied
fchown03    2  TBROK  :  tst_tmpdir.c:264: Remaining cases broken
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=1
<<<test_end>>>
After I trace the kerenel syscalls, found it do a setresuid operate,
set uid to nobody.

I did test on my self C code, make that nobody did have no exec
permission to mkdtemp. other normal user successed.

So I pizzled that how to fix this error. need someone help me.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200309/14616a7e/attachment.htm>
