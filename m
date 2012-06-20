Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ShFiV-00058B-6I
	for ltp-list@lists.sourceforge.net; Wed, 20 Jun 2012 07:52:43 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ShFiP-0006j0-4N
	for ltp-list@lists.sourceforge.net; Wed, 20 Jun 2012 07:52:43 +0000
Date: Wed, 20 Jun 2012 03:52:28 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <543d8876-f65c-4dab-8f7e-ced6f4798346@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1340158615-5623-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] get_robust_list: change seteuid to setuid
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



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Wednesday, 20 June, 2012 4:16:55 AM
> Subject: [LTP] [PATCH] get_robust_list: change seteuid to setuid
> 
> Since kernel commit bdbb776f changed the permission check
> from euid to uid, so, we should also change our code to
> be consistent with it.
> 
> commit bdbb776f882f5ad431aa1e694c69c1c3d6a4a5b8
> Author: Kees Cook <keescook@chromium.org>
> Date:   Mon Mar 19 16:12:53 2012 -0700
> 
>     futex: Do not leak robust list to unprivileged process
> 
>     It was possible to extract the robust list head address from a
>     setuid
>     process if it had used set_robust_list(), allowing an ASLR info
>     leak. This
>     changes the permission checks to be the same as those used for
>     similar
>     info that comes out of /proc.
> 
>     Running a setuid program that uses robust futexes would have had:
>       cred->euid != pcred->euid
>       cred->euid == pcred->uid
>     so the old permissions check would allow it. I'm not aware of any
>     setuid
>     programs that use robust futexes, so this is just a preventative
>     measure.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  .../syscalls/get_robust_list/get_robust_list01.c   | 28
>  ++++++++++------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git
> a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
> b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
> index 27c0be6..b8e9797 100644
> --- a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
> +++ b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
> @@ -152,7 +152,17 @@ int main(int argc, char **argv)
>  			tst_resm(TFAIL,
>  			    "get_robust_list succeeded unexpectedly");
>  
> -		if (seteuid(1) == -1)
> +		TEST(retval = syscall(__NR_get_robust_list, 0,
> +				      (struct robust_list_head **)&head,
> +				      &len_ptr));
> +
> +		if (TEST_RETURN == 0)
> +			tst_resm(TPASS, "get_robust_list succeeded");
> +		else
> +			tst_resm(TFAIL|TTERRNO,
> +				 "get_robust_list failed unexpectedly");
> +
> +		if (setuid(1) == -1)
>  			tst_brkm(TBROK|TERRNO, cleanup, "seteuid(1) failed");

error above still says "seteuid",
other than that it looks OK and still works on kernels older than 3.4

Regards,
Jan

>  
>  		TEST(retval = syscall(__NR_get_robust_list, 1,
> @@ -170,20 +180,6 @@ int main(int argc, char **argv)
>  		} else
>  			tst_resm(TFAIL,
>  			    "get_robust_list succeeded unexpectedly");
> -
> -		if (seteuid(0) == -1)
> -			tst_brkm(TBROK|TERRNO, cleanup, "seteuid(0) failed");
> -
> -		TEST(retval = syscall(__NR_get_robust_list, 0,
> -				      (struct robust_list_head **)&head,
> -				      &len_ptr));
> -
> -		if (TEST_RETURN == 0)
> -			tst_resm(TPASS, "get_robust_list succeeded");
> -		else
> -			tst_resm(TFAIL|TTERRNO,
> -				 "get_robust_list failed unexpectedly");
> -
>  	}
>  
>  	cleanup();
> @@ -203,4 +199,4 @@ void setup(void)
>  void cleanup(void)
>  {
>  	TEST_CLEANUP;
> -}
> \ No newline at end of file
> +}
> --
> 1.7.11.rc0
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond.
> Discussions
> will include endpoint security, mobile security and the latest in
> malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
