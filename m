From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 15 Feb 2019 14:52:38 +0000
Subject: [LTP] [RFC][PATCH 0/1] cgroup_regression_test.sh fix
Message-ID: <20190215145239.51806-1-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi

while working on this LTP tip (LTP Jan19 REL + fixes):

81e28eab1 memcg_stress_test.sh: fix memory usage
b25c719de memcg_stress_test.sh: Further cleanup + print info
a6d7d16f4 memcg_stress_test.sh: ported to newlib
6a651fe16 controllers/cpuset: cpuset.cpus file doesn't exist which triggers=
 TFAIL
fa049ec9f controllers/cgroup_regression_test.sh: Fix two issues
a6a5caef1 (tag: 20190115, LTP_20190115) LTP 20190115

I realized 'cgroup' testcase is now wrongly reported FAIL even if NO failur=
es
happens in the sub testcases:


Running tests.......
<<<test_start>>>
tag=3Dcgroup stim[  125.419776] LTP: starting cgroup (            cgroup_re=
gression_test.sh)
e=3D1550611029
cmdline=3D"               cgroup_regression_test.sh"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
incrementing stop
cgroup_regression_test 1 TINFO: timeout per run is 0h 5m 0s
cgroup_regression_test 1 TPASS: no kernel bug was found
cgroup_regression_test 2 TPASS: notify_on_release is inherited
cgroup_regression_test 3 TCONF: CONFIG_SCHED_DEBUG is not enabled
cgroup_regression_test 4 TCONF: CONFIG_LOCKDEP is not enabled
cgroup_regression_test 5 TPASS: no kernel bug was found
cgroup_regression_test 6 TCONF: CONFIG_CGROUP_NS is NOT supported in Kernel=
s >=3D 3.0
cgroup_regression_test 7 TPASS: no kernel bug was found for test 1
[  126.879398] option changes via remount are deprecated (pid=3D8105 comm=
=3Dmount)
cgroup_regression_test 7 TWARN: skip rest of testing due possible oops trig=
gered by reading /proc/sched_debug
cgroup_regression_test 7 TPASS: no kernel bug was found for test 2
cgroup_regression_test 8 TPASS: no kernel bug was found
cgroup_regression_test 9 TPASS: no kernel bug was found
mkdir: cannot create directory 'cgroup/0': File exists
cgroup_regression_test 10 TPASS: no kernel bug was found

Summary:
passed   8
failed   0
skipped  3
warnings 1
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D61 termination_type=3Dexited termination_id=3D36 corefile=3Dno
cutime=3D4314 cstime=3D5792
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20190115

       ###############################################################

            Done executing testcases.
            LTP Version:  20190115
       ###############################################################


This seems to be due to the TWARN added in 78bfa7e785e87d5e7e4e6ebd518ca9a6=
7c78a1f3 which leads
to an exit code interpreted by ltp-pan as failure.
Is this expected ? An ltp-pan issue ? Is there something wrong in my setup ?

A possibly trivial patch follows, BUT anyway there still an unresolved prob=
lem: in
the above test run even using TINFO instead of TWARN, I'll have the whole
cgroup_regression_test.sh test case reported as TCONF, since some of the
contained sub test cases have been in fact skipped: is there any way to add=
ress
this kind of situation in the LTP framework ? (beside using TINFO everywher=
e)
I understand the scenario is tricky:=C2=A0a test case with many sub-testcas=
es that
could each PASS/FAIL/SKIP. Any thought/guideline on this ?

Thanks

Cristian

Cristian Marussi (1):
  cgroup_regression_test.sh: Fix TWARN usage

 testcases/kernel/controllers/cgroup/cgroup_regression_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.17.1

