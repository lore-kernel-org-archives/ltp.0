Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZHfyX-0002PZ-HJ
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2015 22:25:25 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZHfyW-0002xs-9P
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2015 22:25:25 +0000
Date: Mon, 20 Jul 2015 08:17:29 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1723241423.662829.1437394649041.JavaMail.zimbra@redhat.com>
In-Reply-To: <1437394221-22320-1-git-send-email-sunyuan3@huawei.com>
References: <1437394221-22320-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] userns02: always set/check GID mapping
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
> Sent: Monday, 20 July, 2015 2:10:21 PM
> Subject: [PATCH] userns02: always set/check GID mapping
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>

Pushed with following text added to commit message:
    The test previously relied on fact that it can always set GID mapping.
    To allow this for unprivileged users on kernels >= 3.19, we have to
    disable setgroups first.

Thanks,
Jan

> ---
>  testcases/kernel/containers/userns/userns02.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/containers/userns/userns02.c
> b/testcases/kernel/containers/userns/userns02.c
> index 3bcb97d..e1677b6 100644
> --- a/testcases/kernel/containers/userns/userns02.c
> +++ b/testcases/kernel/containers/userns/userns02.c
> @@ -62,7 +62,6 @@ static int child_fn1(void)
>  static void setup(void)
>  {
>  	check_newuser();
> -
>  	tst_tmpdir();
>  	TST_CHECKPOINT_INIT(NULL);
>  }
> @@ -96,6 +95,14 @@ int main(int argc, char *argv[])
>  		fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
>  		SAFE_WRITE(cleanup, 1, fd, content, strlen(content));
>  		SAFE_CLOSE(cleanup, fd);
> +
> +		if (access("/proc/self/setgroups", F_OK) == 0) {
> +			sprintf(path, "/proc/%d/setgroups", childpid);
> +			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
> +			SAFE_WRITE(cleanup, 1, fd, "deny", 4);
> +			SAFE_CLOSE(cleanup, fd);
> +		}
> +
>  		sprintf(path, "/proc/%d/gid_map", childpid);
>  		sprintf(content, "100 %d 1", parentgid);
>  		fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
> --
> 1.9.1
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
