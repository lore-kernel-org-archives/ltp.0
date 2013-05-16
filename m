Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UcsXp-0006dE-8U
	for ltp-list@lists.sourceforge.net; Thu, 16 May 2013 07:24:09 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UcsXm-0003v9-LJ
	for ltp-list@lists.sourceforge.net; Thu, 16 May 2013 07:24:08 +0000
Date: Thu, 16 May 2013 03:23:56 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1543097786.2539046.1368689036530.JavaMail.root@redhat.com>
In-Reply-To: <51944DF0.3080506@cn.fujitsu.com>
References: <51944C16.5080607@cn.fujitsu.com> <51944DF0.3080506@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] shmat/shmat01.c: Test for specifying NULL
	to	shmaddr
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "DAN LI" <li.dan@cn.fujitsu.com>
> To: "LTP list" <ltp-list@lists.sourceforge.net>
> Sent: Thursday, 16 May, 2013 5:09:36 AM
> Subject: [LTP] [PATCH 2/2] shmat/shmat01.c: Test for specifying NULL to	shmaddr
> 
> 
> Test for statement:
> "If shmaddr is NULL, the system chooses a suitable (unused) address
> at which to attach the segment."
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/ipc/shmat/shmat01.c | 41
>  ++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> index 3461782..13c9b1b 100644
> --- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> +++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> @@ -46,7 +46,7 @@
>  #define CASE1		20
> 
>  char *TCID = "shmat01";
> -int TST_TOTAL = 3;
> +int TST_TOTAL = 4;
> 
>  int shm_id_1 = -1;
> 
> @@ -70,6 +70,7 @@ int main(int argc, char *argv[])
>  {
>  	int lc, i;
>  	char *msg;
> +	void *attchaddr;
> 
>  	msg = parse_opts(argc, argv, NULL, NULL);
>  	if (msg != NULL)
> @@ -85,10 +86,10 @@ int main(int argc, char *argv[])
> 
>  			base_addr = probe_free_addr();
> 
> -			addr = shmat(*(TC[i].shmid), base_addr + TC[i].offset,
> -				     TC[i].flags);
> -			TEST_ERRNO = errno;
> +			attchaddr = (i ? base_addr + TC[i].offset : NULL);
> +			addr = shmat(*(TC[i].shmid), attchaddr, TC[i].flags);

Hi,

I'd suggest adding a field to test_case_t, which would tell if you need probe_free_addr()
or NULL, so you don't need to check for specific testcase number.

> 
> +			TEST_ERRNO = errno;
>  			if (addr == (void *)-1) {
>  				tst_brkm(TFAIL | TTERRNO, cleanup,
>  					 "shmat call failed");
> @@ -148,11 +149,20 @@ static void check_functionality(int i)
>  		 * If this fails the program will get a SIGSEGV, dump
>  		 * core and exit.
>  		 */
> -
>  		*shared = CASE0;
>  		break;
>  	case 1:
>  		/*
> +		 * Check the functionality of the first call by simply
> +		 * "writing" a value to the shared memory space.
> +		 * If this fails the program will get a SIGSEGV, dump
> +		 * core and exit.
> +		 */
> +
> +		*shared = CASE0;
> +		break;

Since case 0 and case 1 are the same, I'd suggest making it as fallthrough.

> +	case 2:
> +		/*
>  		 * Check the functionality of the second call by writing
>  		 * a value to the shared memory space and then checking
>  		 * that the original address given was rounded down as

It's not directly visible in patch, but case 2 is now using TC[1].

Comments don't match case numbers, both case 0 and case 1 say now "first call",
I would drop that numbering in comments.

Regards,
Jan

> @@ -167,7 +177,7 @@ static void check_functionality(int i)
>  			fail = 1;
>  		}
>  		break;
> -	case 2:
> +	case 3:
>  		/*
>  		 * This time the shared memory is read only.  Read the value
>  		 * and check that it is equal to the value set in case #2,
> @@ -195,20 +205,25 @@ void setup(void)
>  	if (TC == NULL)
>  		tst_brkm(TFAIL | TERRNO, cleanup, "failed to allocate memory");
> 
> -	/* a straight forward read/write attach */
> +	/* set NULL as attaching address*/
>  	TC[0].shmid = &shm_id_1;
>  	TC[0].offset = 0;
>  	TC[0].flags = 0;
> 
> -	/* an attach using unaligned memory */
> +	/* a straight forward read/write attach */
>  	TC[1].shmid = &shm_id_1;
> -	TC[1].offset = SHMLBA - 1;
> -	TC[1].flags = SHM_RND;
> +	TC[1].offset = 0;
> +	TC[1].flags = 0;
> 
> -	/* a read only attach */
> +	/* an attach using unaligned memory */
>  	TC[2].shmid = &shm_id_1;
> -	TC[2].offset = 0;
> -	TC[2].flags = SHM_RDONLY;
> +	TC[2].offset = SHMLBA - 1;
> +	TC[2].flags = SHM_RND;
> +
> +	/* a read only attach */
> +	TC[3].shmid = &shm_id_1;
> +	TC[3].offset = 0;
> +	TC[3].flags = SHM_RDONLY;
> 
>  	tst_tmpdir();
> 
> --
> 1.8.1
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> AlienVault Unified Security Management (USM) platform delivers complete
> security visibility with the essential security capabilities. Easily and
> efficiently configure, manage, and operate all of your security controls
> from a single console and one unified framework. Download a free trial.
> http://p.sf.net/sfu/alienvault_d2d
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
