Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MwDyc-0007q5-7g
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 11:49:38 +0000
Received: from relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 78EF78D893
	for <ltp-list@lists.sourceforge.net>;
	Fri,  9 Oct 2009 13:49:21 +0200 (CEST)
Date: Fri, 9 Oct 2009 13:49:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091009114920.GA3725@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
Subject: [LTP] [PATCH] just another printf cleanup
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


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
attached patch fixes some more printf formating issues as well as some coding
style errors.

Signed-off-by: chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--WIyZ46R2i8wDzkSu
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="printf_cleanup.patch"

Index: ltp/testcases/kernel/fs/proc/proc01.c
===================================================================
--- ltp.orig/testcases/kernel/fs/proc/proc01.c
+++ ltp/testcases/kernel/fs/proc/proc01.c
@@ -27,14 +27,14 @@
 
 #include "config.h"
 
-#include <errno.h>		/* for errno */
-#include <stdio.h>		/* for NULL */
-#include <stdlib.h>		/* for malloc() */
-#include <string.h>		/* for string function */
-#include <limits.h>		/* for PATH_MAX */
-#include <sys/types.h>		/* for opendir(), readdir(), closedir(), stat() */
-#include <sys/stat.h>		/* for [l]stat() */
-#include <dirent.h>		/* for opendir(), readdir(), closedir() */
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <dirent.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <fnmatch.h>
@@ -67,12 +67,12 @@ size_t buffsize = 1024;
 size_t total_read = 0;
 unsigned int total_obj = 0;
 
-struct mapping
-{
-  char func[MAX_FUNC_NAME];
-  char file[PATH_MAX];
-  int err;
+struct mapping {
+	char func[MAX_FUNC_NAME];
+	char file[PATH_MAX];
+	int err;
 };
+
 typedef struct mapping Mapping;
 
 /* Those are known failures for 2.6.18 baremetal kernel and Xen dom0
@@ -388,7 +388,7 @@ int main(int argc, char *argv[])
 	char *msg;
 	int lc;
 
-	if ((msg = parse_opts(argc, argv, options, help)) != (char *)NULL)
+	if ((msg = parse_opts(argc, argv, options, help)) != NULL)
 		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
 
 	if (opt_buffsize) {
@@ -414,7 +414,7 @@ int main(int argc, char *argv[])
 		TEST(readproc(procpath));
 
 		if (TEST_RETURN != 0) {
-			tst_resm(TFAIL, "readproc() failed with %d errors.",
+			tst_resm(TFAIL, "readproc() failed with %ld errors.",
 				 TEST_RETURN);
 		} else {
 			tst_resm(TPASS, "readproc() completed successfully, "
Index: ltp/testcases/kernel/fs/stream/stream03.c
===================================================================
--- ltp.orig/testcases/kernel/fs/stream/stream03.c
+++ ltp/testcases/kernel/fs/stream/stream03.c
@@ -33,6 +33,7 @@
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <inttypes.h>
 #include "test.h"
 #include "usctest.h"
 
@@ -46,9 +47,7 @@ int     local_flag;
 
 char progname[] = "stream03()" ;
 char tempfile1[40]="";
-long ftell();
 
-/*--------------------------------------------------------------------*/
 int main(int ac, char *av[])
 {
 	FILE *stream;
@@ -56,19 +55,18 @@ int main(int ac, char *av[])
 	char *junk="abcdefghijklmnopqrstuvwxyz";
 	long pos;
 	off_t opos;
-	int lc;                 /* loop counter */
-        char *msg;              /* message returned from parse_opts */
+	int lc;
+        char *msg;
 
-         /*
-          * parse standard options
-          */
-        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
-                         tst_resm(TBROK, "OPTION PARSING ERROR - %s", msg);
-                 tst_exit();
-                 /*NOTREACHED*/
-        }
+	/*
+	 * parse standard options
+	 */
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+		tst_resm(TBROK, "OPTION PARSING ERROR - %s", msg);
+		tst_exit();
+	}
 
-        local_flag = PASSED;
+	local_flag = PASSED;
 	tst_tmpdir();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -76,74 +74,94 @@ int main(int ac, char *av[])
 		sprintf(tempfile1, "stream03.%d", getpid());
 	/*--------------------------------------------------------------------*/
 	//block0:
-		if((stream=fopen(tempfile1,"a+")) == NULL) {
+
+		if ((stream=fopen(tempfile1, "a+")) == NULL) {
 			tst_resm(TBROK,"fopen(%s) a+ failed: %s", tempfile1, strerror(errno));
 			tst_exit();
 		}
+
 		/* make sure offset of zero at start */
 		pos=ftell(stream);
-		if ( pos != 0 ) {
+
+		if (pos != 0) {
 			tst_resm(TFAIL,"file pointer descrepancy 1");
 			local_flag = FAILED;
 		}
+
 		/* write something and check */
-		if(fwrite(junk,sizeof(*junk),strlen(junk),stream) == 0) {
+		if (fwrite(junk, sizeof(*junk), strlen(junk), stream) == 0) {
 			tst_resm(TFAIL,"fwrite failed: %s", strerror(errno));
 			tst_exit();
 		}
+
 		pos=ftell(stream);
-		if ((size_t)pos != strlen(junk) ) {
-			tst_resm(TFAIL, "strlen(junk)=%zi: file pointer descrepancy 2 (pos=%zi)", strlen(junk), pos);
+
+		if (pos != strlen(junk)) {
+			tst_resm(TFAIL, "strlen(junk)=%zi: file pointer descrepancy 2 (pos=%li)", strlen(junk), pos);
 			local_flag = FAILED;
 		}
+
 		/* rewind and check */
 		rewind(stream);
-		pos=ftell(stream);
-		if ( pos != 0 ) {
-			tst_resm(TFAIL,0,"file pointer descrepancy 3 (pos=%zi, wanted pos=0)", pos);
+		pos = ftell(stream);
+
+		if (pos != 0) {
+			tst_resm(TFAIL,"file pointer descrepancy 3 (pos=%li, wanted pos=0)", pos);
 			local_flag = FAILED;
 		}
+
 		/* seek from current position and then check */
-		if (fseek(stream,strlen(junk),1) != 0) {
-			tst_resm(TFAIL,"fseek failed: %s", strerror(errno));
+		if (fseek(stream,strlen(junk), 1) != 0) {
+			tst_resm(TFAIL, "fseek failed: %s", strerror(errno));
 			tst_exit();
 		}
-		pos=ftell(stream);
-		if ((size_t)pos != strlen(junk) ) {
-			tst_resm(TFAIL,"strlen(junk)=%zi: file pointer descrepancy 4 (pos=%zi)", strlen(junk), pos);
+
+		pos = ftell(stream);
+
+		if (pos != strlen(junk)) {
+			tst_resm(TFAIL, "strlen(junk)=%zi: file pointer descrepancy 4 (pos=%li)", strlen(junk), pos);
 			local_flag = FAILED;
 		}
+
 		/* seek from end of file and then check */
-		if (fseek(stream,0,2) != 0) {
-			tst_resm(TFAIL,"fseek failed: %s", strerror(errno));
+		if (fseek(stream, 0, 2) != 0) {
+			tst_resm(TFAIL, "fseek failed: %s", strerror(errno));
 			tst_exit();
 		}
-		pos=ftell(stream);
-		if ((size_t)pos != strlen(junk) ) {
-			tst_resm(TFAIL,"strlen(junk)=%zi: file pointer descrepancy 5 (pos=%zi)", strlen(junk), pos);
+
+		pos = ftell(stream);
+
+		if (pos != strlen(junk) ) {
+			tst_resm(TFAIL,"strlen(junk)=%zi: file pointer descrepancy 5 (pos=%li)", strlen(junk), pos);
 			local_flag = FAILED;
 		}
+
 		/* rewind with seek and then check */
-		if (fseek(stream,0,0) != 0) {
+		if (fseek(stream, 0, 0) != 0) {
 			tst_resm(TFAIL,"fseek failed: %s", strerror(errno));
 			tst_exit();
 		}
-		pos=ftell(stream);
-		if (pos != 0 ) {
-			tst_resm(TFAIL,"file pointer descrepancy 6 (pos=%zi, wanted pos=0)", pos);
+
+		pos = ftell(stream);
+
+		if (pos != 0) {
+			tst_resm(TFAIL,"file pointer descrepancy 6 (pos=%li, wanted pos=0)", pos);
 			local_flag = FAILED;
 		}
 
 		/* read till EOF, do getc and then check ftell */
-		while (fgets (buf, sizeof(buf), stream));
+		while (fgets(buf, sizeof(buf), stream));
 		pos=ftell(stream);
-		(void) getc(stream);
+		getc(stream);
 		pos=ftell(stream);
-		if ((size_t)pos != strlen(junk) ) {
-			tst_resm(TFAIL,"strlen(junk)=%zi: file pointer descrepancy 7 (pos=%zi)", strlen(junk), pos);
+
+		if (pos != strlen(junk)) {
+			tst_resm(TFAIL,"strlen(junk)=%zi: file pointer descrepancy 7 (pos=%li)", strlen(junk), pos);
 			local_flag = FAILED;
 		}
+
 		fclose(stream);
+
 		if (local_flag == PASSED) {
                         tst_resm(TPASS, "Test passed in block0.");
                 } else {
@@ -155,83 +173,103 @@ int main(int ac, char *av[])
 		unlink(tempfile1);
 	/*--------------------------------------------------------------------*/
 	//block1:
-		if((stream=fopen(tempfile1,"a+")) == NULL) {
+		if ((stream = fopen(tempfile1, "a+")) == NULL) {
 			tst_resm(TFAIL,"fopen(%s) a+ failed: %s", tempfile1, strerror(errno));
 			tst_exit();
 		}
+
 		/* make sure offset of zero at start */
-		opos=ftello(stream);
-		if ( opos != 0 ) {
-			tst_resm(TFAIL,"file pointer descrepancy 1 (opos=%zi, wanted opos=0)", opos);
+		opos = ftello(stream);
+
+		if (opos != 0) {
+			tst_resm(TFAIL,"file pointer descrepancy 1 (opos=%"PRId64", wanted opos=0)", (int64_t)opos);
 			local_flag = FAILED;
 		}
+
 		/* write something and check */
-		if(fwrite(junk,sizeof(*junk),strlen(junk),stream) == 0) {
-			tst_resm(TFAIL,"fwrite failed: %s", strerror(errno));
+		if (fwrite(junk, sizeof(*junk), strlen(junk), stream) == 0) {
+			tst_resm(TFAIL, "fwrite failed: %s", strerror(errno));
 			tst_exit();
 		}
-		opos=ftello(stream);
-		if ((size_t)opos != strlen(junk) ) {
-			tst_resm(TFAIL,"strlen(junk)=%zi: file pointer descrepancy 2 (opos=%zi)", strlen(junk), opos);
+
+		opos = ftello(stream);
+
+		if (opos != strlen(junk)) {
+			tst_resm(TFAIL, "strlen(junk)=%zi: file pointer descrepancy 2 (opos=%"PRId64")", strlen(junk), (int64_t)opos);
 			local_flag = FAILED;
 		}
+
 		/* rewind and check */
 		rewind(stream);
-		opos=ftello(stream);
-		if ( opos != 0 ) {
-			tst_resm(TFAIL,"file pointer descrepancy 3 (opos=%zi, wanted opos=0)", opos);
+		opos = ftello(stream);
+
+		if (opos != 0) {
+			tst_resm(TFAIL,"file pointer descrepancy 3 (opos=%"PRId64", wanted opos=0)", (int64_t)opos);
 			local_flag = FAILED;
 		}
+
 		/* seek from current position and then check */
-		if (fseeko(stream, (off_t)strlen(junk), 1) != 0) {
+		if (fseeko(stream, strlen(junk), 1) != 0) {
 			tst_resm(TFAIL,"fseeko failed: %s", strerror(errno));
 			tst_exit();
 		}
-		opos=ftello(stream);
-		if ((size_t)opos != strlen(junk) ) {
-			tst_resm(TFAIL,"strlen(junk)=%zi: file pointer descrepancy 4 (opos=%zi)", strlen(junk), opos);
+
+		opos = ftello(stream);
+
+		if (opos != strlen(junk) ) {
+			tst_resm(TFAIL,"strlen(junk)=%zi: file pointer descrepancy 4 (opos=%"PRId64")", strlen(junk), (int64_t)opos);
 			local_flag = FAILED;
 		}
+
 		/* seek from end of file and then check */
-		if (fseeko(stream, (off_t)0, 2) != 0) {
+		if (fseeko(stream, 0, 2) != 0) {
 			tst_resm(TFAIL,"fseeko failed: %s", strerror(errno));
 			tst_exit();
 		}
-		opos=ftello(stream);
-		if ((size_t)opos != strlen(junk) ) {
-			tst_resm(TFAIL,"strlen(junk)=%zi: file pointer descrepancy 5 (opos=%zi)", strlen(junk), opos);
+
+		opos = ftello(stream);
+
+		if (opos != strlen(junk) ) {
+			tst_resm(TFAIL,"strlen(junk)=%zi: file pointer descrepancy 5 (opos=%"PRId64")", strlen(junk), (int64_t)opos);
 			local_flag = FAILED;
 		}
+
 		/* rewind with seek and then check */
-		if (fseeko(stream, (off_t)0, 0) != 0) {
+		if (fseeko(stream, 0, 0) != 0) {
 			tst_resm(TFAIL,"fseeko failed: %s", strerror(errno));
 			tst_exit();
 		}
-		opos=ftello(stream);
-		if (opos != 0 ) {
-			tst_resm(TFAIL,"file pointer descrepancy 6 (opos=%zi, wanted opos=0)", opos);
+
+		opos = ftello(stream);
+
+		if (opos != 0) {
+			tst_resm(TFAIL,"file pointer descrepancy 6 (opos=%"PRId64", wanted opos=0)", (int64_t)opos);
 			local_flag = FAILED;
 		}
 
 		/* read till EOF, do getc and then check ftello */
-		while (fgets (buf, sizeof(buf), stream));
+		while (fgets(buf, sizeof(buf), stream));
+
 		opos=ftello(stream);
-		(void) getc(stream);
+		getc(stream);
 		opos=ftello(stream);
-		if ((size_t)opos != strlen(junk) ) {
-			tst_resm(TFAIL,"strlen(junk)=%zi: file pointer descrepancy 7 (opos=%zi)", strlen(junk), opos);
+
+		if (opos != strlen(junk) ) {
+			tst_resm(TFAIL,"strlen(junk)=%zi: file pointer descrepancy 7 (opos=%li)", strlen(junk), opos);
 			local_flag = FAILED;
 		}
+
 		fclose(stream);
+
 		if (local_flag == PASSED) {
                         tst_resm(TPASS, "Test passed in block1.");
                 } else {
                         tst_resm(TFAIL, "Test failed in block1.");
                 }
-	/*--------------------------------------------------------------------*/
+
 		unlink(tempfile1);
-	} /* end for */
+	}
+
 	tst_rmdir();
 	tst_exit();
-	return 0;
 }
Index: ltp/testcases/kernel/mem/mtest06/mmap1.c
===================================================================
--- ltp.orig/testcases/kernel/mem/mtest06/mmap1.c
+++ ltp/testcases/kernel/mem/mtest06/mmap1.c
@@ -92,7 +92,6 @@
 /*	        read must be a success between map and unmap of the region.   */
 /*									      */
 /******************************************************************************/
-/* Include Files.							      */
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -114,7 +113,6 @@
 #include "test.h"
 #include "usctest.h"
 
-/* Defines								      */
 #define M_SUCCESS 	0	/* exit code - on success, clone functions    */
 #define MWU_FAIL 	1	/* error code - map_write_unmap()  on error   */
 #define RM_FAIL 	1	/* error code - read_mem()  on error          */
@@ -137,7 +135,6 @@
 
 
 
-/* Global Variables						              */
 int 	   verbose_print = FALSE;/* when called with -v print more info       */
 caddr_t    *map_address;	/* address of the file mapped.	              */
 sigjmp_buf jmpbuf;		/* argument to sigsetjmp and siglongjmp       */
@@ -532,7 +529,7 @@ main(int  argc,		/* number of input para
     if (verbose_print)
         tst_resm(TINFO, "Input parameters are: "
                     "File size:  %d; "
-                    "Scheduled to run:  %ld hours; "
+                    "Scheduled to run:  %lf hours; "
                     "Number of mmap/write/read:  %d",
 			file_size, exec_time, num_iter);
     set_timer(exec_time);
Index: ltp/testcases/kernel/mem/shmt/shmt05.c
===================================================================
--- ltp.orig/testcases/kernel/mem/shmt/shmt05.c
+++ ltp/testcases/kernel/mem/shmt/shmt05.c
@@ -57,7 +57,7 @@ key_t key[2];
 
 int rm_shm(int);
 
-int main()
+int main(void)
 {
 	int shmid, shmid1;
 	char *cp, *cp1;
@@ -97,7 +97,7 @@ int main()
 		if (cp1 != (char *)-1) {
 			perror("shmat");
 			tst_resm(TFAIL,
-				 "Error: shmat: shmid1 = %d, addr= %#x, errno = %d\n",
+				 "Error: shmat: shmid1 = %d, addr= %p, errno = %d\n",
 				 shmid1, cp1, errno);
 		}
 		else{
Index: ltp/testcases/kernel/mem/shmt/shmt09.c
===================================================================
--- ltp.orig/testcases/kernel/mem/shmt/shmt09.c
+++ ltp/testcases/kernel/mem/shmt/shmt09.c
@@ -125,8 +125,8 @@ int main()
 	c2 = (char *)shmat(shmid, vp, 0);
 	if (c2 != (char *)-1) {
 		tst_resm(TFAIL,
-			 "ERROR: shmat: succeeded!: shmid = %d, shmaddr = 0x%08x, "
-			 "att_addr = 0x%08x\n", shmid, c2, vp);
+			 "ERROR: shmat: succeeded!: shmid = %d, shmaddr = %p, "
+			 "att_addr = %p", shmid, c2, vp);
 		rm_shm(shmid);
 		tst_exit();
 	}
@@ -173,7 +173,7 @@ int main()
 #else
 	if ((vp = sbrk(INCREMENT)) != (void *)-1) {
 		tst_resm(TFAIL,
-			 "Error: sbrk succeeded!  ret = 0x%08x, curbrk = 0x%08x, ",
+			 "Error: sbrk succeeded!  ret = %p, curbrk = %p, ",
 			 vp, sbrk(0));
 		rm_shm(shmid);
 		tst_exit();
Index: ltp/testcases/kernel/mem/vmtests/data_space.c
===================================================================
--- ltp.orig/testcases/kernel/mem/vmtests/data_space.c
+++ ltp/testcases/kernel/mem/vmtests/data_space.c
@@ -89,7 +89,7 @@ int usage(prog)
 	char	*prog;
 {
 	tst_resm(TCONF,"Usage: %s <nchild> <size> <chunk_size> <iterations>",prog);
-	tst_resm(TCONF,"DEFAULTS: 10 1024*1024 4096 25", prog);
+	tst_resm(TCONF,"DEFAULTS: 10 1024*1024 4096 25");
 	tst_exit();
 	return 0;
 }
@@ -323,7 +323,7 @@ int dotest(testers, me)
 			{
 				if (memcmp(buf, zero_buf, csize))
 				{
-					tst_resm(TFAIL, "\t%s[%d] bad verify @ %d (0x%x) for val %d count %d, should be 0x%x.\n",
+					tst_resm(TFAIL, "\t%s[%d] bad verify @ %d (%p) for val %d count %d, should be 0x%x.\n",
 						prog, me, chunk, buf, val, count, val - 1);
 					tst_resm(TINFO, "\tPrev "); dumpbuf(buf-csize);
 					dumpbuf(buf);
@@ -338,7 +338,7 @@ int dotest(testers, me)
 				++collide;
 				if (memcmp(buf, val_buf, csize))
 				{
-					tst_resm(TFAIL, "\t%s[%d] bad verify @ %d (0x%x) for val %d count %d.\n",
+					tst_resm(TFAIL, "\t%s[%d] bad verify @ %d (%p) for val %d count %d.\n",
 						prog, me, chunk, buf, val, count);
 					tst_resm(TINFO, "\tPrev "); dumpbuf(buf-csize);
 					dumpbuf(buf);
Index: ltp/testcases/kernel/mem/vmtests/stack_space.c
===================================================================
--- ltp.orig/testcases/kernel/mem/vmtests/stack_space.c
+++ ltp/testcases/kernel/mem/vmtests/stack_space.c
@@ -78,7 +78,7 @@ char	*prog;				/* invoked name */
 int usage(char* prog)
 {
 	tst_resm(TCONF,"Usage: %s <nchild> <chunk_size> <iterations>",prog);
-        tst_resm(TCONF,"DEFAULTS: 20 1024 50", prog);
+        tst_resm(TCONF,"DEFAULTS: 20 1024 50");
         tst_exit();
         return 0;
 }
@@ -275,7 +275,7 @@ int dotest(int testers, int me)
 
 			if ((bits[chunk/8] & (1<<(chunk%8))) == 0) {
 				if (memcmp(buf, zero_buf, csize)) {
-					tst_resm(TFAIL,"%s[%d] bad verify @ %d (0x%x) for val %d count %d, should be 0.\n",
+					tst_resm(TFAIL,"%s[%d] bad verify @ %d (%p) for val %d count %d, should be 0.\n",
 						prog, me, chunk, buf, val, count);
 					tst_resm(TINFO,"Prev "); dumpbuf(buf-csize);
 					dumpbuf(buf);
@@ -288,7 +288,7 @@ int dotest(int testers, int me)
 			} else {
 				++collide;
 				if (memcmp(buf, val_buf, csize)) {
-					tst_resm(TFAIL,"%s[%d] bad verify @ %d (0x%x) for val %d count %d.\n",
+					tst_resm(TFAIL,"%s[%d] bad verify @ %d (%p) for val %d count %d.\n",
 						prog, me, chunk, buf, val, count);
 					tst_resm(TINFO,"Prev "); dumpbuf(buf-csize);
 					dumpbuf(buf);
Index: ltp/testcases/kernel/sched/nptl/nptl01.c
===================================================================
--- ltp.orig/testcases/kernel/sched/nptl/nptl01.c
+++ ltp/testcases/kernel/sched/nptl/nptl01.c
@@ -35,6 +35,7 @@
  *	by the test hanging and not completing execution.
  *
  ****************************************************************/
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
Index: ltp/testcases/kernel/syscalls/close/close08.c
===================================================================
--- ltp.orig/testcases/kernel/syscalls/close/close08.c
+++ ltp/testcases/kernel/syscalls/close/close08.c
@@ -178,7 +178,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "close(%s) returned %d", fname,
+				tst_resm(TPASS, "close(%s) returned %ld", fname,
 					 TEST_RETURN);
 			}
 		}
Index: ltp/testcases/kernel/syscalls/dup/dup01.c
===================================================================
--- ltp.orig/testcases/kernel/syscalls/dup/dup01.c
+++ ltp/testcases/kernel/syscalls/dup/dup01.c
@@ -178,7 +178,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "dup(%s) returned %d", Fname,
+				tst_resm(TPASS, "dup(%s) returned %ld", Fname,
 					 TEST_RETURN);
 			}
 
Index: ltp/testcases/kernel/syscalls/dup/dup02.c
===================================================================
--- ltp.orig/testcases/kernel/syscalls/dup/dup02.c
+++ ltp/testcases/kernel/syscalls/dup/dup02.c
@@ -186,13 +186,13 @@ int main(int ac, char **av)
 				}
 			} else {
 				tst_resm(TFAIL,
-					 "dup(%d) returned %d, expected -1, errno:%d (EBADF)",
+					 "dup(%d) returned %ld, expected -1, errno:%d (EBADF)",
 					 Fds[ind], TEST_RETURN, EBADF);
 
 				/* close the new file so loops do not open too many files */
 				if (close(TEST_RETURN) == -1) {
 					tst_brkm(TBROK, cleanup,
-						 "close(%d) Failed, errno=%d : %s",
+						 "close(%ld) Failed, errno=%d : %s",
 						 TEST_RETURN, errno,
 						 strerror(errno));
 				}
Index: ltp/testcases/kernel/syscalls/dup/dup03.c
===================================================================
--- ltp.orig/testcases/kernel/syscalls/dup/dup03.c
+++ ltp/testcases/kernel/syscalls/dup/dup03.c
@@ -176,7 +176,7 @@ int main(int ac, char **av)
 			}
 		} else {
 			tst_resm(TFAIL,
-				 "dup(%d) returned %d, expected -1, errno:%d (EMFILE)",
+				 "dup(%d) returned %ld, expected -1, errno:%d (EMFILE)",
 				 Fd[0], TEST_RETURN, EMFILE);
 
 			/* close the new file so loops do not open too many files */
@@ -252,7 +252,7 @@ void setup()
 	}
 	if (Nfds > maxfds) {
 		tst_brkm(TBROK, cleanup,
-			 "Unable to open enough files to use all file descriptors, tried %d",
+			 "Unable to open enough files to use all file descriptors, tried %ld",
 			 maxfds);
 	}
 }				/* End setup() */
Index: ltp/testcases/kernel/syscalls/dup/dup04.c
===================================================================
--- ltp.orig/testcases/kernel/syscalls/dup/dup04.c
+++ ltp/testcases/kernel/syscalls/dup/dup04.c
@@ -179,7 +179,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "dup(%d) read side of syspipe returned %d",
+					 "dup(%d) read side of syspipe returned %ld",
 					 Fd[0], TEST_RETURN);
 
 			} else
@@ -188,7 +188,7 @@ int main(int ac, char **av)
 			/* close the new file so loops do not open too many files */
 			if (close(TEST_RETURN) == -1) {
 				tst_brkm(TBROK, cleanup,
-					 "close(%d) Failed, errno=%d : %s",
+					 "close(%ld) Failed, errno=%d : %s",
 					 TEST_RETURN, errno, strerror(errno));
 			}
 		}
@@ -212,7 +212,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "dup(%d) write side of syspipe returned %d",
+					 "dup(%d) write side of syspipe returned %ld",
 					 Fd[1], TEST_RETURN);
 
 			} else
@@ -221,7 +221,7 @@ int main(int ac, char **av)
 			/* close the new file so loops do not open too many files */
 			if (close(TEST_RETURN) == -1) {
 				tst_brkm(TBROK, cleanup,
-					 "close(%d) Failed, errno=%d : %s",
+					 "close(%ld) Failed, errno=%d : %s",
 					 TEST_RETURN, errno, strerror(errno));
 			}
 		}
Index: ltp/testcases/kernel/syscalls/dup/dup05.c
===================================================================
--- ltp.orig/testcases/kernel/syscalls/dup/dup05.c
+++ ltp/testcases/kernel/syscalls/dup/dup05.c
@@ -179,7 +179,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "dup(%s) returned %d", Fname,
+				tst_resm(TPASS, "dup(%s) returned %ld", Fname,
 					 TEST_RETURN);
 			}
 

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--WIyZ46R2i8wDzkSu--

