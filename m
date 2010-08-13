Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1OjpvD-0004Gm-SB
	for ltp-list@lists.sourceforge.net; Fri, 13 Aug 2010 08:47:27 +0000
Received: from out11.sjc.mx.trendmicro.com ([216.99.131.48])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OjpvC-00070Z-0G
	for ltp-list@lists.sourceforge.net; Fri, 13 Aug 2010 08:47:27 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.9])
	by out11.sjc.mx.trendmicro.com (Postfix) with ESMTP id 7FB85980436
	for <ltp-list@lists.sourceforge.net>;
	Fri, 13 Aug 2010 08:47:19 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 790A995835
	for <ltp-list@lists.sourceforge.net>;
	Fri, 13 Aug 2010 08:47:17 +0000 (UTC)
Message-ID: <000701cb3abf$b6862400$23926c00$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 13 Aug 2010 17:15:38 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_17_15_39_Friday_August_13_2010_28930"
Content-Language: ja
Subject: [LTP] [PATCH] fix "hugeshmget03" test
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

----=_NextPart_ST_17_15_39_Friday_August_13_2010_28930
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi,

I tried to run hugeshmget03 testcase, but it failed in several environment.
This testcase failed in following systems:
   - RHEL5.5-x86
   - RHEL5.5-x86_64
   - RHEL5.5-ia64

On the other hand, this testcase succeeded in following RHEL4.8 systems:
   - RHEL4.8-x86
   - RHEL4.8-x86_64
   - RHEL4.8-ia64


I used following git:
   ltp-dev-22b12b3f972569361dfa28361fe0685bf0eca259.tar.gz
This testcase failed also in previous gits.


RHEL5.5-x86 log (failed case):
------------
[...]
hugeshmget03    0  TINFO  :  errno = 12 : Cannot allocate memory
hugeshmget03    1  TBROK  :  Didn't get ENOSPC in test setup
[...]
------------

RHEL4.8-x86 log (succeeded case):
------------
[...]
hugeshmget03    1  TPASS  :  expected failure - errno = 28 : No space left
on device
hugeshmget03    1  TPASS  :  expected failure - errno = 28 : No space left
on device
hugeshmget03    1  TPASS  :  expected failure - errno = 28 : No space left
on device
hugeshmget03    1  TPASS  :  expected failure - errno = 28 : No space left
on device
hugeshmget03    1  TPASS  :  expected failure - errno = 28 : No space left
on device
hugeshmget03    1  TPASS  :  expected failure - errno = 28 : No space left
on device
hugeshmget03    1  TPASS  :  expected failure - errno = 28 : No space left
on device
hugeshmget03    1  TPASS  :  expected failure - errno = 28 : No space left
on device
hugeshmget03    1  TPASS  :  expected failure - errno = 28 : No space left
on device
hugeshmget03    1  TPASS  :  expected failure - errno = 28 : No space left
on device
[...]
------------

This test expected that "shmget()" returns ENOSPC after "shmget()" called 
till it reached SHMMNI or SHMALL.
In RHEL4.8 system, "shmget()" returned ENOSPC.
But in RHEL5.5 system, shmget() didn't return ENOSPC.

I used strace command in RHEL5.5, and noticed that "shmget()" returned
ENOMEM:
------------
[root@RHEL55-LTP-x86 ltp]# strace -o git0719-shmget03-strace.txt -s 256 -T
-tt testcases/bin/hugeshmget03 hugeshmget03 -i 10
hugeshmget03    0  TINFO  :  errno = 12 : Cannot allocate memory
hugeshmget03    1  TBROK  :  Didn't get ENOSPC in test setup


17:20:27.939953 gettimeofday({1279614027, 939985}, {4294966756, 0}) = 0
<0.000023>
17:20:27.940089 stat64("/tmp/hugWojTGq", {st_mode=S_IFDIR|0777,
st_size=4096, ...}) = 0 <0.000024>
17:20:27.940386 shmget(IPC_PRIVATE, 4194304,
IPC_CREAT|IPC_EXCL|SHM_HUGETLB|0600) = 276463619 <0.000041>
17:20:27.940518 shmget(IPC_PRIVATE, 4194304,
IPC_CREAT|IPC_EXCL|SHM_HUGETLB|0600) = 276496388 <0.000026>
17:20:27.940648 shmget(IPC_PRIVATE, 4194304,
IPC_CREAT|IPC_EXCL|SHM_HUGETLB|0600) = -1 ENOMEM (Cannot allocate memory)
<0.000032>
17:20:27.940861 fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1),
...}) = 0 <0.000026>
17:20:27.941106 mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f45000 <0.000024>
17:20:27.941233 write(1, "hugeshmget03    0  TINFO  :  errno = 12 : Cannot
allocate memory\n", 65) = 65 <0.000270>
17:20:27.941693 write(1, "hugeshmget03    1  TBROK  :  Didn't get ENOSPC in
test setup\n", 61) = 61 <0.000093>
[...]
------------


The confirmation of free Hugepage obeys followings, I think:
   1. Compare necessary pages and the number of Hugepages.
      If necessary pages exceeded Hugepage, ENOMEM is returned. 
   2. Compare of necessary memory and the limit of shared memory "SHMMNI".
      If necessary memory exceeded SHMMNI, ENOSPC is returned.

The comparison logic of necessary pages and the number of Hugepages 
is different from RHEL4.X system and RHEL5.X system.

In RHEL4.8:
   It is the comparison of "necessary pages" and "HugePages_Free".
   The opportunity of ENOMEM is "necessary pages > HugePages_Free".

   "HugePages_Free" doesn't decrease when "shmget()" is called.
   It decreases only when "shmat()" is called.

   Therefore, ENOMEM is not returned, and ENOSPC occurs when reaching 
   the limit of SHMMNI.

In RHEL5.4:
   "HugePages_Psvd" is added. This parameter is the number of Hugepages 
   which are planned to allocate but aren't yet allocated.
   The opportunity of ENOMEM is "necessary pages + HugePages_Rsvd >
HugePages_Free"

   "HugePages_Psvd" increases when "shmget()" is called.

   Therfore, "shmget()" returns with ENOMEM, and doesn't return with ENOSPC.


I thought that it is necessary to change a judgment condition:
   - When "/proc/meminfo" doesn't have "HugePages_Rsvd" (case of RHEL4.X),
     ENOSPC is OK.
   - When "/proc/meminfo" has "HugePages_Rsvd" (case of RHEL5.X), 
     ENOMEM is OK.


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

============
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c	2010-08-05
22:28:15.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c	2010-08-11
15:06:11.000000000 +0900
@@ -71,6 +71,8 @@
 
 int shm_id_arr[MAXIDS];
 
+/* If HugePages_Rsvd exists in /proc/meminfo, hp_rsvd is 1. */
+int hp_rsvd = 0;
 
 int main(int ac, char **av)
 {
@@ -109,16 +111,18 @@
 
 		TEST_ERROR_LOG(TEST_ERRNO);
 
-		switch(TEST_ERRNO) {
-		case ENOSPC:
+		/*
+		 * errno is ENOSPC and hp_rsvd is 0 -> PASS
+		 * errno is ENOMEM and hp_rsvd is 1 -> PASS
+		 * others                           -> FAIL
+		 */
+		if ((errno == ENOSPC && hp_rsvd == 0) || (errno == ENOMEM &&
hp_rsvd == 1)){
 			tst_resm(TPASS, "expected failure - errno = "
 				 "%d : %s", TEST_ERRNO,
strerror(TEST_ERRNO));
-			break;
-		default:
+		} else {
 			tst_resm(TFAIL, "call failed with an "
 				 "unexpected error - %d : %s",
 				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
 		}		
 	}
 
@@ -141,6 +145,19 @@
 	/* Pause if that option was specified */
 	TEST_PAUSE;
 
+	/* Check whether HugePages_Rsvd exists in /proc/meminfo or not. */
+	FILE *fp;
+	char s[50];
+	if ((fp = fopen("/proc/meminfo", "r")) == NULL) {
+		tst_brkm(TBROK, tst_exit, "Cannot open /proc/meminfo.");
+	}
+	while (fgets(s, 50, fp) != NULL) {
+		if (strstr(s, "HugePages_Rsvd") != NULL) {
+			hp_rsvd = 1;
+		}
+	}
+	fclose(fp);
+	
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
@@ -166,11 +183,13 @@
 	}
 
 	/*
-	 * If the errno is other than ENOSPC, then something else is wrong.
+	 * errno is ENOSPC and hp_rsvd is 0 -> OK
+	 * errno is ENOMEM and hp_rsvd is 1 -> OK
+	 * others                           -> NG
 	 */
-	if (errno != ENOSPC) {
+	if (!(errno == ENOSPC && hp_rsvd == 0) && !(errno == ENOMEM &&
hp_rsvd == 1)){
 		tst_resm(TINFO, "errno = %d : %s", errno, strerror(errno));
-		tst_brkm(TBROK, cleanup, "Didn't get ENOSPC in test setup");
+		tst_brkm(TBROK, cleanup, "Didn't get ENOSPC or ENOMEM in
test setup");
 	}
 }
 
============



Regards--


-Tomonori Mitani

----=_NextPart_ST_17_15_39_Friday_August_13_2010_28930
Content-Type: application/octet-stream;
	name="hugeshmget03.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hugeshmget03.patch"

--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c=092010-08-05 2=
2:28:15.000000000 +0900=0A+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hug=
eshmget03.c=092010-08-11 15:06:11.000000000 +0900=0A@@ -71,6 +71,8 @@=0A =0A=
 int shm_id_arr[MAXIDS];=0A =0A+/* If HugePages_Rsvd exists in /proc/meminf=
o, hp_rsvd is 1. */=0A+int hp_rsvd =3D 0;=0A =0A int main(int ac, char **av=
)=0A {=0A@@ -109,16 +111,18 @@=0A =0A =09=09TEST_ERROR_LOG(TEST_ERRNO);=0A =
=0A-=09=09switch(TEST_ERRNO) {=0A-=09=09case ENOSPC:=0A+=09=09/*=0A+=09=09 =
* errno is ENOSPC and hp_rsvd is 0 -> PASS=0A+=09=09 * errno is ENOMEM and =
hp_rsvd is 1 -> PASS=0A+=09=09 * others                           -> FAIL=0A=
+=09=09 */=0A+=09=09if ((errno =3D=3D ENOSPC && hp_rsvd =3D=3D 0) || (errno=
 =3D=3D ENOMEM && hp_rsvd =3D=3D 1)){=0A =09=09=09tst_resm(TPASS, "expected=
 failure - errno =3D "=0A =09=09=09=09 "%d : %s", TEST_ERRNO, strerror(TEST=
_ERRNO));=0A-=09=09=09break;=0A-=09=09default:=0A+=09=09} else {=0A =09=09=09=
tst_resm(TFAIL, "call failed with an "=0A =09=09=09=09 "unexpected error - =
%d : %s",=0A =09=09=09=09 TEST_ERRNO, strerror(TEST_ERRNO));=0A-=09=09=09br=
eak;=0A =09=09}=09=09=0A =09}=0A =0A@@ -141,6 +145,19 @@=0A =09/* Pause if =
that option was specified */=0A =09TEST_PAUSE;=0A =0A+=09/* Check whether H=
ugePages_Rsvd exists in /proc/meminfo or not. */=0A+=09FILE *fp;=0A+=09char=
 s[50];=0A+=09if ((fp =3D fopen("/proc/meminfo", "r")) =3D=3D NULL) {=0A+=09=
=09tst_brkm(TBROK, tst_exit, "Cannot open /proc/meminfo.");=0A+=09}=0A+=09w=
hile (fgets(s, 50, fp) !=3D NULL) {=0A+=09=09if (strstr(s, "HugePages_Rsvd"=
) !=3D NULL) {=0A+=09=09=09hp_rsvd =3D 1;=0A+=09=09}=0A+=09}=0A+=09fclose(f=
p);=0A+=09=0A =09/*=0A =09 * Create a temporary directory and cd into it.=0A=
 =09 * This helps to ensure that a unique msgkey is created.=0A@@ -166,11 +=
183,13 @@=0A =09}=0A =0A =09/*=0A-=09 * If the errno is other than ENOSPC, =
then something else is wrong.=0A+=09 * errno is ENOSPC and hp_rsvd is 0 -> =
OK=0A+=09 * errno is ENOMEM and hp_rsvd is 1 -> OK=0A+=09 * others         =
                  -> NG=0A =09 */=0A-=09if (errno !=3D ENOSPC) {=0A+=09if (=
!(errno =3D=3D ENOSPC && hp_rsvd =3D=3D 0) && !(errno =3D=3D ENOMEM && hp_r=
svd =3D=3D 1)){=0A =09=09tst_resm(TINFO, "errno =3D %d : %s", errno, strerr=
or(errno));=0A-=09=09tst_brkm(TBROK, cleanup, "Didn't get ENOSPC in test se=
tup");=0A+=09=09tst_brkm(TBROK, cleanup, "Didn't get ENOSPC or ENOMEM in te=
st setup");=0A =09}=0A }=0A =0A
----=_NextPart_ST_17_15_39_Friday_August_13_2010_28930
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
----=_NextPart_ST_17_15_39_Friday_August_13_2010_28930
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_17_15_39_Friday_August_13_2010_28930--

