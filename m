Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZP4Dt-0003de-KW
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 07:43:49 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZP4Dp-0004mv-5k
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 07:43:49 +0000
Date: Tue, 11 Aug 2015 03:43:16 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <840251437.7372520.1439278996820.JavaMail.zimbra@redhat.com>
In-Reply-To: <1438923840-13909-1-git-send-email-sunyuan3@huawei.com>
References: <1438923840-13909-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] container: use tst_record_childstatus() in userns
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
> Sent: Friday, 7 August, 2015 7:04:00 AM
> Subject: [PATCH] container: use tst_record_childstatus() in userns
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>

Hi,

Pushed along with same patch for userns01.

Thanks,
Jan

> ---
>  testcases/kernel/containers/userns/userns02.c | 14 +-----------
>  testcases/kernel/containers/userns/userns03.c | 24 ++-------------------
>  testcases/kernel/containers/userns/userns04.c | 31
>  ++++-----------------------
>  3 files changed, 7 insertions(+), 62 deletions(-)
> 
> diff --git a/testcases/kernel/containers/userns/userns02.c
> b/testcases/kernel/containers/userns/userns02.c
> index e1677b6..32db7bc 100644
> --- a/testcases/kernel/containers/userns/userns02.c
> +++ b/testcases/kernel/containers/userns/userns02.c
> @@ -68,7 +68,6 @@ static void setup(void)
>  
>  int main(int argc, char *argv[])
>  {
> -	int status;
>  	int lc;
>  	int childpid;
>  	int parentuid;
> @@ -111,19 +110,8 @@ int main(int argc, char *argv[])
>  
>  		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
>  
> -		if (waitpid(childpid, &status, 0) < 0)
> -			tst_brkm(TBROK | TERRNO, cleanup, "waitpid failed");
> -
> -		if (WIFSIGNALED(status)) {
> -			tst_resm(TFAIL, "child was killed with signal = %d",
> -				WTERMSIG(status));
> -		} else if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> -			tst_resm(TFAIL, "child exited abnormally");
> -		else
> -			tst_resm(TPASS, "the uid and the gid are right inside "
> -				"the container");
> +		tst_record_childstatus(cleanup, childpid);
>  	}
>  	cleanup();
>  	tst_exit();
>  }
> -
> diff --git a/testcases/kernel/containers/userns/userns03.c
> b/testcases/kernel/containers/userns/userns03.c
> index 9b8ede5..6e3cedd 100644
> --- a/testcases/kernel/containers/userns/userns03.c
> +++ b/testcases/kernel/containers/userns/userns03.c
> @@ -166,7 +166,6 @@ int main(int argc, char *argv[])
>  {
>  	pid_t cpid2;
>  	char path[BUFSIZ];
> -	int cpid1status, cpid2status;
>  	int lc;
>  	int fd;
>  
> @@ -211,27 +210,8 @@ int main(int argc, char *argv[])
>  
>  		TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup, 1);
>  
> -		if ((waitpid(cpid1, &cpid1status, 0) < 0) ||
> -			(waitpid(cpid2, &cpid2status, 0) < 0))
> -				tst_brkm(TBROK | TERRNO, cleanup,
> -				"parent: waitpid failed.");
> -
> -		if (WIFSIGNALED(cpid1status)) {
> -			tst_resm(TFAIL, "child1 was killed with signal = %d",
> -				WTERMSIG(cpid1status));
> -		} else if (WIFEXITED(cpid1status) &&
> -			WEXITSTATUS(cpid1status) != 0) {
> -			tst_resm(TFAIL, "child1 exited abnormally");
> -		}
> -
> -		if (WIFSIGNALED(cpid2status)) {
> -			tst_resm(TFAIL, "child2 was killed with signal = %d",
> -				WTERMSIG(cpid2status));
> -		} else if (WIFEXITED(cpid2status) &&
> -			WEXITSTATUS(cpid2status) != 0) {
> -			tst_resm(TFAIL, "child2 exited abnormally");
> -		} else
> -			tst_resm(TPASS, "test pass");
> +		tst_record_childstatus(cleanup, cpid1);
> +		tst_record_childstatus(cleanup, cpid2);
>  	}
>  	cleanup();
>  	tst_exit();
> diff --git a/testcases/kernel/containers/userns/userns04.c
> b/testcases/kernel/containers/userns/userns04.c
> index 9836fd9..4d38891 100644
> --- a/testcases/kernel/containers/userns/userns04.c
> +++ b/testcases/kernel/containers/userns/userns04.c
> @@ -70,29 +70,11 @@ static int child_fn2(void *arg)
>  	return exit_val;
>  }
>  
> -static int wait4child(pid_t pid, const char *msg)
> -{
> -	int status;
> -
> -	if (waitpid(pid, &status, 0) == -1) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
> -	} else if (WIFSIGNALED(status)) {
> -		tst_resm(TFAIL, "%s: child was killed with signal = %d",
> -			msg, WTERMSIG(status));
> -		return WTERMSIG(status);
> -	} else if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
> -		tst_resm(TFAIL, "%s: child returns %d", msg, status);
> -		return WEXITSTATUS(status);
> -	}
> -
> -	return 0;
> -}
> -
>  static void test_cap_sys_admin(void)
>  {
>  	pid_t cpid1, cpid2, cpid3;
>  	char path[BUFSIZ];
> -	int fd, status;
> +	int fd;
>  
>  	/* child 1 */
>  	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
> @@ -124,14 +106,9 @@ static void test_cap_sys_admin(void)
>  	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
>  	TST_SAFE_CHECKPOINT_WAKE(cleanup, 1);
>  
> -	status = 0;
> -	status |= wait4child(cpid1, "child1");
> -	status |= wait4child(cpid2, "child2");
> -	status |= wait4child(cpid3, "child3");
> -	if (status == 0)
> -		tst_resm(TPASS, "The setns function works well.");
> -	else
> -		tst_resm(TFAIL, "Some child reported failure.");
> +	tst_record_childstatus(cleanup, cpid1);
> +	tst_record_childstatus(cleanup, cpid2);
> +	tst_record_childstatus(cleanup, cpid3);
>  
>  	SAFE_CLOSE(cleanup, fd);
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
