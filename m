Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RoEsP-0006R2-GH
	for ltp-list@lists.sourceforge.net; Fri, 20 Jan 2012 13:51:33 +0000
Date: Fri, 20 Jan 2012 15:03:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120120140343.GH4024@saboteur.suse.cz>
References: <1326939459-24110-1-git-send-email-YanFeng.Shang@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1326939459-24110-1-git-send-email-YanFeng.Shang@windriver.com>
Subject: Re: [LTP] [PATCH] v2:updated mmap2.c for low memory target
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
To: Shang Yanfeng <YanFeng.Shang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Markos.Chandras@imgtec.com

Hi!
> many low memory boards don't have 1G memory,so add get_free_mem function for
> low memory target,limit 1000M for n32 file system test.

First of all, please use checkpatch (a script that is packed with linux
kernel sources) before submitting patch.

Ideally you may send a patch that fixes the formatting of the test in
separate patch before you start fixing the test logic. That is an easy
job. You first remove all the trivial comments from the code (there is a
poluttion of useless coments in these mmap testcases) and then run
checkpatch -f mmapX.c and do what you are told. That would ease the
patch reviewing.

> signed-off-by: YanFeng.Shang  <YanFeng.Shang@windriver.com>

That should be Signed-off-by: YanFeng Shang <YanFeng.Shang@windriver.com>

The best way to generate the signature is to use configure git email and
name then with 'git commit -s' the Signed-off-by line is added
automatically.

> ---
>  testcases/kernel/mem/mtest06/mmap2.c |   50 ++++++++++++++++++++++++++-------
>  1 files changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/testcases/kernel/mem/mtest06/mmap2.c b/testcases/kernel/mem/mtest06/mmap2.c
> index aa9dc33..d83ba54 100644
> --- a/testcases/kernel/mem/mtest06/mmap2.c
> +++ b/testcases/kernel/mem/mtest06/mmap2.c
> @@ -69,13 +69,14 @@
>  #include <signal.h>
>  #include <sys/time.h>
>  #include <sys/wait.h>
> +#include <sys/sysinfo.h>
>  #include <signal.h>
>  #include <string.h>
>  #include "test.h"
>  #include "usctest.h"
>  
>  /* Defines								      */
> -#define GB 1000000000
> +#define MB 1048576 
>  #ifndef TRUE
>  #define TRUE 1
>  #endif
> @@ -96,7 +97,7 @@
>  /*                                                                            */
>  /******************************************************************************/
>  static int
> -mkfile(int size) 		/* size of the file to be generated in GB     */
> +mkfile(int size) 		/* size of the file to be generated in MB     */
>  {
>      int  fd;			/* file descriptior of tmpfile		      */
>      int  index = 0;		/* index into the file, fill it with a's      */
> @@ -118,7 +119,7 @@ mkfile(int size) 		/* size of the file to be generated in GB     */
>      }
>  
>      /* fill the file with the character a */
> -    while (index < (size * GB))
> +    while (index < (size * MB))
>      {
>          index += 4096;
>          if (write(fd, buff, 4096) == -1)
> @@ -165,6 +166,21 @@ sig_handler(int signal)         /* signal number, set to handle SIGALRM       */
>      exit(0);
>  }
>  
> +/*******************************************************************************/
> +/* Function:	get_free_mem                                                   */
> +/* Description: get the free memory.                                          */ 
> +/* Return:	free memory with M					       */
> +/*******************************************************************************/
> +unsigned long get_free_mem()
> +{
> +	struct sysinfo board_sysinfo;
> +	unsigned long avail_mem;
> +	if(sysinfo(&board_sysinfo))
> +		perror("sysinfo failed\n");
> +	avail_mem = board_sysinfo.freeram/MB;
> +	return avail_mem;
> +}
> +
>  /******************************************************************************//*								 	      */
>  /* Function:	usage							      */
>  /*									      */
> @@ -180,7 +196,7 @@ usage(char *progname)           /* name of this program                       */
>  	       "\t -a set map_flags to MAP_ANONYMOUS\n"
>                 "\t -h help, usage message.\n"
>                 "\t -p set map_flag to MAP_PRIVATE.\tdefault: MAP_SHARED\n"
> -               "\t -s size of the file/memory to be mmaped.\tdefault: 1GB\n"
> +               "\t -s size of the file/memory to be mmaped.\tdefault: 1000MB\n"
>                 "\t -x time for which test is to be run.\tdefault: 24 Hrs\n",
>                      progname);
>      exit(-1);
> @@ -204,7 +220,7 @@ int main(int argc,	    /* number of input parameters.		      */
>       char **argv)	    /* pointer to the command line arguments.         */
>  {
>      int   fd;		    /* descriptor of temp file.		              */
> -    int   fsize = 1;	    /* size of the temp file created. default 1GB     */
> +    unsigned long  fsize = 1000;	    /* size of the temp file created. default 1000MB     */
>      float exec_time = 24;    /* period of execution, default 24 hours.	      */
>      int   c;		    /* command line options			      */
>      int   sig_ndx;	    /* index into signal handler structure.	      */
> @@ -234,6 +250,13 @@ int main(int argc,	    /* number of input parameters.		      */
>  			   {-1,     "ENDSIG"}
>  		   };
>  
> +	fsize = get_free_mem()/2;
> +
> +#if __WORDSIZE==32
> +	if ( fsize > 1000 )
> +		fprintf(stderr, "Using default fsize %ld MB\n", fsize = 1000);
> +#endif
> +
>      while ((c =  getopt(argc, argv, "ahps:x:")) != -1)
>      {
>          switch(c)
> @@ -249,8 +272,13 @@ int main(int argc,	    /* number of input parameters.		      */
>  		map_flags = MAP_PRIVATE;
>  		break;
>  	    case 's':
> +#if __WORDSIZE==32
> +		if ((fsize = atoi(optarg)) == 0 || (fsize = atoi(optarg)) > 1000 )
> +		    fprintf(stderr, "Using default fsize %ld MB\n", fsize = 1000);
> +#else
>  		if ((fsize = atoi(optarg)) == 0)
> -		    fprintf(stderr, "Using default fsize %d GB\n", fsize = 1);
> +			fprintf(stderr,"Using default fsize %ld MB\n", fsize = 1000);
> +#endif

Are you sure that it's a good idea to do this based on __WORDSIZE, there
are 32 bit PC machines with plenty of gigabytes of RAM out there (my
atom based netbook for example).

>  		break;
>              case 'x':
>  		if ((exec_time = atof(optarg)) == 0)
> @@ -266,7 +294,7 @@ int main(int argc,	    /* number of input parameters.		      */
>  
>      fprintf(stdout, "MM Stress test, map/write/unmap large file\n"
>  		    "\tTest scheduled to run for:       %f\n"
> -		    "\tSize of temp file in GB:         %d\n",
> +		    "\tSize of temp file in MB:         %ld\n",
>  			exec_time, fsize);
>  
>      /* set up time for which test has to be run */
> @@ -308,7 +336,7 @@ int main(int argc,	    /* number of input parameters.		      */
>  	    map_flags = map_flags|MAP_ANONYMOUS;
>          }
>  
> -        if ((memptr = (char *)mmap(0,(fsize * GB), PROT_READ|PROT_WRITE,
> +        if ((memptr = (char *)mmap(0,(fsize * MB), PROT_READ|PROT_WRITE,
>  		     map_flags, fd, 0)) == (char *)-1)
>          {
>              perror("main(): mmap()");
> @@ -319,16 +347,16 @@ int main(int argc,	    /* number of input parameters.		      */
>  			    "changing file content to 'A'\n", memptr);
>  
>          /* Change the content of the file with A's, and commit changes */
> -        memset(memptr, 'A', ((fsize * GB)/sizeof(char)));
> +        memset(memptr, 'A', ((fsize * MB)/sizeof(char)));
>  
> -        if (msync(memptr, ((fsize * GB)/sizeof(char)),
> +        if (msync(memptr, ((fsize * MB)/sizeof(char)),
>  	                 MS_SYNC|MS_INVALIDATE) == -1)
>          {
>              perror("main(): msync()");
>              exit (-1);
>          }
>  
> -        if (munmap(memptr, (fsize * GB)/sizeof(char)) == -1)
> +        if (munmap(memptr, (fsize * MB)/sizeof(char)) == -1)
>          {
>              perror("main(): munmap()");
>              exit (-1);

-- 
Cyril Hrubis
chrubis@suse.cz

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
