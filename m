Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9v1r-0005oS-TO
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:57:51 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9v1p-0001BM-By
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:57:51 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o466qPBu030703
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 02:52:25 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o466vhjr122182
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 02:57:43 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o466vgHl001150
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 02:57:43 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 06 May 2010 12:27:30 +0530
Message-Id: <20100506065729.23879.9995.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [06/12 FAILURE] Many CONTAINER tests of LTP fail
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Sharyathi Nagesh <sharyath@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>

Subject:Many CONTAINER tests of LTP fail

I know Serge and Dan is already working on it.

Issues Description Below:
====================================================
# ./runltp -f containers
<<<test_start>>>
tag=Containers stime=1271856718
cmdline="container_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
Running utsns tests.
unshare tests
test 1 (unshare)
uts_namespace    1  TPASS  :  test 1 (unshare): success
test 2 (unshare)
uts_namespace    1  TPASS  :  test 2 (unshare): success
test 3 (unshare)
uts_namespace    1  TPASS  :  test 3 (unshare): success
test 4 (unshare)
uts_namespace    1  TPASS  :  test 4 (unshare): successful
test 5 (unshare)
uts_namespace    1  TPASS  :  P2: P1 claims error
clone tests
test 1 (clone)
uts_namespace    1  TPASS  :  test 1 (clone): success
test 2 (clone)
uts_namespace    1  TPASS  :  test 2 (clone): success
test 3 (clone)
uts_namespace    1  TPASS  :  test 3 (clone): success
test 4 (clone)
uts_namespace    1  TPASS  :  test 4 (clone): successful
test 5 (clone)
uts_namespace    1  TPASS  :  P2: P1 claims error
Running ipcns tests.
****************** sysvipc tests ******************
sysvipc: SharedMemory none
sysvipc_namespace    0  TINFO  :  shmid namespaces test : none
sysvipc_namespace    1  TPASS  :  plain cloned process found shmid
sysvipc_namespace    0  TINFO  :  shmid namespaces test : none
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : none
shmem_2nstest    0  TINFO  :  Cont1: Able to create shared mem segment
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : none
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : none
shmem_2nstest    1  TPASS  :  Plain cloned process able to access shmem segment
created
sysvipc: SharedMemory clone
sysvipc_namespace    0  TINFO  :  shmid namespaces test : clone
sysvipc_namespace    0  TINFO  :  shmid namespaces test : clone
sysvipc_namespace    1  TPASS  :  clone: child process didn't find shmid
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : clone
shmem_2nstest    0  TINFO  :  Cont1: Able to create shared mem segment
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : clone
shmem_2nstest    0  TINFO  :  Cont2: Able to allocate shmem seg with the same
key
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : clone
shmem_2nstest    1  TPASS  :  clone : In namespace2 unable to access the shmem
seg created in Namespace1
sysvipc: SharedMemory unshare
sysvipc_namespace    0  TINFO  :  shmid namespaces test : unshare
sysvipc_namespace    0  TINFO  :  shmid namespaces test : unshare
sysvipc_namespace    1  TPASS  :  unshare: child process didn't find shmid
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : unshare
shmem_2nstest    0  TINFO  :  Cont1: Able to create shared mem segment
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : unshare
shmem_2nstest    0  TINFO  :  Cont2: Able to allocate shmem seg with the same
key
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : unshare
shmem_2nstest    1  TPASS  :  unshare : In namespace2 unable to access the
shmem seg created in Namespace1
sysvipc: MesgQ none
mesgq_nstest    0  TINFO  :  mesgq namespaces test : none
mesgq_nstest    1  TPASS  :  Plain cloned process found mesgq inside container
mesgq_nstest    0  TINFO  :  mesgq namespaces test : none
mesgq_nstest    0  TINFO  :  Mesg read of 18 bytes; Type 5: Msg: Message of
type 5!
sysvipc: MesgQ clone
mesgq_nstest    0  TINFO  :  mesgq namespaces test : clone
mesgq_nstest    0  TINFO  :  mesgq namespaces test : clone
mesgq_nstest    1  TPASS  :  clone: Container didn't find mesgq
sysvipc: MesgQ unshare
mesgq_nstest    0  TINFO  :  mesgq namespaces test : unshare
mesgq_nstest    0  TINFO  :  mesgq namespaces test : unshare
mesgq_nstest    1  TPASS  :  unshare: Container didn't find mesgq
sysvipc: Semaphore none
sem_nstest    0  TINFO  :  Semaphore namespaces Isolation test : none
sem_nstest    1  TPASS  :  Plain cloned process found semaphore inside
container
sem_nstest    0  TINFO  :  Semaphore namespaces Isolation test : none
sem_nstest    0  TINFO  :  PID 4362: Fetched existing semaphore..id = 10158080
semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : none
semtest_2ns    0  TINFO  :  Cont1: Able to create semaphore
semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : none
semtest_2ns    0  TINFO  :  Sem1: File locked, Critical section is updated...
semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : none
semtest_2ns    1  TPASS  :  Plain cloned process able to access the semaphore
created
sysvipc: Semaphore clone
sem_nstest    0  TINFO  :  Semaphore namespaces Isolation test : clone
sem_nstest    0  TINFO  :  Semaphore namespaces Isolation test : clone
sem_nstest    1  TPASS  :  clone: Container didn't find semaphore
semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : clone
semtest_2ns    0  TINFO  :  Cont1: Able to create semaphore
semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : clone
semtest_2ns    0  TINFO  :  Cont2: Able to create semaphore with sameKey
semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : clone
semtest_2ns    1  TPASS  :  clone : In namespace2 unable to access the
semaphore created in Namespace1
sysvipc: Semaphore unshare
sem_nstest    0  TINFO  :  Semaphore namespaces Isolation test : unshare
sem_nstest    0  TINFO  :  Semaphore namespaces Isolation test : unshare
sem_nstest    1  TPASS  :  unshare: Container didn't find semaphore
semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : unshare
semtest_2ns    0  TINFO  :  Cont1: Able to create semaphore
semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : unshare
semtest_2ns    0  TINFO  :  Cont2: Able to create semaphore with sameKey
semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : unshare
semtest_2ns    1  TPASS  :  unshare : In namespace2 unable to access the
semaphore created in Namespace1
Running pidns tests.
pid_namespace1    0  TINFO  :  PIDNS test is running inside container
pid_namespace1    1  TPASS  :  Success:
pid_namespace3    0  TINFO  :   Checking pid for parent ns and container-init
                                Parent namespace pid = 4383,container parent
pid = 0,and container pid = 1
pid_namespace3    1  TFAIL  :  Failed to open /proc directory
pid_namespace4    0  TINFO  :  PIDNS test is running inside container
pid_namespace4    1  TPASS  :  Container init : I was not killed !
pidns05     0  TINFO  :   5 Nested Containers are created
pidns05     1  TPASS  :  The number of containers killed are 2
pidns06     0  TINFO  :  Parent: Passing the pid of the process 4394
pidns06     1  TPASS  :  Container: tried kill() on the parent pid 4394: errno
set to 3 (No such process), as expected
pidns06     2  TPASS  :  Container: While killing non existent pid errno set to
3 : No such process, as expected
pidns06     0  TINFO  :  Parent: Passing the pid of the process 4394
pidns30     1  TBROK  :  parent: mq_open() failed (Permission denied)
pidns31     1  TBROK  :  parent: mq_open() failed (Permission denied)
pidns10     1  TPASS  :  cinit: expected kill(-1, sig) failure.
pidns12     0  TINFO  :  parent: PID is 4400
pidns12     1  TPASS  :  cinit: signalling PID (from other namespace) is 0 as
expected
pidns12     0  TINFO  :  parent: PID is 4400
pidns13     0  TINFO  :  cinit2: writing some data in pipe
pidns13     0  TINFO  :  cinit1: setup handler for async I/O on pipe
pidns13     1  TPASS  :  cinit1: si_fd is 5, si_code is 1
pidns16     1  TPASS  :  container init continued successfuly, after handling
signal -USR1
pidns17     1  TPASS  :  cinit: all children are terminated.
pidns20     0  TINFO  :  cinit: blocked SIGUSR1
pidns20     0  TINFO  :  cinit: unblocking SIGUSR1
pidns20     1  TPASS  :  cinit: user function is called as expected
pidns20     0  TINFO  :  parent: signalled SIGUSR1 to container
Running POSIX message queue tests.
mq_open: Permission denied
posixmq_namespace_01    0  TINFO  :  Testing posix mq namespaces through
unshare(2).
posixmq_namespace_01    1  TFAIL  :  mq_open failed
Running netns tests.
parentns.sh    0  TINFO  :  PASS: Pinging ChildNS from ParentNS
sshd re-exec requires execution with an absolute path^M
childns.sh    0  TINFO  :  PASS: Pinging ParentNS from ChildNS
crtchild: PASS
netns_2children    1  TFAIL  :  Error while running the scripts
two_children_ns: return code is 1 ;
sshd re-exec requires execution with an absolute path^M
childns.sh    0  TINFO  :  Successfully Renamed device to veth1
Files /tmp/sys_b4_child_killed and /tmp/sys_aftr_child_killed differ
Cannot find device "veth1"
crtchild_delchild: PASS
paripv6.sh    0  TINFO  :  IPv6: Pinging child from parent: PASS
childipv6.sh    0  TINFO  :  IPv6: Pinging Parent from Child: PASS
par_chld_ipv6: PASS
parentns.sh    0  TINFO  :  Pinging ChildNS from ParentNS
sshd re-exec requires execution with an absolute path^M
Error: Can't ftp to 192.168.0.181: Connection refused
childns.sh    1  TFAIL  :  ftp failed
Error while running the script
two_children_ns: return code is 1 ; par_chld_ftp: FAIL 1 ;
<<<execution_status>>>
initiation_status="ok"
duration=41 termination_type=exited termination_id=1 corefile=no
cutime=14 cstime=98
<<<test_end>>>

Regards--
Subrata


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
