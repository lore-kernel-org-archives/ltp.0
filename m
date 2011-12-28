Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rfly1-0001lt-PF
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 05:22:21 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Rfly0-00061p-Oa
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 05:22:21 +0000
Received: by yhoo47 with SMTP id o47so8312215yho.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 27 Dec 2011 21:22:14 -0800 (PST)
Message-ID: <4EFAA778.5030704@casparzhang.com>
Date: Wed, 28 Dec 2011 13:22:00 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1322044169-30851-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1322044169-30851-3-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1322044169-30851-3-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/5] hugemmap01.c : automatically mount hugetlbfs.
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

On 11/23/2011 06:29 PM, Wanlong Gao wrote:
> Firstly, mounting hugetlbfs on /tmp is not a good idea, because lots of
> programs could use /tmp for other purpose. This could cause other tests
> fail.
> Secondly, mounting hugetlbfs could be done automatically.
> This patch creates a temp directory with name including the current PID,
> automatically mounts hugetlbfs on the directory before test starts, and
> umounts it when the test is over.
> 
> Signed-off-by: tangchen <tangchen@cn.fujitsu.com>
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |   50 +++++++-------------
>  1 files changed, 18 insertions(+), 32 deletions(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
> index 874f736..906f7e4 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
> @@ -73,51 +73,35 @@
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
>  int beforetest=0;		/* Amount of free huge pages before testing */
>  int aftertest=0;		/* Amount of free huge pages after testing */
>  int hugepagesmapped=0;		/* Amount of huge pages mapped after testing */
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
>  	char *msg;		/* message returned from parse_opts */
> -        int Hflag=0;              /* binary flag: opt or not */
>  	int page_sz=0;
>  
> -       	option_t options[] = {
> -        	{ "H:",   &Hflag, &Hopt },    /* Required for location of hugetlbfs */
> -            	{ NULL, NULL, NULL }          /* NULL required to end array */
> -       	};

Hi, I think it's better to keep this option, since not all users would
like the default mount place.

> -
>  	/* Parse standard options given to run the test. */
> -	msg = parse_opts(ac, av, options, &help);
> -	if (msg != (char *) NULL) {
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL) {
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s, use -help", msg);
> -		tst_exit();
> -	}
> -
> -	if (Hflag == 0) {
> -		tst_brkm(TBROK, NULL, "-H option is REQUIRED for this test, use -h for options help");
> -		tst_exit();
>  	}
>  
>  	setup();
> @@ -189,18 +173,19 @@ main(int ac, char **av)
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
> -
> +	tst_require_root(NULL);
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>  
>  	TEST_PAUSE;
>  
> +	tst_tmpdir();
> +	mount_point = get_tst_tmpdir();
> +	mount_hugetlbfs(mount_point);
> +	hugepage_alloc(1024);

hard-coded hugepage size is not recommended. You should either set it
dynamically or allow user pass a parameter via argv.

> +	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d",
> +		mount_point, getpid());
>  }
>  
>  /*
> @@ -209,7 +194,7 @@ setup()
>   * 	       Remove the temporary directory created.
>   */
>  void
> -cleanup()
> +cleanup(void)
>  {
>  	/*
>  	 * print timing stats if that option was specified.
> @@ -217,5 +202,6 @@ cleanup()
>  	TEST_CLEANUP;
>  
>  	unlink(TEMPFILE);
> -
> +	umount_hugetlbfs(mount_point);
> +	tst_rmdir();
>  }


------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
