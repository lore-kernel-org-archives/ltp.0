Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <YanFeng.Shang@windriver.com>) id 1RroYx-00050l-5D
	for ltp-list@lists.sourceforge.net; Mon, 30 Jan 2012 10:34:15 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RroYs-0004L8-V1
	for ltp-list@lists.sourceforge.net; Mon, 30 Jan 2012 10:34:15 +0000
From: Shang Yanfeng <YanFeng.Shang@windriver.com>
Date: Mon, 30 Jan 2012 18:34:00 +0800
Message-ID: <1327919640-11447-1-git-send-email-YanFeng.Shang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] v2:mmap2.c coding style cleanups
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
To: YanFeng.Shang@windriver.com, gaowanlong@cn.fujitsu.com, ltp-list@lists.sourceforge.net

cleanup the coding style

Signed-off-by: Shang Yanfeng <YanFeng.Shang@windriver.com>
---
 testcases/kernel/mem/mtest06/mmap2.c |  402 ++++++++++++++--------------------
 1 files changed, 164 insertions(+), 238 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap2.c b/testcases/kernel/mem/mtest06/mmap2.c
index aa9dc33..ca907f8 100644
--- a/testcases/kernel/mem/mtest06/mmap2.c
+++ b/testcases/kernel/mem/mtest06/mmap2.c
@@ -45,18 +45,17 @@
 /*				 we are done with the test - Paul Larson      */
 /*				 email:plars@linuxtestproject.org             */
 /* File:	mmap2.c							      */
-/*			         					      */
+/*									      */
 /* Description: Test the LINUX memory manager. The program is aimed at        */
 /*              stressing the memory manager by repeaded map/write/unmap of a */
 /*		of a large gb size file.				      */
-/*			         					      */
+/*									      */
 /*		Create a file of the specified size in gb, map the file,      */
 /*		change the contents of the file and unmap it. This is repeated*/
 /*		several times for the specified number of hours.	      */
-/*			         					      */
+/*									      */
 /******************************************************************************/
 
-/* Include Files							      */
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -74,7 +73,6 @@
 #include "test.h"
 #include "usctest.h"
 
-/* Defines								      */
 #define GB 1000000000
 #ifndef TRUE
 #define TRUE 1
@@ -83,261 +81,189 @@
 #define FALSE 0
 #endif
 
-/******************************************************************************/
-/*                                                                            */
-/* Function:    mkfile                                                        */
-/*                                                                            */
-/* Description: Create a temparory file of required size. 		      */
-/*                                                                            */
-/* Input:	size - size of the temp file to be created in giga bytes      */
-/*                                                                            */
-/* Return:      int fd - file descriptor if the file was created.             */
-/*              -1     - if it failed to create.                              */
-/*                                                                            */
-/******************************************************************************/
-static int
-mkfile(int size) 		/* size of the file to be generated in GB     */
+static int mkfile(int size)
 {
-    int  fd;			/* file descriptior of tmpfile		      */
-    int  index = 0;		/* index into the file, fill it with a's      */
-    char buff[4096];		/* buffer that will be written to the file.   */
-    char template[PATH_MAX];    /* template for temp file name                */
+	int  fd;
+	int  index = 0;
+	char buff[4096];
+	char template[PATH_MAX];
 
-    /* fill the buffer with a's and open a temp file */
-    memset(buff, 'a', 4096);
-    snprintf(template, PATH_MAX, "ashfileXXXXXX");
-    if ((fd = mkstemp(template)) == -1)
-    {
-	perror("mkfile(): mkstemp()");
-	return -1;
-    }
-    else
-    {
-	unlink(template);
-        fprintf(stdout, "creating tmp file and writing 'a' to it ");
-    }
+	memset(buff, 'a', 4096);
+	snprintf(template, PATH_MAX, "ashfileXXXXXX");
+	fd = mkstemp(template);
+	if (fd == -1)	{
+		perror("mkfile(): mkstemp()");
+		return -1; }
+	else	{
+		unlink(template);
+		fprintf(stdout, "creating tmp file and writing 'a' to it ");
+	}
 
-    /* fill the file with the character a */
-    while (index < (size * GB))
-    {
-        index += 4096;
-        if (write(fd, buff, 4096) == -1)
-	{
-	    perror("mkfile(): write()");
-	    return -1;
+	while (index < (size * GB))	{
+		index += 4096;
+		if (write(fd, buff, 4096) == -1)	{
+			perror("mkfile(): write()");
+			return -1;
+		}
 	}
-    }
-    fprintf(stdout, "created file of size %d\n"
-		    "content of the file is 'a'\n", index);
+	fprintf(stdout, "created file of size %d\n"
+			"content of the file is 'a'\n", index);
 
-    /* make sure a's are written to the file. */
-    if (fsync(fd) == -1)
-    {
-	perror("mkfile(): fsync()");
-	return -1;
-    }
-    return fd;
+	if (fsync(fd) == -1)	{
+		perror("mkfile(): fsync()");
+		return -1;
+	}
+	return fd;
 }
 
-/******************************************************************************/
-/*                                                                            */
-/* Function:    sig_handler                                                   */
-/*                                                                            */
-/* Description: handle SIGALRM raised by set_timer(), SIGALRM is raised when  */
-/*              the timer expires. If any other signal is recived exit the    */
-/*              test.                                                         */
-/*                                                                            *//* Input:       signal - signal number, intrested in SIGALRM!                 */
-/*                                                                            */
-/* Return:      exit 1 if unexpected signal is recived                        */
-/*              exit 0 if SIGALRM is recieved                                 */
-/*                                                                            */
-/******************************************************************************/
-static void
-sig_handler(int signal)         /* signal number, set to handle SIGALRM       */{
-    if (signal != SIGALRM)
-    {
-        fprintf(stderr, "sig_handlder(): unexpected signal caught [%d]\n",
-            signal);
-        exit(-1);
-    }
-    else
-        fprintf(stdout, "Test ended, success\n");
-    exit(0);
+static void sig_handler(int signal)
+{
+	if (signal != SIGALRM)	{
+		fprintf(stderr, "sig_handlder(): unexpected signal caught"
+				"[%d]\n", signal);
+		exit(-1); }
+	else
+		fprintf(stdout, "Test ended, success\n");
+	exit(0);
 }
 
-/******************************************************************************//*								 	      */
-/* Function:	usage							      */
-/*									      */
-/* Description:	Print the usage message.				      */
-/*									      */
-/* Return:	exits with -1						      */
-/*									      */
-/******************************************************************************/
-static void
-usage(char *progname)           /* name of this program                       */{
-    fprintf(stderr,
-               "Usage: %s -h -s -x\n"
-	       "\t -a set map_flags to MAP_ANONYMOUS\n"
-               "\t -h help, usage message.\n"
-               "\t -p set map_flag to MAP_PRIVATE.\tdefault: MAP_SHARED\n"
-               "\t -s size of the file/memory to be mmaped.\tdefault: 1GB\n"
-               "\t -x time for which test is to be run.\tdefault: 24 Hrs\n",
-                    progname);
-    exit(-1);
+static void usage(char *progname)
+{
+	fprintf(stderr,
+			"Usage: %s -h -s -x\n"
+			"\t -a set map_flags to MAP_ANONYMOUS\n"
+			"\t -h help, usage message.\n"
+			"\t -p set map_flag to MAP_PRIVATE.\tdefault:"
+			"MAP_SHARED\n"
+			"\t -s size of the file/memory to be mmaped.\tdefault:"
+			"1GB\n"
+			"\t -x time for which test is to be run.\tdefault:"
+			"24 Hrs\n",
+			progname);
+	exit(-1);
 }
 
-/******************************************************************************/
-/*                                                                            */
-/* Function:    main                                                          */
-/*                                                                            */
-/* Descrption:	Create a large file of size in Giga Bytes. Fill it with 'a's  */
-/*		(lower case alphabet a). Map the file and change the contents */
-/*		to 'A's (upper case alphabet), write the contents to the file,*/
-/*		and unmap the file from memory. Continue map/write/unmap      */
-/*		operation for user specified number of times.		      */
-/*                                                                            */
-/* Return:	exits with -1 on error					      */
-/*		exits with a 0 o success.				      */
-/*                                                                            */
-/******************************************************************************/
-int main(int argc,	    /* number of input parameters.		      */
-     char **argv)	    /* pointer to the command line arguments.         */
+int main(int argc, char **argv)
 {
-    int   fd;		    /* descriptor of temp file.		              */
-    int   fsize = 1;	    /* size of the temp file created. default 1GB     */
-    float exec_time = 24;    /* period of execution, default 24 hours.	      */
-    int   c;		    /* command line options			      */
-    int   sig_ndx;	    /* index into signal handler structure.	      */
-    int   map_flags =        /* type of mapping, defaut is MAP_SHARED .	      */
-		     MAP_SHARED;
-    int   map_anon =  FALSE; /* do not map anonymous memory,map file by default*/
-    int   run_once = TRUE;   /* run the test once. (dont repeat)               */
-    char  *memptr;	    /* address of the mapped file.	              */
-    extern  char *optarg;   /* arguments passed to each option                */
-    struct sigaction sigptr;/* set up signal, for interval timer              */
+	int   fd;
+	int   fsize = 1;
+	float exec_time = 24;
+	int   c;
+	int   sig_ndx;
+	int   map_flags =  MAP_SHARED;
+	int   map_anon =  FALSE;
+	int   run_once = TRUE;
+	char  *memptr;
+	extern  char *optarg;
+	struct sigaction sigptr;
 
-    static struct signal_info
-    {
-        int  signum;	/* signal number that hasto be handled 		      */
-	char *signame;  /* name of the signal to be handled.		      */
-    } sig_info[] =
-                   {
-			   {SIGHUP,"SIGHUP"},
-			   {SIGINT,"SIGINT"},
-			   {SIGQUIT,"SIGQUIT"},
-			   {SIGABRT,"SIGABRT"},
-			   {SIGBUS,"SIGBUS"},
-			   {SIGSEGV,"SIGSEGV"},
-			   {SIGALRM, "SIGALRM"},
-			   {SIGUSR1,"SIGUSR1"},
-			   {SIGUSR2,"SIGUSR2"},
-			   {-1,     "ENDSIG"}
-		   };
+	static struct signal_info
+	{
+		int  signum;
+		char *signame;
+	} sig_info[] = {
+		{SIGHUP, "SIGHUP"},
+		{SIGINT, "SIGINT"},
+		{SIGQUIT, "SIGQUIT"},
+		{SIGABRT, "SIGABRT"},
+		{SIGBUS, "SIGBUS"},
+		{SIGSEGV, "SIGSEGV"},
+		{SIGALRM, "SIGALRM"},
+		{SIGUSR1, "SIGUSR1"},
+		{SIGUSR2, "SIGUSR2"},
+		{-1,     "ENDSIG"}
+	};
 
-    while ((c =  getopt(argc, argv, "ahps:x:")) != -1)
-    {
-        switch(c)
-        {
-	    case 'a':
-		map_anon = TRUE;
-	        break;
-            case 'h':
-		usage(argv[0]);
-		exit(-1);
-		break;
-	    case 'p':
-		map_flags = MAP_PRIVATE;
-		break;
-	    case 's':
-		if ((fsize = atoi(optarg)) == 0)
-		    fprintf(stderr, "Using default fsize %d GB\n", fsize = 1);
-		break;
-            case 'x':
-		if ((exec_time = atof(optarg)) == 0)
-		    fprintf(stderr, "Using default exec time %f hrs",
-		          exec_time = (float)24);
-                run_once = FALSE;
-		break;
-	    default :
-		usage(argv[0]);
-		break;
+	while ((c =  getopt(argc, argv, "ahps:x:")) != -1) {
+			switch (c) {
+			case 'a':
+				map_anon = TRUE;
+				break;
+			case 'h':
+				usage(argv[0]);
+				exit(-1);
+				break;
+			case 'p':
+				map_flags = MAP_PRIVATE;
+				break;
+			case 's':
+				fsize = atoi(optarg);
+				if (fsize == 0)
+					fprintf(stderr, "Using default "
+						"fsize %d GB\n", fsize = 1);
+				break;
+			case 'x':
+				exec_time = atof(optarg);
+				if (exec_time == 0)
+					fprintf(stderr, "Using default exec "
+						"time %f hrs",
+						exec_time = (float)24);
+				run_once = FALSE;
+				break;
+			default:
+				usage(argv[0]);
+				break;
+		}
 	}
-    }
 
-    fprintf(stdout, "MM Stress test, map/write/unmap large file\n"
-		    "\tTest scheduled to run for:       %f\n"
-		    "\tSize of temp file in GB:         %d\n",
+	fprintf(stdout, "MM Stress test, map/write/unmap large file\n"
+			"\tTest scheduled to run for:       %f\n"
+			"\tSize of temp file in GB:         %d\n",
 			exec_time, fsize);
 
-    /* set up time for which test has to be run */
-    alarm(exec_time * 3600.00);
-
-    /* set up signals */
-    sigptr.sa_handler = (void (*)(int signal))sig_handler;
-    sigfillset(&sigptr.sa_mask);
-    sigptr.sa_flags = 0;
-    for (sig_ndx = 0; sig_info[sig_ndx].signum != -1; sig_ndx++)
-    {
-        sigaddset(&sigptr.sa_mask, sig_info[sig_ndx].signum);
-        if (sigaction(sig_info[sig_ndx].signum, &sigptr,
-		(struct sigaction *)NULL) == -1 )
-        {
-            perror( "man(): sigaction()" );
-            fprintf(stderr, "could not set handler for SIGALRM, errno = %d\n",
-                    errno);
-            exit(-1);
-        }
-    }
+	alarm(exec_time * 3600.00);
 
-    do
-    {
-        if (!map_anon)
-        {
-            /* create a new file of giga byte size */
-            if ((fd = mkfile(fsize)) == -1)
-            {
- 	        fprintf(stderr,
-			     "main(): mkfile(): Failed to create temp file.\n");
- 	        exit (-1);
-            }
-        }
-        else
-        {
-            /* mapping anonymous,  MAP_SHARED or MAP_PRIVATE must be also set */
-            fd = -1;
-	    map_flags = map_flags|MAP_ANONYMOUS;
-        }
+	sigptr.sa_handler = (void (*)(int signal))sig_handler;
+	sigfillset(&sigptr.sa_mask);
+	sigptr.sa_flags = 0;
+	for (sig_ndx = 0; sig_info[sig_ndx].signum != -1; sig_ndx++) {
+		sigaddset(&sigptr.sa_mask, sig_info[sig_ndx].signum);
+		if (sigaction(sig_info[sig_ndx].signum, &sigptr, \
+					(struct sigaction *)NULL) == -1) {
+			perror("man(): sigaction()");
+			fprintf(stderr, "could not set handler for SIGALRM,"
+				"errno = %d\n",	errno);
+			exit(-1);
+		}
+	}
 
-        if ((memptr = (char *)mmap(0,(fsize * GB), PROT_READ|PROT_WRITE,
-		     map_flags, fd, 0)) == (char *)-1)
-        {
-            perror("main(): mmap()");
-            exit (-1);
-        }
-        else
-	    fprintf(stdout, "file mapped at %p\n"
-			    "changing file content to 'A'\n", memptr);
+	do {
+		if (!map_anon) {
+			fd = mkfile(fsize);
+			if (fd == -1) {
+				fprintf(stderr, "main(): mkfile(): Failed "
+					"to create temp file.\n");
+				exit(-1);
+			} }
+		else {
+			fd = -1;
+			map_flags = map_flags|MAP_ANONYMOUS;
+		}
+		memptr = (char *)mmap(0, (fsize * GB), PROT_READ|PROT_WRITE,
+					map_flags, fd, 0);
+		if (memptr  == (char *)-1) {
+			perror("main(): mmap()");
+			exit(-1);
+		} else
+			fprintf(stdout, "file mapped at %p\n"
+				"changing file content to 'A'\n", memptr);
 
-        /* Change the content of the file with A's, and commit changes */
-        memset(memptr, 'A', ((fsize * GB)/sizeof(char)));
+		memset(memptr, 'A', ((fsize * GB)/sizeof(char)));
 
-        if (msync(memptr, ((fsize * GB)/sizeof(char)),
-	                 MS_SYNC|MS_INVALIDATE) == -1)
-        {
-            perror("main(): msync()");
-            exit (-1);
-        }
+		if (msync(memptr, ((fsize * GB)/sizeof(char)),
+					MS_SYNC|MS_INVALIDATE) == -1) {
+			perror("main(): msync()");
+			exit(-1);
+		}
 
-        if (munmap(memptr, (fsize * GB)/sizeof(char)) == -1)
-        {
-            perror("main(): munmap()");
-            exit (-1);
-        }
-	else
-	    fprintf(stdout, "unmapped file at %p\n", memptr);
+		if (munmap(memptr, (fsize * GB)/sizeof(char)) == -1) {
+			perror("main(): munmap()");
+			exit(-1);
+		} else
+			fprintf(stdout, "unmapped file at %p\n", memptr);
 
-	close(fd);
-        sync();
-    }while (TRUE && !run_once);
-    exit (0);
+		close(fd);
+		sync();
+	} while (TRUE && !run_once);
+	exit(0);
 }
-- 
1.6.3.1


------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
