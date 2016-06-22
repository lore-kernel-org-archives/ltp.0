From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Jun 2016 14:30:17 +0200
Subject: [LTP] [PATCH 2/2] nfs05: rewrite the test,
 make use of new library
In-Reply-To: <1466076425-12790-2-git-send-email-alexey.kodanev@oracle.com>
References: <1466076425-12790-1-git-send-email-alexey.kodanev@oracle.com>
 <1466076425-12790-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160622123017.GC13962@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/testcases/network/nfs/nfs_stress/Makefile
> +++ b/testcases/network/nfs/nfs_stress/Makefile
> @@ -19,7 +19,7 @@ top_srcdir		?= ../../../..
>  include $(top_srcdir)/include/mk/env_pre.mk
>  
>  nfs04_create_file: CPPFLAGS += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> -nfs05_make_tree: LDLIBS += -lpthread
> +nfs05_make_tree: LDLIBS += -I../../../kernel/include -lltp -lpthread

Hmm, shouldn't we rather include testcase.mk to get the -lltp and
the include path?

And even if we don't the -I directive should go to CPPFLAGS instead.

>  INSTALL_TARGETS		:= nfs_lib.sh \
>  			   nfs01 \
> diff --git a/testcases/network/nfs/nfs_stress/nfs05 b/testcases/network/nfs/nfs_stress/nfs05
> index 0e15c8c..26977ab 100755
> --- a/testcases/network/nfs/nfs_stress/nfs05
> +++ b/testcases/network/nfs/nfs_stress/nfs05
> @@ -34,8 +34,12 @@ THREAD_NUM=${THREAD_NUM:-"8"}
>  nfs_setup

Shouldn't we check that make and gcc is installed at this point?

>  tst_resm TINFO "start nfs05_make_tree -d $DIR_NUM -f $FILE_NUM -t $THREAD_NUM"
> -ROD nfs05_make_tree -d $DIR_NUM -f $FILE_NUM -t $THREAD_NUM
> +TMPDIR=$(pwd) nfs05_make_tree -d $DIR_NUM -f $FILE_NUM -t $THREAD_NUM
>  
> -tst_resm TPASS "test finished"
> +if [ $? -ne 0 ]; then
> +	tst_resm TFAIL "'make' test failed"
> +else
> +	tst_resm TPASS "'make' test finished"
> +fi
>  
>  tst_exit
> diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
> index 4163988..5d128dd 100644
> --- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
> +++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
> @@ -1,179 +1,50 @@
> -/******************************************************************************/
> -/*									      */
> -/* Copyright (c) International Business Machines  Corp., 2001		      */
> -/*									      */
> -/* This program is free software;  you can redistribute it and/or modify      */
> -/* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or          */
> -/* (at your option) any later version.					      */
> -/*									      */
> -/* This program is distributed in the hope that it will be useful,	      */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of	      */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See	              */
> -/* the GNU General Public License for more details.			      */
> -/*									      */
> -/* You should have received a copy of the GNU General Public License	      */
> -/* along with this program;  if not, write to the Free Software		      */
> -/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
> -/*									      */
> -/******************************************************************************/
> -
> -/******************************************************************************/
> -/*                                                                            */
> -/* History:     Oct - 10 - 2001 Created - Manoj Iyer, IBM Austin TX.          */
> -/*                               email:manjo@austin.ibm.com                   */
> -/*					- create a directory tree that is     */
> -/*				unique to each process. The base directory    */
> -/*				looks like hostname.<pid of the process>      */
> -/*				the subdirectories will be <pid>.0 <pid.1> etc*/
> -/*				eg:					      */
> -/*				    hostname.1234			      */
> -/*					       |_ 1234.0	              */
> -/*					               |_ 1234.1              */
> -/*					                      |_1234.2        */
> -/*								    |....     */
> -/*				hostname -  hostname of the machine           */
> -/*			        1234     -  pid of the current process.       */
> -/*			        Each of these directories are populated with  */
> -/*				N number of ".c" files and a makefile that can*/
> -/*				compile the ".c" files and also initiate      */
> -/*				compile of ".c" files in the subdirectories   */
> -/*				under it.			              */
> -/*                                                                            */
> -/*		Oct - 11 - 2001 Modified 				      */
> -/*				- fixed a bug in the makefiles, the last make-*/
> -/*				  file was expecting subdirectories. Added    */
> -/*				  code to generate a different makefile for   */
> -/*				  the last subdirectory.		      */
> -/*				- Added logic to first compile all the c files*/
> -/*				  and upon completion remove them.            */
> -/*			        - Added multithreading, arguments handling.   */
> -/*				  By default the program will generate 8      */
> -/*				  threads, each creating by default 100 deep  */
> -/*				  directory tree each containing default 100  */
> -/*			          ".c" files and one makefile.                */
> -/*			        - Added usage message.                        */
> -/*								              */
> -/*		Oct - 12 - 2001 Modified			              */
> -/*				- Added logic to print missing arguments to   */
> -/*				  options.                                    */
> -/*                                                                            */
> -/*		Oct - 15 - 2001 Modified			              */
> -/*				- Added logic to remove the files, makefiles  */
> -/*				  and subdirectories that were created.       */
> -/*			        - Added logic to print debug messages.        */
> -/*								              */
> -/*		Oct - 16 - 2001 Modified		                      */
> -/*				- Added sync() calls to commit changes.       */
> -/*				- Fixed bug. pthread_join() returns 0 when    */
> -/*			          pthread_join fails, if the thread function  */
> -/*				  fails pthread_join() will put the exit value*/
> -/*			          of the thread function in the thread_return */
> -/*				  output argument.			      */
> -/*				- Debugging function crte_mk_rm fails to      */
> -/*				  create fies, problem appears only in multi- */
> -/*				  threaded case.                              */
> -/*								              */
> -/*		Oct - 17 - 2001 Checked in		                      */
> -/*				- GPL statement was added and the initial ver */
> -/*			        - checked into CVS.		              */
> -/*			        - note: this version works only if it is run  */
> -/*				  single threaded, when its run multithreaded */
> -/*		                  random thread will fail on open() sys call  */
> -/*				  problem currently under investigation.      */
> -/*                                                                            */
> -/*		Oct - 20 - 2001 Modified				      */
> -/*				- fixed a whole bunch of problems.            */
> -/*			        - created function init_compile. Apparently   */
> -/*				  this code works!!.                          */
> -/*			        - removed system() system call that was doing */
> -/*				  make and make clean. init_compile() replaces*/
> -/*				  this piece of code.                         */
> -/*				- on supplying the full pathname to unlink()  */
> -/*				  solved most of the problems with rm_file_mk */
> -/*			          function.                                   */
> -/*				- reset the default vaulues for MAXT = 8      */
> -/*				  MAXD = 100 and MAXF = 100.                  */
> -/*				  ie. maximum number of threads = 8           */
> -/*				      directory depth (num of sub dirs) = 100 */
> -/*				      numeber of .c fils in each sub dir = 100*/
> -/*				- finally program is now in working state.    */
> -/*                                                                            */
> -/*		Nov - 01 - 2001 Modified.				      */
> -/*				- fixed usage message default MAXT is 8 not 1 */
> -/*				- fixed make to compile the files silently    */
> -/*									      */
> -/*		Nov - 19 - 2001 Modified.				      */
> -/*				- changed th_status in function main() from   */
> -/*				  dynamic variable to static array.           */
> -/*									      */
> -/* File:        make_tree.c                                                   */
> -/*                                                                            */
> -/* Description:	This program is designed stress the NFS implimentation.       */
> -/* 		Many bugs were uncovered in the AIX operating system          */
> -/*		implimentation of NFS when AIX kernel was built over NFS.     */
> -/*		Source directory on a remote machine (one server many clients)*/
> -/*		NFS-mounted on to a directory on a local machine from which   */
> -/*		the kernel build was initiated. Apparently many defects/bugs  */
> -/* 		were uncovered when multiple users tried to build the kernel  */
> -/* 		by NFS mounting the kernel source from a remote machine and   */
> -/* 		tried to build the kernel on a local machine. AIX build envi- */
> -/*		ronment is set up to create the object files and executable   */
> -/*		on the local machine. 					      */
> -/* 		This testcase will try to recreate such a senario.            */
> -/*		Spawn N number of threads. Each thread does the following.    */
> -/*		* Create a directory tree.                                    */
> -/*		* Populate it with ".c" files and makefiles.                  */
> -/*		* initate a build. Executable will print hello world when exed*/
> -/*		* clean up all the executables that were created.             */
> -/*		* recurssively remove each subdir and its contents.           */
> -/*		The test is aimed at stressing the NFS client and server.     */
> -/*				    hostname.1234			      */
> -/*                                             |                              */
> -/*				               | - 1234.0.0.c                 */
> -/*					       | - 1234.0.1.c                 */
> -/*                                             | - ..........                 */
> -/*					       | - makefile                   */
> -/*                                             |                              */
> -/*					       |_ 1234.0	              */
> -/*                                                    |                       */
> -/*				                      | - 1234.1.0.c          */
> -/*					              | - 1234.1.1.c          */
> -/*                                                    | - ..........          */
> -/*					              | - makefile            */
> -/*                                                    |                       */
> -/*					              |_ 1234.1               */
> -/*                                                           |                */
> -/*				                             | - 1234.2.0.c   */
> -/*					                     | - 1234.2.1.c   */
> -/*                                                           | - ..........   */
> -/*					                     | - makefile     */
> -/*                                                           |                */
> -/*					                     |_1234.2         */
> -/*								    |....     */
> -/*                                                                            */
> -/* Setup:	- on the server side:			                      */
> -/*		  * create a directory /nfs_test 		              */
> -/*		  * make an entry in /etc/exports file like this...           */
> -/*		    "/nfs_test *(rw,no_root_squash)"		              */
> -/*		  * run command "exportfs -a"		                      */
> -/*	        - on client side:			                      */
> -/*		  * create a directory say for eg: /nfs_cli                   */
> -/*		  * mount -t nfs servername:/nfs_test /nfs_cli                */
> -/*		  * set up the tescase in /nfs_cli directory		      */
> -/*		- I reccomend that you have atleast 8 client machines running */
> -/*		   this test, linux has 8 NFSD's running by default, you might*/
> -/*		   have to increase it as per your requirement.               */
> -/*		                                                              */
> -/* Note:	- assumed that NFS services are installed and configured      */
> -/*		- you have atleast 2 machines to act as client and server     */
> -/*		  (you can have muiltiple client machines and one server)     */
> -/*		- large amount of disk space, this depends on the number of   */
> -/*		  of clients you will have, if you have only one client, I    */
> -/*		  reccomend that the server have atleast 4 Giga bytes of      */
> -/*		  disk space (paranoid!).			              */
> -/*									      */
> -/******************************************************************************/
> +/*
> + * Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
> + * Copyright (c) International Business Machines  Corp., 2001
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> +
> + * Description:
> + * This program is designed to stress the NFS implimentation. Many bugs were
> + * uncovered in the AIX operating system implimentation of NFS when AIX kernel
> + * was built over NFS. Source directory on a remote machine (one server many
> + * clients) NFS-mounted on to a directory on a local machine from which the
> + * kernel build was initiated. Apparently many defects/bugs were uncovered when
> + * multiple users tried to build the kernel by NFS mounting the kernel source
> + * from a remote machine and tried to build the kernel on a local machine.
> + *
> + * The test's aimed to stress NFS client/server and recreates such a senario.
> + * Spawn N number of threads. Each thread does the following:
> + *   * create a directory tree;
> + *   * populate it with ".c" files and makefiles;
> + *     hostname.1234
> + *             | - 1234.0.0.c
> + *             | - ..........
> + *             | - makefile
> + *             |_ 1234.0
> + *                    |
> + *                    | - 1234.1.0.c
> + *                    | - ..........
> + *                    | - makefile
> + *                    |_ 1234.1
> + *                           |....
> + *
> + *   * initate a build, executable will print hello world;
> + *   * clean up all the executables that were created;
> + *   * recurssively remove each subdir and its contents.
> + *
> + */
>  
>  #include <stdio.h>
>  #include <sys/stat.h>
> @@ -188,609 +59,133 @@
>  #include <errno.h>
>  #include <linux/unistd.h>
>  
> -#define gettid() syscall(__NR_gettid)
> -
> -#ifdef DEBUG
> -#define dprt(fmt, args...)	printf(fmt, ## args)
> -#else
> -#define dprt(fmt, args...)
> -#endif
> -
> -#define MAKE_EXE	1	/* initate a make                             */
> -#define MAKE_CLEAN	0	/* initate a make clean                       */
> -
> -#define PTHREAD_EXIT(val)    do {\
> -			exit_val = val; \
> -                        dprt("pid[%d]: exiting with %d\n", gettid(),exit_val); \
> -			pthread_exit((void *)exit_val); \
> -				} while (0)
> -
> -#define OPT_MISSING(prog, opt)   do{\
> -			       fprintf(stderr, "%s: option -%c ", prog, opt); \
> -                               fprintf(stderr, "requires an argument\n"); \
> -                               usage(prog); \
> -                                   } while (0)
> -
> -#define MAXD	100		/* default number of directories to create.           */
> -#define MAXF	100		/* default number of files to create.                 */
> -#define MAXT	8		/* default number of threads to create.               */
> -
> -/******************************************************************************/
> -/*								 	      */
> -/* Function:	usage							      */
> -/*									      */
> -/* Description:	Print the usage message.				      */
> -/*									      */
> -/* Return:	exits with -1						      */
> -/*									      */
> -/******************************************************************************/
> -static void usage(char *progname)
> -{				/* name of this program                       */
> -	fprintf(stderr,
> -		"Usage: %s -d NUMDIR -f NUMFILES -h -t NUMTHRD\n"
> -		"\t -d Number of subdirectories to generate:   Default: 100\n"
> -		"\t -f Number of c files in each subdirectory: Default: 100\n"
> -		"\t -h Help!\n"
> -		"\t -t Number of threads to generate:          Default: 8\n",
> -		progname);
> -	exit(-1);
> -}
> -
> -/******************************************************************************/
> -/*								 	      */
> -/* Function:	init_compile						      */
> -/*									      */
> -/* Description:	This function compiles the .c files and removes the exeutables*/
> -/*		This function does the same function as the system() system   */
> -/*		call, the code is available in the system() man page. When    */
> -/*		called with the parameter MAKE_EXE it will initiate make in   */
> -/*		the first directory created, the makefile is designed to build*/
> -/*		recursively all the files in the subdirectories below.        */
> -/*		When called with the MAKE_CLEAN parameter it will remove the  */
> -/*		executables that were created design is similar to the case   */
> -/*		were it initiates a make.                                     */
> -/*									      */
> -/* Return:	exits with 1 on error, 0 on success                           */
> -/*									      */
> -/******************************************************************************/
> -static int init_compile(int what_todo,	/* do a compile or clean             */
> -			char *base_dir,	/* base directory of the test        */
> -			char *hname)
> -{				/* hostname of the machine           */
> -	int status;		/* return status of execve process            */
> -	pid_t pid;		/* pid of the process that does compile       */
> -	char *dirname;		/* location where compile is initated         */
> -	char *command;		/* make or make clean command.                */
> -
> -	if ((dirname = malloc(sizeof(char) * 2048)) == NULL) {	/* just paranoid */
> -		perror("init_compile(): dirname malloc()");
> -		return 1;
> -	}
> -
> -	if ((command = malloc(sizeof(char) * 1024)) == NULL) {	/* just paranoid */
> -		perror("init_compile(): dirname malloc()");
> -		return 1;
> -	}
> -
> -	what_todo ? sprintf(command, "make -s") : sprintf(command,
> -							  "make -s clean");
> +#include "lapi/mkdirat.h"
> +#include "tst_safe_stdio.h"
> +#include "tst_test.h"
>  
> -	sprintf(dirname, "%s/%s.%ld", base_dir, hname, gettid());
> +#define gettid() syscall(__NR_gettid)
>  
> -	if (chdir(dirname) == -1) {
> -		dprt("pid[%d]: init_compile(): dir name = %s\n", gettid(),
> -		     dirname);
> -		perror("init_compile() chdir()");
> -		free(dirname);
> -		return 1;
> -	}
> +static int thrd_num = 8;
> +static int dirs_num = 100;
> +static int file_num = 100;
>  
> -	dprt("pid[%d]: init_compile(): command = %s\n", gettid(), command);
> +static char *t_arg, *d_arg, *f_arg;
>  
> -	if ((pid = fork()) == -1) {
> -		perror("init_compile(): fork()");
> -		return 1;
> -	}
> -	if (!pid) {
> -		char *argv[4];
> +static struct tst_option opts[] = {
> +	{"t:", &t_arg, "-t x    Number of threads to generate, default: 8\n"},
> +	{"d:", &d_arg, "-d x    Number of subdirs to generate, default: 100\n"},
> +	{"f:", &f_arg, "-f x    Number of c files in each dir, default: 100\n"},
> +	{NULL, NULL, NULL}
> +};
>  
> -		argv[0] = "/bin/sh";
> -		argv[1] = "-c";
> -		argv[2] = command;
> -		argv[3] = 0;
> -
> -		if (execv("/bin/sh", argv) == -1) {
> -			perror("init_compile(): execv()");
> -			return 1;
> -		}
> -	}
> -	do {
> -		if (waitpid(pid, &status, 0) == -1) {
> -			if (errno != EINTR) {
> -				fprintf(stderr,
> -					"init_compile(): waitpid() failed\n");
> -				return 1;
> -			}
> +static void *thread_fn(LTP_ATTRIBUTE_UNUSED void *args)
> +{
> +	const char prog_buf[] = "main()\n{\n\t printf(\"hello world\");\n}\n";
> +	const size_t prog_buf_size = strlen(prog_buf);
                                     ^
				     sizeof(prog_buf) - 1
> +	int i, k, fd, dirfd, len, ret;
> +	char *dirname, *tmpdir;
> +	char cfile[PATH_MAX];
> +	char make_buf[1024];
> +	char hostname[256];
> +	pid_t tid = gettid();
> +
> +	SAFE_GETHOSTNAME(hostname, 256);
> +	SAFE_ASPRINTF(&dirname, "%s.%ld", hostname, tid);
> +	SAFE_ASPRINTF(&tmpdir, "%ld", tid);
> +
> +	SAFE_MKDIR(dirname, 0755);
> +	dirfd = SAFE_OPEN(dirname, O_DIRECTORY);
> +
> +	for (i = 0; i < dirs_num; ++i) {
> +		if (i == dirs_num - 1) {
> +			len = snprintf(make_buf, 1024,
> +				"CFLAGS := -O -w -g\n"
> +				"SUBDIRS = %s\n"
> +				"SRCS=$(wildcard *.c)\n"
> +				"TARGETS=$(patsubst %%.c,\%%,$(SRCS))\n"
> +				"all:\t $(TARGETS)\n"
> +				"clean:\n"
> +				"\trm -f $(TARGETS)\n",
> +				tmpdir);

                      The SUBDIRS variable seems to be unused here.

>  		} else {
> -			if (chdir(base_dir) == -1) {
> -				dprt("pid[%d]: init_compile(): dir = %s\n",
> -				     gettid(), dirname);
> -				perror("init_compile(): chdir()");
> -				return 1;
> +			len = snprintf(make_buf, 1024,
> +				"CFLAGS := -O -w -g\n"
> +				"SUBDIRS = %s\n"
> +				"SRCS=$(wildcard *.c)\n"
> +				"TARGETS=$(patsubst %%.c,\%%,$(SRCS))\n"
> +				"all:\t $(TARGETS)\n\t@for i in $(SUBDIRS);"
> +				"do $(MAKE) -C $$i ; done\nclean:\n"
> +				"\trm -f $(TARGETS)\n\t@for i in $(SUBDIRS);"
> +				"do $(MAKE) -C $$i clean ; done\n", tmpdir);
> +		}
> +
> +		fd = openat(dirfd, "makefile", O_CREAT | O_RDWR,
> +			    S_IRWXU | S_IRWXG | S_IRWXO);
> +		if (fd < 0)
> +			tst_brk(TFAIL | TERRNO, "openat(makefile) failed");
> +
> +		SAFE_WRITE(1, fd, make_buf, len);
> +		SAFE_CLOSE(fd);
> +
> +		for (k = 0; k < file_num; ++k) {
> +			snprintf(cfile, PATH_MAX, "%d.%d.%d.c", tid, i, k);
> +			fd = openat(dirfd, cfile, O_CREAT | O_RDWR,
> +				    S_IRWXU | S_IRWXG | S_IRWXO);
> +			if (fd < 0) {
> +				tst_brk(TFAIL | TERRNO,
> +					"openat(%s) failed", cfile);
>  			}
>  
> -			dprt("pid[%d]: init_compile(): status = %d\n",
> -			     gettid(), status);
> -			dprt("we are here %d\n", __LINE__);
> -			return status;
> +			SAFE_WRITE(1, fd, prog_buf, prog_buf_size);
> +			fsync(fd);

Why do we fsync(fd) here? Isn't the whole point of this test to find a
race conditions?

-- 
Cyril Hrubis
chrubis@suse.cz
