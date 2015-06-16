Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Z4rSm-0000tV-8f
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2015 14:03:40 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z4rSi-0005gV-35
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2015 14:03:40 +0000
Date: Tue, 16 Jun 2015 10:03:25 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <105649905.2697646.1434463405501.JavaMail.zimbra@redhat.com>
In-Reply-To: <1434491631-28506-1-git-send-email-sunyuan3@huawei.com>
References: <1434491631-28506-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] userns02: add SAFE_CLOSE
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
> Sent: Tuesday, 16 June, 2015 11:53:51 PM
> Subject: [PATCH] userns02: add SAFE_CLOSE
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> ---
>  testcases/kernel/containers/userns/userns02.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/testcases/kernel/containers/userns/userns02.c
> b/testcases/kernel/containers/userns/userns02.c
> index ad5dda5..f5feceb 100644
> --- a/testcases/kernel/containers/userns/userns02.c
> +++ b/testcases/kernel/containers/userns/userns02.c
> @@ -31,6 +31,11 @@
>  char *TCID = "user_namespace2";
>  int TST_TOTAL = 1;
>  
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
>  /*
>   * child_fn1() - Inside a new user namespace
>   */
> @@ -39,7 +44,7 @@ static int child_fn1(void)
>  	int exit_val;
>  	int uid, gid;
>  
> -	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
> +	TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);

You shouldn't call cleanup from child. The rest looks OK.

Regards,
Jan

>  	uid = geteuid();
>  	gid = getegid();
>  
> @@ -62,11 +67,6 @@ static void setup(void)
>  	TST_CHECKPOINT_INIT(NULL);
>  }
>  
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> -
>  int main(int argc, char *argv[])
>  {
>  	int status;
> @@ -93,14 +93,16 @@ int main(int argc, char *argv[])
>  		parentgid = getegid();
>  		sprintf(path, "/proc/%d/uid_map", childpid);
>  		sprintf(content, "100 %d 1", parentuid);
> -		fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
> -		SAFE_WRITE(NULL, 1, fd, content, strlen(content));
> +		fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
> +		SAFE_WRITE(cleanup, 1, fd, content, strlen(content));
> +		SAFE_CLOSE(cleanup, fd);
>  		sprintf(path, "/proc/%d/gid_map", childpid);
>  		sprintf(content, "100 %d 1", parentgid);
> -		fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
> -		SAFE_WRITE(NULL, 1, fd, content, strlen(content));
> +		fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
> +		SAFE_WRITE(cleanup, 1, fd, content, strlen(content));
> +		SAFE_CLOSE(cleanup, fd);
>  
> -		TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
> +		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
>  
>  		if (waitpid(childpid, &status, 0) < 0)
>  			tst_brkm(TBROK | TERRNO, cleanup, "waitpid failed");
> --
> 1.9.1
> 
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
