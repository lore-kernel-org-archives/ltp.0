Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <YanFeng.Shang@windriver.com>) id 1RnNXU-0003AV-Ny
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 04:54:24 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RnNXT-0003jQ-IK
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 04:54:24 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q0I4sHnl022752
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Jan 2012 20:54:17 -0800 (PST)
From: Shang Yanfeng <YanFeng.Shang@windriver.com>
Date: Wed, 18 Jan 2012 12:54:14 +0800
Message-ID: <1326862455-16756-1-git-send-email-YanFeng.Shang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] updated mmap2.c for low memory target
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
To: YanFeng.Shang@windriver.com, ltp-list@lists.sourceforge.net
Cc: Haotian.Zhang@windriver.com

many low memory boards don't have 1G memory,so add get_free_mem function
for low memory target,limit 1000M for n32 file system test.

signed-off-by: YanFeng.Shang  <YanFeng.Shang@windriver.com>
---
 testcases/kernel/mem/mtest06/mmap2.c |   51 ++++++++++++++++++++++++++-------
 1 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap2.c b/testcases/kernel/mem/mtest06/mmap2.c
index aa9dc33..fdfad05 100644
--- a/testcases/kernel/mem/mtest06/mmap2.c
+++ b/testcases/kernel/mem/mtest06/mmap2.c
@@ -69,13 +69,14 @@
 #include <signal.h>
 #include <sys/time.h>
 #include <sys/wait.h>
+#include <sys/sysinfo.h>
 #include <signal.h>
 #include <string.h>
 #include "test.h"
 #include "usctest.h"
 
 /* Defines								      */
-#define GB 1000000000
+#define MB 1048576 
 #ifndef TRUE
 #define TRUE 1
 #endif
@@ -96,7 +97,7 @@
 /*                                                                            */
 /******************************************************************************/
 static int
-mkfile(int size) 		/* size of the file to be generated in GB     */
+mkfile(int size) 		/* size of the file to be generated in MB     */
 {
     int  fd;			/* file descriptior of tmpfile		      */
     int  index = 0;		/* index into the file, fill it with a's      */
@@ -118,7 +119,7 @@ mkfile(int size) 		/* size of the file to be generated in GB     */
     }
 
     /* fill the file with the character a */
-    while (index < (size * GB))
+    while (index < (size * MB))
     {
         index += 4096;
         if (write(fd, buff, 4096) == -1)
@@ -165,6 +166,22 @@ sig_handler(int signal)         /* signal number, set to handle SIGALRM       */
     exit(0);
 }
 
+/*******************************************************************************/
+/* Finction get_free_mem
+Description: get the free memory . 
+Return: free memory with M
+/ *******************************************************************************/
+unsigned long get_free_mem()
+{
+	struct sysinfo board_sysinfo;
+	unsigned long avail_mem;
+	int error;
+	error = sysinfo(&board_sysinfo);
+	printf("\n\ncode error=%d\n",error);
+	avail_mem = board_sysinfo.freeram/MB;
+	return avail_mem;
+}
+
 /******************************************************************************//*								 	      */
 /* Function:	usage							      */
 /*									      */
@@ -180,7 +197,7 @@ usage(char *progname)           /* name of this program                       */
 	       "\t -a set map_flags to MAP_ANONYMOUS\n"
                "\t -h help, usage message.\n"
                "\t -p set map_flag to MAP_PRIVATE.\tdefault: MAP_SHARED\n"
-               "\t -s size of the file/memory to be mmaped.\tdefault: 1GB\n"
+               "\t -s size of the file/memory to be mmaped.\tdefault: 1000MB\n"
                "\t -x time for which test is to be run.\tdefault: 24 Hrs\n",
                     progname);
     exit(-1);
@@ -204,7 +221,7 @@ int main(int argc,	    /* number of input parameters.		      */
      char **argv)	    /* pointer to the command line arguments.         */
 {
     int   fd;		    /* descriptor of temp file.		              */
-    int   fsize = 1;	    /* size of the temp file created. default 1GB     */
+    unsigned long  fsize = 1000;	    /* size of the temp file created. default 1000MB     */
     float exec_time = 24;    /* period of execution, default 24 hours.	      */
     int   c;		    /* command line options			      */
     int   sig_ndx;	    /* index into signal handler structure.	      */
@@ -234,6 +251,13 @@ int main(int argc,	    /* number of input parameters.		      */
 			   {-1,     "ENDSIG"}
 		   };
 
+	fsize = get_free_mem()/2;
+
+#if __WORDSIZE==32
+	if ( fsize > 1000 )
+		fprintf(stderr, "Using default fsize %ld MB\n", fsize = 1000);
+#endif
+
     while ((c =  getopt(argc, argv, "ahps:x:")) != -1)
     {
         switch(c)
@@ -249,8 +273,13 @@ int main(int argc,	    /* number of input parameters.		      */
 		map_flags = MAP_PRIVATE;
 		break;
 	    case 's':
+#if __WORDSIZE==32
+		if ((fsize = atoi(optarg)) == 0 || (fsize = atoi(optarg)) > 1000 )
+		    fprintf(stderr, "Using default fsize %ld MB\n", fsize = 1000);
+#else
 		if ((fsize = atoi(optarg)) == 0)
-		    fprintf(stderr, "Using default fsize %d GB\n", fsize = 1);
+			fprintf(stderr,"Using default fsize %ld MB\n", fsize = 1000);
+#endif
 		break;
             case 'x':
 		if ((exec_time = atof(optarg)) == 0)
@@ -266,7 +295,7 @@ int main(int argc,	    /* number of input parameters.		      */
 
     fprintf(stdout, "MM Stress test, map/write/unmap large file\n"
 		    "\tTest scheduled to run for:       %f\n"
-		    "\tSize of temp file in GB:         %d\n",
+		    "\tSize of temp file in MB:         %ld\n",
 			exec_time, fsize);
 
     /* set up time for which test has to be run */
@@ -308,7 +337,7 @@ int main(int argc,	    /* number of input parameters.		      */
 	    map_flags = map_flags|MAP_ANONYMOUS;
         }
 
-        if ((memptr = (char *)mmap(0,(fsize * GB), PROT_READ|PROT_WRITE,
+        if ((memptr = (char *)mmap(0,(fsize * MB), PROT_READ|PROT_WRITE,
 		     map_flags, fd, 0)) == (char *)-1)
         {
             perror("main(): mmap()");
@@ -319,16 +348,16 @@ int main(int argc,	    /* number of input parameters.		      */
 			    "changing file content to 'A'\n", memptr);
 
         /* Change the content of the file with A's, and commit changes */
-        memset(memptr, 'A', ((fsize * GB)/sizeof(char)));
+        memset(memptr, 'A', ((fsize * MB)/sizeof(char)));
 
-        if (msync(memptr, ((fsize * GB)/sizeof(char)),
+        if (msync(memptr, ((fsize * MB)/sizeof(char)),
 	                 MS_SYNC|MS_INVALIDATE) == -1)
         {
             perror("main(): msync()");
             exit (-1);
         }
 
-        if (munmap(memptr, (fsize * GB)/sizeof(char)) == -1)
+        if (munmap(memptr, (fsize * MB)/sizeof(char)) == -1)
         {
             perror("main(): munmap()");
             exit (-1);
-- 
1.6.3.1


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
