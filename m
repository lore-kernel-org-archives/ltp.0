Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZABvp-0007hI-VN
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 06:55:41 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZABvo-0005Ml-CN
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 06:55:41 +0000
Date: Wed, 1 Jul 2015 02:55:33 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <105343732.10909567.1435733733296.JavaMail.zimbra@redhat.com>
In-Reply-To: <1435732532-10995-1-git-send-email-liuhangbin@gmail.com>
References: <1435732532-10995-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCHv3] containers: Use ltp_syscall for setns incase
 some libc library do not support it
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>





----- Original Message -----
> From: "Hangbin Liu" <liuhangbin@gmail.com>
> To: "LTP List" <ltp-list@lists.sourceforge.net>
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Wednesday, 1 July, 2015 8:35:32 AM
> Subject: [LTP][PATCHv3] containers: Use ltp_syscall for setns incase some libc library do not support it
> 
> Use ltp_syscall for setns incase some libc library do not support it. Also
> check whether we support setns in setup(). If it's support the syscall will
> silently fails and test continues. If not, then tst_brkm call will end the
> test with TCONF.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Pushed with cosmetic change to commit message.

Thanks,
Jan

> ---
>  testcases/kernel/containers/userns/userns04.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/containers/userns/userns04.c
> b/testcases/kernel/containers/userns/userns04.c
> index 7077679..9836fd9 100644
> --- a/testcases/kernel/containers/userns/userns04.c
> +++ b/testcases/kernel/containers/userns/userns04.c
> @@ -35,6 +35,7 @@ int TST_TOTAL = 1;
>  static void setup(void)
>  {
>  	check_newuser();
> +	ltp_syscall(__NR_setns, -1, 0);
>  	tst_tmpdir();
>  	TST_CHECKPOINT_INIT(NULL);
>  }
> @@ -55,7 +56,7 @@ static int child_fn2(void *arg)
>  	int exit_val = 0;
>  	int ret;
>  
> -	ret = setns(((long)arg), CLONE_NEWUSER);
> +	ret = ltp_syscall(__NR_setns, ((long)arg), CLONE_NEWUSER);
>  	if (ret != -1) {
>  		printf("child2 setns() unexpected success\n");
>  		exit_val = 1;
> @@ -112,7 +113,7 @@ static void test_cap_sys_admin(void)
>  	case -1:
>  		tst_brkm(TBROK | TERRNO, cleanup, "fork");
>  	case 0:
> -		if (setns(fd, CLONE_NEWUSER) == -1) {
> +		if (ltp_syscall(__NR_setns, fd, CLONE_NEWUSER) == -1) {
>  			printf("parent pid setns failure: (%d) %s",
>  				errno, strerror(errno));
>  			exit(1);
> --
> 1.9.3
> 
> 

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
