From: Jaggi, Manish <Manish.Jaggi@cavium.com>
Date: Wed, 24 Oct 2018 08:40:11 +0000
Subject: [LTP] cpuhotplug03 test fails in FULL ltp run,
	but passes individually
Message-ID: <D2251CD4-ED6B-4C5F-959D-9F850E3CFED2@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi All,

cpuhotplug03 test fails in full ltp run.
---
cpuhotplug03 1 TFAIL: No cpuhotplug_do_spin_loop processes found on CPU1
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D210 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D20941 cstime=3D65
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
=E2=80=94

This failure is only observed with full LTP run. This doesn't happens with =
individual test run.
I am running this test on Cavium ThunderX ARM64 machine with 200+ cores.

Need some pointers to debug this issue.

-Thanks
Manish
