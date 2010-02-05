Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1NdRum-0005OD-Cn
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 17:24:20 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 88F3C74609
	for <ltp-list@lists.sourceforge.net>;
	Fri,  5 Feb 2010 18:24:11 +0100 (CET)
Date: Fri, 5 Feb 2010 18:24:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100205172438.GA2333@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
Subject: [LTP] [PATCH] fix buffer overflow in sem_getvalue tests
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


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Attached patch fixes possible buffer oveflow in sem_getvalue tests (the buffer
overflow happens when getpid() returns number that couldn't fit into buffer)
and also cleans coding style.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--17pEHd4RhPHOinZp
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
@@ -24,34 +23,33 @@
 #define FUNCTION "sem_getvalue"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
-
-int main() {
-
-	char semname[20];
+int main(void)
+{
+	char semname[64];
 	sem_t *mysemp;
 	int val;
 
-	sprintf(semname, "/" FUNCTION "_" TEST "_%d", getpid());
+	snprintf(semname, 64, "/" FUNCTION "_" TEST "_%d", getpid());
 
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
@@ -60,7 +58,7 @@ int main() {
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
@@ -26,23 +24,22 @@
 #define FUNCTION "sem_getvalue"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
-
-int main() {
-
-	char semname[28];
+int main(void)
+{
+	char semname[64];
 	sem_t *mysemp;
 	int val;
 
-	sprintf(semname, "/" FUNCTION "_" TEST "_%d", getpid());
+	snprintf(semname, 64, "/" FUNCTION "_" TEST "_%d", getpid());
 
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
@@ -50,7 +47,8 @@ int main() {
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
@@ -23,29 +22,28 @@
 #define FUNCTION "sem_getvalue"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
-
-int main() {
-
-	char semname[28];
+int main(void)
+{
+	char semname[64];
 	sem_t *mysemp;
 	int val;
 
-	sprintf(semname, "/" FUNCTION "_" TEST "_%d", getpid());
+	snprintf(semname, 64, "/" FUNCTION "_" TEST "_%d", getpid());
 
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
@@ -25,23 +23,22 @@
 #define FUNCTION "sem_getvalue"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
-
-int main() {
-
-	char semname[28];
+int main(void)
+{
+	char semname[64];
 	sem_t *mysemp;
 	int val;
 
-	sprintf(semname, "/" FUNCTION "_" TEST "_%d", getpid());
+	snprintf(semname, 64, "/" FUNCTION "_" TEST "_%d", getpid());
 
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

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--17pEHd4RhPHOinZp--

