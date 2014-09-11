Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XS5LH-0000fb-9u
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 14:27:23 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XS5LG-0003ku-9c
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 14:27:23 +0000
Message-ID: <5411B140.4030007@oracle.com>
Date: Thu, 11 Sep 2014 18:27:12 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1143685925.31209960.1410431487838.JavaMail.zimbra@redhat.com>
In-Reply-To: <1143685925.31209960.1410431487838.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 2/3] fcntl14: only skip test block2 on NFS
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
To: Xiong Zhou <xzhou@redhat.com>, ltp-list@lists.sourceforge.net

Hi!

On 09/11/2014 02:31 PM, Xiong Zhou wrote:
> NFS does not support mandaroty locking.
>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>   testcases/kernel/syscalls/fcntl/fcntl14.c | 53 ++++++++++++++++---------------
>   1 file changed, 27 insertions(+), 26 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
> index 9db88e8..e1ae565 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl14.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
> @@ -546,6 +546,7 @@ void catch_alarm(int sig);
>
>   char *TCID = "fcntl14";
>   int TST_TOTAL = 1;
> +int NO_NFS = 1;
>
>   #ifdef UCLINUX
>   static char *argv0;		/* Set by main(), passed to self_exec() */
> @@ -1000,10 +1001,9 @@ int main(int ac, char **av)
>
>   	setup();		/* global setup */
>
> -	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
> -		tst_brkm(TCONF, cleanup,
> -			 "Cannot do fcntl on a file on NFS filesystem");
> -	}
> +	/* Check if test on NFS or not*/
> +	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC)
> +		NO_NFS = 0;
>
>   	/* Check for looping state if -i option is given */
>   	for (lc = 0; TEST_LOOPING(lc); lc++) {
> @@ -1027,30 +1027,31 @@ int main(int ac, char **av)
>   		tst_resm(TINFO, "Exit block 1");
>
>   /* //block2: */
> -		tst_resm(TINFO, "Enter block 2: with mandatory locking");
> -		fail = 0;
>   		/*
> -		 * Try various locks on a file with mandatory record locking
> -		 * this should behave the same as an ordinary file
> +		 * Skip block2 if test on NFS, since NFS does not support
> +		 * mandatory locking
>   		 */
> -		(void)run_test(O_CREAT | O_RDWR | O_TRUNC, S_ENFMT | S_IRUSR |
> -			       S_IWUSR, 0, 0, 36);
> -		if (fail) {
> -			tst_resm(TFAIL, "Block 2, test 1 FAILED");
> -		} else {
> -			tst_resm(TPASS, "Block 2, test 1 PASSED");
> -		}
> -
> -		/* Now try negative values for L_start and L_len */
> -		(void)run_test(O_CREAT | O_RDWR | O_TRUNC, S_ENFMT | S_IRUSR |
> -			       S_IWUSR, 5, 36, 45);
> -		if (fail) {
> -			tst_resm(TFAIL, "Block 2, test 2 FAILED");
> -		} else {
> -			tst_resm(TPASS, "Block 2, test 2 PASSED");
> -		}
> -
> -		tst_resm(TINFO, "Exit block 2");
> +		if (NO_NFS) {
> +			tst_resm(TINFO, "Enter block 2: with"
> +					" mandatory locking");
> +			fail = 0;
> +			/*
> +			 * Try various locks on a file with mandatory
> +			 * record locking this should behave the same
> +			 * as an ordinary file
> +			 */
> +			(void)run_test(O_CREAT | O_RDWR | O_TRUNC,
> +				S_ENFMT | S_IRUSR | S_IWUSR, 0, 0, 36);
> +			testcheck_end(fail, "Block 2, test 1");
> +
> +			/* Now try negative values for L_start and L_len */
> +			(void)run_test(O_CREAT | O_RDWR | O_TRUNC,
> +				S_ENFMT | S_IRUSR | S_IWUSR, 5, 36, 45);
> +			testcheck_end(fail, "Block 2, test 2");
> +
> +			tst_resm(TINFO, "Exit block 2");
> +		} else
> +			tst_resm(TINFO, "Skip block 2 on NFS");

It's more a matter of taste, but recently in commit:
commit a2d860c854511cccd682ce244636cbb5f4b75d7c
Author: Xiong Zhou <xzhou@redhat.com>
Date:   Tue Aug 26 03:01:26 2014 -0400

     fcntl16: Skip fcntl16 test block2 and block3 on NFS

     According to nfs(5), NLM supports advisory file locks only. So skip
     fcntl16 test block 1 if NFS.

     Signed-off-by: Xiong Zhou <xzhou@redhat.com>
     Reviewed-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

you changed the same skipping logic as:

tst_resm(TINFO, "Entering block bla")
if (NO_NFS) {
	do_the_tests();
} else {
	tst_resm(TCONF, "NFS does not support mandatory locking");
}
tst_resm(TINFO, "Exiting block bla")

Maybe fix fcntl14.c using the same style?

And testcheck_end() to block 2 should be introduced in the previous patch.

Thanks.

>
>   /* //block3: */
>   		tst_resm(TINFO, "Enter block 3");
>

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
