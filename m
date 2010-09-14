Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <romansc@us.ibm.com>) id 1OvVX8-0004z4-L2
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 13:26:50 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OvVX7-0001fR-3M
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 13:26:50 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8EDC5jl016743
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 09:12:05 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8EDQgX5390270
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 09:26:42 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8EDQfRt030123
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 09:26:41 -0400
Received: from d01ml605.pok.ibm.com (d01ml605.pok.ibm.com [9.56.227.91])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o8EDQeaG029922
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 09:26:40 -0400
Message-ID: <OFD6B689AE.1AE38E72-ON8525779D.0054A722-8525779E.0049DA86@us.ibm.com>
From: Scott Romanowski <romansc@us.ibm.com>
Date: Tue, 14 Sep 2010 09:26:39 -0400
MIME-Version: 1.0
Subject: [LTP] 20100831 release hugetlb tests bug and patch (re-post with
	sign-off line)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7022240575421208192=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7022240575421208192==
Content-type: multipart/alternative; 
	Boundary="0__=0ABBFD0EDFC721B28f9e8a93df938690918c0ABBFD0EDFC721B2"
Content-Disposition: inline

--0__=0ABBFD0EDFC721B28f9e8a93df938690918c0ABBFD0EDFC721B2
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



The various hugetlb tests don't check to see if they are trying to allo=
cate
> SHMMAX memory, nor do they try to compensate for multiple processes -=
-
each process will try to get half of memory, so eventually a request wi=
ll
fail.

I suggest adding a function to lib/system_specific_hugepages_info.c and=

include/system_specific_hugepages_info.h, and replacing the existing
calculation with a call to the new function in
testcases\kernel\mem\hugetlb\hugeshmat\hugeshmat01.c
testcases\kernel\mem\hugetlb\hugeshmat\hugeshmat02.c
testcases\kernel\mem\hugetlb\hugeshmat\hugeshmat03.c
testcases\kernel\mem\hugetlb\hugeshmctl\hugeshmctl01.c
testcases\kernel\mem\hugetlb\hugeshmctl\hugeshmctl02.c
testcases\kernel\mem\hugetlb\hugeshmctl\hugeshmctl03.c
testcases\kernel\mem\hugetlb\hugeshmdt\hugeshmdt01.c
testcases\kernel\mem\hugetlb\hugeshmget\hugeshmget01.c
testcases\kernel\mem\hugetlb\hugeshmget\hugeshmget02.c
testcases\kernel\mem\hugetlb\hugeshmget\hugeshmget03.c
testcases\kernel\mem\hugetlb\hugeshmget\hugeshmget05.c

With this change you can run all the tests with multiple forked process=
es,
except hugeshmget02 and hugeshmget03.

hugeshmget02 creates a large shared memory segment, then loops, trying =
to
shmget() it in various invalid ways.  Once it has finished looping, it
deletes the segment.  If you run it with multiple parallel processes, o=
nce
one process finishes its loop and deletes the segment, the others fail.=


hugeshmget03 allocates all of the available huge memory, then loops, tr=
ying
to allocate one more chunk and expecting an error.  It finally dealloca=
tes
all the memory.  However, running this test in multiple parallel proces=
ses
can cause false errors as follows:
- The numerous processes allocate all of huge memory.
- process 1 tries to allocate more.  It fails, finishes its loops, and =
then
releases all the memory it allocated.
- process 2, which hasn't finished all its loops then tries to allocate=

more, and succeeds, which is a failure.


The patches:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
diff -r 90778db5a87c include/system_specific_hugepages_info.h
--- a/include/system_specific_hugepages_info.h	Mon Sep 13 11:19:49 2010=

-0400
+++ b/include/system_specific_hugepages_info.h	Mon Sep 13 14:51:14 2010=

-0400
@@ -24,5 +24,13 @@
 int get_no_of_hugepages(void);
 /*Returns Hugepages Size from /proc/meminfo*/
 int hugepages_size(void);
+
+/*  Returns number of bytes to allocate, based on total huge memory,
+	a fraction, SHMMAX, and the number of parallel processes that will be=

+	allocating memory.  fraction is the fraction of total memory to use.
+	E.g., a fraction of 0.5 will allocate from 1/2 the total, 0.333 would=

use 1/3.
+	A fraction of 1 would allocate from all the huge memory.
+*/
+size_t calculate_huge_pages_shm_to_be_allocated( double fraction );
 #endif

diff -r 90778db5a87c lib/system_specific_hugepages_info.c
--- a/lib/system_specific_hugepages_info.c	Mon Sep 13 11:19:49 2010
-0400
+++ b/lib/system_specific_hugepages_info.c	Mon Sep 13 14:51:14 2010
-0400
@@ -26,8 +26,10 @@
  */

 #include <fcntl.h>
+#include <linux/shm.h>
 #include <sys/types.h>
 #include <test.h>
+#include "usctest.h"

 #define BUFSIZE 512

@@ -76,3 +78,29 @@
  #endif
 }

+/*  Calculate how much memory to allocate based on the available huge
memory and
+	how many parallel processes are going to allocate it.
+*/
+size_t calculate_huge_pages_shm_to_be_allocated( double fraction )
+{
+#ifdef __linux__
+	size_t bytes_to_allocate;
+
+	bytes_to_allocate =3D (size_t)(fraction * (double)get_no_of_hugepages=
()
* (double)hugepages_size() * 1024.0);
+
+	/* Now divide that up amongst the processes */
+	if( STD_COPIES > 1 )
+		bytes_to_allocate /=3D (size_t)STD_COPIES;
+	/* and limit to SHMMAX */
+	if( bytes_to_allocate > SHMMAX )
+		bytes_to_allocate =3D (size_t)SHMMAX;
+
+	#ifdef DEBUG
+	printf( "calculate_huge_pages_shm_to_be_allocated(%lf) returns %lu
\n", divider, (unsigned long)bytes_to_allocate );
+	#endif
+
+	return bytes_to_allocate;
+#else
+	return (size_t)-1;
+#endif
+}
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01=
.c
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c	Mon Sep 13
11:19:49 2010 -0400
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c	Mon Sep 13
14:51:14 2010 -0400
@@ -106,8 +106,8 @@

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=

              tst_brkm(TCONF, tst_exit, "Not enough available Hugepages=
");
-        else
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) *
hugepages_size() * 1024) / 2 ;
+        else
+	        huge_pages_shm_to_be_allocated =3D
calculate_huge_pages_shm_to_be_allocated(0.5);

 	setup();			/* global setup */

diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02=
.c
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c	Mon Sep 13
11:19:49 2010 -0400
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c	Mon Sep 13
14:51:14 2010 -0400
@@ -103,8 +103,8 @@

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=

              tst_brkm(TCONF, tst_exit, "Not enough available Hugepages=
");
-        else
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) *
hugepages_size() * 1024) / 2 ;
+        else
+	        huge_pages_shm_to_be_allocated =3D
calculate_huge_pages_shm_to_be_allocated(0.5);

 	setup();			/* global setup */

diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03=
.c
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c	Mon Sep 13
11:19:49 2010 -0400
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c	Mon Sep 13
14:51:14 2010 -0400
@@ -87,8 +87,8 @@

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=

              tst_brkm(TCONF, cleanup, "Not enough available Hugepages"=
);
-        else
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) *
hugepages_size() * 1024) / 2 ;
+        else
+	        huge_pages_shm_to_be_allocated =3D
calculate_huge_pages_shm_to_be_allocated(0.5);

 	setup();			/* global setup */

diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl=
01.c
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c	Mon Sep
13 11:19:49 2010 -0400
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c	Mon Sep
13 14:51:14 2010 -0400
@@ -131,8 +131,8 @@

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=

              tst_brkm(TCONF, tst_exit, "Not enough available Hugepages=
");
-        else
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) *
hugepages_size() * 1024) / 2 ;
+        else
+	        huge_pages_shm_to_be_allocated =3D
calculate_huge_pages_shm_to_be_allocated(0.5);

 	setup();			/* global setup */

diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl=
02.c
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c	Mon Sep
13 11:19:49 2010 -0400
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c	Mon Sep
13 14:51:14 2010 -0400
@@ -103,8 +103,8 @@

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=

              tst_brkm(TCONF, tst_exit, "Not enough available Hugepages=
");
-        else
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) *
hugepages_size() * 1024) / 2 ;
+        else
+             huge_pages_shm_to_be_allocated =3D
calculate_huge_pages_shm_to_be_allocated(0.5);

 	setup();			/* global setup */

diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl=
03.c
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c	Mon Sep
13 11:19:49 2010 -0400
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c	Mon Sep
13 14:51:14 2010 -0400
@@ -106,8 +106,8 @@

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=

              tst_brkm(TCONF, cleanup, "Not enough available Hugepages"=
);
-        else
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) *
hugepages_size() * 1024) / 2 ;
+        else
+             huge_pages_shm_to_be_allocated =3D
calculate_huge_pages_shm_to_be_allocated(0.5);

 	setup();			/* global setup */

diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01=
.c
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c	Mon Sep 13
11:19:49 2010 -0400
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c	Mon Sep 13
14:51:14 2010 -0400
@@ -88,8 +88,8 @@

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=

              tst_brkm(TCONF, tst_exit, "Not enough available Hugepages=
");
-        else
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) *
hugepages_size() * 1024) / 2 ;
+        else
+	        huge_pages_shm_to_be_allocated =3D
calculate_huge_pages_shm_to_be_allocated(0.5);

 	setup();			/* global setup */

diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget=
01.c
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	Mon Sep
13 11:19:49 2010 -0400
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	Mon Sep
13 14:51:14 2010 -0400
@@ -81,9 +81,9 @@
 	/* The following loop checks looping state if -i option given */
         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=

              tst_brkm(TCONF, tst_exit, "Not enough available Hugepages=
");
-        else
-              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages=
() *
hugepages_size() * 1024) / 2 ;
-
+        else
+	        huge_pages_shm_to_be_allocated =3D
calculate_huge_pages_shm_to_be_allocated(0.5);
+
 	setup();			/* global setup */

         for (lc =3D 0; TEST_LOOPING(lc); lc++) {
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget=
02.c
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c	Mon Sep
13 11:19:49 2010 -0400
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c	Mon Sep
13 14:51:14 2010 -0400
@@ -85,9 +85,9 @@

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=

              tst_brkm(TCONF, tst_exit, "Not enough available Hugepages=
");
-        else
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) *
hugepages_size() * 1024) / 2 ;
-
+        else
+	        huge_pages_shm_to_be_allocated =3D
calculate_huge_pages_shm_to_be_allocated(0.5);
+
         struct test_case_t TC[] =3D {
          /* EINVAL - size is 0 */
          {&shmkey2, 0, SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW,
EINVAL},
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget=
03.c
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c	Mon Sep
13 11:19:49 2010 -0400
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c	Mon Sep
13 14:51:14 2010 -0400
@@ -86,8 +86,8 @@
 	/* The following loop checks looping state if -i option given */
         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=

              tst_brkm(TCONF, tst_exit, "Not enough available Hugepages=
");
-        else
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) *
hugepages_size() * 1024) / 2 ;
+        else
+             huge_pages_shm_to_be_allocated =3D
calculate_huge_pages_shm_to_be_allocated(0.5);

 	setup2(huge_pages_shm_to_be_allocated);			/* local  setup */

diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget=
05.c
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c	Mon Sep
13 11:19:49 2010 -0400
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c	Mon Sep
13 14:51:14 2010 -0400
@@ -87,9 +87,9 @@

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=

              tst_brkm(TCONF, cleanup, "Not enough available Hugepages"=
);
-        else
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) *
hugepages_size() * 1024) / 2 ;
-
+        else
+             huge_pages_shm_to_be_allocated =3D
calculate_huge_pages_shm_to_be_allocated(0.5);
+
 	setup();			/* global setup */

 	if ((pid =3D fork()) =3D=3D -1) {
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~

Signed-off-by: Scott Romanowski <romansc@us.ibm.com>
--
Scott Romanowski=

--0__=0ABBFD0EDFC721B28f9e8a93df938690918c0ABBFD0EDFC721B2
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p>The various hugetlb tests don't check to see if they are trying to a=
llocate &gt; SHMMAX memory, nor do they try to compensate for multiple =
processes -- each process will try to get half of memory, so eventually=
 a request will fail.<br>
<br>
I suggest adding a function to lib/system_specific_hugepages_info.c and=
 include/system_specific_hugepages_info.h, and replacing the existing c=
alculation with a call to the new function in<br>
testcases\kernel\mem\hugetlb\hugeshmat\hugeshmat01.c<br>
testcases\kernel\mem\hugetlb\hugeshmat\hugeshmat02.c<br>
testcases\kernel\mem\hugetlb\hugeshmat\hugeshmat03.c<br>
testcases\kernel\mem\hugetlb\hugeshmctl\hugeshmctl01.c<br>
testcases\kernel\mem\hugetlb\hugeshmctl\hugeshmctl02.c<br>
testcases\kernel\mem\hugetlb\hugeshmctl\hugeshmctl03.c<br>
testcases\kernel\mem\hugetlb\hugeshmdt\hugeshmdt01.c<br>
testcases\kernel\mem\hugetlb\hugeshmget\hugeshmget01.c<br>
testcases\kernel\mem\hugetlb\hugeshmget\hugeshmget02.c<br>
testcases\kernel\mem\hugetlb\hugeshmget\hugeshmget03.c<br>
testcases\kernel\mem\hugetlb\hugeshmget\hugeshmget05.c<br>
<br>
With this change you can run all the tests with multiple forked process=
es, except hugeshmget02 and hugeshmget03.<br>
<br>
hugeshmget02 creates a large shared memory segment, then loops, trying =
to shmget() it in various invalid ways.  Once it has finished looping, =
it deletes the segment.  If you run it with multiple parallel processes=
, once one process finishes its loop and deletes the segment, the other=
s fail.<br>
<br>
hugeshmget03 allocates all of the available huge memory, then loops, tr=
ying to allocate one more chunk and expecting an error.  It finally dea=
llocates all the memory.  However, running this test in multiple parall=
el processes can cause false errors as follows:<br>
- The numerous processes allocate all of huge memory.<br>
- process 1 tries to allocate more.  It fails, finishes its loops, and =
then releases all the memory it allocated.<br>
- process 2, which hasn't finished all its loops then tries to allocate=
 more, and succeeds, which is a failure.<br>
<br>
<br>
The patches:<br>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~<br>
diff -r 90778db5a87c include/system_specific_hugepages_info.h<br>
--- a/include/system_specific_hugepages_info.h	Mon Sep 13 11:19:49 2010=
 -0400<br>
+++ b/include/system_specific_hugepages_info.h	Mon Sep 13 14:51:14 2010=
 -0400<br>
@@ -24,5 +24,13 @@<br>
 int get_no_of_hugepages(void);<br>
 /*Returns Hugepages Size from /proc/meminfo*/<br>
 int hugepages_size(void);<br>
+<br>
+/*  Returns number of bytes to allocate, based on total huge memory,<b=
r>
+	a fraction, SHMMAX, and the number of parallel processes that will be=
<br>
+	allocating memory.  fraction is the fraction of total memory to use.<=
br>
+	E.g., a fraction of 0.5 will allocate from 1/2 the total, 0.333 would=
 use 1/3.<br>
+	A fraction of 1 would allocate from all the huge memory.<br>
+*/<br>
+size_t calculate_huge_pages_shm_to_be_allocated( double fraction );<br=
>
 #endif<br>
 <br>
diff -r 90778db5a87c lib/system_specific_hugepages_info.c<br>
--- a/lib/system_specific_hugepages_info.c	Mon Sep 13 11:19:49 2010 -04=
00<br>
+++ b/lib/system_specific_hugepages_info.c	Mon Sep 13 14:51:14 2010 -04=
00<br>
@@ -26,8 +26,10 @@<br>
  */<br>
 <br>
 #include &lt;fcntl.h&gt;<br>
+#include &lt;linux/shm.h&gt;<br>
 #include &lt;sys/types.h&gt;<br>
 #include &lt;test.h&gt;<br>
+#include &quot;usctest.h&quot;<br>
 <br>
 #define BUFSIZE 512<br>
 <br>
@@ -76,3 +78,29 @@<br>
  #endif<br>
 }<br>
 <br>
+/*  Calculate how much memory to allocate based on the available huge =
memory and<br>
+	how many parallel processes are going to allocate it.<br>
+*/<br>
+size_t calculate_huge_pages_shm_to_be_allocated( double fraction )<br>=

+{<br>
+#ifdef __linux__<br>
+	size_t bytes_to_allocate;<br>
+<br>
+	bytes_to_allocate =3D (size_t)(fraction * (double)get_no_of_hugepages=
() * (double)hugepages_size() * 1024.0);<br>
+<br>
+	/* Now divide that up amongst the processes */<br>
+	if( STD_COPIES &gt; 1 )<br>
+		bytes_to_allocate /=3D (size_t)STD_COPIES;<br>
+	/* and limit to SHMMAX */<br>
+	if( bytes_to_allocate &gt; SHMMAX )<br>
+		bytes_to_allocate =3D (size_t)SHMMAX;<br>
+<br>
+	#ifdef DEBUG<br>
+	printf( &quot;calculate_huge_pages_shm_to_be_allocated(%lf) returns %=
lu\n&quot;, divider, (unsigned long)bytes_to_allocate );<br>
+	#endif<br>
+<br>
+	return bytes_to_allocate;<br>
+#else<br>
+	return (size_t)-1;<br>
+#endif<br>
+}<br>
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01=
.c<br>
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c	Mon Sep 13 1=
1:19:49 2010 -0400<br>
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c	Mon Sep 13 1=
4:51:14 2010 -0400<br>
@@ -106,8 +106,8 @@<br>
 <br>
         if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt;=3D=
 0 )<br>
              tst_brkm(TCONF, tst_exit, &quot;Not enough available Huge=
pages&quot;);<br>
-        else             <br>
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) * hugepages_size() * 1024) / 2 ;<br>
+        else<br>
+	        huge_pages_shm_to_be_allocated =3D calculate_huge_pages_shm_t=
o_be_allocated(0.5);<br>
 <br>
 	setup();			/* global setup */<br>
 <br>
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02=
.c<br>
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c	Mon Sep 13 1=
1:19:49 2010 -0400<br>
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c	Mon Sep 13 1=
4:51:14 2010 -0400<br>
@@ -103,8 +103,8 @@<br>
 <br>
         if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt;=3D=
 0 )<br>
              tst_brkm(TCONF, tst_exit, &quot;Not enough available Huge=
pages&quot;);<br>
-        else             <br>
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) * hugepages_size() * 1024) / 2 ;<br>
+        else<br>
+	        huge_pages_shm_to_be_allocated =3D calculate_huge_pages_shm_t=
o_be_allocated(0.5);<br>
 <br>
 	setup();			/* global setup */<br>
 <br>
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03=
.c<br>
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c	Mon Sep 13 1=
1:19:49 2010 -0400<br>
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c	Mon Sep 13 1=
4:51:14 2010 -0400<br>
@@ -87,8 +87,8 @@<br>
 <br>
         if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt;=3D=
 0 )<br>
              tst_brkm(TCONF, cleanup, &quot;Not enough available Hugep=
ages&quot;);<br>
-        else             <br>
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) * hugepages_size() * 1024) / 2 ;<br>
+        else<br>
+	        huge_pages_shm_to_be_allocated =3D calculate_huge_pages_shm_t=
o_be_allocated(0.5);<br>
 <br>
 	setup();			/* global setup */<br>
 <br>
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl=
01.c<br>
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c	Mon Sep 13=
 11:19:49 2010 -0400<br>
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c	Mon Sep 13=
 14:51:14 2010 -0400<br>
@@ -131,8 +131,8 @@<br>
 <br>
         if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt;=3D=
 0 )<br>
              tst_brkm(TCONF, tst_exit, &quot;Not enough available Huge=
pages&quot;);<br>
-        else             <br>
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) * hugepages_size() * 1024) / 2 ;<br>
+        else<br>
+	        huge_pages_shm_to_be_allocated =3D calculate_huge_pages_shm_t=
o_be_allocated(0.5);<br>
 <br>
 	setup();			/* global setup */<br>
 <br>
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl=
02.c<br>
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c	Mon Sep 13=
 11:19:49 2010 -0400<br>
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c	Mon Sep 13=
 14:51:14 2010 -0400<br>
@@ -103,8 +103,8 @@<br>
 <br>
         if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt;=3D=
 0 )<br>
              tst_brkm(TCONF, tst_exit, &quot;Not enough available Huge=
pages&quot;);<br>
-        else             <br>
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) * hugepages_size() * 1024) / 2 ;<br>
+        else<br>
+             huge_pages_shm_to_be_allocated =3D calculate_huge_pages_s=
hm_to_be_allocated(0.5);<br>
 <br>
 	setup();			/* global setup */<br>
 <br>
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl=
03.c<br>
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c	Mon Sep 13=
 11:19:49 2010 -0400<br>
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c	Mon Sep 13=
 14:51:14 2010 -0400<br>
@@ -106,8 +106,8 @@<br>
 <br>
         if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt;=3D=
 0 )<br>
              tst_brkm(TCONF, cleanup, &quot;Not enough available Hugep=
ages&quot;);<br>
-        else             <br>
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) * hugepages_size() * 1024) / 2 ;<br>
+        else<br>
+             huge_pages_shm_to_be_allocated =3D calculate_huge_pages_s=
hm_to_be_allocated(0.5);<br>
 <br>
 	setup();			/* global setup */<br>
 <br>
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01=
.c<br>
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c	Mon Sep 13 1=
1:19:49 2010 -0400<br>
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c	Mon Sep 13 1=
4:51:14 2010 -0400<br>
@@ -88,8 +88,8 @@<br>
 <br>
         if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt;=3D=
 0 )<br>
              tst_brkm(TCONF, tst_exit, &quot;Not enough available Huge=
pages&quot;);<br>
-        else             <br>
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) * hugepages_size() * 1024) / 2 ;<br>
+        else<br>
+	        huge_pages_shm_to_be_allocated =3D calculate_huge_pages_shm_t=
o_be_allocated(0.5);<br>
 <br>
 	setup();			/* global setup */<br>
 <br>
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget=
01.c<br>
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	Mon Sep 13=
 11:19:49 2010 -0400<br>
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	Mon Sep 13=
 14:51:14 2010 -0400<br>
@@ -81,9 +81,9 @@<br>
 	/* The following loop checks looping state if -i option given */<br>
         if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt;=3D=
 0 )<br>
              tst_brkm(TCONF, tst_exit, &quot;Not enough available Huge=
pages&quot;);<br>
-        else             <br>
-              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages=
() * hugepages_size() * 1024) / 2 ;<br>
-        <br>
+        else<br>
+	        huge_pages_shm_to_be_allocated =3D calculate_huge_pages_shm_t=
o_be_allocated(0.5);<br>
+<br>
 	setup();			/* global setup */<br>
 <br>
         for (lc =3D 0; TEST_LOOPING(lc); lc++) {<br>
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget=
02.c<br>
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c	Mon Sep 13=
 11:19:49 2010 -0400<br>
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c	Mon Sep 13=
 14:51:14 2010 -0400<br>
@@ -85,9 +85,9 @@<br>
 <br>
         if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt;=3D=
 0 )<br>
              tst_brkm(TCONF, tst_exit, &quot;Not enough available Huge=
pages&quot;);<br>
-        else             <br>
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) * hugepages_size() * 1024) / 2 ;<br>
-  <br>
+        else<br>
+	        huge_pages_shm_to_be_allocated =3D calculate_huge_pages_shm_t=
o_be_allocated(0.5);<br>
+<br>
         struct test_case_t TC[] =3D {<br>
          /* EINVAL - size is 0 */<br>
          {&amp;shmkey2, 0, SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW=
, EINVAL},<br>
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget=
03.c<br>
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c	Mon Sep 13=
 11:19:49 2010 -0400<br>
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c	Mon Sep 13=
 14:51:14 2010 -0400<br>
@@ -86,8 +86,8 @@<br>
 	/* The following loop checks looping state if -i option given */<br>
         if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt;=3D=
 0 )<br>
              tst_brkm(TCONF, tst_exit, &quot;Not enough available Huge=
pages&quot;);<br>
-        else             <br>
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) * hugepages_size() * 1024) / 2 ;<br>
+        else<br>
+             huge_pages_shm_to_be_allocated =3D calculate_huge_pages_s=
hm_to_be_allocated(0.5);<br>
 <br>
 	setup2(huge_pages_shm_to_be_allocated);			/* local  setup */<br>
 <br>
diff -r 90778db5a87c testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget=
05.c<br>
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c	Mon Sep 13=
 11:19:49 2010 -0400<br>
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c	Mon Sep 13=
 14:51:14 2010 -0400<br>
@@ -87,9 +87,9 @@<br>
 <br>
         if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt;=3D=
 0 )<br>
              tst_brkm(TCONF, cleanup, &quot;Not enough available Hugep=
ages&quot;);<br>
-        else             <br>
-             huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages(=
) * hugepages_size() * 1024) / 2 ;<br>
-       <br>
+        else<br>
+             huge_pages_shm_to_be_allocated =3D calculate_huge_pages_s=
hm_to_be_allocated(0.5);<br>
+<br>
 	setup();			/* global setup */<br>
 <br>
 	if ((pid =3D fork()) =3D=3D -1) {<br>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~<br>
<br>
Signed-off-by: Scott Romanowski &lt;romansc@us.ibm.com&gt;<br>
--<br>
Scott Romanowski<br>
</body></html>=

--0__=0ABBFD0EDFC721B28f9e8a93df938690918c0ABBFD0EDFC721B2--



--===============7022240575421208192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--===============7022240575421208192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7022240575421208192==--


