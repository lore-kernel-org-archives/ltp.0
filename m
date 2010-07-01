Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OVpi1-000792-2M
	for ltp-list@lists.sourceforge.net; Mon, 05 Jul 2010 17:43:57 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUNE1-0004Qq-T9
	for ltp-list@lists.sourceforge.net; Thu, 01 Jul 2010 17:06:59 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o61GrDge020956
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Jul 2010 12:53:13 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o61H6pkD127634
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Jul 2010 13:06:51 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o61H6d6I003648
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Jul 2010 11:06:39 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4C2C8492.503@linux.vnet.ibm.com>
References: <4C2C8492.503@linux.vnet.ibm.com>
Date: Thu, 01 Jul 2010 22:36:24 +0530
Message-Id: <1278003985.21642.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] close file descriptors and munmap pages.
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
To: Darshak Shah <darshaks@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Probably, you would need to fix these:

patching file testcases/kernel/syscalls/open/open10.c
Hunk #1 FAILED at 282.
Hunk #2 FAILED at 311.
Hunk #3 FAILED at 359.
Hunk #4 FAILED at 389.
Hunk #5 FAILED at 440.
5 out of 5 hunks FAILED -- saving rejects to file
testcases/kernel/syscalls/open/open10.c.rej
patching file testcases/kernel/syscalls/splice/splice02.c
patch: **** malformed patch at line 229: Passed");

Regards--
Subrata
(Refer to git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev)

On Thu, 2010-07-01 at 17:35 +0530, Darshak Shah wrote: 
> Hi,
> 
> While executing the ltp on an nfs root mounted system, I faced a problem 
> with some of the ltp test cases. These tests either did not close their 
> file descriptors or did no unmap the mmaped files. This results in a 
> failures while trying to clean up the temporary directory of the testcase.
> 
> Here are the failures I see.
> 
> [darshak@darsshah-tp mcp61_ppcnf-197001010022]$ grep TWARN 
> mcp61_ppcnf-197001010022.out |grep rmdir
> open10      0  TWARN  :  rmdir(open10.testdir.A.19588) failed: 
> errno=???(39): Directory not empty
> open10      0  TWARN  :  tst_rmdir(): 
> rmobj(/tmp/ltp-yYmhzAq5ao/ope6m8CUb) failed: 
> unlink(/tmp/ltp-yYmhzAq5ao/ope6m8CUb/open10.testdir.B.19588/.nfs000000000011ef45000004b0) 
> failed; errno=16: Device or resource busy
> ppoll01     0  TWARN  :  tst_rmdir(): 
> rmobj(/tmp/ltp-yYmhzAq5ao/ppo1xLQtp) failed: 
> unlink(/tmp/ltp-yYmhzAq5ao/ppo1xLQtp/.nfs000000000011ef4a000004b7) 
> failed; errno=16: Device or resource busy
> splice02    0  TWARN  :  tst_rmdir(): 
> rmobj(/tmp/ltp-yYmhzAq5ao/splESzJrq) failed: 
> remove(/tmp/ltp-yYmhzAq5ao/splESzJrq) failed; errno=39: Directory not empty
> utimes01    0  TWARN  :  tst_rmdir(): 
> rmobj(/tmp/ltp-yYmhzAq5ao/utia5lQ1w) failed: 
> unlink(/tmp/ltp-yYmhzAq5ao/utia5lQ1w/.nfs0000000000122f28000004ca) 
> failed; errno=16: Device or resource busy
> diotest02    0  TWARN  :  tst_rmdir(): 
> rmobj(/tmp/ltp-yYmhzAq5ao/dioaaIAuQ) failed: 
> unlink(/tmp/ltp-yYmhzAq5ao/dioaaIAuQ/.nfs000000000011ef57000004d3) 
> failed; errno=16: Device or resource busy
> diotest03    0  TWARN  :  tst_rmdir(): 
> rmobj(/tmp/ltp-yYmhzAq5ao/dioqfwc9n) failed: 
> unlink(/tmp/ltp-yYmhzAq5ao/dioqfwc9n/.nfs000000000011ef58000004d4) 
> failed; errno=16: Device or resource busy
> diotest05    0  TWARN  :  tst_rmdir(): 
> rmobj(/tmp/ltp-yYmhzAq5ao/dioYf4Dai) failed: 
> unlink(/tmp/ltp-yYmhzAq5ao/dioYf4Dai/.nfs000000000011ef59000004d5) 
> failed; errno=16: Device or resource busy
> diotest06    0  TWARN  :  tst_rmdir(): 
> rmobj(/tmp/ltp-yYmhzAq5ao/dioBzOOyB) failed: 
> unlink(/tmp/ltp-yYmhzAq5ao/dioBzOOyB/.nfs000000000011ef5a000004d8) 
> failed; errno=16: Device or resource busy
> mmapstress01    0  TWARN  :  tst_rmdir(): 
> rmobj(/tmp/ltp-yYmhzAq5ao/mmaR0zAez) failed: 
> unlink(/tmp/ltp-yYmhzAq5ao/mmaR0zAez/.nfs000000000011ef6e000004f9) 
> failed; errno=16: Device or resource busy
> mmapstress02    0  TWARN  :  tst_rmdir(): 
> rmobj(/tmp/ltp-yYmhzAq5ao/mmad84xcc) failed: 
> unlink(/tmp/ltp-yYmhzAq5ao/mmad84xcc/.nfs000000000011ef6f000004fa) 
> failed; errno=16: Device or resource busy
> mmapstress05    0  TWARN  :  tst_rmdir(): 
> rmobj(/tmp/ltp-yYmhzAq5ao/mmaOrvt5a) failed: 
> unlink(/tmp/ltp-yYmhzAq5ao/mmaOrvt5a/.nfs000000000011ef70000004fc) 
> failed; errno=16: Device or resource busy
> mmapstress10    0  TWARN  :  tst_rmdir(): 
> rmobj(/tmp/ltp-yYmhzAq5ao/mmaBRE9gi) failed: 
> unlink(/tmp/ltp-yYmhzAq5ao/mmaBRE9gi/.nfs000000000011ef71000004fe) 
> failed; errno=16: Device or resource busy
> [darshak@darsshah-tp mcp61_ppcnf-197001010022]$
> 
> I have fixed all of the above tests with the following patch.
> 
> Signed-off-by: Darshak P Shah<darshaks@linux.vnet.ibm.com>
> 
> 
> Index: ltp-full-20091231/testcases/kernel/syscalls/open/open10.c
> ===================================================================
> --- ltp-full-20091231.orig/testcases/kernel/syscalls/open/open10.c
> +++ ltp-full-20091231/testcases/kernel/syscalls/open/open10.c
> @@ -282,6 +282,7 @@ int main(int ac, char *av[])
>               tst_resm(TFAIL|TERRNO, "open(%s) failed", nosetgid_A);
>               local_flag = FAILED;
>           }
> +        close(ret);
> 
>           if ((ret = stat(nosetgid_A, &buf)) < 0) {
>               tst_resm(TFAIL|TERRNO, "stat(%s) failed", nosetgid_A);
> @@ -310,6 +311,7 @@ int main(int ac, char *av[])
>               tst_resm(TFAIL|TERRNO, "open(%s) failed", setgid_A);
>               local_flag = FAILED;
>           }
> +        close(ret);
> 
>           if ((ret = stat(setgid_A, &buf)) < 0) {
>               tst_resm(TFAIL|TERRNO, "stat(%s) failed", setgid_A);
> @@ -357,6 +359,7 @@ int main(int ac, char *av[])
>               tst_resm(TFAIL|TERRNO, "open(%s) failed", nosetgid_B);
>               local_flag = FAILED;
>           }
> +        close(ret);
> 
>           if ((ret = stat(nosetgid_B, &buf)) < 0) {
>               tst_resm(TFAIL|TERRNO, "stat(%s) failed", nosetgid_B);
> @@ -386,6 +389,7 @@ int main(int ac, char *av[])
>               tst_resm(TFAIL|TERRNO, "open(%s) failed", setgid_B);
>               local_flag = FAILED;
>           }
> +        close(ret);
> 
>           if ((ret = stat(setgid_B, &buf)) < 0) {
>               tst_resm(TFAIL|TERRNO, "stat(%s) failed", setgid_B);
> @@ -436,6 +440,7 @@ int main(int ac, char *av[])
>               tst_resm(TFAIL|TERRNO, "open(%s) failed", root_setgid_B);
>               local_flag = FAILED;
>           }
> +        close(ret);
> 
>           if ((ret = stat(root_setgid_B, &buf)) < 0) {
>               tst_resm(TFAIL|TERRNO, "stat(%s) failed", root_setgid_B);
> Index: ltp-full-20091231/testcases/kernel/syscalls/splice/splice02.c
> ===================================================================
> --- ltp-full-20091231.orig/testcases/kernel/syscalls/splice/splice02.c
> +++ ltp-full-20091231/testcases/kernel/syscalls/splice/splice02.c
> @@ -148,6 +148,7 @@ int main(int ac, char **av) {
>           } else
>               if (TEST_RETURN == 0){
>                               tst_resm(TPASS, "splice() system call 
> Passed");
> +        close(fd);
>               cleanup();
>               tst_exit();
>           }
> Index: ltp-full-20091231/testcases/kernel/io/direct_io/diotest2.c
> ===================================================================
> --- ltp-full-20091231.orig/testcases/kernel/io/direct_io/diotest2.c
> +++ ltp-full-20091231/testcases/kernel/io/direct_io/diotest2.c
> @@ -275,6 +275,7 @@ static void setup(void)
>       if ((fd1 = open(filename, O_DIRECT, 0600)) < 0) {
>           tst_brkm(TCONF, cleanup, "O_DIRECT is not supported by this 
> filesystem. %s", strerror(errno));
>       }
> +    close(fd1);
> 
>   }
> 
> Index: ltp-full-20091231/testcases/kernel/io/direct_io/diotest3.c
> ===================================================================
> --- ltp-full-20091231.orig/testcases/kernel/io/direct_io/diotest3.c
> +++ ltp-full-20091231/testcases/kernel/io/direct_io/diotest3.c
> @@ -363,6 +363,7 @@ static void setup(void)
>       if ((fd1 = open(filename, O_DIRECT, 0600)) < 0) {
>           tst_brkm(TCONF, cleanup, "O_DIRECT is not supported by this 
> filesystem. %s", strerror(errno));
>       }
> +    close(fd1);
>   }
> 
>   static void cleanup(void)
> Index: ltp-full-20091231/testcases/kernel/io/direct_io/diotest5.c
> ===================================================================
> --- ltp-full-20091231.orig/testcases/kernel/io/direct_io/diotest5.c
> +++ ltp-full-20091231/testcases/kernel/io/direct_io/diotest5.c
> @@ -309,6 +309,7 @@ static void setup(void)
>       if ((fd1 = open(filename, O_DIRECT, 0600)) < 0) {
>           tst_brkm(TCONF, cleanup, "O_DIRECT is not supported by this 
> filesystem. %s", strerror(errno));
>       }
> +    close(fd1);
>   }
> 
>   static void cleanup(void)
> Index: ltp-full-20091231/testcases/kernel/io/direct_io/diotest6.c
> ===================================================================
> --- ltp-full-20091231.orig/testcases/kernel/io/direct_io/diotest6.c
> +++ ltp-full-20091231/testcases/kernel/io/direct_io/diotest6.c
> @@ -387,6 +387,7 @@ static void setup(void)
>       if ((fd1 = open(filename, O_DIRECT, 0600)) < 0) {
>           tst_brkm(TCONF, cleanup, "O_DIRECT is not supported by this 
> filesystem. %s", strerror(errno));
>       }
> +    close(fd1);
>   }
> 
>   static void cleanup(void)
> Index: ltp-full-20091231/testcases/kernel/mem/mmapstress/mmapstress02.c
> ===================================================================
> --- ltp-full-20091231.orig/testcases/kernel/mem/mmapstress/mmapstress02.c
> +++ ltp-full-20091231/testcases/kernel/mem/mmapstress/mmapstress02.c
> @@ -165,6 +165,10 @@ main(int argc, char *argv[]) {
>           CLEANERROR("close failed");
>           anyfail();
>       }
> +    if (munmap(mmapaddr, pagesize) == -1) {
> +        CLEANERROR("munmap failed");
> +        anyfail();
> +    }
>       if (unlink(tmpname) == -1) {
>           ERROR("unlink failed");
>           anyfail();
> Index: ltp-full-20091231/testcases/kernel/mem/mmapstress/mmapstress01.c
> ===================================================================
> --- ltp-full-20091231.orig/testcases/kernel/mem/mmapstress/mmapstress01.c
> +++ ltp-full-20091231/testcases/kernel/mem/mmapstress/mmapstress01.c
> @@ -590,7 +590,11 @@ child_mapper(char *file, unsigned procno
>               anyfail();
>           }
>       }
> -
> +    if (munmap(maddr, mapsize) == -1) {
> +        perror("munmap failed");
> +        local_flag = FAILED;
> +        anyfail();
> +    }
>       exit(0);
>   }
> 
> @@ -694,6 +698,7 @@ fileokay(char *file, uchar_t *expbuf)
>               }
>           }
>       }
> +    close(fd);
> 
>       return 1;
>   }
> Index: ltp-full-20091231/testcases/kernel/mem/mmapstress/mmapstress05.c
> ===================================================================
> --- ltp-full-20091231.orig/testcases/kernel/mem/mmapstress/mmapstress05.c
> +++ ltp-full-20091231/testcases/kernel/mem/mmapstress/mmapstress05.c
> @@ -61,6 +61,15 @@ void ok_exit();
>   #define ERROR(M)    (void)fprintf(stderr, "%s:  errno = %d; " M "\n", \
>                   progname, errno);
>   #define CLEAN    (void)close(fd); \
> +        if (munmap(mmapaddr+pagesize, pagesize) == -1) { \
> +            ERROR("munmap failed"); \
> +        } \
> +        if (munmap(mmapaddr, pagesize) == -1) { \
> +            ERROR("munmap failed"); \
> +        } \
> +        if (munmap(mmapaddr+2*pagesize, pagesize) == -1) { \
> +            ERROR("munmap failed"); \
> +        } \
>           if (unlink(tmpname)) { \
>               ERROR("couldn't clean up temp file"); \
>           }
> Index: ltp-full-20091231/testcases/kernel/mem/mmapstress/mmapstress10.c
> ===================================================================
> --- ltp-full-20091231.orig/testcases/kernel/mem/mmapstress/mmapstress10.c
> +++ ltp-full-20091231/testcases/kernel/mem/mmapstress/mmapstress10.c
> @@ -154,6 +154,15 @@ unsigned do_offset = 0;
>   unsigned pattern = 0;
>   char filename[64];
> 
> +void clean_mapper(int sig);
> +void clean_writer(int sig);
> +
> +int fd_mapper = 0;
> +caddr_t maddr_mapper;
> +size_t mapsize_mapper;
> +
> +int fd_writer = 0;
> +
>   int
>   main(int argc, char *argv[])
>   {
> @@ -484,8 +493,8 @@ main(int argc, char *argv[])
> 
>   cleanup:
>       for (i = 0; i < nprocs; i++)
> -        (void)kill(pidarray[i], SIGKILL);
> -    (void)kill(wr_pid, SIGKILL);
> +        (void)kill(pidarray[i], SIGUSR1);
> +    (void)kill(wr_pid, SIGUSR1);
> 
>       while (wait(&wait_stat) != -1 || errno != ECHILD)
>           continue;
> @@ -531,9 +540,7 @@ child_mapper(char *file, unsigned procno
>       off_t offset;
>   #endif /* LARGE_FILE */
>       size_t validsize;
> -    size_t mapsize;
> -    caddr_t maddr, paddr;
> -    int fd;
> +    caddr_t paddr;
>       int pagesize = sysconf(_SC_PAGE_SIZE);
>       unsigned randpage;
>       unsigned int seed;
> @@ -542,25 +549,38 @@ child_mapper(char *file, unsigned procno
>       unsigned mappages;
>       unsigned mapflags;
>       unsigned i;
> +    struct sigaction sa_mapper;
> 
>       mapflags = MAP_SHARED;
> 
>       seed = initrand();        /* initialize random seed */
> 
> +    sa_mapper.sa_handler = clean_mapper;
> +    sa_mapper.sa_flags = 0;
> +    if (sigemptyset(&sa_mapper.sa_mask)) {
> +        perror("sigempty error");
> +                anyfail();
> +    }
> +
> +    if (sigaction(SIGUSR1, &sa_mapper, 0) == -1) {
> +        perror("sigaction error SIGUSR1");
> +                anyfail();
> +    }
> +
> 
>   #ifdef LARGE_FILE
> -    if ((fd = open64(file, O_RDWR)) == -1) {
> +    if ((fd_mapper = open64(file, O_RDWR)) == -1) {
>   #else /* LARGE_FILE */
> -    if ((fd = open(file, O_RDWR)) == -1) {
> +    if ((fd_mapper = open(file, O_RDWR)) == -1) {
>   #endif /* LARGE_FILE */
>           perror("open error");
>                   anyfail();
>       }
> 
>   #ifdef LARGE_FILE
> -    if (fstat64(fd, &statbuf) == -1) {
> +    if (fstat64(fd_mapper, &statbuf) == -1) {
>   #else /* LARGE_FILE */
> -    if (fstat(fd, &statbuf) == -1) {
> +    if (fstat(fd_mapper, &statbuf) == -1) {
>   #endif /* LARGE_FILE */
>           perror("stat error");
>                   anyfail();
> @@ -571,29 +591,29 @@ child_mapper(char *file, unsigned procno
>           fprintf(stderr, "size_t overflow when setting up map\n");
>                   anyfail();
>       }
> -    mapsize = (size_t)(statbuf.st_size - sparseoffset);
> -    mappages = roundup(mapsize, pagesize) / pagesize;
> +    mapsize_mapper = (size_t)(statbuf.st_size - sparseoffset);
> +    mappages = roundup(mapsize_mapper, pagesize) / pagesize;
>       offset = sparseoffset;
>       if (do_offset) {
>           int pageoffset = lrand48() % mappages;
>           int byteoffset = pageoffset * pagesize;
>           offset += byteoffset;
> -        mapsize -= byteoffset;
> +        mapsize_mapper -= byteoffset;
>           mappages -= pageoffset;
>       }
> 
>   #ifdef LARGE_FILE
> -    if ((maddr = mmap64(0, mapsize, PROT_READ|PROT_WRITE,
> -            mapflags, fd, offset)) == (caddr_t)-1) {
> +    if ((maddr_mapper = mmap64(0, mapsize_mapper, PROT_READ|PROT_WRITE,
> +            mapflags, fd_mapper, offset)) == (caddr_t)-1) {
>   #else /* LARGE_FILE */
> -    if ((maddr = mmap(0, mapsize, PROT_READ|PROT_WRITE,
> -            mapflags, fd, offset)) == (caddr_t)-1) {
> +    if ((maddr_mapper = mmap(0, mapsize_mapper, PROT_READ|PROT_WRITE,
> +            mapflags, fd_mapper, offset)) == (caddr_t)-1) {
>   #endif /* LARGE_FILE */
>           perror("mmap error");
>                   anyfail();
>       }
> 
> -    (void)close(fd);
> +    (void)close(fd_mapper);
> 
>       nloops = (randloops) ? (lrand48() % MAXLOOPS) : MAXLOOPS;
> 
> @@ -601,12 +621,12 @@ child_mapper(char *file, unsigned procno
>   #ifdef LARGE_FILE
>           (void)printf("child %d (pid %ld): seed %d, fsize %Ld, "
>               "mapsize %d, off %Ld, loop %d\n",
> -            procno, getpid(), seed, filesize, mapsize,
> +            procno, getpid(), seed, filesize, mapsize_mapper,
>               offset/pagesize, nloops);
>   #else /* LARGE_FILE */
>           (void)printf("child %d (pid %d): seed %d, fsize %ld, "
>               "mapsize %ld, off %ld, loop %d\n",
> -            procno, getpid(), seed, filesize, (long)mapsize,
> +            procno, getpid(), seed, filesize, (long)mapsize_mapper,
>               offset/pagesize, nloops);
>   #endif /* LARGE_FILE */
>       }
> @@ -616,13 +636,13 @@ child_mapper(char *file, unsigned procno
>        */
>       for (loopcnt = 0; loopcnt < nloops; loopcnt++) {
>           randpage = lrand48() % mappages;
> -        paddr = maddr + (randpage * pagesize);     /* page address */
> +        paddr = maddr_mapper + (randpage * pagesize);     /* page 
> address */
> 
>           if (randpage < mappages - 1
> -            || !(mapsize % pagesize))
> +            || !(mapsize_mapper % pagesize))
>               validsize = pagesize;
>           else
> -            validsize = mapsize % pagesize;
> +            validsize = mapsize_mapper % pagesize;
> 
>           /*
>            * Because one child is mapping file in extend mode,
> @@ -652,14 +672,17 @@ child_mapper(char *file, unsigned procno
>            * Exercise msync() as well!
>            */
>           randpage = lrand48() % mappages;
> -        paddr = maddr + (randpage * pagesize);     /* page address */
> +        paddr = maddr_mapper + (randpage * pagesize);     /* page 
> address */
>           if (msync(paddr, (mappages - randpage)*pagesize,
>               MS_SYNC) == -1) {
>               perror("msync error");
>                           anyfail();
>           }
>       }
> -
> +    if ( munmap(maddr_mapper,mapsize_mapper) == -1 ) {
> +        perror("munmap failed");
> +        anyfail();
> +    }
>       exit(0);
>   }
> 
> @@ -675,7 +698,20 @@ child_mapper(char *file, unsigned procno
>   void
>   child_writer(char *file, uchar_t *buf)    /* buf already set up in main */
>   {
> -    int fd;
> +    struct sigaction sa_writer;
> +
> +    sa_writer.sa_handler = clean_writer;
> +    sa_writer.sa_flags = 0;
> +    if (sigemptyset(&sa_writer.sa_mask)) {
> +        perror("sigempty error");
> +                anyfail();
> +    }
> +
> +    if (sigaction(SIGUSR1, &sa_writer, 0) == -1) {
> +        perror("sigaction error SIGUSR1");
> +                anyfail();
> +    }
> +
>   #ifdef LARGE_FILE
>       struct stat64 statbuf;
>       off64_t off;
> @@ -688,18 +724,18 @@ child_writer(char *file, uchar_t *buf)    /
>       int cnt;
> 
>   #ifdef LARGE_FILE
> -    if ((fd = open64(file, O_RDWR)) == -1) {
> +    if ((fd_writer = open64(file, O_RDWR)) == -1) {
>   #else /* LARGE_FILE */
> -    if ((fd = open(file, O_RDWR)) == -1) {
> +    if ((fd_writer = open(file, O_RDWR)) == -1) {
>   #endif /* LARGE_FILE */
>           perror("open error");
>                   anyfail();
>       }
> 
>   #ifdef LARGE_FILE
> -    if ((off = lseek64(fd, 0, SEEK_END)) == -1) {
> +    if ((off = lseek64(fd_writer, 0, SEEK_END)) == -1) {
>   #else /* LARGE_FILE */
> -    if ((off = lseek(fd, 0, SEEK_END)) == -1) {
> +    if ((off = lseek(fd_writer, 0, SEEK_END)) == -1) {
>   #endif /* LARGE_FILE */
>           perror("lseek error");
>                   anyfail();
> @@ -708,9 +744,9 @@ child_writer(char *file, uchar_t *buf)    /
> 
>       for (;;) {
>   #ifdef LARGE_FILE
> -        if (fstat64(fd, &statbuf) == -1) {
> +        if (fstat64(fd_writer, &statbuf) == -1) {
>   #else /* LARGE_FILE */
> -        if (fstat(fd, &statbuf) == -1) {
> +        if (fstat(fd_writer, &statbuf) == -1) {
>   #endif /* LARGE_FILE */
>               perror("fstat error");
>                           anyfail();
> @@ -734,7 +770,7 @@ child_writer(char *file, uchar_t *buf)    /
> 
>           p = buf + (off % pagesize);
> 
> -        if ((cnt = write(fd, p, growsize)) != growsize) {
> +        if ((cnt = write(fd_writer, p, growsize)) != growsize) {
>               if (cnt == -1)
>                   perror("write error");
>               else
> @@ -747,12 +783,13 @@ child_writer(char *file, uchar_t *buf)    /
> 
>           (void)sleep(sleeptime);
>           if (dosync) {
> -            if (fsync(fd) == -1) {
> +            if (fsync(fd_writer) == -1) {
>                   perror("fsync error");
>                                   anyfail();
>               }
>           }
>       }
> +    close(fd_writer);
>   }
> 
> 
> @@ -814,6 +851,7 @@ fileokay(char *file, uchar_t *expbuf)
>           cnt = read(fd, (char *)readbuf, pagesize);
>           if (cnt == -1) {
>               perror("read error");
> +            close(fd);
>               return 0;
>           } else if (cnt != pagesize) {
>               /*
> @@ -822,6 +860,7 @@ fileokay(char *file, uchar_t *expbuf)
>               if ((i * pagesize) + cnt != mapsize) {
>                   (void)fprintf(stderr, "read %d of %ld bytes\n",
>                       (i*pagesize)+cnt, (long)mapsize);
> +                close(fd);
>                   return 0;
>               }
>           }
> @@ -841,6 +880,7 @@ fileokay(char *file, uchar_t *expbuf)
>                   (void)fprintf(stderr, ", pg %d off %d, "
>                       "(fsize %ld)\n", i, j, statbuf.st_size);
>   #endif /* LARGE_FILE */
> +                close(fd);
>                   return 0;
>               }
>           }
> @@ -866,6 +906,21 @@ clean_up_file(int sig)
>       exit(1);
>   }
> 
> +void clean_mapper(int sig)
> +{
> +    if (fd_mapper)
> +        close(fd_mapper);
> +    munmap(maddr_mapper,mapsize_mapper);
> +    exit (0);
> +}
> +
> +void clean_writer(int sig)
> +{
> +    if (fd_writer)
> +        close(fd_writer);
> +    exit(0);
> +}
> +
>   unsigned int
>   initrand(void)
>   {
> @@ -887,7 +942,6 @@ initrand(void)
>       return (seed);
>   }
> 
> -
>   /*****  LTP Port        *****/
>   void ok_exit()
>   {
> Index: ltp-full-20091231/testcases/kernel/syscalls/ppoll/ppoll01.c
> ===================================================================
> --- ltp-full-20091231.orig/testcases/kernel/syscalls/ppoll/ppoll01.c
> +++ ltp-full-20091231/testcases/kernel/syscalls/ppoll/ppoll01.c
> @@ -378,8 +378,10 @@ static int do_test(struct test_case *tc)
>       }
>       result |= (sys_errno != tc->err) || !cmp_ok;
>       PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, 
> sys_errno, cmp_ok);
> -    cleanup: if (fd >= 0)
> +    cleanup: if (fd >= 0) {
> +        close(fd);
>           cleanup_file(fpath);
> +    }
> 
>       sigemptyset(&sigmask);
>       sigprocmask(SIG_SETMASK, &sigmask, NULL);
> Index: ltp-full-20091231/testcases/kernel/syscalls/utimes/utimes01.c
> ===================================================================
> --- ltp-full-20091231.orig/testcases/kernel/syscalls/utimes/utimes01.c
> +++ ltp-full-20091231/testcases/kernel/syscalls/utimes/utimes01.c
> @@ -234,6 +234,8 @@ static int do_test(struct test_case *tc)
>           TEST(rc = setup_file(TESTDIR, "test.file", fpath));
>           if (rc < 0)
>                   return 1;
> +    /* The test just needs the file, so no need to keep it open. */
> +    close(rc);
> 
>       /*
>            * Change effective user id
> 
> 
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by Sprint
> What will you do first with EVO, the first 4G phone?
> Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
