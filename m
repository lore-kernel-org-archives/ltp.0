Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PSQHV-0005vn-BA
	for ltp-list@lists.sourceforge.net; Tue, 14 Dec 2010 08:30:45 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PSQHT-0006km-BJ
	for ltp-list@lists.sourceforge.net; Tue, 14 Dec 2010 08:30:45 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.26])
	by out03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 4AC672113BF
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Dec 2010 08:30:37 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 4C58E3DD01F
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Dec 2010 08:30:36 +0000 (UTC)
Message-ID: <000001cb9b68$e2a50240$a7ef06c0$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 14 Dec 2010 17:28:28 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_17_28_29_Tuesday_December_14_2010_29415"
Content-Language: ja
Subject: [LTP] [PATCH] POSIX "sched_setparam/9-1" and "sched_setparam/10-1"
	tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: =?iso-2022-jp?B?GyRCYUQ6QhsoQiAbJEI3cjtUGyhC?= <toza@ryobi.co.jp>

This is a multi-part message in MIME format.

----=_NextPart_ST_17_28_29_Tuesday_December_14_2010_29415
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi,

LTP's testset "hugeshmget02" failed in my systems.
But usually, "hugeshmget02" passed.

My environments are as follows:
------------
RHEL5.5 --- (x86, x86_64)
RHEL4.8 --- (x86_64)
------------


I noticed that "hugeshmget02" certainly fails after running 
of following POSIX testsets:
------------
sched_setparam/9-1
sched_setparam/10-1
------------

I tried to find the reason of this failure, and examined status of 
the shared memory before execution of test and after execution of test:
------------
[root@RHEL55-64-LTP sched_setparam]# ipcs -m

------ Shared Memory Segments --------
key        shmid      owner      perms      bytes      nattch     status
0x7402035b 1605632    root      600        4          0
0x00000000 1966081    gdm       600        393216     2          dest
0x7402035a 1572866    root      600        4          0

[root@RHEL55-64-LTP sched_setparam]# strace -o $(date +%Y%m%d%H%M%S).strace
-s 256 -T -tt -ff ./9-1.run-test
Test PASSED
[root@RHEL55-64-LTP sched_setparam]# ipcs -m

------ Shared Memory Segments --------
key        shmid      owner      perms      bytes      nattch     status
0x7402035b 1605632    root      600        4          0
0x00000000 1966081    gdm       600        393216     2          dest
0x7402035a 1572866    root      600        4          0
0xffffffff 1998851    root      600        4          0
------------


The result of strace is as follows:
------------
09:28:18.314752 execve("./9-1.run-test", ["./9-1.run-test"], [/* 24 vars
*/]) = 0 <0.011434>
09:28:18.332764 brk(0)                  = 0x17e5000 <0.000011>
09:28:18.332836 mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b9422d13000 <0.000018>
09:28:18.332974 uname({sys="Linux", node="RHEL55-64-LTP", ...}) = 0
<0.000010>
09:28:18.333069 access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file
or directory) <0.000027>
09:28:18.333214 open("/etc/ld.so.cache", O_RDONLY) = 3 <0.000014>
[...]
09:28:18.336308 stat("conformance/interfaces/sched_setparam/9-1.c",
0x7fff1883ce60) = -1 ENOENT (No such file or directory) <0.000014>
09:28:18.336369 shmget(0xffffffff, 4, IPC_CREAT|0600) = 1998851 <0.000026>
09:28:18.336427 shmat(1998851, 0, 0)    = ? <0.000013>
09:28:18.336500 sched_get_priority_min(SCHED_FIFO) = 1 <0.000026>
09:28:18.336565 sched_setscheduler(2465, SCHED_FIFO, { 1 }) = 0 <0.000012>
09:28:18.336626 clone(child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0x2b9422d28930) = 2466 <0.000363>
[...]
09:28:19.384594 kill(2466, SIGTERM)           = 0 <0.000077>
09:28:19.384932 kill(2467, SIGTERM)           = 0 <0.000031>
09:28:19.385112 exit_group(0)           = ?
------------

New shared memory was added after "sched_setparam/9-1".
Added shmid "1998851" is from "shmget()" of "sched_setparam/9-1".
And I judged that it is necessary to detach shared memory.

"sched_setparam/10-1" is same situation.

I revised "sched_setparam/9-1" and "sched_setparam/10-1".
After revision, "hugeshmget02" passed.


This failure may be only in several syetems of RHEL environment.
But I think that detaching is necessary at least even in non-failed systems.


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
============
---
a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
2010-12-14 09:47:45.000000000 +0900
+++
b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
2010-12-14 15:07:56.000000000 +0900
@@ -144,6 +144,7 @@
 	shmptr = (int *)shmat(shm_id, 0, 0);
 	if (shmptr < (int*)0) {
 		perror("An error occurs when calling shmat()");
+		shmctl(shm_id, IPC_RMID, NULL);
 		return PTS_UNRESOLVED;
 	}
 	*shmptr = 0;
@@ -155,6 +156,8 @@
 		} else {
 			perror("An error occurs when calling
sched_setscheduler()");
 		}
+		shmdt(shmptr);
+		shmctl(shm_id, IPC_RMID, NULL);
 		return PTS_UNRESOLVED;
 	}
 
@@ -165,12 +168,16 @@
 			for(j=0; j<i; j++) {
 				kill(child_pid[j], SIGTERM);		
 			}
+			shmdt(shmptr);
+			shmctl(shm_id, IPC_RMID, NULL);
 			return PTS_UNRESOLVED;
 		} else if (child_pid[i] == 0){
 			
 			child_process();
 
 			printf("This code should not be executed.\n");
+			shmdt(shmptr);
+			shmctl(shm_id, IPC_RMID, NULL);
 			return PTS_UNRESOLVED;
 		}
 	}		
@@ -181,12 +188,16 @@
 		for(j=0; j<i; j++) {
 			kill(child_pid[j], SIGTERM);		
 		}
+		shmdt(shmptr);
+		shmctl(shm_id, IPC_RMID, NULL);
 		return PTS_UNRESOLVED;
 	} else if (child_pid[i] == 0){
 		
 		test_process();
 		
 		printf("This code should not be executed.\n");
+		shmdt(shmptr);
+		shmctl(shm_id, IPC_RMID, NULL);
 		return PTS_UNRESOLVED;
 	}
 
@@ -199,6 +210,8 @@
 	if (sched_setparam(child_pid[i], &param) != 0) {
 		perror("An error occurs when calling sched_setparam()");
 		kill_children(child_pid);
+		shmdt(shmptr);
+		shmctl(shm_id, IPC_RMID, NULL);
 		return PTS_UNRESOLVED;
 	}
 	newcount = *shmptr;
@@ -206,10 +219,14 @@
 	if (newcount == oldcount){
 		printf("The target process does not preempt the calling
process\n");
 		kill_children(child_pid);
+		shmdt(shmptr);
+		shmctl(shm_id, IPC_RMID, NULL);
 		return PTS_FAIL;
 	} 
 		
 	printf("Test PASSED\n");
 	kill_children(child_pid);
+	shmdt(shmptr);
+	shmctl(shm_id, IPC_RMID, NULL);
 	return PTS_PASS;
 }
---
a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/10-1.
c	2010-12-11 02:09:56.000000000 +0900
+++
b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/10-1.
c	2010-12-14 15:11:24.000000000 +0900
@@ -123,6 +123,7 @@
 	shmptr = (int *)shmat(shm_id, 0, 0);
 	if (shmptr < (int*)0) {
 		perror("An error occurs when calling shmat()");
+		shmctl(shm_id, IPC_RMID, NULL);
 		return PTS_UNRESOLVED;
 	}
 	*shmptr = 0;
@@ -135,6 +136,8 @@
 		} else {
 			perror("An error occurs when calling
sched_setscheduler()");
 		}
+		shmdt(shmptr);
+		shmctl(shm_id, IPC_RMID, NULL);
 		return PTS_UNRESOLVED;
 	}
 
@@ -145,12 +148,16 @@
 			for(j=0; j<i; j++) {
 				kill(child_pid[j], SIGTERM);		
 			}
+			shmdt(shmptr);
+			shmctl(shm_id, IPC_RMID, NULL);
 			return PTS_UNRESOLVED;
 		} else if (child_pid[i] == 0){
 			
 			child_process();
 
 			printf("This code should not be executed.\n");
+			shmdt(shmptr);
+			shmctl(shm_id, IPC_RMID, NULL);
 			return PTS_UNRESOLVED;
 		}
 	}
@@ -163,6 +170,8 @@
 	if (sched_setparam(getpid(), &param) != 0) {
 		perror("An error occurs when calling sched_setparam()");
 		kill_children(child_pid);
+		shmdt(shmptr);
+		shmctl(shm_id, IPC_RMID, NULL);
 		return PTS_UNRESOLVED;
 	}
 	newcount = *shmptr;
@@ -170,10 +179,14 @@
 	if (newcount == oldcount){
 		printf("The calling process does not relinquish the
processor\n");
 		kill_children(child_pid);
+		shmdt(shmptr);
+		shmctl(shm_id, IPC_RMID, NULL);
 		return PTS_FAIL;
 	} 
 		
 	printf("Test PASSED\n");
 	kill_children(child_pid);
+	shmdt(shmptr);
+	shmctl(shm_id, IPC_RMID, NULL);
 	return PTS_PASS;
 }
============


Regards--

-Tomonori Mitani

----=_NextPart_ST_17_28_29_Tuesday_December_14_2010_29415
Content-Type: application/octet-stream;
	name="9-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="9-1.patch"

--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/=
9-1.c=092010-12-14 09:47:45.000000000 +0900=0A+++ b/testcases/open_posix_te=
stsuite/conformance/interfaces/sched_setparam/9-1.c=092010-12-14 15:07:56.0=
00000000 +0900=0A@@ -144,6 +144,7 @@=0A =09shmptr =3D (int *)shmat(shm_id, =
0, 0);=0A =09if (shmptr < (int*)0) {=0A =09=09perror("An error occurs when =
calling shmat()");=0A+=09=09shmctl(shm_id, IPC_RMID, NULL);=0A =09=09return=
 PTS_UNRESOLVED;=0A =09}=0A =09*shmptr =3D 0;=0A@@ -155,6 +156,8 @@=0A =09=09=
} else {=0A =09=09=09perror("An error occurs when calling sched_setschedule=
r()");=0A =09=09}=0A+=09=09shmdt(shmptr);=0A+=09=09shmctl(shm_id, IPC_RMID,=
 NULL);=0A =09=09return PTS_UNRESOLVED;=0A =09}=0A =0A@@ -165,12 +168,16 @@=
=0A =09=09=09for(j=3D0; j<i; j++) {=0A =09=09=09=09kill(child_pid[j], SIGTE=
RM);=09=09=0A =09=09=09}=0A+=09=09=09shmdt(shmptr);=0A+=09=09=09shmctl(shm_=
id, IPC_RMID, NULL);=0A =09=09=09return PTS_UNRESOLVED;=0A =09=09} else if =
(child_pid[i] =3D=3D 0){=0A =09=09=09=0A =09=09=09child_process();=0A =0A =09=
=09=09printf("This code should not be executed.\n");=0A+=09=09=09shmdt(shmp=
tr);=0A+=09=09=09shmctl(shm_id, IPC_RMID, NULL);=0A =09=09=09return PTS_UNR=
ESOLVED;=0A =09=09}=0A =09}=09=09=0A@@ -181,12 +188,16 @@=0A =09=09for(j=3D=
0; j<i; j++) {=0A =09=09=09kill(child_pid[j], SIGTERM);=09=09=0A =09=09}=0A=
+=09=09shmdt(shmptr);=0A+=09=09shmctl(shm_id, IPC_RMID, NULL);=0A =09=09ret=
urn PTS_UNRESOLVED;=0A =09} else if (child_pid[i] =3D=3D 0){=0A =09=09=0A =09=
=09test_process();=0A =09=09=0A =09=09printf("This code should not be execu=
ted.\n");=0A+=09=09shmdt(shmptr);=0A+=09=09shmctl(shm_id, IPC_RMID, NULL);=0A=
 =09=09return PTS_UNRESOLVED;=0A =09}=0A =0A@@ -199,6 +210,8 @@=0A =09if (s=
ched_setparam(child_pid[i], &param) !=3D 0) {=0A =09=09perror("An error occ=
urs when calling sched_setparam()");=0A =09=09kill_children(child_pid);=0A+=
=09=09shmdt(shmptr);=0A+=09=09shmctl(shm_id, IPC_RMID, NULL);=0A =09=09retu=
rn PTS_UNRESOLVED;=0A =09}=0A =09newcount =3D *shmptr;=0A@@ -206,10 +219,14=
 @@=0A =09if (newcount =3D=3D oldcount){=0A =09=09printf("The target proces=
s does not preempt the calling process\n");=0A =09=09kill_children(child_pi=
d);=0A+=09=09shmdt(shmptr);=0A+=09=09shmctl(shm_id, IPC_RMID, NULL);=0A =09=
=09return PTS_FAIL;=0A =09} =0A =09=09=0A =09printf("Test PASSED\n");=0A =09=
kill_children(child_pid);=0A+=09shmdt(shmptr);=0A+=09shmctl(shm_id, IPC_RMI=
D, NULL);=0A =09return PTS_PASS;=0A }=0A
----=_NextPart_ST_17_28_29_Tuesday_December_14_2010_29415
Content-Type: application/octet-stream;
	name="10-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="10-1.patch"

--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/=
10-1.c=092010-12-11 02:09:56.000000000 +0900=0A+++ b/testcases/open_posix_t=
estsuite/conformance/interfaces/sched_setparam/10-1.c=092010-12-14 15:11:24=
=2E000000000 +0900=0A@@ -123,6 +123,7 @@=0A =09shmptr =3D (int *)shmat(shm_=
id, 0, 0);=0A =09if (shmptr < (int*)0) {=0A =09=09perror("An error occurs w=
hen calling shmat()");=0A+=09=09shmctl(shm_id, IPC_RMID, NULL);=0A =09=09re=
turn PTS_UNRESOLVED;=0A =09}=0A =09*shmptr =3D 0;=0A@@ -135,6 +136,8 @@=0A =
=09=09} else {=0A =09=09=09perror("An error occurs when calling sched_setsc=
heduler()");=0A =09=09}=0A+=09=09shmdt(shmptr);=0A+=09=09shmctl(shm_id, IPC=
_RMID, NULL);=0A =09=09return PTS_UNRESOLVED;=0A =09}=0A =0A@@ -145,12 +148=
,16 @@=0A =09=09=09for(j=3D0; j<i; j++) {=0A =09=09=09=09kill(child_pid[j],=
 SIGTERM);=09=09=0A =09=09=09}=0A+=09=09=09shmdt(shmptr);=0A+=09=09=09shmct=
l(shm_id, IPC_RMID, NULL);=0A =09=09=09return PTS_UNRESOLVED;=0A =09=09} el=
se if (child_pid[i] =3D=3D 0){=0A =09=09=09=0A =09=09=09child_process();=0A=
 =0A =09=09=09printf("This code should not be executed.\n");=0A+=09=09=09sh=
mdt(shmptr);=0A+=09=09=09shmctl(shm_id, IPC_RMID, NULL);=0A =09=09=09return=
 PTS_UNRESOLVED;=0A =09=09}=0A =09}=0A@@ -163,6 +170,8 @@=0A =09if (sched_s=
etparam(getpid(), &param) !=3D 0) {=0A =09=09perror("An error occurs when c=
alling sched_setparam()");=0A =09=09kill_children(child_pid);=0A+=09=09shmd=
t(shmptr);=0A+=09=09shmctl(shm_id, IPC_RMID, NULL);=0A =09=09return PTS_UNR=
ESOLVED;=0A =09}=0A =09newcount =3D *shmptr;=0A@@ -170,10 +179,14 @@=0A =09=
if (newcount =3D=3D oldcount){=0A =09=09printf("The calling process does no=
t relinquish the processor\n");=0A =09=09kill_children(child_pid);=0A+=09=09=
shmdt(shmptr);=0A+=09=09shmctl(shm_id, IPC_RMID, NULL);=0A =09=09return PTS=
_FAIL;=0A =09} =0A =09=09=0A =09printf("Test PASSED\n");=0A =09kill_childre=
n(child_pid);=0A+=09shmdt(shmptr);=0A+=09shmctl(shm_id, IPC_RMID, NULL);=0A=
 =09return PTS_PASS;=0A }=0A
----=_NextPart_ST_17_28_29_Tuesday_December_14_2010_29415
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
----=_NextPart_ST_17_28_29_Tuesday_December_14_2010_29415
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_17_28_29_Tuesday_December_14_2010_29415--

