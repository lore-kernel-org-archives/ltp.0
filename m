Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Z2Frz-0001pO-9y
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 09:30:55 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2Frx-0001dq-FD
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 09:30:55 +0000
Date: Tue, 9 Jun 2015 05:30:43 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <19148692.12842296.1433842243807.JavaMail.zimbra@redhat.com>
In-Reply-To: <1433842119-27558-1-git-send-email-sunyuan3@huawei.com>
References: <1433842119-27558-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Add TEST_LOOPING in userns01.
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
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Yuan Sun" <sunyuan3@huawei.com>
> To: jstancek@redhat.com
> Cc: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 9 June, 2015 11:28:39 AM
> Subject: [PATCH] Add TEST_LOOPING in userns01.
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>

Thanks for following-up on this, applied.

Regards,
Jan

> ---
>  testcases/kernel/containers/userns/userns01.c | 31
>  +++++++++++++++------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/testcases/kernel/containers/userns/userns01.c
> b/testcases/kernel/containers/userns/userns01.c
> index 6e313c0..9cada5e 100644
> --- a/testcases/kernel/containers/userns/userns01.c
> +++ b/testcases/kernel/containers/userns/userns01.c
> @@ -71,25 +71,28 @@ static void setup(void)
>  int main(int argc, char *argv[])
>  {
>  	int status;
> +	int lc;
>  
>  	tst_parse_opts(argc, argv, NULL, NULL);
>  	setup();
>  
> -	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWUSER, child_fn1, NULL));
> -
> -	if (TEST_RETURN == -1)
> -		tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
> -	else if ((wait(&status)) == -1)
> -		tst_brkm(TWARN | TERRNO, NULL, "wait failed");
> -
> -	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> -		tst_resm(TFAIL, "child exited abnormally");
> -	else if (WIFSIGNALED(status)) {
> -		tst_resm(TFAIL, "child was killed with signal = %d",
> -			 WTERMSIG(status));
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWUSER,
> +			child_fn1, NULL));
> +
> +		if (TEST_RETURN == -1)
> +			tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
> +		else if ((wait(&status)) == -1)
> +			tst_brkm(TWARN | TERRNO, NULL, "wait failed");
> +
> +		if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> +			tst_resm(TFAIL, "child exited abnormally");
> +		else if (WIFSIGNALED(status)) {
> +			tst_resm(TFAIL, "child was killed with signal = %d",
> +				 WTERMSIG(status));
> +		} else
> +			tst_resm(TPASS, "uid and gid are right");
>  	}
> -
> -	tst_resm(TPASS, "the uid and the gid are right inside the container");
>  	tst_exit();
>  }
>  
> --
> 1.9.1
> 
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
