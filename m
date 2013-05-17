Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UdEkk-0004mi-R9
	for ltp-list@lists.sourceforge.net; Fri, 17 May 2013 07:06:59 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UdEkg-0002W5-Jb
	for ltp-list@lists.sourceforge.net; Fri, 17 May 2013 07:06:58 +0000
Date: Fri, 17 May 2013 03:06:46 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1592687735.3210558.1368774406712.JavaMail.root@redhat.com>
In-Reply-To: <5195C294.2040809@cn.fujitsu.com>
References: <51944C16.5080607@cn.fujitsu.com> <5195C294.2040809@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V2 2/2] shmat/shmat01.c: Test for specifying NULL
 to shmaddr
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
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Friday, 17 May, 2013 7:39:32 AM
> Subject: [LTP] [PATCH V2 2/2] shmat/shmat01.c: Test for specifying NULL to shmaddr
> 
> 
> Test for statement:
> "If shmaddr is NULL, the system chooses a suitable (unused) address
> at which to attach the segment."
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>

V2 looks good to me, applies cleanly, tested on x86_64.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

> ---
>  testcases/kernel/syscalls/ipc/shmat/shmat01.c | 60
>  +++++++++++++++++----------
>  1 file changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> index 3461782..3c09817 100644
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
> @@ -62,6 +62,7 @@ static struct test_case_t {
>  	int *shmid;
>  	int offset;
>  	int flags;
> +	int getbase;
>  } *TC;
> 
>  static void check_functionality(int);
> @@ -70,6 +71,7 @@ int main(int argc, char *argv[])
>  {
>  	int lc, i;
>  	char *msg;
> +	void *attchaddr;
> 
>  	msg = parse_opts(argc, argv, NULL, NULL);
>  	if (msg != NULL)
> @@ -83,12 +85,16 @@ int main(int argc, char *argv[])
> 
>  		for (i = 0; i < TST_TOTAL; i++) {
> 
> -			base_addr = probe_free_addr();
> +			if (TC[i].getbase) {
> +				base_addr = probe_free_addr();
> +				attchaddr = base_addr + TC[i].offset;
> +			} else {
> +				attchaddr = NULL;
> +			}
> 
> -			addr = shmat(*(TC[i].shmid), base_addr + TC[i].offset,
> -				     TC[i].flags);
> -			TEST_ERRNO = errno;
> +			addr = shmat(*(TC[i].shmid), attchaddr, TC[i].flags);
> 
> +			TEST_ERRNO = errno;
>  			if (addr == (void *)-1) {
>  				tst_brkm(TFAIL | TTERRNO, cleanup,
>  					 "shmat call failed");
> @@ -142,35 +148,36 @@ static void check_functionality(int i)
>  	/* check for specific conditions depending on the type of attach */
>  	switch (i) {
>  	case 0:
> +	case 1:
>  		/*
> -		 * Check the functionality of the first call by simply
> -		 * "writing" a value to the shared memory space.
> +		 * Check the functionality of shmat by simply "writing"
> +		 * a value to the shared memory space.
>  		 * If this fails the program will get a SIGSEGV, dump
>  		 * core and exit.
>  		 */
> 
>  		*shared = CASE0;
>  		break;
> -	case 1:
> +	case 2:
>  		/*
> -		 * Check the functionality of the second call by writing
> -		 * a value to the shared memory space and then checking
> -		 * that the original address given was rounded down as
> +		 * Check the functionality of shmat by writing a value
> +		 * to the shared memory space and then checking that
> +		 * the original address given was rounded down as
>  		 * specified in the man page.
>  		 */
> 
>  		*shared = CASE1;
> -		orig_add = addr + ((unsigned long)TC[1].offset % SHMLBA);
> -		if (orig_add != base_addr + TC[1].offset) {
> +		orig_add = addr + ((unsigned long)TC[2].offset % SHMLBA);
> +		if (orig_add != base_addr + TC[2].offset) {
>  			tst_resm(TFAIL, "shared memory address is not "
>  				 "correct");
>  			fail = 1;
>  		}
>  		break;
> -	case 2:
> +	case 3:
>  		/*
>  		 * This time the shared memory is read only.  Read the value
> -		 * and check that it is equal to the value set in case #2,
> +		 * and check that it is equal to the value set in last case,
>  		 * because shared memory is persistent.
>  		 */
> 
> @@ -195,20 +202,29 @@ void setup(void)
>  	if (TC == NULL)
>  		tst_brkm(TFAIL | TERRNO, cleanup, "failed to allocate memory");
> 
> -	/* a straight forward read/write attach */
> +	/* set NULL as attaching address*/
>  	TC[0].shmid = &shm_id_1;
>  	TC[0].offset = 0;
>  	TC[0].flags = 0;
> +	TC[0].getbase = 0;
> 
> -	/* an attach using unaligned memory */
> +	/* a straight forward read/write attach */
>  	TC[1].shmid = &shm_id_1;
> -	TC[1].offset = SHMLBA - 1;
> -	TC[1].flags = SHM_RND;
> +	TC[1].offset = 0;
> +	TC[1].flags = 0;
> +	TC[1].getbase = 1;
> 
> -	/* a read only attach */
> +	/* an attach using unaligned memory */
>  	TC[2].shmid = &shm_id_1;
> -	TC[2].offset = 0;
> -	TC[2].flags = SHM_RDONLY;
> +	TC[2].offset = SHMLBA - 1;
> +	TC[2].flags = SHM_RND;
> +	TC[2].getbase = 1;
> +
> +	/* a read only attach */
> +	TC[3].shmid = &shm_id_1;
> +	TC[3].offset = 0;
> +	TC[3].flags = SHM_RDONLY;
> +	TC[3].getbase = 1;
> 
>  	tst_tmpdir();
> 
> --
> 1.8.1
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
