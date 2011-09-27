Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huruomu@gmail.com>) id 1R8ZdN-00027l-HK
	for ltp-list@lists.sourceforge.net; Tue, 27 Sep 2011 15:31:49 +0000
Received: from mail-qy0-f175.google.com ([209.85.216.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1R8ZdM-0001rU-Ja
	for ltp-list@lists.sourceforge.net; Tue, 27 Sep 2011 15:31:49 +0000
Received: by qyk10 with SMTP id 10so1216140qyk.13
	for <ltp-list@lists.sourceforge.net>;
	Tue, 27 Sep 2011 08:31:43 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 27 Sep 2011 23:31:43 +0800
Message-ID: <CANoG8sUB9+PFXbc_a9GfLhhkhOOZYHwYQfTGwJoHKq4xAHTB=A@mail.gmail.com>
From: Romu <huruomu@gmail.com>
Subject: [LTP] Containers test failed on 2.6.39
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hi,

Containers test in LTP 20110915 failed on 2.6.39 kernel:

pidns30     1  TBROK  :  container did not respond as expected!
pidns30     2  TBROK  :  Remaining cases broken
pidns31     1  TBROK  :  cinit: mq_open() failed (Bad address)

parentns.sh    0  TINFO  :  Pinging ChildNS from ParentNS
Error: Can't ftp to 192.168.0.181: Connection refused
childns.sh    1  TFAIL  :  ftp failed
Error while running the script
par_chld_ftp: FAIL 1

I have no idea about the TBROKs, for the TFAIL, do I need to setup a
ftp daemon? where?


Full test output
===========

<<<test_start>>>
tag=Containers stime=1317139405
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

sysvipc_namespace    0  TINFO  :  shmid namespaces test : none

sysvipc_namespace    1  TPASS  :  plain cloned process found shmid

shmem_2nstest    0  TINFO  :  Shared Memory namespace test : none
shmem_2nstest    0  TINFO  :  Cont1: Able to create shared mem segment
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : none
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : none
shmem_2nstest    1  TPASS  :  Plain cloned process able to access
shmem segment created

sysvipc: SharedMemory clone
sysvipc_namespace    0  TINFO  :  shmid namespaces test : clone

sysvipc_namespace    0  TINFO  :  shmid namespaces test : clone

sysvipc_namespace    1  TPASS  :  clone: child process didn't find shmid

shmem_2nstest    0  TINFO  :  Shared Memory namespace test : clone
shmem_2nstest    0  TINFO  :  Cont1: Able to create shared mem segment
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : clone
shmem_2nstest    0  TINFO  :  Cont2: Able to allocate shmem seg with
the same key
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : clone
shmem_2nstest    1  TPASS  :  clone : In namespace2 unable to access
the shmem seg created in Namespace1

sysvipc: SharedMemory unshare
sysvipc_namespace    0  TINFO  :  shmid namespaces test : unshare

sysvipc_namespace    0  TINFO  :  shmid namespaces test : unshare

sysvipc_namespace    1  TPASS  :  unshare: child process didn't find shmid

shmem_2nstest    0  TINFO  :  Shared Memory namespace test : unshare
shmem_2nstest    0  TINFO  :  Cont1: Able to create shared mem segment
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : unshare
shmem_2nstest    0  TINFO  :  Cont2: Able to allocate shmem seg with
the same key
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : unshare
shmem_2nstest    1  TPASS  :  unshare : In namespace2 unable to access
the shmem seg created in Namespace1


sysvipc: MesgQ none
mesgq_nstest    0  TINFO  :  mesgq namespaces test : none

mesgq_nstest    0  TINFO  :  Mesg read of 18 bytes; Type 5: Msg:
Message of type 5!

mesgq_nstest    0  TINFO  :  mesgq namespaces test : none

mesgq_nstest    1  TPASS  :  Plain cloned process found mesgq inside container

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

sem_nstest    0  TINFO  :  PID 7998: Fetched existing semaphore..id = 196610

sem_nstest    0  TINFO  :  Semaphore namespaces Isolation test : none

sem_nstest    1  TPASS  :  Plain cloned process found semaphore inside container

semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : none
semtest_2ns    0  TINFO  :  Cont1: Able to create semaphore
semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : none
semtest_2ns    0  TINFO  :  Sem1: File locked, Critical section is updated...

semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : none
semtest_2ns    1  TPASS  :  Plain cloned process able to access the
semaphore created

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
semtest_2ns    1  TPASS  :  unshare : In namespace2 unable to access
the semaphore created in Namespace1


Running pidns tests.
Checking session id & group id inside container
Success: Got Group ID = 1 & Session ID = 1
PIDNS test is running inside container
pid_namespace4    1  TPASS  :  Container init : I was not killed !
pidns05     0  TINFO  :   5 Nested Containers are created
pidns05     1  TPASS  :  The number of containers killed are 2

pidns06     0  TINFO  :  Parent: Passing the pid of the process 8028
Container: killing parent pid=8028 failed as expected with ESRCH
Container: killing non-existent pid failed as expected with ESRCH
pidns06     0  TINFO  :  Parent: Passing the pid of the process 8028
mq_open failed: Bad address
pidns30     0  TINFO  :  successfully created posix mqueue
pidns30     1  TBROK  :  container did not respond as expected!
pidns30     2  TBROK  :  Remaining cases broken
pidns31     0  TINFO  :  parent: successfully created posix mqueue
pidns31     0  TINFO  :  cinit: my father is ready to receive a message
pidns31     1  TBROK  :  cinit: mq_open() failed (Bad address)
pidns31     0  TINFO  :  parent: successfully created posix mqueue
pidns31     0  TINFO  :  parent: successfully created child (pid = 8033)
pidns31     0  TINFO  :  parent: successfully registered for notification
pidns31     0  TINFO  :  parent: successfully registered handler for SIGUSR1
cinit: kill(-1, sig) failed with -1 / ESRCH as expected
pidns12     0  TINFO  :  parent: PID is 8036
pidns12     1  TPASS  :  cinit: signalling PID (from other namespace)
is 0 as expected
pidns12     0  TINFO  :  parent: PID is 8036
pidns13     0  TINFO  :  cinit2: writing some data in pipe
pidns13     0  TINFO  :  cinit1: setup handler for async I/O on pipe
pidns13     1  TPASS  :  cinit1: si_fd is 5, si_code is 1
pidns16     1  TPASS  :  container init continued successfuly, after
handling signal -USR1

cinit: all children have terminated.
pidns20     0  TINFO  :  cinit: blocked SIGUSR1
pidns20     0  TINFO  :  cinit: unblocking SIGUSR1
pidns20     1  TPASS  :  cinit: user function is called as expected
pidns20     0  TINFO  :  parent: signalled SIGUSR1 to container
Running POSIX message queue tests.
posixmq_namespace_01    0  TINFO  :  Testing posix mq namespaces
through unshare(2).

posixmq_namespace_01    0  TINFO  :  Checking namespaces isolation
from parent to child

posixmq_namespace_01    1  TPASS  :  child process didn't find mqueue

posixmq_namespace_01    0  TINFO  :  Testing posix mq namespaces
through unshare(2).

posixmq_namespace_01    0  TINFO  :  Checking namespaces isolation
from parent to child

posixmq_namespace_01    0  TINFO  :  Testing posix mq namespaces
through clone(2).

posixmq_namespace_01    0  TINFO  :  Checking namespaces isolation
from parent to child

posixmq_namespace_01    1  TPASS  :  child process didn't find mqueue

posixmq_namespace_01    0  TINFO  :  Testing posix mq namespaces
through clone(2).

posixmq_namespace_01    0  TINFO  :  Checking namespaces isolation
from parent to child

posixmq_namespace_02    0  TINFO  :  Testing posix mq namespaces
through unshare(2).

posixmq_namespace_02    0  TINFO  :  Checking namespaces isolation
(child to parent)

posixmq_namespace_02    1  TPASS  :  Parent process can't see the mqueue

posixmq_namespace_02    0  TINFO  :  Testing posix mq namespaces
through unshare(2).

posixmq_namespace_02    0  TINFO  :  Testing posix mq namespaces
through clone(2).

posixmq_namespace_02    0  TINFO  :  Checking namespaces isolation
(child to parent)

posixmq_namespace_02    1  TPASS  :  Parent process can't see the mqueue

posixmq_namespace_02    0  TINFO  :  Testing posix mq namespaces
through clone(2).

posixmq_namespace_03    0  TINFO  :  Testing posix mq namespaces
through unshare(2)
posixmq_namespace_03    0  TINFO  :  Testing posix mq namespaces
through unshare(2)
posixmq_namespace_03    0  TINFO  :  Checking correct umount+remount of mqueuefs
posixmq_namespace_03    1  TPASS  :  umount+remount of mqueuefs
remounted the right fs
posixmq_namespace_03    0  TINFO  :  Testing posix mq namespaces
through clone(2)
posixmq_namespace_03    0  TINFO  :  Checking correct umount+remount of mqueuefs
posixmq_namespace_03    1  TPASS  :  umount+remount of mqueuefs
remounted the right fs
posixmq_namespace_03    0  TINFO  :  Testing posix mq namespaces
through clone(2)
posixmq_namespace_04    0  TINFO  :  Testing posix mq namespaces
through unshare(2).

posixmq_namespace_04    0  TINFO  :  Checking mqueue filesystem lifetime

posixmq_namespace_04    0  TINFO  :  Testing posix mq namespaces
through unshare(2).

posixmq_namespace_04    0  TINFO  :  Checking mqueue filesystem lifetime

posixmq_namespace_04    1  TPASS  :  Child mqueue fs still visible for parent

posixmq_namespace_04    0  TINFO  :  Testing posix mq namespaces
through clone(2).

posixmq_namespace_04    0  TINFO  :  Checking mqueue filesystem lifetime

posixmq_namespace_04    0  TINFO  :  Testing posix mq namespaces
through clone(2).

posixmq_namespace_04    0  TINFO  :  Checking mqueue filesystem lifetime

posixmq_namespace_04    1  TPASS  :  Child mqueue fs still visible for parent

check_netns_enabled    1  TPASS  :  unshare syscall smoke test passed
Running netns tests.
parentns.sh    0  TINFO  :  PASS: Pinging ChildNS from ParentNS
childns.sh    0  TINFO  :  PASS: Pinging ParentNS from ChildNS
crtchild: PASS

child_2.sh    0  TINFO  :  PASS: CHILD1 is pinging from CHILD2 !
child_1.sh    0  TINFO  :  PASS: Child2 is pinging from CHILD1 !
two_children_ns: PASS

childns.sh    0  TINFO  :  Successfully Renamed device to veth2
Files /tmp/sys_b4_child_killed and /tmp/sys_aftr_child_killed differ
Cannot find device "veth0"
crtchild_delchild: PASS

paripv6.sh    0  TINFO  :  IPv6: Pinging child from parent: PASS
childipv6.sh    0  TINFO  :  IPv6: Pinging Parent from Child: PASS
par_chld_ipv6: PASS

parentns.sh    0  TINFO  :  Pinging ChildNS from ParentNS
Error: Can't ftp to 192.168.0.181: Connection refused
childns.sh    1  TFAIL  :  ftp failed
Error while running the script
par_chld_ftp: FAIL 1 ;

incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=51 termination_type=exited termination_id=1 corefile=no
cutime=46 cstime=144
<<<test_end>>>
/opt/ltp/testcases/bin/initialize.sh: line 83:    49 Terminated
      ( ip link delete $netdev ) 2> /dev/null
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20110915

       ###############################################################"

            Done executing testcases."
            LTP Version:  LTP-20110915
       ###############################################################"

Thanks,
Romu

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
