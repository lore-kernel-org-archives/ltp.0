Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1NofuH-0002kl-Ja
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 16:34:13 +0000
Date: Mon, 8 Mar 2010 17:37:20 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100308163720.GA8744@saboteur.suse.cz>
References: <20100205172438.GA2333@saboteur.suse.cz>
	<364299f41002051125x3fe2446dx2d67e5e4f687274f@mail.gmail.com>
	<20100218175018.GA29671@saboteur.suse.cz>
	<364299f41002181351s4c815216ld1911f0d6d522064@mail.gmail.com>
	<20100308144319.GA30879@saboteur.suse.cz>
	<364299f41003080750i27602084ufed62c929fa149c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <364299f41003080750i27602084ufed62c929fa149c8@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Subject: Re: [LTP] [PATCH] fix buffer overflow in sem_getvalue tests
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> >> SEM_NAME_MAX (see
> >> http://publib.boulder.ibm.com/infocenter/iseries/v5r3/topic/apis/ipc=
semo.htm
> >> )?
> >>
> >> This doesn't appear to exist on older versions of Linux (RHEL 4.6 fo=
r
> >> instance...)
> >>
> >> The logic required to determine SEM_NAME_MAX should be easy to grab,
> >> or you could follow the following logic from the sem_open manpage:
> >>
> >> =A0 =A0 =A0 =A0ENAMETOOLONG
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 The length of the name argument exceeds =
{PATH_MAX} or =A0a =A0path-
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 name component is longer than {NAME_MAX}=
.
> >
> > My manual dated as 20-02-2009 says just:
> >
> >
> > ENAMETOOLONG
> > =A0 =A0 =A0 =A0name was too long.
> >
> >
> > And 'man sem_overview' says we should use NAME_MAX - 4 (as on linux, =
named
> > semaphores are files created in /dev/shm/ virtual filesystem that sta=
rts with
> > 'sem.' prefix). Is semname declared as 'char semname[NAME_MAX - 4];' =
okay?
>=20

Patch attached.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

--=20
Cyril Hrubis
chrubis@suse.cz

--X1bOJ3K7DJ5YkBrT
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="sem_getvalue_buffer_overflow.patch"

Index: ltp-full-20090930/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/5-1.c
===================================================================
--- ltp-full-20090930.orig/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/5-1.c
+++ ltp-full-20090930/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/5-1.c
@@ -9,8 +9,7 @@
 /*
  * This test case verifies that calling sem_getvalue doesn't change the 
  * state of the semaphore.
-*/
-
+ */
 
 #include <stdio.h>
 #include <errno.h>
@@ -18,40 +17,40 @@
 #include <semaphore.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <limits.h>
 #include "posixtest.h"
 
 #define TEST "5-1"
 #define FUNCTION "sem_getvalue"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
-
-int main() {
-
-	char semname[20];
+int main(void)
+{
+	char semname[NAME_MAX - 4];
 	sem_t *mysemp;
 	int val;
 
-	sprintf(semname, "/" FUNCTION "_" TEST "_%d", getpid());
+	snprintf(semname, sizeof(semname), "/" FUNCTION "_" TEST "_%d", getpid());
 
 	mysemp = sem_open(semname, O_CREAT, 0777, 4);
 
-	if( mysemp == SEM_FAILED || mysemp == NULL ) {
+	if (mysemp == SEM_FAILED || mysemp == NULL) {
 		perror(ERROR_PREFIX "sem_open");
 		return PTS_UNRESOLVED;
 	}
 
 
-	if( sem_getvalue(mysemp, &val) == -1 ) {
+	if (sem_getvalue(mysemp, &val) == -1) {
 		perror(ERROR_PREFIX "sem_getvalue");
 		return PTS_UNRESOLVED; 
 	}
 
-	if ( sem_trywait(mysemp) == -1 ) {
+	if (sem_trywait(mysemp) == -1) {
 		perror(ERROR_PREFIX "sem_trywait");
 		return PTS_UNRESOLVED;
 	}
 
-	if( sem_getvalue(mysemp, &val) == -1 ) {
+	if (sem_getvalue(mysemp, &val) == -1) {
 		perror(ERROR_PREFIX "sem_getvalue");
 		return PTS_UNRESOLVED; 
 	}
@@ -60,7 +59,7 @@ int main() {
 	printf("Current value is: %d\n", val);
 	*/
 
-	if (val == 3 ) {
+	if (val == 3) {
 		puts("TEST PASSED");
 		sem_close(mysemp);
 		sem_unlink(semname);
Index: ltp-full-20090930/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/1-1.c
===================================================================
--- ltp-full-20090930.orig/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/1-1.c
+++ ltp-full-20090930/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/1-1.c
@@ -10,9 +10,7 @@
  * This test case will call sem_getvalue to update the location referenced
  * by the semaphpre without effecting the state of the semaphore.  The 
  * updated value represents the actual semaphore value when it was called.
-*/
-
-
+ */
 
 #include <stdio.h>
 #include <errno.h>
@@ -20,29 +18,29 @@
 #include <semaphore.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <limits.h>
 #include "posixtest.h"
 
 #define TEST "1-1"
 #define FUNCTION "sem_getvalue"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
-
-int main() {
-
-	char semname[28];
+int main(void)
+{
+	char semname[NAME_MAX - 4];
 	sem_t *mysemp;
 	int val;
 
-	sprintf(semname, "/" FUNCTION "_" TEST "_%d", getpid());
+	snprintf(semname, sizeof(semname), "/" FUNCTION "_" TEST "_%d", getpid());
 
 	mysemp = sem_open(semname, O_CREAT, 0777, 1);
 
-	if( mysemp == SEM_FAILED || mysemp == NULL ) {
+	if (mysemp == SEM_FAILED || mysemp == NULL) {
 		perror(ERROR_PREFIX "sem_open");
 		return PTS_UNRESOLVED;
 	}
 
-	if( sem_getvalue(mysemp, &val) == -1 ) {
+	if (sem_getvalue(mysemp, &val) == -1) {
 		perror(ERROR_PREFIX "sem_getvalue");
 		return PTS_UNRESOLVED; 
 	}
@@ -50,7 +48,8 @@ int main() {
 	/*
 	printf("Current value is: %d\n", val);
 	*/
-	if (val == 1 ) {
+
+	if (val == 1) {
 		puts("TEST PASSED");
 		sem_close(mysemp);
 		sem_unlink(semname);
Index: ltp-full-20090930/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/2-1.c
===================================================================
--- ltp-full-20090930.orig/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/2-1.c
+++ ltp-full-20090930/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/2-1.c
@@ -8,8 +8,7 @@
 
 /*
  * When semaphore is locked, then the value returned by sem_getvalue is zero.
-*/
-
+ */
 
 #include <stdio.h>
 #include <errno.h>
@@ -17,35 +16,35 @@
 #include <semaphore.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <limits.h>
 #include "posixtest.h"
 
 #define TEST "2-1"
 #define FUNCTION "sem_getvalue"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
-
-int main() {
-
-	char semname[28];
+int main(void)
+{
+	char semname[NAME_MAX - 4];
 	sem_t *mysemp;
 	int val;
 
-	sprintf(semname, "/" FUNCTION "_" TEST "_%d", getpid());
+	snprintf(semname, sizeof(semname), "/" FUNCTION "_" TEST "_%d", getpid());
 
 	mysemp = sem_open(semname, O_CREAT, 0777, 1);
 
-	if( mysemp == SEM_FAILED || mysemp == NULL ) {
+	if (mysemp == SEM_FAILED || mysemp == NULL) {
 		perror(ERROR_PREFIX "sem_open");
 		return PTS_UNRESOLVED;
 	}
 
 	/* Lock Semaphore */
-	if (sem_trywait(mysemp) == -1 ) {
+	if (sem_trywait(mysemp) == -1) {
 		perror(ERROR_PREFIX "trywait");
 		return PTS_UNRESOLVED;
 	}
 
-	if( sem_getvalue(mysemp, &val) < 0 ) {
+	if (sem_getvalue(mysemp, &val) < 0) {
 		perror(ERROR_PREFIX "sem_getvalue");
 		return PTS_UNRESOLVED; 
 	}
Index: ltp-full-20090930/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/2-2.c
===================================================================
--- ltp-full-20090930.orig/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/2-2.c
+++ ltp-full-20090930/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/2-2.c
@@ -83,18 +83,15 @@
 /***************************    Test case   ***********************************/
 /******************************************************************************/
 
-void * threaded ( void * arg )
+void *threaded(void * arg)
 {
 	int ret;
 
-	do
-	{
+	do {
 		ret = sem_wait( arg );
-	}
-	while ( ( ret != 0 ) && ( errno == EINTR ) );
+	} while (( ret != 0 ) && (errno == EINTR));
 
-	if ( ret != 0 )
-	{
+	if (ret != 0) {
 		UNRESOLVED( errno, "Failed to wait for the semaphore" );
 	}
 
@@ -103,7 +100,7 @@ void * threaded ( void * arg )
 
 
 /* The main test function. */
-int main( int argc, char * argv[] )
+int main(int argc, char *argv[])
 {
 	int ret, val;
 	sem_t sem;
@@ -113,71 +110,61 @@ int main( int argc, char * argv[] )
 	output_init();
 
 	/* Initialize semaphore */
-	ret = sem_init( &sem, 0, 0 );
+	ret = sem_init(&sem, 0, 0);
 
-	if ( ret != 0 )
-	{
+	if (ret != 0) {
 		UNRESOLVED( errno, "Failed to init semaphore" );
 	}
 
 	/* Create the thread */
-	ret = pthread_create( &th, NULL, threaded, &sem );
+	ret = pthread_create(&th, NULL, threaded, &sem);
 
-	if ( ret != 0 )
-	{
+	if (ret != 0) {
 		UNRESOLVED( ret, "Failed to create the thread" );
 	}
 
 	/* Sleep 1 sec so the thread enters the sem_wait call */
-	sleep( 1 );
+	sleep(1);
 
 	/* Check value */
-	ret = sem_getvalue( &sem, &val );
+	ret = sem_getvalue(&sem, &val);
 
-	if ( ret != 0 )
-	{
+	if (ret != 0) {
 		UNRESOLVED( errno, "Failed to get semaphore value" );
 	}
 
-	if ( ( val != 0 ) && ( val != -1 ) )
-	{
-		output( "Val: %d\n", val );
-		FAILED( "Semaphore count is neither 0 nor # of waiting processes" );
+	if ((val != 0) && (val != -1)) {
+		output("Val: %d\n", val );
+		FAILED("Semaphore count is neither 0 nor # of waiting processes");
 	}
 
 	/* Post the semaphore */
-	ret = sem_post( &sem );
+	ret = sem_post(&sem);
 
-	if ( ret != 0 )
-	{
-		UNRESOLVED( errno, "Failed to post the semaphore" );
+	if (ret != 0) {
+		UNRESOLVED(errno, "Failed to post the semaphore");
 	}
 
 	/* Join the thread */
-	ret = pthread_join( th, NULL );
+	ret = pthread_join(th, NULL);
 
-	if ( ret != 0 )
-	{
+	if (ret != 0) {
 		UNRESOLVED( ret, "Failed to join the thread" );
 	}
 
-
 	/* Destroy the semaphore */
-	ret = sem_destroy( &sem );
+	ret = sem_destroy(&sem);
 
-	if ( ret != 0 )
-	{
+	if (ret != 0) {
 		UNRESOLVED( errno, "Failed to sem_destroy" );
 	}
 
 	/* Test passed */
 #if VERBOSE > 0
 
-	output( "Test passed\n" );
+	output("Test passed\n");
 
 #endif
 
 	PASSED;
 }
-
-
Index: ltp-full-20090930/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/4-1.c
===================================================================
--- ltp-full-20090930.orig/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/4-1.c
+++ ltp-full-20090930/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/4-1.c
@@ -9,9 +9,7 @@
 /*
  * Upon successful completion of calling sem_getvalue, it shall return a value
  * of zero.
-*/
-
-
+ */
 
 #include <stdio.h>
 #include <errno.h>
@@ -19,29 +17,29 @@
 #include <semaphore.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <limits.h>
 #include "posixtest.h"
 
 #define TEST "4-1"
 #define FUNCTION "sem_getvalue"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
-
-int main() {
-
-	char semname[28];
+int main(void)
+{
+	char semname[NAME_MAX - 4];
 	sem_t *mysemp;
 	int val;
 
-	sprintf(semname, "/" FUNCTION "_" TEST "_%d", getpid());
+	snprintf(semname, sizeof(semname), "/" FUNCTION "_" TEST "_%d", getpid());
 
 	mysemp = sem_open(semname, O_CREAT, 0777, 1);
 
-	if( mysemp == SEM_FAILED || mysemp == NULL ) {
+	if (mysemp == SEM_FAILED || mysemp == NULL) {
 		perror(ERROR_PREFIX "sem_open");
 		return PTS_UNRESOLVED;
 	}
 
-	if( sem_getvalue(mysemp, &val) != 0 ) {
+	if (sem_getvalue(mysemp, &val) != 0) {
 		puts("TEST FAILED");
 		return PTS_FAIL;
 	} else {

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--X1bOJ3K7DJ5YkBrT--

