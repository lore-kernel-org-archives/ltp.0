Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QzT62-0003Wg-Hp
	for ltp-list@lists.sourceforge.net; Fri, 02 Sep 2011 12:43:46 +0000
Date: Fri, 2 Sep 2011 14:43:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110902124352.GA14558@saboteur.suse.cz>
References: <4E377560.7060600@cn.fujitsu.com> <4E4A2359.2040602@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E4A2359.2040602@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 3/6] hugemmap01.c
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
To: tangchen <tangchen@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
>  #include "test.h"
>  #include "usctest.h"
>  #include "system_specific_hugepages_info.h"
> +#include "libmnt.h"
>  
>  #define BUFFER_SIZE  256
>  
> -char* TEMPFILE="mmapfile";
> +char TEMPFILE[MAXPATHLEN];
>  
>  char *TCID="hugemmap01";	/* Test program identifier.    */
>  int TST_TOTAL=1;		/* Total number of test cases. */
>  long *addr;			/* addr of memory mapped region */
>  int fildes;			/* file descriptor for tempfile */
> -char *Hopt;                     /* location of hugetlbfs */
> +int hugepagesmapped=0;		/* Amount of huge pages mapped after testing */
>  int beforetest=0;		/* Amount of free huge pages before testing */
>  int aftertest=0;		/* Amount of free huge pages after testing */
> -int hugepagesmapped=0;		/* Amount of huge pages mapped after testing */
> +char *mount_point=NULL;
>  
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> -
> -void help()
> -{
> -	printf("  -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs \n");
> -}
> +void setup(void);			/* Main setup function of test */
> +void cleanup(void);			/* cleanup function for the test */
>  
>  int
>  main(int ac, char **av)
>  {
>  	int lc;			/* loop counter */
> -	char *msg;		/* message returned from parse_opts */
> -        int Hflag=0;              /* binary flag: opt or not */
>  	int page_sz=0;
>  
> -       	option_t options[] = {
> -        	{ "H:",   &Hflag, &Hopt },    /* Required for location of hugetlbfs */
> -            	{ NULL, NULL, NULL }          /* NULL required to end array */
> -       	};
> -
> -	/* Parse standard options given to run the test. */
> -	msg = parse_opts(ac, av, options, &help);
> -	if (msg != (char *) NULL) {
> -		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s, use -help", msg);
> -		tst_exit();
> -	}

The parse_opts() should stay here but with NULL parameters there are
some default options and it makes the test bail out on invalid options
passed.

> -	if (Hflag == 0) {
> -		tst_brkm(TBROK, NULL, "-H option is REQUIRED for this test, use -h for options help");
> -		tst_exit();
> -	}
> -
>  	setup();
>  
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
> @@ -189,18 +166,22 @@ main(int ac, char **av)
>   * 	     Write some known data into file and get the size of the file.
>   */
>  void
> -setup()
> +setup(void)
>  {
> -	char mypid[40];
> -
> -	sprintf(mypid,"/%d",getpid());
> -	TEMPFILE=strcat(mypid,TEMPFILE);
> -	TEMPFILE=strcat(Hopt,TEMPFILE);
> +	tst_require_root(NULL);
>  
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>  
>  	TEST_PAUSE;
>  
> +	tst_tmpdir();
> +	mount_point = get_tst_tmpdir();
> +
> +	mount_hugetlbfs(mount_point);
> +	hugepage_alloc(1024);
> +
> +	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", 
> +		mount_point, getpid());
>  }
>  
>  /*
> @@ -209,7 +190,7 @@ setup()
>   * 	       Remove the temporary directory created.
>   */
>  void
> -cleanup()
> +cleanup(void)
>  {
>  	/*
>  	 * print timing stats if that option was specified.
> @@ -218,4 +199,6 @@ cleanup()
>  
>  	unlink(TEMPFILE);
>  
> +	umount_hugetlbfs(mount_point);
> +	tst_rmdir();
>  }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
