From: Carlos Hernandez <ceh@ti.com>
Date: Fri, 1 Dec 2017 17:00:51 -0500
Subject: [LTP] Possible bug on tests ksm03, ksm03_1 and ksm05
Message-ID: <02937496-8951-60db-05ba-b565346e267e@ti.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ksm03, ksm03_1 and ksm05 are reported as failures even though KSM is not enabled in kernel config.
Test does detect KSM configuration is not enabled as shown below:

<<<test_start>>>
tag=ksm03_1 stime=1511674217
cmdline="ksm03 -u 128"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:934: [1;34mINFO: [0mTimeout per run is 0h 05m 00s
ksm03.c:71: [1;33mCONF: [0mKSM configuration is not enabled
mem.c:761: [1;35mWARN: [0mopen /dev/cgroup/tasks: ENOENT
mem.c:766: [1;35mWARN: [0mfopen /dev/cgroup/1/tasks: ENOENT
mem.c:778: [1;35mWARN: [0mrmdir /dev/cgroup/1: ENOENT
mem.c:780: [1;35mWARN: [0mumount /dev/cgroup: ENOENT
mem.c:782: [1;35mWARN: [0mrmdir /dev/cgroup: ENOENT

Summary:
passed   0
failed   0
skipped  0
warnings 5
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=36 corefile=no
cutime=0 cstime=0
<<<test_end>>>


However, the test is marked as FAIL in the summary results table.


LTP Version: 20170929
         
        ###############################################################"
         
             Done executing testcases."
             LTP Version:  20170929
             Result log is in the /tmp/tmp.npDZeq "
        ###############################################################"
        
Test Start Time: Sun Nov 26 05:24:16 2017
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
mm01                           PASS       0
mm02                           PASS       0
mtest01                        PASS       0
mtest01w                       PASS       0
mtest05                        PASS       0
mtest06                        PASS       0
mtest06_3                      PASS       0
mem01                          PASS       0
mem02                          PASS       0
mem03                          PASS       0
page01                         PASS       0
page02                         PASS       0
data_space                     PASS       0
stack_space                    PASS       0
shmt02                         PASS       0
shmt03                         PASS       0
shmt04                         PASS       0
shmt05                         PASS       0
shmt06                         PASS       0
shmt07                         PASS       0
shmt08                         PASS       0
shmt09                         PASS       0
shmt10                         PASS       0
shm_test01                     PASS       0
mallocstress01                 PASS       0
mmapstress01                   PASS       0
mmapstress02                   PASS       0
mmapstress03                   PASS       0
mmapstress04                   PASS       0
mmapstress05                   PASS       0
mmapstress06                   PASS       0
mmapstress07                   PASS       0
mmapstress08                   CONF       32
mmapstress09                   PASS       0
mmapstress10                   PASS       0
mmap10                         PASS       0
mmap10_1                       PASS       0
mmap10_2                       CONF       32
mmap10_3                       CONF       32
mmap10_4                       CONF       32
ksm01                          CONF       32
ksm01_1                        CONF       32
ksm02                          CONF       32
ksm02_1                        CONF       32
ksm03                          FAIL       36
ksm03_1                        FAIL       36
ksm04                          CONF       32
ksm04_1                        CONF       32
ksm05                          FAIL       36
ksm06                          CONF       32
ksm06_1                        CONF       32
ksm06_2                        CONF       32

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20171201/bd803998/attachment-0001.html>
