Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OdyuG-0000sA-Rf
	for ltp-list@lists.sourceforge.net; Wed, 28 Jul 2010 05:10:16 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OdyuE-0007tS-GM
	for ltp-list@lists.sourceforge.net; Wed, 28 Jul 2010 05:10:16 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6S58EOB024891
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Jul 2010 23:08:14 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6S5A6c7135724
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Jul 2010 23:10:06 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6S5A5UW006615
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Jul 2010 23:10:05 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <q2z364299f41005061053zcc57d5c4gc5577e9d80ffc8e5@mail.gmail.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065729.23879.9995.sendpatchset@subratamodak.linux.ibm.com>
	<q2z364299f41005061053zcc57d5c4gc5577e9d80ffc8e5@mail.gmail.com>
Date: Tue, 27 Jul 2010 23:10:45 +0530
Message-Id: <1280252447.7374.5.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [06/12 FAILURE] Many CONTAINER tests of LTP fail
Reply-To: subrata@linux.vnet.ibm.com
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
To: sukadev <sukadev@linux.vnet.ibm.com>
Cc: Linux Test Project <ltp-list@lists.sourceforge.net>

Hi Suka,

Some issues continue to exist in latest LTP. Do you have proposal for
them:

<<<test_start>>>
tag=Containers stime=1280251869
cmdline="container_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
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

shmem_2nstest    0  TINFO  :  Shared Memory namespace test : none
shmem_2nstest    0  TINFO  :  Cont1: Able to create shared mem segment
shmem_2nstest    1  TPASS  :  Plain cloned process able to access shmem
segment created

sysvipc: SharedMemory clone
sysvipc_namespace    0  TINFO  :  shmid namespaces test : clone

sysvipc_namespace    1  TPASS  :  clone: child process didn't find shmid

shmem_2nstest    0  TINFO  :  Shared Memory namespace test : clone
shmem_2nstest    0  TINFO  :  Cont1: Able to create shared mem segment
shmem_2nstest    0  TINFO  :  Cont2: Able to allocate shmem seg with the
same key
shmem_2nstest    1  TPASS  :  clone : In namespace2 unable to access the
shmem seg created in Namespace1

sysvipc: SharedMemory unshare
sysvipc_namespace    0  TINFO  :  shmid namespaces test : unshare

sysvipc_namespace    1  TPASS  :  unshare: child process didn't find
shmid

shmem_2nstest    0  TINFO  :  Shared Memory namespace test : unshare
shmem_2nstest    0  TINFO  :  Cont1: Able to create shared mem segment
shmem_2nstest    0  TINFO  :  Cont2: Able to allocate shmem seg with the
same key
shmem_2nstest    1  TPASS  :  unshare : In namespace2 unable to access
the shmem seg created in Namespace1


sysvipc: MesgQ none
mesgq_nstest    0  TINFO  :  mesgq namespaces test : none

mesgq_nstest    1  TPASS  :  Plain cloned process found mesgq inside
container

mesgq_nstest    0  TINFO  :  Mesg read of 18 bytes; Type 5: Msg: Message
of type 5!

sysvipc: MesgQ clone
mesgq_nstest    0  TINFO  :  mesgq namespaces test : clone

mesgq_nstest    1  TPASS  :  clone: Container didn't find mesgq
sysvipc: MesgQ unshare
mesgq_nstest    0  TINFO  :  mesgq namespaces test : unshare

mesgq_nstest    1  TPASS  :  unshare: Container didn't find mesgq

sysvipc: Semaphore none
sem_nstest    0  TINFO  :  Semaphore namespaces Isolation test : none

sem_nstest    1  TPASS  :  Plain cloned process found semaphore inside
container

sem_nstest    0  TINFO  :  PID 25710: Fetched existing semaphore..id = 0

semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : none
semtest_2ns    0  TINFO  :  Cont1: Able to create semaphore
semtest_2ns    0  TINFO  :  Sem1: File locked, Critical section is
updated...

semtest_2ns    1  TPASS  :  Plain cloned process able to access the
semaphore created

sysvipc: Semaphore clone
sem_nstest    0  TINFO  :  Semaphore namespaces Isolation test : clone

sem_nstest    1  TPASS  :  clone: Container didn't find semaphore
semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : clone
semtest_2ns    0  TINFO  :  Cont1: Able to create semaphore
semtest_2ns    0  TINFO  :  Cont2: Able to create semaphore with sameKey
semtest_2ns    1  TPASS  :  clone : In namespace2 unable to access the
semaphore created in Namespace1

sysvipc: Semaphore unshare
sem_nstest    0  TINFO  :  Semaphore namespaces Isolation test : unshare

sem_nstest    1  TPASS  :  unshare: Container didn't find semaphore
semtest_2ns    0  TINFO  :  Semaphore Namespaces Test : unshare
semtest_2ns    0  TINFO  :  Cont1: Able to create semaphore
semtest_2ns    0  TINFO  :  Cont2: Able to create semaphore with sameKey
semtest_2ns    1  TPASS  :  unshare : In namespace2 unable to access the
semaphore created in Namespace1


Running pidns tests.
pid_namespace1    0  TINFO  :  PIDNS test is running inside container

pid_namespace1    1  TPASS  :  Success:
pid_namespace2    0  TINFO  :  Checking session id & group id inside
container

pid_namespace2    1  TPASS  :  Success: Got Group ID = 1 & Session ID =
1 

pid_namespace3    0  TINFO  :   Checking pid for parent ns and
container-init
                                Parent namespace pid = 25731,container
parent pid = 0,and container pid = 1
pid_namespace3    1  TFAIL  :  Failed to open /proc directory
pid_namespace4    0  TINFO  :  PIDNS test is running inside container
pid_namespace4    1  TPASS  :  Container init : I was not killed !
pidns05     0  TINFO  :   5 Nested Containers are created
pidns05     1  TPASS  :  The number of containers killed are 2

pidns06     0  TINFO  :  Parent: Passing the pid of the process 25742
pidns06     1  TPASS  :  Container: tried kill() on the parent pid
25742: errno set to 3 (No such process), as expected

pidns06     2  TPASS  :  Container: While killing non existent pid errno
set to 3 : No such process, as expected

pidns30     0  TINFO  :  parent: successfully created posix mqueue
pidns30     0  TINFO  :  cinit: mq_open succeeded
pidns30     0  TINFO  :  cinit: successfully registered for notification
pidns30     0  TINFO  :  cinit: successfully registered handler for
SIGUSR1
pidns30     1  TPASS  :  cinit: signal originator PID = 0
pidns30     0  TINFO  :  parent: mq_send() succeeded
pidns30     0  TINFO  :  cinit: my father is done - cleaning
pidns31     1  TBROK  :  parent: mq_open() failed (Permission denied)
pidns10     1  TPASS  :  cinit: expected kill(-1, sig) failure.
pidns12     0  TINFO  :  parent: PID is 25749
pidns12     1  TPASS  :  cinit: signalling PID (from other namespace) is
0 as expected
pidns13     0  TINFO  :  cinit1: setup handler for async I/O on pipe
pidns13     0  TINFO  :  cinit2: writing some data in pipe
pidns13     1  TPASS  :  cinit1: si_fd is 5, si_code is 1
pidns16     1  TBROK  :  Unexpected value for Sending-ProcessID when
signal handler called 0

pidns16     0  TINFO  :  Container: Resumed after receiving SIGUSR1 from
parentNS 
pidns16     0  TINFO  :  sig_handler is signalled from pid  1
pidns16     0  TINFO  :  Container: Resumed after sending SIGUSR1 from
container itself
pidns16     1  TPASS  :  container init continued successfuly, after
handling signal -USR1

pidns17     1  TPASS  :  cinit: all children are terminated.
pidns20     0  TINFO  :  cinit: blocked SIGUSR1
pidns20     0  TINFO  :  parent: signalled SIGUSR1 to container
pidns20     0  TINFO  :  cinit: unblocking SIGUSR1
pidns20     1  TPASS  :  cinit: user function is called as expected
Running POSIX message queue tests.
posixmq_namespace_01    0  TINFO  :  Testing posix mq namespaces through
unshare(2).

posixmq_namespace_01    0  TINFO  :  Checking namespaces isolation from
parent to child

posixmq_namespace_01    1  TPASS  :  child process didn't find mqueue

posixmq_namespace_01    0  TINFO  :  Testing posix mq namespaces through
clone(2).

posixmq_namespace_01    0  TINFO  :  Checking namespaces isolation from
parent to child

posixmq_namespace_01    1  TPASS  :  child process didn't find mqueue

posixmq_namespace_02    0  TINFO  :  Testing posix mq namespaces through
unshare(2).

posixmq_namespace_02    0  TINFO  :  Checking namespaces isolation
(child to parent)

posixmq_namespace_02    1  TPASS  :  Parent process can't see the mqueue

posixmq_namespace_02    0  TINFO  :  Testing posix mq namespaces through
clone(2).

posixmq_namespace_02    0  TINFO  :  Checking namespaces isolation
(child to parent)

posixmq_namespace_02    1  TPASS  :  Parent process can't see the mqueue

posixmq_namespace_03    0  TINFO  :  Testing posix mq namespaces through
unshare(2).

posixmq_namespace_03    0  TINFO  :  Checking correct umount+remount of
mqueuefs

posixmq_namespace_03    1  TPASS  :  umount+remount of mqueuefs
remounted the right fs

posixmq_namespace_03    0  TINFO  :  Testing posix mq namespaces through
clone(2).

posixmq_namespace_03    0  TINFO  :  Checking correct umount+remount of
mqueuefs

posixmq_namespace_03    1  TPASS  :  umount+remount of mqueuefs
remounted the right fs

posixmq_namespace_04    0  TINFO  :  Testing posix mq namespaces through
unshare(2).

posixmq_namespace_04    0  TINFO  :  Checking mqueue filesystem lifetime

posixmq_namespace_04    1  TPASS  :  Child mqueue fs still visible for
parent

posixmq_namespace_04    0  TINFO  :  Testing posix mq namespaces through
clone(2).

posixmq_namespace_04    0  TINFO  :  Checking mqueue filesystem lifetime

posixmq_namespace_04    1  TPASS  :  Child mqueue fs still visible for
parent

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

<<<execution_status>>>
initiation_status="ok"
duration=47 termination_type=exited termination_id=1 corefile=no
cutime=20 cstime=112
<<<test_end>>>
/opt/ltp/testcases/bin/initialize.sh: line 83:    57 Terminated
( ip link delete $netdev ) 2> /dev/null
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20100630
        
       ###############################################################"
        
            Done executing testcases."
            LTP Version:  LTP-20100630
       ###############################################################"

Regards--
Subrata

On Thu, 2010-05-06 at 10:53 -0700, Garrett Cooper wrote:
> Clipping the output to denote the failures.
> 
> On Wed, May 5, 2010 at 11:57 PM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
> > Subject:Many CONTAINER tests of LTP fail
> >
> > I know Serge and Dan is already working on it.
> >
> > Issues Description Below:
> > ====================================================
> > # ./runltp -f containers
> > <<<test_start>>>
> 
> [...]
> 
> > pid_namespace3    1  TFAIL  :  Failed to open /proc directory
> 
> This is interesting... is /proc not mounted in the child container?
> 
> > pidns30     1  TBROK  :  parent: mq_open() failed (Permission denied)
> > pidns31     1  TBROK  :  parent: mq_open() failed (Permission denied)
> 
> Does the queue exist?
> 
> > posixmq_namespace_01    1  TFAIL  :  mq_open failed
> > Running netns tests.
> 
> [...]
> 
> > netns_2children    1  TFAIL  :  Error while running the scripts
> > two_children_ns: return code is 1 ;
> > sshd re-exec requires execution with an absolute path^M
> 
> This was going to be fixed with a patch proposed earlier.
> 
> > childns.sh    0  TINFO  :  Successfully Renamed device to veth1
> > Files /tmp/sys_b4_child_killed and /tmp/sys_aftr_child_killed differ
> > Cannot find device "veth1"
> > crtchild_delchild: PASS
> 
> This seems suspect even though it says passed.
> 
> [...]
> 
> > sshd re-exec requires execution with an absolute path^M
> > Error: Can't ftp to 192.168.0.181: Connection refused
> > childns.sh    1  TFAIL  :  ftp failed
> 
> One of the prereqs is missing probably (setup an ftp daemon ... maybe
> this was going to be done via ssh?)
> 
> [...]
> 
> > <<<test_end>>>


------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share 
of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
